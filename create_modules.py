#!/usr/bin/env python3
import os

# Crear módulo Storage Account
storage_tf = '''# =============================================================================
# Módulo: Azure Storage Account
# Descripción: Crea Storage Accounts con blobs y file shares
# =============================================================================

resource "azurerm_storage_account" "this" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.replication_type

  tags = var.tags
}

resource "azurerm_storage_container" "blobs" {
  count                 = length(var.container_names)
  name                  = var.container_names[count.index]
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = "private"
}
'''

storage_vars = '''# =============================================================================
# Variables - Storage Account
# =============================================================================

variable "storage_account_name" {
  description = "Nombre único del storage account (3-24 chars, lowercase)"
  type        = string
}

variable "resource_group_name" {
  description = "Nombre del Resource Group"
  type        = string
}

variable "location" {
  description = "Región de Azure"
  type        = string
  default     = "eastus"
}

variable "account_tier" {
  description = "Tier del storage (Standard o Premium)"
  type        = string
  default     = "Standard"
}

variable "replication_type" {
  description = "Tipo de replicación (LRS, GRS, ZRS, etc.)"
  type        = string
  default     = "LRS"
}

variable "container_names" {
  description = "Lista de nombres de containers blob"
  type        = list(string)
  default     = ["data", "logs"]
}

variable "tags" {
  description = "Tags para los recursos"
  type        = map(string)
  default     = {}
}
'''

storage_outputs = '''# =============================================================================
# Outputs - Storage Account
# =============================================================================

output "storage_account_id" {
  description = "ID del Storage Account"
  value       = azurerm_storage_account.this.id
}

output "storage_account_name" {
  description = "Nombre del Storage Account"
  value       = azurerm_storage_account.this.name
}

output "primary_access_key" {
  description = "Primary access key (sensitive)"
  value       = azurerm_storage_account.this.primary_access_key
  sensitive   = true
}

output "blob_endpoint" {
  description = "Blob service endpoint"
  value       = azurerm_storage_account.this.primary_blob_endpoint
}
'''

# Crear módulo Compute (VMs)
compute_tf = '''# =============================================================================
# Módulo: Azure Compute (VMs)
# Descripción: Crea Virtual Machines Linux/Windows
# =============================================================================

resource "azurerm_network_interface" "this" {
  count               = var.vm_count
  name                = "\${var.vm_name_prefix}-nic-\${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.create_public_ip ? azurerm_public_ip.this[count.index].id : null
  }
}

resource "azurerm_public_ip" "this" {
  count               = var.create_public_ip ? var.vm_count : 0
  name                = "\${var.vm_name_prefix}-pip-\${count.index + 1}"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Dynamic"
}

resource "azurerm_linux_virtual_machine" "this" {
  count               = var.os_type == "Linux" ? var.vm_count : 0
  name                = "\${var.vm_name_prefix}-\${count.index + 1}"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_username

  network_interface_ids = [
    azurerm_network_interface.this[count.index].id,
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
'''

compute_vars = '''# =============================================================================
# Variables - Compute
# =============================================================================

variable "vm_count" {
  description = "Número de VMs a crear"
  type        = number
  default     = 1
}

variable "vm_name_prefix" {
  description = "Prefijo para los nombres de las VMs"
  type        = string
}

variable "resource_group_name" {
  description = "Nombre del Resource Group"
  type        = string
}

variable "location" {
  description = "Región de Azure"
  type        = string
  default     = "eastus"
}

variable "vm_size" {
  description = "Tamaño de la VM (ej: Standard_B2s)"
  type        = string
  default     = "Standard_B2s"
}

variable "os_type" {
  description = "Tipo de OS (Linux o Windows)"
  type        = string
  default     = "Linux"
}

variable "subnet_id" {
  description = "ID de la subnet donde se desplegarán las VMs"
  type        = string
}

variable "admin_username" {
  description = "Usuario administrador"
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key" {
  description = "SSH public key para acceso Linux"
  type        = string
}

variable "create_public_ip" {
  description = "Crear IP pública para las VMs"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags para los recursos"
  type        = map(string)
  default     = {}
}
'''

compute_outputs = '''# =============================================================================
# Outputs - Compute
# =============================================================================

output "vm_ids" {
  description = "IDs de las VMs creadas"
  value       = azurerm_linux_virtual_machine.this[*].id
}

output "vm_names" {
  description = "Nombres de las VMs"
  value       = azurerm_linux_virtual_machine.this[*].name
}

output "nic_ids" {
  description = "IDs de las Network Interfaces"
  value       = azurerm_network_interface.this[*].id
}

output "private_ips" {
  description = "IPs privadas de las VMs"
  value       = azurerm_network_interface.this[*].private_ip_address
}
'''

# Crear módulo AKS
aks_tf = '''# =============================================================================
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
    name                = "default"
    node_count          = var.node_count
    vm_size             = var.node_vm_size
    type                = "VirtualMachineScaleSets"
    enable_auto_scaling = var.enable_auto_scaling
    min_count           = var.enable_auto_scaling ? var.min_count : null
    max_count           = var.enable_auto_scaling ? var.max_count : null
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

aks_vars = '''# =============================================================================
# Variables - AKS
# =============================================================================

variable "cluster_name" {
  description = "Nombre del cluster AKS"
  type        = string
}

variable "resource_group_name" {
  description = "Nombre del Resource Group"
  type        = string
}

variable "location" {
  description = "Región de Azure"
  type        = string
  default     = "eastus"
}

variable "dns_prefix" {
  description = "DNS prefix para el cluster"
  type        = string
}

variable "kubernetes_version" {
  description = "Versión de Kubernetes"
  type        = string
  default     = "1.28"
}

variable "node_count" {
  description = "Número de nodos inicial"
  type        = number
  default     = 2
}

variable "node_vm_size" {
  description = "Tamaño de los nodos"
  type        = string
  default     = "Standard_B2s"
}

variable "enable_auto_scaling" {
  description = "Habilitar auto-scaling del node pool"
  type        = bool
  default     = true
}

variable "min_count" {
  description = "Mínimo de nodos para auto-scaling"
  type        = number
  default     = 1
}

variable "max_count" {
  description = "Máximo de nodos para auto-scaling"
  type        = number
  default     = 5
}

variable "tags" {
  description = "Tags para los recursos"
  type        = map(string)
  default     = {}
}
'''

aks_outputs = '''# =============================================================================
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
'''

# Escribir archivos
base_path = '/workspace/test-project/terraform/modules'

os.makedirs(f'{base_path}/storage', exist_ok=True)
os.makedirs(f'{base_path}/compute', exist_ok=True)
os.makedirs(f'{base_path}/aks', exist_ok=True)

with open(f'{base_path}/storage/main.tf', 'w') as f:
    f.write(storage_tf)
with open(f'{base_path}/storage/variables.tf', 'w') as f:
    f.write(storage_vars)
with open(f'{base_path}/storage/outputs.tf', 'w') as f:
    f.write(storage_outputs)

with open(f'{base_path}/compute/main.tf', 'w') as f:
    f.write(compute_tf)
with open(f'{base_path}/compute/variables.tf', 'w') as f:
    f.write(compute_vars)
with open(f'{base_path}/compute/outputs.tf', 'w') as f:
    f.write(compute_outputs)

with open(f'{base_path}/aks/main.tf', 'w') as f:
    f.write(aks_tf)
with open(f'{base_path}/aks/variables.tf', 'w') as f:
    f.write(aks_vars)
with open(f'{base_path}/aks/outputs.tf', 'w') as f:
    f.write(aks_outputs)

print('✅ Módulos Terraform creados:')
print('  - storage (Storage Account + Containers)')
print('  - compute (Virtual Machines Linux)')
print('  - aks (Azure Kubernetes Service)')
print('  - vpc (ya existía)')
