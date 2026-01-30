# aks

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
| [azurerm_kubernetes_cluster.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) | resource |
| [azurerm_kubernetes_cluster_node_pool.user](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster_node_pool) | resource |
| [azurerm_role_assignment.acr_pull](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acr_id"></a> [acr\_id](#input\_acr\_id) | ID of Azure Container Registry for image pull | `string` | `null` | no |
| <a name="input_admin_group_object_ids"></a> [admin\_group\_object\_ids](#input\_admin\_group\_object\_ids) | List of Azure AD group object IDs for cluster admin | `list(string)` | `[]` | no |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | List of availability zones for node pools | `list(string)` | <pre>[<br>  "1",<br>  "2",<br>  "3"<br>]</pre> | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the AKS cluster | `string` | n/a | yes |
| <a name="input_dns_prefix"></a> [dns\_prefix](#input\_dns\_prefix) | DNS prefix for the AKS cluster | `string` | n/a | yes |
| <a name="input_dns_service_ip"></a> [dns\_service\_ip](#input\_dns\_service\_ip) | DNS service IP address | `string` | `"10.0.0.10"` | no |
| <a name="input_enable_auto_scaling"></a> [enable\_auto\_scaling](#input\_enable\_auto\_scaling) | Enable cluster auto-scaler | `bool` | `true` | no |
| <a name="input_enable_azure_rbac"></a> [enable\_azure\_rbac](#input\_enable\_azure\_rbac) | Enable Azure AD RBAC for Kubernetes | `bool` | `false` | no |
| <a name="input_enable_key_vault_secrets_provider"></a> [enable\_key\_vault\_secrets\_provider](#input\_enable\_key\_vault\_secrets\_provider) | Enable Key Vault secrets provider | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name (dev, staging, production) | `string` | `"dev"` | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | Kubernetes version for the cluster | `string` | `"1.28"` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure region for the AKS cluster | `string` | `"eastus"` | no |
| <a name="input_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#input\_log\_analytics\_workspace\_id) | ID of Log Analytics workspace for monitoring | `string` | `null` | no |
| <a name="input_max_pods_per_node"></a> [max\_pods\_per\_node](#input\_max\_pods\_per\_node) | Maximum number of pods per node | `number` | `110` | no |
| <a name="input_network_plugin"></a> [network\_plugin](#input\_network\_plugin) | Network plugin for AKS (azure or kubenet) | `string` | `"azure"` | no |
| <a name="input_network_policy"></a> [network\_policy](#input\_network\_policy) | Network policy for AKS (azure, calico, or null) | `string` | `"azure"` | no |
| <a name="input_outbound_type"></a> [outbound\_type](#input\_outbound\_type) | Outbound routing type (loadBalancer, userDefinedRouting) | `string` | `"loadBalancer"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the Azure resource group | `string` | n/a | yes |
| <a name="input_service_cidr"></a> [service\_cidr](#input\_service\_cidr) | CIDR for Kubernetes services | `string` | `"10.0.0.0/16"` | no |
| <a name="input_sku_tier"></a> [sku\_tier](#input\_sku\_tier) | SKU tier for the AKS cluster (Free or Standard) | `string` | `"Free"` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | ID of the subnet for AKS nodes | `string` | n/a | yes |
| <a name="input_system_node_count"></a> [system\_node\_count](#input\_system\_node\_count) | Number of nodes in the system node pool | `number` | `2` | no |
| <a name="input_system_node_max_count"></a> [system\_node\_max\_count](#input\_system\_node\_max\_count) | Maximum number of system nodes (when auto-scaling) | `number` | `5` | no |
| <a name="input_system_node_min_count"></a> [system\_node\_min\_count](#input\_system\_node\_min\_count) | Minimum number of system nodes (when auto-scaling) | `number` | `2` | no |
| <a name="input_system_node_os_disk_size"></a> [system\_node\_os\_disk\_size](#input\_system\_node\_os\_disk\_size) | OS disk size in GB for system nodes | `number` | `128` | no |
| <a name="input_system_node_os_disk_type"></a> [system\_node\_os\_disk\_type](#input\_system\_node\_os\_disk\_type) | OS disk type for system nodes (Managed, Ephemeral) | `string` | `"Managed"` | no |
| <a name="input_system_node_vm_size"></a> [system\_node\_vm\_size](#input\_system\_node\_vm\_size) | VM size for system node pool | `string` | `"Standard_D2s_v3"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to all resources | `map(string)` | `{}` | no |
| <a name="input_user_node_pools"></a> [user\_node\_pools](#input\_user\_node\_pools) | List of user node pools | <pre>list(object({<br>    name                = string<br>    vm_size             = string<br>    node_count          = number<br>    os_disk_size_gb     = number<br>    os_disk_type        = string<br>    enable_auto_scaling = bool<br>    min_count           = number<br>    max_count           = number<br>    node_labels         = map(string)<br>    node_taints         = list(string)<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_client_certificate"></a> [client\_certificate](#output\_client\_certificate) | Base64 encoded client certificate |
| <a name="output_client_key"></a> [client\_key](#output\_client\_key) | Base64 encoded client key |
| <a name="output_cluster_ca_certificate"></a> [cluster\_ca\_certificate](#output\_cluster\_ca\_certificate) | Base64 encoded cluster CA certificate |
| <a name="output_cluster_fqdn"></a> [cluster\_fqdn](#output\_cluster\_fqdn) | The FQDN of the AKS cluster |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | The ID of the AKS cluster |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | The name of the AKS cluster |
| <a name="output_host"></a> [host](#output\_host) | Kubernetes API server host |
| <a name="output_identity_principal_id"></a> [identity\_principal\_id](#output\_identity\_principal\_id) | Principal ID of the cluster managed identity |
| <a name="output_kube_admin_config"></a> [kube\_admin\_config](#output\_kube\_admin\_config) | Kubernetes admin configuration |
| <a name="output_kube_config"></a> [kube\_config](#output\_kube\_config) | Kubernetes configuration for kubectl |
| <a name="output_kubelet_identity"></a> [kubelet\_identity](#output\_kubelet\_identity) | Kubelet managed identity |
| <a name="output_node_resource_group"></a> [node\_resource\_group](#output\_node\_resource\_group) | Auto-generated resource group for AKS nodes |
| <a name="output_oidc_issuer_url"></a> [oidc\_issuer\_url](#output\_oidc\_issuer\_url) | OIDC issuer URL for workload identity |
| <a name="output_user_node_pool_ids"></a> [user\_node\_pool\_ids](#output\_user\_node\_pool\_ids) | Map of user node pool names to their IDs |
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
| [azurerm_kubernetes_cluster.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) | resource |
| [azurerm_kubernetes_cluster_node_pool.user](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster_node_pool) | resource |
| [azurerm_role_assignment.acr_pull](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acr_id"></a> [acr\_id](#input\_acr\_id) | ID of Azure Container Registry for image pull | `string` | `null` | no |
| <a name="input_admin_group_object_ids"></a> [admin\_group\_object\_ids](#input\_admin\_group\_object\_ids) | List of Azure AD group object IDs for cluster admin | `list(string)` | `[]` | no |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | List of availability zones for node pools | `list(string)` | <pre>[<br>  "1",<br>  "2",<br>  "3"<br>]</pre> | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the AKS cluster | `string` | n/a | yes |
| <a name="input_dns_prefix"></a> [dns\_prefix](#input\_dns\_prefix) | DNS prefix for the AKS cluster | `string` | n/a | yes |
| <a name="input_dns_service_ip"></a> [dns\_service\_ip](#input\_dns\_service\_ip) | DNS service IP address | `string` | `"10.0.0.10"` | no |
| <a name="input_enable_auto_scaling"></a> [enable\_auto\_scaling](#input\_enable\_auto\_scaling) | Enable cluster auto-scaler | `bool` | `true` | no |
| <a name="input_enable_azure_rbac"></a> [enable\_azure\_rbac](#input\_enable\_azure\_rbac) | Enable Azure AD RBAC for Kubernetes | `bool` | `false` | no |
| <a name="input_enable_key_vault_secrets_provider"></a> [enable\_key\_vault\_secrets\_provider](#input\_enable\_key\_vault\_secrets\_provider) | Enable Key Vault secrets provider | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name (dev, staging, production) | `string` | `"dev"` | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | Kubernetes version for the cluster | `string` | `"1.28"` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure region for the AKS cluster | `string` | `"eastus"` | no |
| <a name="input_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#input\_log\_analytics\_workspace\_id) | ID of Log Analytics workspace for monitoring | `string` | `null` | no |
| <a name="input_max_pods_per_node"></a> [max\_pods\_per\_node](#input\_max\_pods\_per\_node) | Maximum number of pods per node | `number` | `110` | no |
| <a name="input_network_plugin"></a> [network\_plugin](#input\_network\_plugin) | Network plugin for AKS (azure or kubenet) | `string` | `"azure"` | no |
| <a name="input_network_policy"></a> [network\_policy](#input\_network\_policy) | Network policy for AKS (azure, calico, or null) | `string` | `"azure"` | no |
| <a name="input_outbound_type"></a> [outbound\_type](#input\_outbound\_type) | Outbound routing type (loadBalancer, userDefinedRouting) | `string` | `"loadBalancer"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the Azure resource group | `string` | n/a | yes |
| <a name="input_service_cidr"></a> [service\_cidr](#input\_service\_cidr) | CIDR for Kubernetes services | `string` | `"10.0.0.0/16"` | no |
| <a name="input_sku_tier"></a> [sku\_tier](#input\_sku\_tier) | SKU tier for the AKS cluster (Free or Standard) | `string` | `"Free"` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | ID of the subnet for AKS nodes | `string` | n/a | yes |
| <a name="input_system_node_count"></a> [system\_node\_count](#input\_system\_node\_count) | Number of nodes in the system node pool | `number` | `2` | no |
| <a name="input_system_node_max_count"></a> [system\_node\_max\_count](#input\_system\_node\_max\_count) | Maximum number of system nodes (when auto-scaling) | `number` | `5` | no |
| <a name="input_system_node_min_count"></a> [system\_node\_min\_count](#input\_system\_node\_min\_count) | Minimum number of system nodes (when auto-scaling) | `number` | `2` | no |
| <a name="input_system_node_os_disk_size"></a> [system\_node\_os\_disk\_size](#input\_system\_node\_os\_disk\_size) | OS disk size in GB for system nodes | `number` | `128` | no |
| <a name="input_system_node_os_disk_type"></a> [system\_node\_os\_disk\_type](#input\_system\_node\_os\_disk\_type) | OS disk type for system nodes (Managed, Ephemeral) | `string` | `"Managed"` | no |
| <a name="input_system_node_vm_size"></a> [system\_node\_vm\_size](#input\_system\_node\_vm\_size) | VM size for system node pool | `string` | `"Standard_D2s_v3"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to all resources | `map(string)` | `{}` | no |
| <a name="input_user_node_pools"></a> [user\_node\_pools](#input\_user\_node\_pools) | List of user node pools | <pre>list(object({<br>    name                = string<br>    vm_size             = string<br>    node_count          = number<br>    os_disk_size_gb     = number<br>    os_disk_type        = string<br>    enable_auto_scaling = bool<br>    min_count           = number<br>    max_count           = number<br>    node_labels         = map(string)<br>    node_taints         = list(string)<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_client_certificate"></a> [client\_certificate](#output\_client\_certificate) | Base64 encoded client certificate |
| <a name="output_client_key"></a> [client\_key](#output\_client\_key) | Base64 encoded client key |
| <a name="output_cluster_ca_certificate"></a> [cluster\_ca\_certificate](#output\_cluster\_ca\_certificate) | Base64 encoded cluster CA certificate |
| <a name="output_cluster_fqdn"></a> [cluster\_fqdn](#output\_cluster\_fqdn) | The FQDN of the AKS cluster |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | The ID of the AKS cluster |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | The name of the AKS cluster |
| <a name="output_host"></a> [host](#output\_host) | Kubernetes API server host |
| <a name="output_identity_principal_id"></a> [identity\_principal\_id](#output\_identity\_principal\_id) | Principal ID of the cluster managed identity |
| <a name="output_kube_admin_config"></a> [kube\_admin\_config](#output\_kube\_admin\_config) | Kubernetes admin configuration |
| <a name="output_kube_config"></a> [kube\_config](#output\_kube\_config) | Kubernetes configuration for kubectl |
| <a name="output_kubelet_identity"></a> [kubelet\_identity](#output\_kubelet\_identity) | Kubelet managed identity |
| <a name="output_node_resource_group"></a> [node\_resource\_group](#output\_node\_resource\_group) | Auto-generated resource group for AKS nodes |
| <a name="output_oidc_issuer_url"></a> [oidc\_issuer\_url](#output\_oidc\_issuer\_url) | OIDC issuer URL for workload identity |
| <a name="output_user_node_pool_ids"></a> [user\_node\_pool\_ids](#output\_user\_node\_pool\_ids) | Map of user node pool names to their IDs |
<!-- END_TF_DOCS -->
