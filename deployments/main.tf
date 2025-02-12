data "azurerm_client_config" "current" {}

resource azurerm_resource_group functions_rg {
  name = "myfunctions"
  location = "uksouth"
}

resource azurerm_key_vault functions_kv {
  name = "myfunctions-vault"
  resource_group_name = azurerm_resource_group.functions_rg.name
  location = "uksouth"
  sku_name = "standard"
  tenant_id = data.azurerm_client_config.current.tenant_id

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = ["Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set"]
  }
}

resource azurerm_app_configuration functions_appcfg {
  name = "myfunctions-appcfg"
  resource_group_name = azurerm_resource_group.functions_rg.name
  location = "uksouth"
}



module "function_app" {
  source = "./modules/function_app"

  functions                   = toset(var.function_app_names)
  resource_group              = azurerm_resource_group.functions_rg
  app_config_uri              = azurerm_app_configuration.functions_appcfg.endpoint
  app_config_id               = azurerm_app_configuration.functions_appcfg.id
  tenant_id = data.azurerm_client_config.current.tenant_id
  key_vault_id = azurerm_key_vault.functions_kv.id
}
