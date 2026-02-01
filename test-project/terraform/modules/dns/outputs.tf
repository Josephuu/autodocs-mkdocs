output "zone_id" {
  description = "ID de la zona DNS"
  value       = azurerm_dns_zone.this.id
}

output "name_servers" {
  description = "Name servers de la zona"
  value       = azurerm_dns_zone.this.name_servers
}

output "zone_name" {
  description = "Nombre de la zona creada"
  value       = azurerm_dns_zone.this.name
}
