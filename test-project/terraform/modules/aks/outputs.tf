# =============================================================================
# Outputs - AKS
# =============================================================================

output "cluster_id" {
  description = "ID del cluster AKS"
  value       = azurerm_kubernetes_cluster.this.id
}

output "cluster_name" {
  description = "Nombre del cluster"
  value       = azurerm_kubernetes_cluster.this.name
}

output "kube_config" {
  description = "Kubeconfig para acceso al cluster (sensitive)"
  value       = azurerm_kubernetes_cluster.this.kube_config_raw
  sensitive   = true
}

output "host" {
  description = "Kubernetes host"
  value       = azurerm_kubernetes_cluster.this.kube_config.0.host
}

output "node_resource_group" {
  description = "Resource Group de los nodos"
  value       = azurerm_kubernetes_cluster.this.node_resource_group
}
