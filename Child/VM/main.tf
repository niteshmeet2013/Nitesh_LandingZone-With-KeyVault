variable "nicc" {}

data "azurerm_subnet" "subnetdata" {
  for_each = var.nicc
  name                 = each.value.subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}

data "azurerm_public_ip" "publicipdata" {
  for_each = var.nicc
  name                = each.value.pip_name
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_network_interface" "nic" {
  for_each = var.nicc
  name = each.value.nic_name
  resource_group_name = each.value.resource_group_name
  location = each.value.location

  ip_configuration {
    name = "internal"
    subnet_id = data.azurerm_subnet.subnetdata[each.key].id
    public_ip_address_id = data.azurerm_public_ip.publicipdata[each.key].id
    private_ip_address_allocation = each.value.private_ip_address_allocation
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
    for_each = var.nicc
  name                = each.value.vm_name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  size                = each.value.vm_size
  admin_username      = each.value.admin_username
  admin_password = each.value.admin_password
  disable_password_authentication = each.value.disable_password_authentication

  priority        = each.value.priority
  eviction_policy = each.value.priority == "Spot" ? "Deallocate" : null
  max_bid_price   = each.value.priority == "Spot" ? -1 : null

  network_interface_ids = [
    azurerm_network_interface.nic[each.key].id
  ]

   os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}