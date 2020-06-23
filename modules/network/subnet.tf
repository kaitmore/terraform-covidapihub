

resource "aws_internet_gateway" "gw" {
  count  = var.internet_gateway
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.network_name}_igw"
  }
}


resource "aws_route_table" "public_rt" {

  # Only create a route to the internet if the internet gateway exists
  count = var.internet_gateway

  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw[count.index].id
  }

  tags = {
    Name = "${var.network_name}_public_rt"
  }
}

resource "aws_route_table_association" "public1_rt_assoc" {
  # Only create route table association if the internet gateway exists
  count          = var.internet_gateway
  route_table_id = aws_route_table.public_rt[count.index].id
  subnet_id      = aws_subnet.public1.id
}


resource "aws_route_table_association" "public2_rt_assoc" {
  count          = var.internet_gateway
  route_table_id = aws_route_table.public_rt[count.index].id
  subnet_id      = aws_subnet.public2.id
}

resource "aws_route_table" "private_rt" {

  count  = var.nat_gateway
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw1[count.index].id
  }

  tags = {
    Name = "${var.network_name}_public_rt"
  }
}


resource "aws_route_table_association" "private1_private_rt" {
  count          = var.nat_gateway
  route_table_id = aws_route_table.private_rt[count.index].id
  subnet_id      = aws_subnet.private1.id
}

resource "aws_route_table_association" "private2_private_rt" {
  count          = var.nat_gateway
  route_table_id = aws_route_table.private_rt[count.index].id
  subnet_id      = aws_subnet.private2.id
}

resource "aws_subnet" "public1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 4, 2)
  availability_zone = "us-east-1a"

  tags = {
    Name                                        = "${var.network_name}_public1"
    "kubernetes.io/cluster/${var.network_name}" = "shared"
    "kubernetes.io/role/elb"                    = 1
  }
}

resource "aws_subnet" "public2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 4, 3)
  availability_zone = "us-east-1b"

  tags = {
    Name                                        = "${var.network_name}_public2"
    "kubernetes.io/cluster/${var.network_name}" = "shared"
  }
}

resource "aws_subnet" "private1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 4, 4)
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name                                        = "${var.network_name}_private1"
    "kubernetes.io/cluster/${var.network_name}" = "shared"
  }
}

resource "aws_subnet" "private2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 4, 5)
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    Name                                        = "${var.network_name}_private2"
    "kubernetes.io/cluster/${var.network_name}" = "shared"
  }
}

# NAT gateways live on the public subnet
resource "aws_nat_gateway" "nat_gw1" {
  count         = var.nat_gateway
  allocation_id = aws_eip.nat_gw1[count.index].id
  subnet_id     = aws_subnet.public1.id

  tags = {
    Name = "${var.network_name}_nat_gw1"
  }
}

resource "aws_eip" "nat_gw1" {
  count = var.nat_gateway
  vpc   = true
  tags = {
    Name = "${var.network_name}_nat_gw1_eip"
  }
}
