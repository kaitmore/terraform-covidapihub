
module "dev1_network" {
  source       = "./modules/network"
  network_name = "dev1"
  vpc_cidr     = "10.1.0.0/16"
}

