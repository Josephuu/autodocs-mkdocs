# Terraform KeyVault Module

Azure Key Vault para gestion segura de secretos y keys.

## Uso

```hcl
module "keyvault" {
  source = "./modules/keyvault"

  name                = "my-keyvault"
  resource_group_name = "my-rg"
  tenant_id           = var.tenant_id
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Nombre del Key Vault | `string` | n/a | yes |
| resource_group_name | Nombre del Resource Group | `string` | n/a | yes |
| location | Region de Azure | `string` | `"eastus"` | no |
| tenant_id | Azure AD Tenant ID | `string` | n/a | yes |
| sku_name | SKU del Key Vault | `string` | `"standard"` | no |
| purge_protection | Proteccion contra purga | `bool` | `false` | no |
| secrets | Mapa de secretos a crear | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | ID del Key Vault |
| name | Nombre del Key Vault |
| uri | URI del Key Vault |
| tenant_id | Tenant ID del Key Vault |
