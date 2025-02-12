# resource "azurerm_key_vault_functions_kv" {
#   name = "myfunctions-vault"
#   resource_group_name = azurerm_resource_group.functions_rg.name
#   location = "uksouth"
#   sku_name = "standard"
#   tenant_id = data.azurerm_client_config.current.tenant_id

#   access_policy {
#     tenant_id = data.azurerm_client_config.current.tenant_id
#     object_id = data.azurerm_client_config.current.object_id

#     secret_permissions = ["Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set"]
#   }
# }

########################

resource "azurerm_key_vault" "main" {
  location                        = var.location
  name                            = var.name
  resource_group_name             = var.resource_group_name
  sku_name                        = var.sku_name
  tenant_id                       = var.tenant_id
  public_network_access_enabled   = false
  tags                            = var.tags

  # Only one network_acls block is allowed.
  # Create it if the variable is not null.
  dynamic "network_acls" {
    for_each = var.network_acls != null ? { this = var.network_acls } : {}

    content {
      bypass                     = network_acls.value.bypass
      default_action             = network_acls.value.default_action
      ip_rules                   = network_acls.value.ip_rules
      virtual_network_subnet_ids = network_acls.value.virtual_network_subnet_ids
    }
  }
}

resource "azurerm_key_vault_access_policy" "this" {
  for_each = var.legacy_access_policies_enabled ? var.legacy_access_policies : {}

  key_vault_id            = azurerm_key_vault.this.id
  object_id               = each.value.object_id
  tenant_id               = var.tenant_id
  application_id          = each.value.application_id
  secret_permissions      = each.value.secret_permissions
}