# =============================================================================
# Variables - Storage Account
# =============================================================================

variable "storage_account_name" {
  description = "Nombre único del storage account (3-24 chars, lowercase)"
  type        = string
}

variable "resource_group_name" {
  description = "Nombre del Resource Group"
  type        = string
}

variable "location" {
  description = "Región de Azure"
  type        = string
  default     = "eastus"
}

variable "account_tier" {
  description = "Tier del storage (Standard o Premium)"
  type        = string
  default     = "Standard"
}

variable "replication_type" {
  description = "Tipo de replicación (LRS, GRS, ZRS, etc.)"
  type        = string
  default     = "LRS"
}

variable "container_names" {
  description = "Lista de nombres de containers blob"
  type        = list(string)
  default     = ["data", "logs"]
}

variable "tags" {
  description = "Tags para los recursos"
  type        = map(string)
  default     = {}
}
