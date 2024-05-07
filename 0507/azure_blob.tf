
data "azurerm_client_config" "cli_conf" {
}

resource "azurerm_role_assignment" "role_sa" {
    scope                = azurerm_storage_account.sa.id
    role_definition_name = "Storage Account Contributor"
    principal_id         = data.azurerm_client_config.cli_conf.object_id
    depends_on = [ 
        azurerm_storage_account.sa
    ]
}

# storage account
resource "azurerm_storage_account" "sa" {
    name                     = "${var.azure_name_prefix}account"
    resource_group_name      = azurerm_resource_group.rg.name
    location                 = azurerm_resource_group.rg.location
    account_tier             = "Standard"
    account_replication_type = "GRS"

    identity {
        type = "SystemAssigned"
    }
}

resource "azurerm_storage_container" "sc" {
  name                  = "${var.azure_name_prefix}container"
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "blob"
}


