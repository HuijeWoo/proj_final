resource "azurerm_private_dns_zone" "priv_dns_zone" {
  name                = "${var.azure_name_prefix}.mysql.database.azure.com"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_mysql_flexible_server" "fl_sql_server" {
  name                   = "${var.azure_name_prefix}fs"
  resource_group_name    = azurerm_resource_group.rg.name
  location               = azurerm_resource_group.rg.location
  administrator_login    = var.db_id_pwd.id
  administrator_password = var.db_id_pwd.pwd
  backup_retention_days  = 7
  delegated_subnet_id    = azurerm_subnet.GatewaySubnet.id
  private_dns_zone_id    = azurerm_private_dns_zone.priv_dns_zone.id
  sku_name               = "GP_Standard_D2ds_v4"

  depends_on = [azurerm_private_dns_zone_virtual_network_link.example]
}


