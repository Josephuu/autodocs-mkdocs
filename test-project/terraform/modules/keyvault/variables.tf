variable "name" {
  description = "Nombre del Key Vault"
  type        = string
}

variable "resource_group_name" {
  description = "Nombre del Resource Group"
  type        = string
}

variable "location" {
  description = "Region de Azure"
  type        = string
  default     = "eastus"
}

variable "tenant_id" {
  description = "Azure AD Tenant ID"
  type        = string
}

variable "sku_name" {
  description = "SKU del Key Vault (standard o premium)"
  type        = string
  default     = "standard"
}

variable "purge_protection" {
  description = "Habilitar proteccion contra purga"
  type        = bool
  default     = false
}

variable "secrets" {
  description = "Mapa de secretos a crear"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Tags para los recursos"
  type        = map(string)
  default     = {}
}
