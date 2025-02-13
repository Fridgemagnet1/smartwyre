
resource "azurerm_key_vault" "main" {
  access_policy                   = []      
  location                        = var.location
  name                            = var.name
  resource_group_name             = var.resource_group_name
  sku_name                        = var.sku_name
  tenant_id                       = var.tenant_id
  public_network_access_enabled   = false
  tags                            = var.tags

  network_acls {
    bypass         = var.network_acls_bypass
    default_action = var.network_acls_default_action
    ip_rules       = var.network_acls_ips_rules
  }
}

# not writitng the kv secret, key, certificate resources but would go here