# =============================================================================
# Outputs - Compute
# =============================================================================

output "vm_ids" {
  description = "IDs de las VMs creadas"
  value       = azurerm_linux_virtual_machine.this[*].id
}

output "vm_names" {
  description = "Nombres de las VMs"
  value       = azurerm_linux_virtual_machine.this[*].name
}

output "nic_ids" {
  description = "IDs de las Network Interfaces"
  value       = azurerm_network_interface.this[*].id
}

output "private_ips" {
  description = "IPs privadas de las VMs"
  value       = azurerm_network_interface.this[*].private_ip_address
}
