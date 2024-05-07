resource "azurerm_kubernetes_cluster" "aks_cluster" {
   name = "${var.azure_name_prefix}_cluster"    #required
   location = azurerm_resource_group.rg.location    #required
   resource_group_name = azurerm_resource_group.rg.name     #required

    default_node_pool {     #required
 		name = "${var.azure_basic.prefix}_pool"    #required
 		vm_size = var.vm_size     #required
 		enable_auto_scaling = true
 		max_count = 3
 		min_count = 1
 		node_count = 1
 		max_pods = 30
 		node_network_profile {
            allowed_host_ports {
                port_start = 80
                port_end = 80
                protocol = "TCP"
            }
 			application_security_group_ids = [ 
                azurerm_application_security_group.basic_asg.id
            ]
 		}
 		temporary_name_for_rotation = "temp"
 		vnet_subnet_id = azurerm_subnet.basic_subnet.id
    }

    dns_prefix = "${var.azure_name_prefix}Cluster"
    identity {
        type = "SystemAssigned"
    }
    depends_on = [
      azurerm_role_assignment.base,
      azurerm_application_security_group.basic_asg,
      azurerm_application_security_group.app_asg,
    ]
    linux_profile {
        admin_username = var.uname
        ssh_key {
            key_data = file(var.ssh_public_key)
        }
    }
    network_profile {
        network_plugin = "kubenet"  #required
        load_balancer_sku = "standard"
    }
    oidc_issuer_enabled = true ### oidc 사용 가능하도록
    workload_identity_enabled = true ## ???
    node_resource_group = "${var.azure_name_prefix}_node_rg"
}
resource "azurerm_kubernetes_cluster_node_pool" "app_pool" {
    name                  = "${var.azure_app.prefix}pool"
    kubernetes_cluster_id = azurerm_kubernetes_cluster.aks_cluster.id
    vm_size               = var.vm_size
    max_count = 3
    min_count = 1
    node_count = 1
    enable_auto_scaling = true
    vnet_subnet_id = azurerm_subnet.app_subnet.id
    node_network_profile {
        allowed_host_ports {
            port_start = 80
            port_end = 80
            protocol = "TCP"
        }
        application_security_group_ids = [ 
            azurerm_application_security_group.app_asg.id
        ]
 	}
    tags = {
        Type = "${var.azure_app.prefix}_pool"
    }
}
