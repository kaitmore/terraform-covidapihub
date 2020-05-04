variable "availability_zones" {
  type        = list(string)
  description = "The AWS availablity zones in which masters and workers will be provisioned."
}

variable "cluster_name" {
  type        = string
  description = "The cluster name."
}

variable "cidr_block" {
  type        = string
  default     = "10.0.0.0/24"
  description = "The CIDR block for the cluster's VPC."
}

variable "worker_groups" {
  type = map(object({
    instance_type = string
    desired_size  = number
    minimum_size  = number
    maximum_size  = number
  }))
  description = "The worker node groups to provision."
}
