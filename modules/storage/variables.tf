variable "project_name" {
  description = "Nombre base para los recursos"
  type        = string
}

variable "environment" {
  description = "Entorno de despliegue"
  type        = string
  default     = "dev"
}
