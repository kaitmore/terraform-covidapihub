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

variable "collaborators" {
  default     = []
  description = "The collaborators in the organization."
  type        = set(string)
}
