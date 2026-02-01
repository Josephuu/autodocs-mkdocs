variable "resource_group_name" {
  description = "Nombre del Resource Group"
  type        = string
}

variable "location" {
  description = "Región de Azure"
  type        = string
  default     = "eastus"
}

variable "tags" {
  description = "Tags para los recursos"
  type        = map(string)
  default     = {}
}
