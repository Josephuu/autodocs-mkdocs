# =============================================================================
# Variables del Módulo VPC
# =============================================================================

variable "resource_group_name" {
  description = "Nombre del Resource Group de Azure"
  type        = string
}

variable "location" {
  description = "Región de Azure donde se desplegará la infraestructura"
  type        = string
  default     = "eastus"
}

variable "vnet_name" {
  description = "Nombre de la Virtual Network"
  type        = string
}

variable "address_space" {
  description = "Espacio de direcciones IP de la VNet (CIDR)"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "public_subnets" {
  description = "Lista de CIDRs para subnets públicas"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  description = "Lista de CIDRs para subnets privadas"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "environment" {
  description = "Ambiente de despliegue (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "tags" {
  description = "Tags para todos los recursos"
  type        = map(string)
  default = {
    ManagedBy = "Terraform"
    Project   = "Infrastructure"
  }
}
