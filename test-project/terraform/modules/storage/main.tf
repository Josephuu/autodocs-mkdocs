# =============================================================================
# Módulo: Azure Storage Account
# Descripción: Crea Storage Accounts con blobs y file shares
# =============================================================================

resource "azurerm_storage_account" "this" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.replication_type

  tags = var.tags
}

resource "azurerm_storage_container" "blobs" {
  count                 = length(var.container_names)
  name                  = var.container_names[count.index]
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = "private"
}
