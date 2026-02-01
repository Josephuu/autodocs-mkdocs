# outputs.tf - Output values for Storage module

output "storage_account_id" {
  description = "The ID of the storage account"
  value       = azurerm_storage_account.main.id
}

output "storage_account_name" {
  description = "The name of the storage account"
  value       = azurerm_storage_account.main.name
}

output "primary_blob_endpoint" {
  description = "The primary blob endpoint URL"
  value       = azurerm_storage_account.main.primary_blob_endpoint
}

output "primary_file_endpoint" {
  description = "The primary file endpoint URL"
  value       = azurerm_storage_account.main.primary_file_endpoint
}

output "primary_access_key" {
  description = "The primary access key for the storage account"
  value       = azurerm_storage_account.main.primary_access_key
  sensitive   = true
}

output "primary_connection_string" {
  description = "The primary connection string for the storage account"
  value       = azurerm_storage_account.main.primary_connection_string
  sensitive   = true
}

output "container_ids" {
  description = "Map of container names to their IDs"
  value       = { for k, v in azurerm_storage_container.containers : k => v.id }
}

output "file_share_ids" {
  description = "Map of file share names to their IDs"
  value       = { for k, v in azurerm_storage_share.shares : k => v.id }
}
