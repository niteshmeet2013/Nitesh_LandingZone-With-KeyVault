variable "vnetc" {}

resource "azurerm_virtual_network" "vnet" {
  for_each = var.vnetc
  name = each.value.name
  resource_group_name = each.value.resource_group_name
  location = each.value.location
  address_space = each.value.address_space
}