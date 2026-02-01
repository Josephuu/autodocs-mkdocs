# variables.tf - Input variables for Compute module

variable "resource_group_name" {
  description = "Name of the Azure resource group"
  type        = string
}

variable "location" {
  description = "Azure region for the virtual machine"
  type        = string
  default     = "eastus"
}

variable "vm_name" {
  description = "Name of the virtual machine"
  type        = string

  validation {
    condition     = length(var.vm_name) >= 1 && length(var.vm_name) <= 64
    error_message = "VM name must be between 1 and 64 characters."
  }
}

variable "vm_count" {
  description = "Number of VMs to create"
  type        = number
  default     = 1
}

variable "vm_size" {
  description = "Size of the virtual machine (e.g., Standard_D2s_v3)"
  type        = string
  default     = "Standard_D2s_v3"
}

variable "os_type" {
  description = "Operating system type (linux or windows)"
  type        = string
  default     = "linux"

  validation {
    condition     = contains(["linux", "windows"], var.os_type)
    error_message = "OS type must be linux or windows."
  }
}

variable "admin_username" {
  description = "Administrator username for the VM"
  type        = string
  default     = "azureuser"
}

variable "admin_password" {
  description = "Administrator password for Windows VMs"
  type        = string
  default     = null
  sensitive   = true
}

variable "ssh_public_key" {
  description = "SSH public key for Linux VMs"
  type        = string
  default     = null
}

variable "subnet_id" {
  description = "ID of the subnet for the VM network interface"
  type        = string
}

variable "private_ip_address" {
  description = "Static private IP address (null for dynamic)"
  type        = string
  default     = null
}

variable "public_ip_address_id" {
  description = "ID of an existing public IP address to attach"
  type        = string
  default     = null
}

# Availability
variable "use_availability_set" {
  description = "Use availability set for the VM"
  type        = bool
  default     = false
}

variable "availability_zone" {
  description = "Availability zone for the VM (1, 2, or 3)"
  type        = string
  default     = null
}

variable "fault_domain_count" {
  description = "Number of fault domains for availability set"
  type        = number
  default     = 2
}

variable "update_domain_count" {
  description = "Number of update domains for availability set"
  type        = number
  default     = 5
}

# OS Disk
variable "os_disk_type" {
  description = "Storage account type for OS disk (Standard_LRS, Premium_LRS, StandardSSD_LRS)"
  type        = string
  default     = "Premium_LRS"
}

variable "os_disk_size_gb" {
  description = "Size of OS disk in GB"
  type        = number
  default     = 128
}

# Image
variable "image_publisher" {
  description = "Publisher of the VM image"
  type        = string
  default     = "Canonical"
}

variable "image_offer" {
  description = "Offer of the VM image"
  type        = string
  default     = "0001-com-ubuntu-server-jammy"
}

variable "image_sku" {
  description = "SKU of the VM image"
  type        = string
  default     = "22_04-lts-gen2"
}

variable "image_version" {
  description = "Version of the VM image"
  type        = string
  default     = "latest"
}

# Identity
variable "identity_type" {
  description = "Type of managed identity (SystemAssigned, UserAssigned, or both)"
  type        = string
  default     = "SystemAssigned"
}

# Diagnostics
variable "boot_diagnostics_storage_uri" {
  description = "URI of storage account for boot diagnostics (null to disable)"
  type        = string
  default     = null
}

# Data Disks
variable "data_disks" {
  description = "List of data disks to attach to the VM"
  type = list(object({
    name                 = string
    disk_size_gb         = number
    storage_account_type = string
    lun                  = number
    caching              = string
  }))
  default = []
}

# Tags
variable "environment" {
  description = "Environment name (dev, staging, production)"
  type        = string
  default     = "dev"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
