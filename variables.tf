variable "aws_region" {
  type        = string
  description = "region"
  default     = "us-east-1"
}

variable "project_name" {
  type    = string
  default = "reto2"
}
variable "environment" {
  description = "Entorno de despliegue"
  type        = string
  default     = "dev"
}