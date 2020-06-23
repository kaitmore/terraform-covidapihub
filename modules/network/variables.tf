# We create two public and two private subnets.
#
# Creation of NAT gateway and internet gateway are controlled with variables.
# By default, they're created. Networks not in use can destroy these
# to save some money, but leave the VPC network intact.
#
# Only create route tables and associations for private subnets
# if the internet gateway exists
#
# Only create a route to the internet from the public subnet
# if the internet gateway exists
#
# The default VPC CIDR -> local route is created implicitly, and cannot be specified in TF.

variable "network_name" {
  description = "A name for this network and its assets. If you intend to launch an EKS cluster in this vpc, this will be the cluster name."
}

variable "vpc_cidr" {
  description = "A /16 CIDR range. Will be divided into /20 subnets."
}

variable "internet_gateway" {
  description = "Whether to create an internet gateway. Specify 1 or 0."
  type        = number
  default     = 1
}

variable "nat_gateway" {
  description = "Whether to create a NAT gateway. Specify 1 or 0."
  type        = number
  default     = 1
}


