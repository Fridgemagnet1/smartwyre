# resource "azurerm_windows_function_app" "new" {
#   for_each = var.functions

#   name                        = "myfunc${each.key}"
#   location                    = var.resource_group.location
#   resource_group_name         = var.resource_group.name
#   service_plan_id             = azurerm_service_plan.func_service_plan[each.key].id
#   storage_account_name        = azurerm_storage_account.func_storage[each.key].name
#   storage_account_access_key  = azurerm_storage_account.func_storage[each.key].primary_access_key
#   https_only                  = true
#   client_certificate_mode     = "Required"
#   functions_extension_version = "~4"

#   site_config {
#     ftps_state = "Disabled"
#     app_scale_limit = 2
#     use_32_bit_worker = false

#     application_stack {
#       dotnet_version  = "v8.0"
#       use_dotnet_isolated_runtime = true
#     }
#   }

#   app_settings = {
#       "WEBSITE_RUN_FROM_PACKAGE" = "1"
#       "environmentApplicationConfig" = var.app_config_uri
#     }

#   tags = var.tags

#   identity {
#     type = "SystemAssigned"
#   }
# }


resource "azurerm_windows_function_app" "main" {
  for_each = var.functions

  location                                       = var.location
  name                                           = var.name
  resource_group_name                            = var.resource_group_name
  service_plan_id                                = var.service_plan_resource_id
  storage_account_name                           = var.storage_account_name
  storage_account_access_key                     = var.storage_account_access_key != null && var.storage_uses_managed_identity != true ? var.storage_account_access_key : null
  https_only                                     = var.https_only
  client_certificate_mode                        = var.client_certificate_mode
  functions_extension_version                    = var.functions_extension_version

  site_config {
    ftps_state                             = var.site_config.ftps_state
    app_scale_limit                        = var.site_config.app_scale_limit
    use_32_bit_worker                      = var.site_config.use_32_bit_worker

    dynamic "application_stack" {
      for_each = var.site_config.application_stack

      content {
        dotnet_version              = application_stack.value.dotnet_version != null ? application_stack.value.dotnet_version : null
        use_dotnet_isolated_runtime = application_stack.value.use_dotnet_isolated_runtime != null ? application_stack.value.use_dotnet_isolated_runtime : null
      }
    }
  }

  app_settings = {
      "WEBSITE_RUN_FROM_PACKAGE" = "1"
      "environmentApplicationConfig" = var.app_config_uri
    }

  dynamic "identity" {
    for_each = local.managed_identities.system_assigned_user_assigned

    content {
      type         = identity.value.type
      identity_ids = identity.value.user_assigned_resource_ids
    }
  }

  tags = var.tags
}
