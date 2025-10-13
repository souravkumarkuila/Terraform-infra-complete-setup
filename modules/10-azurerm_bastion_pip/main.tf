resource "azurerm_public_ip" "souravkuilabastionip" {
  name                = var.bastion_pip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  
}