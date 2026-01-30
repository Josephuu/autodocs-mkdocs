# =============================================================================
# Variables - Compute
# =============================================================================

variable "vm_count" {
  description = "Número de VMs a crear"
  type        = number
  default     = 1
}

variable "vm_name_prefix" {
  description = "Prefijo para los nombres de las VMs"
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

variable "vm_size" {
  description = "Tamaño de la VM (ej: Standard_B2s)"
  type        = string
  default     = "Standard_B2s"
}

variable "os_type" {
  description = "Tipo de OS (Linux o Windows)"
  type        = string
  default     = "Linux"
}

variable "subnet_id" {
  description = "ID de la subnet donde se desplegarán las VMs"
  type        = string
}

variable "admin_username" {
  description = "Usuario administrador"
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key" {
  description = "SSH public key para acceso Linux"
  type        = string
}

variable "create_public_ip" {
  description = "Crear IP pública para las VMs"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags para los recursos"
  type        = map(string)
  default     = {}
}
