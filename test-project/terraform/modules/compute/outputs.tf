# outputs.tf - Output values for Compute module

output "vm_ids" {
  description = "List of virtual machine IDs"
  value = var.os_type == "linux" ? [
    for vm in azurerm_linux_virtual_machine.main : vm.id
    ] : [
    for vm in azurerm_windows_virtual_machine.main : vm.id
  ]
}

output "vm_names" {
  description = "List of virtual machine names"
  value = var.os_type == "linux" ? [
    for vm in azurerm_linux_virtual_machine.main : vm.name
    ] : [
    for vm in azurerm_windows_virtual_machine.main : vm.name
  ]
}

output "private_ip_addresses" {
  description = "List of private IP addresses"
  value       = [for nic in azurerm_network_interface.main : nic.private_ip_address]
}

output "network_interface_ids" {
  description = "List of network interface IDs"
  value       = [for nic in azurerm_network_interface.main : nic.id]
}

output "availability_set_id" {
  description = "ID of the availability set (if created)"
  value       = var.use_availability_set ? azurerm_availability_set.main[0].id : null
}

output "identity_principal_ids" {
  description = "List of managed identity principal IDs"
  value = var.os_type == "linux" ? [
    for vm in azurerm_linux_virtual_machine.main : vm.identity[0].principal_id
    ] : [
    for vm in azurerm_windows_virtual_machine.main : vm.identity[0].principal_id
  ]
}

output "data_disk_ids" {
  description = "Map of data disk names to their IDs"
  value       = { for k, v in azurerm_managed_disk.data : k => v.id }
}
