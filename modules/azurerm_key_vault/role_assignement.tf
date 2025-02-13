resource "azurerm_role_assignment" "main_key_vault" {
  for_each = tomap(var.role_assignment) != null ? var.role_assignment : {}

  principal_id         = lookup(lookup(var.role_assignment, each.key), "principal_id")
  role_definition_name = lookup(lookup(var.role_assignment, each.key), "role_definition_name")
  scope                = azurerm_key_vault.main.id

  depends_on = [
    azurerm_key_vault.main
  ]
}