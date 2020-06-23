variable "k8s_version" {}

variable "cluster_name" {
  description = "The name of your cluster. Also annotates associated resources."
}

# Note: Subnets MUST satisfy EKS networking prerequisites. For example, there must be
# route tables, a route to the internet, and a NAT gateway accessible to private subnets.
#
# See:
# https://aws.amazon.com/blogs/containers/de-mystifying-cluster-networking-for-amazon-eks-worker-nodes/
variable "private_subnet_ids" {
  type        = list(string)
  description = "A list of private subnet ids that our EKS node group will use."
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "A list of public subnet ids. One of these will be used for LoadBalancer services"
}

variable "instance_types" {
  type = list(string)
}

variable "num_workers" {
  type = number
}
