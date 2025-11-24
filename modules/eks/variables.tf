#################################################
# VARIABLES
#################################################
variable "project_name" {
  type = string
}

#variable "private_subnet_ids" {
#  type = list(string)
#}
variable "public_subnets" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "node_desired_capacity" {
  type    = number
  default = 1
}

variable "node_min_size" {
  type    = number
  default = 1
}

variable "node_max_size" {
  type    = number
  default = 2
}

variable "ssh_key_name" {
  type    = string
  default = ""
}

variable "node_allowed_from_alb_port" {
  type    = number
  default = 80
}

variable "node_allowed_from_alb_cidrs" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}
