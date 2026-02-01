output "resource_group_id" {
  description = "ID del Resource Group"
  value       = azurerm_resource_group.this.id
}

output "vnet_id" {
  description = "ID de la Virtual Network"
  value       = azurerm_virtual_network.this.id
}

output "subnet_id" {
  description = "ID de la subnet default"
  value       = azurerm_subnet.default.id
}

output "location" {
  description = "Región desplegada"
  value       = azurerm_resource_group.this.location
}
