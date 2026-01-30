# =============================================================================
# Outputs del Módulo VPC
# =============================================================================

output "vnet_id" {
  description = "ID de la Virtual Network creada"
  value       = azurerm_virtual_network.this.id
}

output "vnet_name" {
  description = "Nombre de la Virtual Network"
  value       = azurerm_virtual_network.this.name
}

output "public_subnet_ids" {
  description = "IDs de las subnets públicas"
  value       = azurerm_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "IDs de las subnets privadas"
  value       = azurerm_subnet.private[*].id
}

output "nsg_id" {
  description = "ID del Network Security Group"
  value       = azurerm_network_security_group.public.id
}

output "resource_group_name" {
  description = "Nombre del Resource Group"
  value       = azurerm_resource_group.this.name
}
