module "network" {
 source = "./modules/network"
}

module "compute" {
 source = "./modules/compute"
  rgname = module.network.rgname
  rglocation = module.network.rglocation
  vnet = module.network.vnet
  vm_size = module.compute.vm_size
  snvnetpub1a = module.network.snvnetpub1a
  snvnetpub1b = module.network.snvnetpub1b
}
