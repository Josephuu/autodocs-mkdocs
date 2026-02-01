variable "zone_name" {
  description = "Nombre de la zona DNS (ej: ejemplo.com)"
  type        = string
}

variable "resource_group_name" {
  description = "Nombre del Resource Group"
  type        = string
}

variable "root_ip" {
  description = "IP para el registro A raíz"
  type        = string
}

variable "ttl" {
  description = "Time To Live para los registros DNS"
  type        = number
  default     = 300
}

variable "tags" {
  description = "Tags para los recursos"
  type        = map(string)
  default     = {}
}
