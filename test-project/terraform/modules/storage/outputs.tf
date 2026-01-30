# =============================================================================
# Outputs - Storage Account
# =============================================================================

output "storage_account_id" {
  description = "ID del Storage Account"
  value       = azurerm_storage_account.this.id
}

output "storage_account_name" {
  description = "Nombre del Storage Account"
  value       = azurerm_storage_account.this.name
}

output "primary_access_key" {
  description = "Primary access key (sensitive)"
  value       = azurerm_storage_account.this.primary_access_key
  sensitive   = true
}

output "blob_endpoint" {
  description = "Blob service endpoint"
  value       = azurerm_storage_account.this.primary_blob_endpoint
}
