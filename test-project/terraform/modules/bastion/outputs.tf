output "public_ip" {
  description = "IP publica del Bastion"
  value       = azurerm_public_ip.bastion.ip_address
}

output "private_ip" {
  description = "IP privada del Bastion"
  value       = azurerm_network_interface.bastion.private_ip_address
}

output "vm_id" {
  description = "ID de la VM"
  value       = azurerm_linux_virtual_machine.bastion.id
}
