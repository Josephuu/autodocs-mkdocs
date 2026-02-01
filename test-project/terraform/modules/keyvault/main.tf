# Azure Key Vault Module
# Creates a Key Vault for storing secrets and keys

resource "azurerm_key_vault" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = var.tenant_id
  sku_name            = var.sku_name

  soft_delete_retention_days = 7
  purge_protection_enabled   = var.purge_protection

  tags = var.tags
}

resource "azurerm_key_vault_secret" "this" {
  for_each = var.secrets

  name         = each.key
  value        = each.value
  key_vault_id = azurerm_key_vault.this.id
}
