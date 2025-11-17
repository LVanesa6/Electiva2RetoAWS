variable "project_name" { 
    type = string 
    }
variable "public_subnets" { 
    type = list(string) 
}
variable "vpc_id" { 
    type = string 
}
variable "target_group_port" { 
    type = number 
}
variable "eks_nodes_sg_id" { 
    type = string 
}
