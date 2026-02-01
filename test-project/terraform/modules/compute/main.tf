# main.tf - Azure Virtual Machine Module

terraform {
  required_version = ">= 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

# Availability Set (optional)
resource "azurerm_availability_set" "main" {
  count                        = var.use_availability_set ? 1 : 0
  name                         = "${var.vm_name}-avset"
  location                     = var.location
  resource_group_name          = var.resource_group_name
  platform_fault_domain_count  = var.fault_domain_count
  platform_update_domain_count = var.update_domain_count
  managed                      = true

  tags = var.tags
}

# Network Interface
resource "azurerm_network_interface" "main" {
  count               = var.vm_count
  name                = "${var.vm_name}-${count.index + 1}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.private_ip_address != null ? "Static" : "Dynamic"
    private_ip_address            = var.private_ip_address
    public_ip_address_id          = var.public_ip_address_id
  }

  tags = var.tags
}

# Linux Virtual Machine
resource "azurerm_linux_virtual_machine" "main" {
  count               = var.os_type == "linux" ? var.vm_count : 0
  name                = var.vm_count > 1 ? "${var.vm_name}-${count.index + 1}" : var.vm_name
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = var.vm_size
  admin_username      = var.admin_username
  availability_set_id = var.use_availability_set ? azurerm_availability_set.main[0].id : null
  zone                = var.availability_zone

  network_interface_ids = [azurerm_network_interface.main[count.index].id]

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_public_key
  }

  os_disk {
    name                 = "${var.vm_name}-${count.index + 1}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = var.os_disk_type
    disk_size_gb         = var.os_disk_size_gb
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

  identity {
    type = var.identity_type
  }

  boot_diagnostics {
    storage_account_uri = var.boot_diagnostics_storage_uri
  }

  tags = merge(
    var.tags,
    {
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  )
}

# Windows Virtual Machine
resource "azurerm_windows_virtual_machine" "main" {
  count               = var.os_type == "windows" ? var.vm_count : 0
  name                = var.vm_count > 1 ? "${var.vm_name}-${count.index + 1}" : var.vm_name
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = var.vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  availability_set_id = var.use_availability_set ? azurerm_availability_set.main[0].id : null
  zone                = var.availability_zone

  network_interface_ids = [azurerm_network_interface.main[count.index].id]

  os_disk {
    name                 = "${var.vm_name}-${count.index + 1}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = var.os_disk_type
    disk_size_gb         = var.os_disk_size_gb
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

  identity {
    type = var.identity_type
  }

  tags = merge(
    var.tags,
    {
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  )
}

# Data Disks
resource "azurerm_managed_disk" "data" {
  for_each             = { for d in var.data_disks : d.name => d }
  name                 = "${var.vm_name}-${each.value.name}"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = each.value.storage_account_type
  create_option        = "Empty"
  disk_size_gb         = each.value.disk_size_gb

  tags = var.tags
}

# Attach Data Disks to Linux VMs
resource "azurerm_virtual_machine_data_disk_attachment" "linux" {
  for_each = var.os_type == "linux" ? { for d in var.data_disks : d.name => d } : {}

  managed_disk_id    = azurerm_managed_disk.data[each.key].id
  virtual_machine_id = azurerm_linux_virtual_machine.main[0].id
  lun                = each.value.lun
  caching            = each.value.caching
}

# Attach Data Disks to Windows VMs
resource "azurerm_virtual_machine_data_disk_attachment" "windows" {
  for_each = var.os_type == "windows" ? { for d in var.data_disks : d.name => d } : {}

  managed_disk_id    = azurerm_managed_disk.data[each.key].id
  virtual_machine_id = azurerm_windows_virtual_machine.main[0].id
  lun                = each.value.lun
  caching            = each.value.caching
}
