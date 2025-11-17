variable "project_name" { 
    type = string 
}
variable "vpc_id" { 
    type = string 
}
variable "public_sg_id" { 
    type = string 
}
variable "subnets_public" { 
    type = list(string) 
}
