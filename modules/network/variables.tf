variable "project_name" {
  description = "Nombre del proyecto para identificar recursos"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR de la VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "Lista de CIDRs para las subredes públicas"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "Lista de CIDRs para las subredes privadas"
  type        = list(string)
}

variable "ssh_allowed_cidrs" {
  description = "CIDRs permitidos para SSH"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
