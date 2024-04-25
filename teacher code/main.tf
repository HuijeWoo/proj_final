
resource "azurerm_resource_group" "aks" {
 name = "aks-resources"
 location = "East US"
}

resource "azurerm_kubernetes_cluster" "project" {
    name = "project-aks"
    location = azurerm_resource_group.aks.location
    resource_group_name = azurerm_resource_group.aks.name
    dns_prefix = "project"

    default_node_pool {
        name = "webpool"
        node_count = 2
        vm_size = "Standard_D2_v2"
        vnet_subnet_id = azurerm_subnet.subnet1.id
    }
    service_principal {
        client_id  = "55fa66b9-04be-450d-853b-280192f8"
        client_secret = "Fr78Q~zRoBflSazcb1sxlP_~yzGgMQoPp36l"
    }
    linux_profile {
        admin_username = var.username
        ssh_key {
            key_data = file(var.ssh_public_key)
        }
    }
    network_profile {
        network_plugin = "kubenet"
        load_balancer_sku = "standard"
    }
}

resource "azurerm_kubernetes_cluster_node_pool" "projectpool" {
    name = "waspool"
    kubernetes_cluster_id = azurerm_kubernetes_cluster.project.id
    vm_size  = "Standard_DS2_v2"
    node_count = 2
    vnet_subnet_id = azurerm_subnet.subnet2.id
}