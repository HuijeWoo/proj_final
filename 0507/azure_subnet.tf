resource "azurerm_subnet" "FrontEnd" {
    name                 = "${var.azure_frontend.prefix}_subnet"
    resource_group_name  = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes     = [var.azure_frontend.address_prefix] 
    lifecycle {
        create_before_destroy = true
    }
}
resource "azurerm_subnet" "GatewaySubnet" {
    name                 = var.azure_gateway_subnet.name
    resource_group_name  = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes     = [var.azure_gateway_subnet.address_prefix]
    service_endpoints    = ["Microsoft.Storage"]
    delegation {
        name = "fs"
        service_delegation {
            name = "Microsoft.DBforMySQL/flexibleServers"
            actions = [
            "Microsoft.Network/virtualNetworks/subnets/join/action",
            ]
        }
    }
    lifecycle {
        create_before_destroy = true
    }
}
resource "azurerm_subnet" "basic_subnet" {
    name                 = "${var.azure_basic.prefix}_subnet"
    virtual_network_name = azurerm_virtual_network.vnet.name
    resource_group_name  = azurerm_resource_group.rg.name
    address_prefixes     = [var.azure_basic.subnet_address_prefix]
    lifecycle {
      create_before_destroy = true
    }
}
resource "azurerm_subnet" "app_subnet" {
    name                 = "${var.azure_app.prefix}_subnet"
    virtual_network_name = azurerm_virtual_network.vnet.name
    resource_group_name  = azurerm_resource_group.rg.name
    address_prefixes     = [var.azure_app.subnet_address_prefix]
    lifecycle {
      create_before_destroy = true
    }
}


