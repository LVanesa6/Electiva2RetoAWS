variable "project_name" {
  type = string
}

variable "subnets_id" {
  type = list(string)
}

variable "eks_role_arn" {
  type = string
}

variable "node_role_arn" {
  type = string
}
