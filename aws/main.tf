module "network" {
 source = "./modules/network"
}

module "compute" {
 source = "./modules/compute"
 ec2_ami = "ami-0f409bae3775dc8e5"
 vpc_id = module.network.vpc_id
 sn_vpc_pub1a = module.network.sn_vpc_pub1a
 sn_vpc_pub1b = module.network.sn_vpc_pub1b
}