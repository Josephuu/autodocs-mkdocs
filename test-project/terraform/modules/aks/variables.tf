# variables.tf - Input variables for AKS module

variable "resource_group_name" {
  description = "Name of the Azure resource group"
  type        = string
}

variable "location" {
  description = "Azure region for the AKS cluster"
  type        = string
  default     = "eastus"
}

variable "cluster_name" {
  description = "Name of the AKS cluster"
  type        = string

  validation {
    condition     = length(var.cluster_name) >= 1 && length(var.cluster_name) <= 63
    error_message = "Cluster name must be between 1 and 63 characters."
  }
}

variable "dns_prefix" {
  description = "DNS prefix for the AKS cluster"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version for the cluster"
  type        = string
  default     = "1.28"
}

variable "sku_tier" {
  description = "SKU tier for the AKS cluster (Free or Standard)"
  type        = string
  default     = "Free"

  validation {
    condition     = contains(["Free", "Standard"], var.sku_tier)
    error_message = "SKU tier must be Free or Standard."
  }
}

# System node pool
variable "system_node_count" {
  description = "Number of nodes in the system node pool"
  type        = number
  default     = 2
}

variable "system_node_vm_size" {
  description = "VM size for system node pool"
  type        = string
  default     = "Standard_D2s_v3"
}

variable "system_node_os_disk_size" {
  description = "OS disk size in GB for system nodes"
  type        = number
  default     = 128
}

variable "system_node_os_disk_type" {
  description = "OS disk type for system nodes (Managed, Ephemeral)"
  type        = string
  default     = "Managed"
}

variable "system_node_min_count" {
  description = "Minimum number of system nodes (when auto-scaling)"
  type        = number
  default     = 2
}

variable "system_node_max_count" {
  description = "Maximum number of system nodes (when auto-scaling)"
  type        = number
  default     = 5
}

# User node pools
variable "user_node_pools" {
  description = "List of user node pools"
  type = list(object({
    name                = string
    vm_size             = string
    node_count          = number
    os_disk_size_gb     = number
    os_disk_type        = string
    enable_auto_scaling = bool
    min_count           = number
    max_count           = number
    node_labels         = map(string)
    node_taints         = list(string)
  }))
  default = []
}

# Network
variable "subnet_id" {
  description = "ID of the subnet for AKS nodes"
  type        = string
}

variable "network_plugin" {
  description = "Network plugin for AKS (azure or kubenet)"
  type        = string
  default     = "azure"

  validation {
    condition     = contains(["azure", "kubenet"], var.network_plugin)
    error_message = "Network plugin must be azure or kubenet."
  }
}

variable "network_policy" {
  description = "Network policy for AKS (azure, calico, or null)"
  type        = string
  default     = "azure"
}

variable "dns_service_ip" {
  description = "DNS service IP address"
  type        = string
  default     = "10.0.0.10"
}

variable "service_cidr" {
  description = "CIDR for Kubernetes services"
  type        = string
  default     = "10.0.0.0/16"
}

variable "outbound_type" {
  description = "Outbound routing type (loadBalancer, userDefinedRouting)"
  type        = string
  default     = "loadBalancer"
}

# Scaling
variable "enable_auto_scaling" {
  description = "Enable cluster auto-scaler"
  type        = bool
  default     = true
}

variable "max_pods_per_node" {
  description = "Maximum number of pods per node"
  type        = number
  default     = 110
}

variable "availability_zones" {
  description = "List of availability zones for node pools"
  type        = list(string)
  default     = ["1", "2", "3"]
}

# Azure AD RBAC
variable "enable_azure_rbac" {
  description = "Enable Azure AD RBAC for Kubernetes"
  type        = bool
  default     = false
}

variable "admin_group_object_ids" {
  description = "List of Azure AD group object IDs for cluster admin"
  type        = list(string)
  default     = []
}

# Integrations
variable "log_analytics_workspace_id" {
  description = "ID of Log Analytics workspace for monitoring"
  type        = string
  default     = null
}

variable "acr_id" {
  description = "ID of Azure Container Registry for image pull"
  type        = string
  default     = null
}

variable "enable_key_vault_secrets_provider" {
  description = "Enable Key Vault secrets provider"
  type        = bool
  default     = false
}

# Tags
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
