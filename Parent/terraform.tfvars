rgp = {
  rg1 = {
    name     = "dadaji"
    location = "central india"
  }
}

vnetp = {
  vnet1 = {
    name                = "papaji"
    location            = "central india"
    resource_group_name = "dadaji"
    address_space       = ["10.5.0.0/16"]
  }
}

subnetp = {
  subnet1 = {
    name                 = "frontend_subnet"
    resource_group_name  = "dadaji"
    virtual_network_name = "papaji"
    address_prefixes     = ["10.5.1.0/24"]
  }
  subnet2 = {
    name                 = "backend_subnet"
    resource_group_name  = "dadaji"
    virtual_network_name = "papaji"
    address_prefixes     = ["10.5.2.0/24"]
  }
}

pipp = {
  pip1 = {
    name                = "frontend_publicip"
    resource_group_name = "dadaji"
    location            = "central india"
    allocation_method   = "Static"
    sku                 = "Standard"
  }
  pip2 = {
    name                = "backend_publicip"
    resource_group_name = "dadaji"
    location            = "central india"
    allocation_method   = "Static"
    sku                 = "Standard"
  }
}

nicp = {
  nic1 = {
    nic_name                        = "frontend_nic"
    subnet_name                     = "frontend_subnet"
    pip_name                        = "frontend_publicip"
    resource_group_name             = "dadaji"
    location                        = "central india"
    private_ip_address_allocation   = "Dynamic"
    virtual_network_name            = "papaji"
    vm_name                         = "frontend-vm"
    vm_size                         = "Standard_D2s_v3"
    priority                        = "Regular"
    admin_username                  = "adminuser"
    admin_password                  = "adminuser@123456"
    disable_password_authentication = false
  }
  nic2 = {
    nic_name                        = "backend_nic"
    subnet_name                     = "backend_subnet"
    pip_name                        = "backend_publicip"
    resource_group_name             = "dadaji"
    location                        = "central india"
    private_ip_address_allocation   = "Dynamic"
    virtual_network_name            = "papaji"
    vm_name                         = "backend-vm"
    vm_size                         = "Standard_D2s_v3"
    priority                        = "Spot"
    admin_username                  = "adminuser"
    admin_password                  = "adminuser@123456"
    disable_password_authentication = false
  }
}

keyvaultvarp = {
  keyvault1 = {
    name                      = "mysecretkeyvault"
    location                  = "central india"
    resource_group_name       = "dadaji"
    enable_rbac_authorization = false
    sku_name                  = "standard"
  }
}