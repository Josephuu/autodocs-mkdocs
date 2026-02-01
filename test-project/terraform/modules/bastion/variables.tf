variable "name" {
  description = "Nombre del Bastion Host"
  type        = string
  default     = "bastion"
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

variable "vm_size" {
  description = "Tamaño de la VM"
  type        = string
  default     = "Standard_B1s"
}

variable "admin_username" {
  description = "Usuario administrador"
  type        = string
  default     = "adminuser"
}

variable "ssh_public_key_path" {
  description = "Ruta a la clave SSH publica"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "subnet_id" {
  description = "ID de la subnet"
  type        = string
}

variable "tags" {
  description = "Tags para los recursos"
  type        = map(string)
  default     = {}
}
