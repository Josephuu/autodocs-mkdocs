# =============================================================================
# Variables - AKS
# =============================================================================

variable "cluster_name" {
  description = "Nombre del cluster AKS"
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

variable "dns_prefix" {
  description = "DNS prefix para el cluster"
  type        = string
}

variable "kubernetes_version" {
  description = "Versión de Kubernetes"
  type        = string
  default     = "1.28"
}

variable "node_count" {
  description = "Número de nodos inicial"
  type        = number
  default     = 2
}

variable "node_vm_size" {
  description = "Tamaño de los nodos"
  type        = string
  default     = "Standard_B2s"
}

variable "enable_auto_scaling" {
  description = "Habilitar auto-scaling del node pool"
  type        = bool
  default     = true
}

variable "min_count" {
  description = "Mínimo de nodos para auto-scaling"
  type        = number
  default     = 1
}

variable "max_count" {
  description = "Máximo de nodos para auto-scaling"
  type        = number
  default     = 5
}

variable "tags" {
  description = "Tags para los recursos"
  type        = map(string)
  default     = {}
}
