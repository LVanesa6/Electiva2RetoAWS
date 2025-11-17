#########################################
# VARIABLES PARA EL MÓDULO DE EKS
#########################################

variable "project_name" {
  description = "Nombre del proyecto para prefijos de recursos"
  type        = string
}

variable "private_subnet_ids" {
  description = "IDs de las subredes privadas donde correrá EKS y Fargate"
  type        = list(string)
}
