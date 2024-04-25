
resource "azurerm_route_table" "yeah-routetable" {
    name                = "yeah-routetable"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    lifecycle {
      create_before_destroy = true
    }
}

resource "azurerm_route" "yeah-route-outward" {
    name                   = "yeah-route-outward"
    resource_group_name    = azurerm_resource_group.rg.name
    route_table_name       = azurerm_route_table.yeah-routetable.name
    address_prefix         = "0.0.0.0/0" 
    next_hop_type       = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_public_ip.public-ip-for-agw.ip_address
    lifecycle {
      create_before_destroy = true
    }
}
resource "azurerm_route" "yeah-route-inward" {
    name                   = "yeah-route-inward"
    resource_group_name    = azurerm_resource_group.rg.name
    route_table_name       = azurerm_route_table.yeah-routetable.name
    address_prefix         = azurerm_subnet.default-pod-subnet.address_prefixes[0]
    next_hop_type       = "VnetLocal"
    lifecycle {
      create_before_destroy = true
    }
}

# association
resource "azurerm_subnet_route_table_association" "base" {
    subnet_id      = azurerm_subnet.default-nodepool-subnet.id
    route_table_id = azurerm_route_table.yeah-routetable.id
}







# resource "azurerm_route_table" "aks"{
#     name                          = "aks" #var.subnetname
#     resource_group_name           = data.azurerm_resource_group.aks.name
#     location                      = data.azurerm_resource_group.aks.location
#     disable_bgp_route_propagation = false

#     route {
#             name                    = "default_route"
#             address_prefix          = "0.0.0.0/0"
#             next_hop_type           = "VirtualAppliance"
#             next_hop_in_ip_address  = var.k8svmip
#     }

#     route {
#             name                = var.route_name
#             address_prefix      = var.route_address_prefix
#             next_hop_type       = var.route_next_hop_type
#     }

