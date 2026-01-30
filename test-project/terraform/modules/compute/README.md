# compute

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
| [azurerm_linux_virtual_machine.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_network_interface.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_public_ip.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | Usuario administrador | `string` | `"azureuser"` | no |
| <a name="input_create_public_ip"></a> [create\_public\_ip](#input\_create\_public\_ip) | Crear IP pública para las VMs | `bool` | `true` | no |
| <a name="input_location"></a> [location](#input\_location) | Región de Azure | `string` | `"eastus"` | no |
| <a name="input_os_type"></a> [os\_type](#input\_os\_type) | Tipo de OS (Linux o Windows) | `string` | `"Linux"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Nombre del Resource Group | `string` | n/a | yes |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | SSH public key para acceso Linux | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | ID de la subnet donde se desplegarán las VMs | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags para los recursos | `map(string)` | `{}` | no |
| <a name="input_vm_count"></a> [vm\_count](#input\_vm\_count) | Número de VMs a crear | `number` | `1` | no |
| <a name="input_vm_name_prefix"></a> [vm\_name\_prefix](#input\_vm\_name\_prefix) | Prefijo para los nombres de las VMs | `string` | n/a | yes |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | Tamaño de la VM (ej: Standard\_B2s) | `string` | `"Standard_B2s"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_nic_ids"></a> [nic\_ids](#output\_nic\_ids) | IDs de las Network Interfaces |
| <a name="output_private_ips"></a> [private\_ips](#output\_private\_ips) | IPs privadas de las VMs |
| <a name="output_vm_ids"></a> [vm\_ids](#output\_vm\_ids) | IDs de las VMs creadas |
| <a name="output_vm_names"></a> [vm\_names](#output\_vm\_names) | Nombres de las VMs |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
