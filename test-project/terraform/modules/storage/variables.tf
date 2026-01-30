# variables.tf - Input variables for Storage module

variable "resource_group_name" {
  description = "Name of the Azure resource group"
  type        = string
}

variable "location" {
  description = "Azure region for the storage account"
  type        = string
  default     = "eastus"
}

variable "storage_account_name" {
  description = "Name of the storage account (must be globally unique, 3-24 chars, lowercase letters and numbers only)"
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]{3,24}$", var.storage_account_name))
    error_message = "Storage account name must be 3-24 characters, lowercase letters and numbers only."
  }
}

variable "account_tier" {
  description = "Storage account tier (Standard or Premium)"
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Standard", "Premium"], var.account_tier)
    error_message = "Account tier must be Standard or Premium."
  }
}

variable "replication_type" {
  description = "Storage replication type (LRS, GRS, RAGRS, ZRS, GZRS, RAGZRS)"
  type        = string
  default     = "LRS"

  validation {
    condition     = contains(["LRS", "GRS", "RAGRS", "ZRS", "GZRS", "RAGZRS"], var.replication_type)
    error_message = "Invalid replication type."
  }
}

variable "account_kind" {
  description = "Storage account kind (StorageV2, BlobStorage, BlockBlobStorage, FileStorage)"
  type        = string
  default     = "StorageV2"
}

variable "access_tier" {
  description = "Access tier for BlobStorage/StorageV2 (Hot or Cool)"
  type        = string
  default     = "Hot"

  validation {
    condition     = contains(["Hot", "Cool"], var.access_tier)
    error_message = "Access tier must be Hot or Cool."
  }
}

variable "environment" {
  description = "Environment name (dev, staging, production)"
  type        = string
  default     = "dev"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}

# Security variables
variable "shared_access_key_enabled" {
  description = "Enable shared access key for the storage account"
  type        = bool
  default     = true
}

variable "enable_network_rules" {
  description = "Enable network rules to restrict access"
  type        = bool
  default     = false
}

variable "allowed_ip_ranges" {
  description = "List of allowed IP ranges when network rules are enabled"
  type        = list(string)
  default     = []
}

variable "allowed_subnet_ids" {
  description = "List of allowed subnet IDs when network rules are enabled"
  type        = list(string)
  default     = []
}

# Blob properties
variable "enable_versioning" {
  description = "Enable blob versioning"
  type        = bool
  default     = false
}

variable "blob_soft_delete_days" {
  description = "Number of days to retain soft-deleted blobs (0 to disable)"
  type        = number
  default     = 7
}

variable "container_soft_delete_days" {
  description = "Number of days to retain soft-deleted containers (0 to disable)"
  type        = number
  default     = 7
}

# Containers
variable "containers" {
  description = "List of blob containers to create"
  type = list(object({
    name        = string
    access_type = string
  }))
  default = []
}

# File shares
variable "file_shares" {
  description = "List of file shares to create"
  type = list(object({
    name        = string
    quota_gb    = number
    access_tier = string
  }))
  default = []
}

# Lifecycle policy
variable "enable_lifecycle_policy" {
  description = "Enable lifecycle management policy"
  type        = bool
  default     = false
}

variable "days_to_cool_tier" {
  description = "Days after which to move blobs to cool tier"
  type        = number
  default     = 30
}

variable "days_to_archive_tier" {
  description = "Days after which to move blobs to archive tier"
  type        = number
  default     = 90
}

variable "days_to_delete" {
  description = "Days after which to delete blobs"
  type        = number
  default     = 365
}
