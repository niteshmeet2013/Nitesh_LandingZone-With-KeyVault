variable "keyvaultvarc" {}

data "azurerm_client_config" "keyvaultdata" {}

resource "azurerm_key_vault" "keyvault" {
  for_each                  = var.keyvaultvarc
  name                      = each.value.name
  location                  = each.value.location
  resource_group_name       = each.value.resource_group_name
  enable_rbac_authorization = each.value.enable_rbac_authorization
  tenant_id                 = data.azurerm_client_config.keyvaultdata.tenant_id
  sku_name                  = each.value.sku_name
}

resource "azurerm_key_vault_secret" "example" {
  for_each     = var.keyvaultvarc
  name         = "secret-sauce"
  value        = "szechuan"
  key_vault_id = azurerm_key_vault.keyvault[each.key].id
}