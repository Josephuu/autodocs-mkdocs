#!/usr/bin/env python3
# Corregir el módulo AKS - quitar enable_auto_scaling del default_node_pool

aks_main = '''# =============================================================================
# Módulo: Azure Kubernetes Service (AKS)
# Descripción: Crea clusters de Kubernetes managed
# =============================================================================

resource "azurerm_kubernetes_cluster" "this" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version

  default_node_pool {
    name       = "default"
    node_count = var.node_count
    vm_size    = var.node_vm_size
    type       = "VirtualMachineScaleSets"
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
  }

  tags = var.tags
}
'''

with open('/workspace/test-project/terraform/modules/aks/main.tf', 'w') as f:
    f.write(aks_main)

print('✅ AKS corregido (quitado enable_auto_scaling)')
