variable "aws_region" {
  type        = string
  description = "region"
  default     = "us-east-1"
}

variable "project_name"{
  type = string
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