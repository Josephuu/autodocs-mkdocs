# main.tf - Azure Kubernetes Service (AKS) Module

terraform {
  required_version = ">= 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

# AKS Cluster
resource "azurerm_kubernetes_cluster" "main" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version
  sku_tier            = var.sku_tier

  # Default node pool (system)
  default_node_pool {
    name                 = "system"
    node_count           = var.system_node_count
    vm_size              = var.system_node_vm_size
    os_disk_size_gb      = var.system_node_os_disk_size
    os_disk_type         = var.system_node_os_disk_type
    vnet_subnet_id       = var.subnet_id
    max_pods             = var.max_pods_per_node
    auto_scaling_enabled = var.enable_auto_scaling
    min_count            = var.enable_auto_scaling ? var.system_node_min_count : null
    max_count            = var.enable_auto_scaling ? var.system_node_max_count : null
    zones                = var.availability_zones
    type                 = "VirtualMachineScaleSets"

    node_labels = {
      "nodepool" = "system"
    }
  }

  # Identity
  identity {
    type = "SystemAssigned"
  }

  # Network configuration
  network_profile {
    network_plugin    = var.network_plugin
    network_policy    = var.network_policy
    dns_service_ip    = var.dns_service_ip
    service_cidr      = var.service_cidr
    load_balancer_sku = "standard"
    outbound_type     = var.outbound_type
  }

  # Azure AD RBAC
  dynamic "azure_active_directory_role_based_access_control" {
    for_each = var.enable_azure_rbac ? [1] : []
    content {
      azure_rbac_enabled     = true
      admin_group_object_ids = var.admin_group_object_ids
    }
  }

  # Key Vault secrets provider
  dynamic "key_vault_secrets_provider" {
    for_each = var.enable_key_vault_secrets_provider ? [1] : []
    content {
      secret_rotation_enabled = true
    }
  }

  # OMS Agent for monitoring
  dynamic "oms_agent" {
    for_each = var.log_analytics_workspace_id != null ? [1] : []
    content {
      log_analytics_workspace_id = var.log_analytics_workspace_id
    }
  }

  # Auto-scaler profile
  dynamic "auto_scaler_profile" {
    for_each = var.enable_auto_scaling ? [1] : []
    content {
      balance_similar_node_groups      = true
      expander                         = "random"
      max_graceful_termination_sec     = 600
      scale_down_delay_after_add       = "10m"
      scale_down_delay_after_delete    = "10s"
      scale_down_unneeded              = "10m"
      scale_down_utilization_threshold = 0.5
    }
  }

  # Maintenance window
  maintenance_window {
    allowed {
      day   = "Sunday"
      hours = [0, 1, 2, 3, 4]
    }
  }

  tags = merge(
    var.tags,
    {
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  )

  lifecycle {
    ignore_changes = [
      default_node_pool[0].node_count,
    ]
  }
}

# User Node Pool (workloads)
resource "azurerm_kubernetes_cluster_node_pool" "user" {
  for_each              = { for np in var.user_node_pools : np.name => np }
  name                  = each.value.name
  kubernetes_cluster_id = azurerm_kubernetes_cluster.main.id
  vm_size               = each.value.vm_size
  node_count            = each.value.node_count
  os_disk_size_gb       = each.value.os_disk_size_gb
  os_disk_type          = each.value.os_disk_type
  vnet_subnet_id        = var.subnet_id
  max_pods              = var.max_pods_per_node
  auto_scaling_enabled  = each.value.enable_auto_scaling
  min_count             = each.value.enable_auto_scaling ? each.value.min_count : null
  max_count             = each.value.enable_auto_scaling ? each.value.max_count : null
  zones                 = var.availability_zones
  mode                  = "User"

  node_labels = merge(
    {
      "nodepool" = each.value.name
    },
    each.value.node_labels
  )

  node_taints = each.value.node_taints

  tags = var.tags
}

# Role assignment for ACR pull
resource "azurerm_role_assignment" "acr_pull" {
  count                = var.acr_id != null ? 1 : 0
  principal_id         = azurerm_kubernetes_cluster.main.kubelet_identity[0].object_id
  role_definition_name = "AcrPull"
  scope                = var.acr_id
}
