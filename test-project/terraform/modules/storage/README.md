# storage

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.58.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_storage_account.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_container.containers](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_management_policy.lifecycle](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_management_policy) | resource |
| [azurerm_storage_share.shares](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_share) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_tier"></a> [access\_tier](#input\_access\_tier) | Access tier for BlobStorage/StorageV2 (Hot or Cool) | `string` | `"Hot"` | no |
| <a name="input_account_kind"></a> [account\_kind](#input\_account\_kind) | Storage account kind (StorageV2, BlobStorage, BlockBlobStorage, FileStorage) | `string` | `"StorageV2"` | no |
| <a name="input_account_tier"></a> [account\_tier](#input\_account\_tier) | Storage account tier (Standard or Premium) | `string` | `"Standard"` | no |
| <a name="input_allowed_ip_ranges"></a> [allowed\_ip\_ranges](#input\_allowed\_ip\_ranges) | List of allowed IP ranges when network rules are enabled | `list(string)` | `[]` | no |
| <a name="input_allowed_subnet_ids"></a> [allowed\_subnet\_ids](#input\_allowed\_subnet\_ids) | List of allowed subnet IDs when network rules are enabled | `list(string)` | `[]` | no |
| <a name="input_blob_soft_delete_days"></a> [blob\_soft\_delete\_days](#input\_blob\_soft\_delete\_days) | Number of days to retain soft-deleted blobs (0 to disable) | `number` | `7` | no |
| <a name="input_container_soft_delete_days"></a> [container\_soft\_delete\_days](#input\_container\_soft\_delete\_days) | Number of days to retain soft-deleted containers (0 to disable) | `number` | `7` | no |
| <a name="input_containers"></a> [containers](#input\_containers) | List of blob containers to create | <pre>list(object({<br>    name        = string<br>    access_type = string<br>  }))</pre> | `[]` | no |
| <a name="input_days_to_archive_tier"></a> [days\_to\_archive\_tier](#input\_days\_to\_archive\_tier) | Days after which to move blobs to archive tier | `number` | `90` | no |
| <a name="input_days_to_cool_tier"></a> [days\_to\_cool\_tier](#input\_days\_to\_cool\_tier) | Days after which to move blobs to cool tier | `number` | `30` | no |
| <a name="input_days_to_delete"></a> [days\_to\_delete](#input\_days\_to\_delete) | Days after which to delete blobs | `number` | `365` | no |
| <a name="input_enable_lifecycle_policy"></a> [enable\_lifecycle\_policy](#input\_enable\_lifecycle\_policy) | Enable lifecycle management policy | `bool` | `false` | no |
| <a name="input_enable_network_rules"></a> [enable\_network\_rules](#input\_enable\_network\_rules) | Enable network rules to restrict access | `bool` | `false` | no |
| <a name="input_enable_versioning"></a> [enable\_versioning](#input\_enable\_versioning) | Enable blob versioning | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name (dev, staging, production) | `string` | `"dev"` | no |
| <a name="input_file_shares"></a> [file\_shares](#input\_file\_shares) | List of file shares to create | <pre>list(object({<br>    name        = string<br>    quota_gb    = number<br>    access_tier = string<br>  }))</pre> | `[]` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure region for the storage account | `string` | `"eastus"` | no |
| <a name="input_replication_type"></a> [replication\_type](#input\_replication\_type) | Storage replication type (LRS, GRS, RAGRS, ZRS, GZRS, RAGZRS) | `string` | `"LRS"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the Azure resource group | `string` | n/a | yes |
| <a name="input_shared_access_key_enabled"></a> [shared\_access\_key\_enabled](#input\_shared\_access\_key\_enabled) | Enable shared access key for the storage account | `bool` | `true` | no |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | Name of the storage account (must be globally unique, 3-24 chars, lowercase letters and numbers only) | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_container_ids"></a> [container\_ids](#output\_container\_ids) | Map of container names to their IDs |
| <a name="output_file_share_ids"></a> [file\_share\_ids](#output\_file\_share\_ids) | Map of file share names to their IDs |
| <a name="output_primary_access_key"></a> [primary\_access\_key](#output\_primary\_access\_key) | The primary access key for the storage account |
| <a name="output_primary_blob_endpoint"></a> [primary\_blob\_endpoint](#output\_primary\_blob\_endpoint) | The primary blob endpoint URL |
| <a name="output_primary_connection_string"></a> [primary\_connection\_string](#output\_primary\_connection\_string) | The primary connection string for the storage account |
| <a name="output_primary_file_endpoint"></a> [primary\_file\_endpoint](#output\_primary\_file\_endpoint) | The primary file endpoint URL |
| <a name="output_storage_account_id"></a> [storage\_account\_id](#output\_storage\_account\_id) | The ID of the storage account |
| <a name="output_storage_account_name"></a> [storage\_account\_name](#output\_storage\_account\_name) | The name of the storage account |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.58.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_storage_account.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_container.containers](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_management_policy.lifecycle](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_management_policy) | resource |
| [azurerm_storage_share.shares](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_share) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_tier"></a> [access\_tier](#input\_access\_tier) | Access tier for BlobStorage/StorageV2 (Hot or Cool) | `string` | `"Hot"` | no |
| <a name="input_account_kind"></a> [account\_kind](#input\_account\_kind) | Storage account kind (StorageV2, BlobStorage, BlockBlobStorage, FileStorage) | `string` | `"StorageV2"` | no |
| <a name="input_account_tier"></a> [account\_tier](#input\_account\_tier) | Storage account tier (Standard or Premium) | `string` | `"Standard"` | no |
| <a name="input_allowed_ip_ranges"></a> [allowed\_ip\_ranges](#input\_allowed\_ip\_ranges) | List of allowed IP ranges when network rules are enabled | `list(string)` | `[]` | no |
| <a name="input_allowed_subnet_ids"></a> [allowed\_subnet\_ids](#input\_allowed\_subnet\_ids) | List of allowed subnet IDs when network rules are enabled | `list(string)` | `[]` | no |
| <a name="input_blob_soft_delete_days"></a> [blob\_soft\_delete\_days](#input\_blob\_soft\_delete\_days) | Number of days to retain soft-deleted blobs (0 to disable) | `number` | `7` | no |
| <a name="input_container_soft_delete_days"></a> [container\_soft\_delete\_days](#input\_container\_soft\_delete\_days) | Number of days to retain soft-deleted containers (0 to disable) | `number` | `7` | no |
| <a name="input_containers"></a> [containers](#input\_containers) | List of blob containers to create | <pre>list(object({<br>    name        = string<br>    access_type = string<br>  }))</pre> | `[]` | no |
| <a name="input_days_to_archive_tier"></a> [days\_to\_archive\_tier](#input\_days\_to\_archive\_tier) | Days after which to move blobs to archive tier | `number` | `90` | no |
| <a name="input_days_to_cool_tier"></a> [days\_to\_cool\_tier](#input\_days\_to\_cool\_tier) | Days after which to move blobs to cool tier | `number` | `30` | no |
| <a name="input_days_to_delete"></a> [days\_to\_delete](#input\_days\_to\_delete) | Days after which to delete blobs | `number` | `365` | no |
| <a name="input_enable_lifecycle_policy"></a> [enable\_lifecycle\_policy](#input\_enable\_lifecycle\_policy) | Enable lifecycle management policy | `bool` | `false` | no |
| <a name="input_enable_network_rules"></a> [enable\_network\_rules](#input\_enable\_network\_rules) | Enable network rules to restrict access | `bool` | `false` | no |
| <a name="input_enable_versioning"></a> [enable\_versioning](#input\_enable\_versioning) | Enable blob versioning | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name (dev, staging, production) | `string` | `"dev"` | no |
| <a name="input_file_shares"></a> [file\_shares](#input\_file\_shares) | List of file shares to create | <pre>list(object({<br>    name        = string<br>    quota_gb    = number<br>    access_tier = string<br>  }))</pre> | `[]` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure region for the storage account | `string` | `"eastus"` | no |
| <a name="input_replication_type"></a> [replication\_type](#input\_replication\_type) | Storage replication type (LRS, GRS, RAGRS, ZRS, GZRS, RAGZRS) | `string` | `"LRS"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the Azure resource group | `string` | n/a | yes |
| <a name="input_shared_access_key_enabled"></a> [shared\_access\_key\_enabled](#input\_shared\_access\_key\_enabled) | Enable shared access key for the storage account | `bool` | `true` | no |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | Name of the storage account (must be globally unique, 3-24 chars, lowercase letters and numbers only) | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_container_ids"></a> [container\_ids](#output\_container\_ids) | Map of container names to their IDs |
| <a name="output_file_share_ids"></a> [file\_share\_ids](#output\_file\_share\_ids) | Map of file share names to their IDs |
| <a name="output_primary_access_key"></a> [primary\_access\_key](#output\_primary\_access\_key) | The primary access key for the storage account |
| <a name="output_primary_blob_endpoint"></a> [primary\_blob\_endpoint](#output\_primary\_blob\_endpoint) | The primary blob endpoint URL |
| <a name="output_primary_connection_string"></a> [primary\_connection\_string](#output\_primary\_connection\_string) | The primary connection string for the storage account |
| <a name="output_primary_file_endpoint"></a> [primary\_file\_endpoint](#output\_primary\_file\_endpoint) | The primary file endpoint URL |
| <a name="output_storage_account_id"></a> [storage\_account\_id](#output\_storage\_account\_id) | The ID of the storage account |
| <a name="output_storage_account_name"></a> [storage\_account\_name](#output\_storage\_account\_name) | The name of the storage account |
<!-- END_TF_DOCS -->
