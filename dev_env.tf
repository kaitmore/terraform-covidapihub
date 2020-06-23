
module "dev1_network" {
  source       = "./modules/network"
  network_name = "dev1"
  vpc_cidr     = "10.1.0.0/16"
}

module "dev1_cluster" {
  source             = "./modules/eks_standalone"
  cluster_name       = "dev1"
  k8s_version        = 1.16
  num_workers        = 3
  instance_types     = ["m5.large"]
  private_subnet_ids = module.dev1_network.private_subnet_ids
  public_subnet_ids  = module.dev1_network.public_subnet_ids
}

