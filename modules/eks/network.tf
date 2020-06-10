resource "aws_vpc" "cluster" {

  cidr_block = var.cidr_block

  tags = {
    Name                                        = "eks-${var.cluster_name}"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}

resource "aws_subnet" "master" {

  count = length(var.availability_zones)

  vpc_id            = aws_vpc.cluster.id
  cidr_block        = cidrsubnet(var.cidr_block, ceil(log(length(var.availability_zones) * 2, 2)), count.index)
  availability_zone = var.availability_zones[count.index % length(var.availability_zones)]

  tags = {
    Name                                        = "eks-${var.cluster_name}"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                    = "1"
  }
}

resource "aws_subnet" "worker" {

  count = length(var.availability_zones)

  vpc_id                  = aws_vpc.cluster.id
  cidr_block              = cidrsubnet(var.cidr_block, ceil(log(length(var.availability_zones) * 2, 2)), length(var.availability_zones) + count.index)
  availability_zone       = var.availability_zones[count.index % length(var.availability_zones)]
  map_public_ip_on_launch = true

  tags = {
    Name                                        = "eks-${var.cluster_name}"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"           = "1"
  }
}

resource "aws_internet_gateway" "egress" {
  vpc_id = aws_vpc.cluster.id

  tags = {
    Name = "eks-${var.cluster_name}"
  }
}

resource "aws_route_table" "egress" {
  vpc_id = aws_vpc.cluster.id

  tags = {
    Name                                        = "eks-${var.cluster_name}"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}

resource "aws_route" "egress" {
  route_table_id         = aws_route_table.egress.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.egress.id

  depends_on = [
    aws_route_table.egress
  ]
}

resource "aws_route_table_association" "master-egress" {
  count = length(aws_subnet.master)

  subnet_id      = aws_subnet.master[count.index].id
  route_table_id = aws_route_table.egress.id
}

resource "aws_route_table_association" "worker-egress" {
  count = length(aws_subnet.worker)

  subnet_id      = aws_subnet.worker[count.index].id
  route_table_id = aws_route_table.egress.id
}

resource "aws_network_interface" "proxy-nlb-master-nic" {
  subnet_id   = aws_subnet.master[0].id
}

resource "aws_eip" "nlb-eip-master" {
  vpc                       = true
  public_ipv4_pool          = "amazon"
  network_interface         = aws_network_interface.proxy-nlb-master-nic.id
  tags = {
    Name = "proxy-nlb-eip-master"
  }
}
