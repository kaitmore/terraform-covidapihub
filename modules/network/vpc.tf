resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name                                        = var.network_name
    "kubernetes.io/cluster/${var.network_name}" = "shared"
  }
}


