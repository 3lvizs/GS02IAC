module "network" {
 source = "./modules/network"
}

module "compute" {
 source = "./modules/compute"
 ec2_ami = "ami-02e136e904f3da870"
 vpc_id = module.network.vpc_id
 sn_vpc_pub1a = module.network.sn_vpc_pub1a
 sn_vpc_pub1b = module.network.sn_vpc_pub1b
}