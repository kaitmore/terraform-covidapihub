variable "members" {
  default     = []
  description = "The members in the organization."
  type        = set(string)
}

variable "repositories" {
  default     = []
  description = "The repositories in the organization."
  type        = set(string)
}
