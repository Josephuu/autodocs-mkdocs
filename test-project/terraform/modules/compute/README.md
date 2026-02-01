# compute

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
| [azurerm_availability_set.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/availability_set) | resource |
| [azurerm_linux_virtual_machine.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_managed_disk.data](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_disk) | resource |
| [azurerm_network_interface.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_virtual_machine_data_disk_attachment.linux](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_data_disk_attachment) | resource |
| [azurerm_virtual_machine_data_disk_attachment.windows](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_data_disk_attachment) | resource |
| [azurerm_windows_virtual_machine.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | Administrator password for Windows VMs | `string` | `null` | no |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | Administrator username for the VM | `string` | `"azureuser"` | no |
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | Availability zone for the VM (1, 2, or 3) | `string` | `null` | no |
| <a name="input_boot_diagnostics_storage_uri"></a> [boot\_diagnostics\_storage\_uri](#input\_boot\_diagnostics\_storage\_uri) | URI of storage account for boot diagnostics (null to disable) | `string` | `null` | no |
| <a name="input_data_disks"></a> [data\_disks](#input\_data\_disks) | List of data disks to attach to the VM | <pre>list(object({<br>    name                 = string<br>    disk_size_gb         = number<br>    storage_account_type = string<br>    lun                  = number<br>    caching              = string<br>  }))</pre> | `[]` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name (dev, staging, production) | `string` | `"dev"` | no |
| <a name="input_fault_domain_count"></a> [fault\_domain\_count](#input\_fault\_domain\_count) | Number of fault domains for availability set | `number` | `2` | no |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | Type of managed identity (SystemAssigned, UserAssigned, or both) | `string` | `"SystemAssigned"` | no |
| <a name="input_image_offer"></a> [image\_offer](#input\_image\_offer) | Offer of the VM image | `string` | `"0001-com-ubuntu-server-jammy"` | no |
| <a name="input_image_publisher"></a> [image\_publisher](#input\_image\_publisher) | Publisher of the VM image | `string` | `"Canonical"` | no |
| <a name="input_image_sku"></a> [image\_sku](#input\_image\_sku) | SKU of the VM image | `string` | `"22_04-lts-gen2"` | no |
| <a name="input_image_version"></a> [image\_version](#input\_image\_version) | Version of the VM image | `string` | `"latest"` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure region for the virtual machine | `string` | `"eastus"` | no |
| <a name="input_os_disk_size_gb"></a> [os\_disk\_size\_gb](#input\_os\_disk\_size\_gb) | Size of OS disk in GB | `number` | `128` | no |
| <a name="input_os_disk_type"></a> [os\_disk\_type](#input\_os\_disk\_type) | Storage account type for OS disk (Standard\_LRS, Premium\_LRS, StandardSSD\_LRS) | `string` | `"Premium_LRS"` | no |
| <a name="input_os_type"></a> [os\_type](#input\_os\_type) | Operating system type (linux or windows) | `string` | `"linux"` | no |
| <a name="input_private_ip_address"></a> [private\_ip\_address](#input\_private\_ip\_address) | Static private IP address (null for dynamic) | `string` | `null` | no |
| <a name="input_public_ip_address_id"></a> [public\_ip\_address\_id](#input\_public\_ip\_address\_id) | ID of an existing public IP address to attach | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the Azure resource group | `string` | n/a | yes |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | SSH public key for Linux VMs | `string` | `null` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | ID of the subnet for the VM network interface | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to all resources | `map(string)` | `{}` | no |
| <a name="input_update_domain_count"></a> [update\_domain\_count](#input\_update\_domain\_count) | Number of update domains for availability set | `number` | `5` | no |
| <a name="input_use_availability_set"></a> [use\_availability\_set](#input\_use\_availability\_set) | Use availability set for the VM | `bool` | `false` | no |
| <a name="input_vm_count"></a> [vm\_count](#input\_vm\_count) | Number of VMs to create | `number` | `1` | no |
| <a name="input_vm_name"></a> [vm\_name](#input\_vm\_name) | Name of the virtual machine | `string` | n/a | yes |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | Size of the virtual machine (e.g., Standard\_D2s\_v3) | `string` | `"Standard_D2s_v3"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_availability_set_id"></a> [availability\_set\_id](#output\_availability\_set\_id) | ID of the availability set (if created) |
| <a name="output_data_disk_ids"></a> [data\_disk\_ids](#output\_data\_disk\_ids) | Map of data disk names to their IDs |
| <a name="output_identity_principal_ids"></a> [identity\_principal\_ids](#output\_identity\_principal\_ids) | List of managed identity principal IDs |
| <a name="output_network_interface_ids"></a> [network\_interface\_ids](#output\_network\_interface\_ids) | List of network interface IDs |
| <a name="output_private_ip_addresses"></a> [private\_ip\_addresses](#output\_private\_ip\_addresses) | List of private IP addresses |
| <a name="output_vm_ids"></a> [vm\_ids](#output\_vm\_ids) | List of virtual machine IDs |
| <a name="output_vm_names"></a> [vm\_names](#output\_vm\_names) | List of virtual machine names |
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
| [azurerm_availability_set.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/availability_set) | resource |
| [azurerm_linux_virtual_machine.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_managed_disk.data](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_disk) | resource |
| [azurerm_network_interface.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_virtual_machine_data_disk_attachment.linux](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_data_disk_attachment) | resource |
| [azurerm_virtual_machine_data_disk_attachment.windows](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_data_disk_attachment) | resource |
| [azurerm_windows_virtual_machine.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | Administrator password for Windows VMs | `string` | `null` | no |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | Administrator username for the VM | `string` | `"azureuser"` | no |
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | Availability zone for the VM (1, 2, or 3) | `string` | `null` | no |
| <a name="input_boot_diagnostics_storage_uri"></a> [boot\_diagnostics\_storage\_uri](#input\_boot\_diagnostics\_storage\_uri) | URI of storage account for boot diagnostics (null to disable) | `string` | `null` | no |
| <a name="input_data_disks"></a> [data\_disks](#input\_data\_disks) | List of data disks to attach to the VM | <pre>list(object({<br>    name                 = string<br>    disk_size_gb         = number<br>    storage_account_type = string<br>    lun                  = number<br>    caching              = string<br>  }))</pre> | `[]` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name (dev, staging, production) | `string` | `"dev"` | no |
| <a name="input_fault_domain_count"></a> [fault\_domain\_count](#input\_fault\_domain\_count) | Number of fault domains for availability set | `number` | `2` | no |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | Type of managed identity (SystemAssigned, UserAssigned, or both) | `string` | `"SystemAssigned"` | no |
| <a name="input_image_offer"></a> [image\_offer](#input\_image\_offer) | Offer of the VM image | `string` | `"0001-com-ubuntu-server-jammy"` | no |
| <a name="input_image_publisher"></a> [image\_publisher](#input\_image\_publisher) | Publisher of the VM image | `string` | `"Canonical"` | no |
| <a name="input_image_sku"></a> [image\_sku](#input\_image\_sku) | SKU of the VM image | `string` | `"22_04-lts-gen2"` | no |
| <a name="input_image_version"></a> [image\_version](#input\_image\_version) | Version of the VM image | `string` | `"latest"` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure region for the virtual machine | `string` | `"eastus"` | no |
| <a name="input_os_disk_size_gb"></a> [os\_disk\_size\_gb](#input\_os\_disk\_size\_gb) | Size of OS disk in GB | `number` | `128` | no |
| <a name="input_os_disk_type"></a> [os\_disk\_type](#input\_os\_disk\_type) | Storage account type for OS disk (Standard\_LRS, Premium\_LRS, StandardSSD\_LRS) | `string` | `"Premium_LRS"` | no |
| <a name="input_os_type"></a> [os\_type](#input\_os\_type) | Operating system type (linux or windows) | `string` | `"linux"` | no |
| <a name="input_private_ip_address"></a> [private\_ip\_address](#input\_private\_ip\_address) | Static private IP address (null for dynamic) | `string` | `null` | no |
| <a name="input_public_ip_address_id"></a> [public\_ip\_address\_id](#input\_public\_ip\_address\_id) | ID of an existing public IP address to attach | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the Azure resource group | `string` | n/a | yes |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | SSH public key for Linux VMs | `string` | `null` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | ID of the subnet for the VM network interface | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to all resources | `map(string)` | `{}` | no |
| <a name="input_update_domain_count"></a> [update\_domain\_count](#input\_update\_domain\_count) | Number of update domains for availability set | `number` | `5` | no |
| <a name="input_use_availability_set"></a> [use\_availability\_set](#input\_use\_availability\_set) | Use availability set for the VM | `bool` | `false` | no |
| <a name="input_vm_count"></a> [vm\_count](#input\_vm\_count) | Number of VMs to create | `number` | `1` | no |
| <a name="input_vm_name"></a> [vm\_name](#input\_vm\_name) | Name of the virtual machine | `string` | n/a | yes |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | Size of the virtual machine (e.g., Standard\_D2s\_v3) | `string` | `"Standard_D2s_v3"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_availability_set_id"></a> [availability\_set\_id](#output\_availability\_set\_id) | ID of the availability set (if created) |
| <a name="output_data_disk_ids"></a> [data\_disk\_ids](#output\_data\_disk\_ids) | Map of data disk names to their IDs |
| <a name="output_identity_principal_ids"></a> [identity\_principal\_ids](#output\_identity\_principal\_ids) | List of managed identity principal IDs |
| <a name="output_network_interface_ids"></a> [network\_interface\_ids](#output\_network\_interface\_ids) | List of network interface IDs |
| <a name="output_private_ip_addresses"></a> [private\_ip\_addresses](#output\_private\_ip\_addresses) | List of private IP addresses |
| <a name="output_vm_ids"></a> [vm\_ids](#output\_vm\_ids) | List of virtual machine IDs |
| <a name="output_vm_names"></a> [vm\_names](#output\_vm\_names) | List of virtual machine names |
<!-- END_TF_DOCS -->
