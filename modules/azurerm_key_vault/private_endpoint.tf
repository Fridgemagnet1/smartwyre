resource "azurerm_private_endpoint" "main" {
  custom_network_interface_name = "${azurerm_key_vault.main.name}-pep-nic"
  location                      = var.location
  name                          = "${azurerm_key_vault.main.name}-pep"
  resource_group_name           = var.resource_group_name
  subnet_id                     = var.subnet_id
  tags                          = var.tags

  private_service_connection {
    is_manual_connection           = false
    name                           = azurerm_key_vault.main.name
    private_connection_resource_id = azurerm_key_vault.main.id
    subresource_names              = ["vault"]
  }

  count = var.enable_private_endpoint == true ? 1 : 0
  
  depends_on = [
    azurerm_key_vault.main
  ]
}