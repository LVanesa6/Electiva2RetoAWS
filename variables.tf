variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "us-east-1"
}

variable "project_name" {
  type    = string
  default = "reto2"
}

variable "azure_vpn_public_ip" {
  type = string
}

variable "shared_key" {
  type = string
}

variable "azure_vnet_cidr" {
  type = string
}
variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "public_subnet_azs" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}
