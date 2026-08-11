variable "subnetc" {}

resource "azurerm_subnet" "snet" {
  for_each = var.subnetc
  name = each.value.name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name = each.value.resource_group_name
  address_prefixes = each.value.address_prefixes
}