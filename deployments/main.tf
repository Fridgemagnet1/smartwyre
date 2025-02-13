data "azurerm_client_config" "current" {}

module "functions_rg" {
  source   = "./modules/resource_group"
  name     = "myfunctions"
  location = "uksouth"
  tags     = "tags"
}

module "azurerm_key_vault_functions_kv" {
  source                       = "./modules/key_vault"
  location                     = "uksouth"
  name                         = "myfunction-vault"
  resource_group_name          = azurerm_resource_group.main.functions_rg
  sku_name                     = "standard"
  tenant_id                    = data.azurerm_client_config.current.tenant_id
  network_acls_bypass          = "AzureServices"
  network_acls_default_action  = "Deny"
  network_acls_ips_rules       = var.authorized_ips
  tags                         = "tags"
}

module "function_app" {
  source                        = "./modules/function_app"
  location                      = "uksouth"
  name                          = "products-denormalizations"
  resource_group_name           = azurerm_resource_group.main.functions_rg
  service_plan_resource_id      = # azurerm service plan.resource_name.id
  storage_account_name          = # azurerm storage account.resource name.name
  storage_account_access_key    = # azurerm storage account.resource name.access_key
  https_only                    = false
  client_certificate_mode        = "Required"
  functions_extension_version    = #####  

  site_config = {
    ftps_state       = "Disabled"
    app_scale_limit  = 2
    use_32_bit_worker = false
    application_stack = [
      {
        dotnet_version               = "v8.0"
        use_dotnet_isolated_runtime  = true
      }
    ]
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE"        = "1"
    "environmentApplicationConfig"    = var.app_config_uri
  }

  tags = {
    environment  = "dev"
    project      = "example"
  }
}
