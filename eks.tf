module "eks" {

  providers = {
    aws = aws.use1
  }

  source = "./modules/eks"

  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]

  cluster_name = "covidapihub"
  cidr_block   = "10.0.0.0/16"

  worker_groups = {
    m5-general = {
      instance_type = "m5.xlarge"
      desired_size  = 6
      minimum_size  = 6
      maximum_size  = 6
    }
  }
}
