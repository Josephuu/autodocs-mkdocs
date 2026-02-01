# main.tf - Azure Storage Account Module

terraform {
  required_version = ">= 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

# Storage Account
resource "azurerm_storage_account" "main" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.replication_type
  account_kind             = var.account_kind
  access_tier              = var.access_tier

  # Security settings
  min_tls_version                 = "TLS1_2"
  https_traffic_only_enabled      = true
  allow_nested_items_to_be_public = false
  shared_access_key_enabled       = var.shared_access_key_enabled

  # Network rules
  dynamic "network_rules" {
    for_each = var.enable_network_rules ? [1] : []
    content {
      default_action             = "Deny"
      ip_rules                   = var.allowed_ip_ranges
      virtual_network_subnet_ids = var.allowed_subnet_ids
      bypass                     = ["AzureServices"]
    }
  }

  # Blob properties
  blob_properties {
    versioning_enabled = var.enable_versioning

    dynamic "delete_retention_policy" {
      for_each = var.blob_soft_delete_days > 0 ? [1] : []
      content {
        days = var.blob_soft_delete_days
      }
    }

    dynamic "container_delete_retention_policy" {
      for_each = var.container_soft_delete_days > 0 ? [1] : []
      content {
        days = var.container_soft_delete_days
      }
    }
  }

  tags = merge(
    var.tags,
    {
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  )
}

# Blob Containers
resource "azurerm_storage_container" "containers" {
  for_each              = { for c in var.containers : c.name => c }
  name                  = each.value.name
  storage_account_id    = azurerm_storage_account.main.id
  container_access_type = each.value.access_type
}

# File Shares
resource "azurerm_storage_share" "shares" {
  for_each           = { for s in var.file_shares : s.name => s }
  name               = each.value.name
  storage_account_id = azurerm_storage_account.main.id
  quota              = each.value.quota_gb
  access_tier        = each.value.access_tier
}

# Lifecycle Management Policy
resource "azurerm_storage_management_policy" "lifecycle" {
  count              = var.enable_lifecycle_policy ? 1 : 0
  storage_account_id = azurerm_storage_account.main.id

  rule {
    name    = "archive-old-blobs"
    enabled = true

    filters {
      blob_types = ["blockBlob"]
    }

    actions {
      base_blob {
        tier_to_cool_after_days_since_modification_greater_than    = var.days_to_cool_tier
        tier_to_archive_after_days_since_modification_greater_than = var.days_to_archive_tier
        delete_after_days_since_modification_greater_than          = var.days_to_delete
      }
    }
  }
}
