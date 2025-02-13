
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

  app_settings = var.app_settings

  dynamic "identity" { # not got enough time but would make it so when systgem assigned, can auto get correct perms to kv.
    for_each = local.managed_identities.system_assigned_user_assigned

    content {
      type         = identity.value.type
      identity_ids = identity.value.user_assigned_resource_ids
    }
  }

  tags = var.tags
}
