resource "azurerm_mssql_server" "mssql-server" {
  name                         = var.sql_server_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_username
  administrator_login_password = var.sql_admin_password
}

resource "azurerm_mssql_database" "souravkuila-mssql-db" {
  name           = var.sql_database_name
  server_id      = azurerm_mssql_server.mssql-server.id
  sku_name       = "S0"
  license_type   = "LicenseIncluded"
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  max_size_gb    = 5
  enclave_type   = "VBS"

  tags = {
    foo = "bar"
  }

  lifecycle {
    prevent_destroy = true
  }
}
