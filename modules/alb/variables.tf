variable "project_name" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}

variable "target_group_port" {
  type = number
  default = 80
}

variable "vpc_id" {
  type = string
}

variable "eks_nodes_sg_id" {
  type = string
}

variable "tags" {
  type = map(string)
  default = {}
}

