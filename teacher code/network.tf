resource "azurerm_virtual_network" "vnet" {
    name = "vnet01"
    location = azurerm_resource_group.aks.location
    resource_group_name = azurerm_resource_group.aks.name
    address_space = ["10.1.0.0/16"]
}

resource "azurerm_subnet" "subnet1" {
 name = "subnet1"
 resource_group_name = azurerm_resource_group.aks.name
 address_prefixes = ["10.1.1.0/24"]
 virtual_network_name = azurerm_virtual_network.vnet.name
}

resource "azurerm_subnet" "subnet2" {
 name = "subnet2"
 resource_group_name = azurerm_resource_group.aks.name
 address_prefixes = ["10.1.2.0/24"]
 virtual_network_name = azurerm_virtual_network.vnet.name
}