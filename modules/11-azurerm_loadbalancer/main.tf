resource "azurerm_lb" "LB" {
  name                = var.lb_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "LbPublicIPAddress"
    public_ip_address_id = var.pip_id
  }
}

resource "azurerm_lb_backend_address_pool" "Lbbackendpool" {
  name             = "BackendAddressPool"
  loadbalancer_id  = azurerm_lb.LB.id
}

resource "azurerm_lb_probe" "Lbprobe" {
  name             = "HealthProbe"
  loadbalancer_id  = azurerm_lb.LB.id
  protocol         = "Http"
  port             = 80
  request_path     = "/"
}

resource "azurerm_lb_rule" "Lbrule" {
  loadbalancer_id               = azurerm_lb.LB.id
  name                          = "HTTPRule"
  protocol                      = "Tcp"
  frontend_port                 = 80
  backend_port                  = 80
  frontend_ip_configuration_name = "LbPublicIPAddress"
  probe_id                      = azurerm_lb_probe.Lbprobe.id
  disable_outbound_snat          = true
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.Lbbackendpool.id]
}

resource "azurerm_lb_outbound_rule" "lbOutboundRule" {
  name                    = "lbOutboundRule"
  loadbalancer_id         = azurerm_lb.LB.id
  protocol                = "Tcp"
  backend_address_pool_id = azurerm_lb_backend_address_pool.Lbbackendpool.id

  frontend_ip_configuration {
    name = "LbPublicIPAddress"
  }
}

resource "azurerm_network_interface_backend_address_pool_association" "nic1-lb" {
  network_interface_id    = var.vm1_nic_id
  ip_configuration_name   = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.Lbbackendpool.id
}

resource "azurerm_network_interface_backend_address_pool_association" "nic2-lb" {
  network_interface_id    = var.vm2_nic_id
  ip_configuration_name   = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.Lbbackendpool.id
}
