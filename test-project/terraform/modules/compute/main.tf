# =============================================================================
# Módulo: Azure Compute (VMs)
# Descripción: Crea Virtual Machines Linux/Windows
# =============================================================================

resource "azurerm_network_interface" "this" {
  count               = var.vm_count
  name                = "${var.vm_name_prefix}-nic-${count.index + 1}"
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
  name                = "${var.vm_name_prefix}-pip-${count.index + 1}"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Dynamic"
}

resource "azurerm_linux_virtual_machine" "this" {
  count               = var.os_type == "Linux" ? var.vm_count : 0
  name                = "${var.vm_name_prefix}-${count.index + 1}"
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
