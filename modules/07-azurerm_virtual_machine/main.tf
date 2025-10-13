resource "azurerm_network_interface" "souravkuilanic" {
  name = var.nic_name
  location = var.location
    resource_group_name = var.resource_group_name

    ip_configuration {
      name                          = "internal"
      subnet_id                     = var.subnet_id
      private_ip_address_allocation = "Dynamic"
      
    }
}

resource "azurerm_linux_virtual_machine" "souravkuilaVM" {
  name                = var.vm_name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_F2"
  admin_username      = var.admin_username
  network_interface_ids = [
    azurerm_network_interface.souravkuilanic.id
  ]

  disable_password_authentication = false
  admin_password                  = var.admin_password

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