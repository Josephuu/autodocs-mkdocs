# storage

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.58.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_storage_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_container.blobs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_tier"></a> [account\_tier](#input\_account\_tier) | Tier del storage (Standard o Premium) | `string` | `"Standard"` | no |
| <a name="input_container_names"></a> [container\_names](#input\_container\_names) | Lista de nombres de containers blob | `list(string)` | <pre>[<br>  "data",<br>  "logs"<br>]</pre> | no |
| <a name="input_location"></a> [location](#input\_location) | Región de Azure | `string` | `"eastus"` | no |
| <a name="input_replication_type"></a> [replication\_type](#input\_replication\_type) | Tipo de replicación (LRS, GRS, ZRS, etc.) | `string` | `"LRS"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Nombre del Resource Group | `string` | n/a | yes |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | Nombre único del storage account (3-24 chars, lowercase) | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags para los recursos | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_blob_endpoint"></a> [blob\_endpoint](#output\_blob\_endpoint) | Blob service endpoint |
| <a name="output_primary_access_key"></a> [primary\_access\_key](#output\_primary\_access\_key) | Primary access key (sensitive) |
| <a name="output_storage_account_id"></a> [storage\_account\_id](#output\_storage\_account\_id) | ID del Storage Account |
| <a name="output_storage_account_name"></a> [storage\_account\_name](#output\_storage\_account\_name) | Nombre del Storage Account |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
