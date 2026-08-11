module "resource_group" {
  source = "../Child/resource_group"
  rgc    = var.rgp
}

module "virtual_network" {
  depends_on = [module.resource_group]
  source     = "../Child/vnet"
  vnetc      = var.vnetp
}

module "sub_net" {
  depends_on = [module.virtual_network]
  source     = "../Child/subnet"
  subnetc    = var.subnetp
}

module "public_ip" {
  depends_on = [module.resource_group]
  source     = "../Child/public_ip"
  pipc       = var.pipp
}

module "virtual_machine" {
  depends_on = [module.sub_net, module.public_ip]
  nicc       = var.nicp
  source     = "../Child/VM"
}

module "key_vault" {
  depends_on   = [module.resource_group]
  keyvaultvarc = var.keyvaultvarp
  source       = "../Child/key_vault"
}