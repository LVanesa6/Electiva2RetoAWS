variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "us-east-1"
}

variable "project_name" {
  type    = string
  default = "reto2"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "public_subnet_azs" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

variable "private_subnet_azs" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}
