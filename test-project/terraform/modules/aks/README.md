# aks

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
| [azurerm_kubernetes_cluster.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Nombre del cluster AKS | `string` | n/a | yes |
| <a name="input_dns_prefix"></a> [dns\_prefix](#input\_dns\_prefix) | DNS prefix para el cluster | `string` | n/a | yes |
| <a name="input_enable_auto_scaling"></a> [enable\_auto\_scaling](#input\_enable\_auto\_scaling) | Habilitar auto-scaling del node pool | `bool` | `true` | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | Versión de Kubernetes | `string` | `"1.28"` | no |
| <a name="input_location"></a> [location](#input\_location) | Región de Azure | `string` | `"eastus"` | no |
| <a name="input_max_count"></a> [max\_count](#input\_max\_count) | Máximo de nodos para auto-scaling | `number` | `5` | no |
| <a name="input_min_count"></a> [min\_count](#input\_min\_count) | Mínimo de nodos para auto-scaling | `number` | `1` | no |
| <a name="input_node_count"></a> [node\_count](#input\_node\_count) | Número de nodos inicial | `number` | `2` | no |
| <a name="input_node_vm_size"></a> [node\_vm\_size](#input\_node\_vm\_size) | Tamaño de los nodos | `string` | `"Standard_B2s"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Nombre del Resource Group | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags para los recursos | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | ID del cluster AKS |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | Nombre del cluster |
| <a name="output_host"></a> [host](#output\_host) | Kubernetes host |
| <a name="output_kube_config"></a> [kube\_config](#output\_kube\_config) | Kubeconfig para acceso al cluster (sensitive) |
| <a name="output_node_resource_group"></a> [node\_resource\_group](#output\_node\_resource\_group) | Resource Group de los nodos |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
