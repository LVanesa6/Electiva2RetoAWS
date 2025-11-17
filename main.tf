provider "aws" {
  region = var.aws_region
}

###################################
# NETWORK (tu módulo existente)
###################################
module "network" {
  source              = "./modules/network"
  project_name        = var.project_name
  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.3.0/24"]
  private_subnet_cidrs = ["10.0.2.0/24", "10.0.4.0/24"]
  ssh_allowed_cidrs   = ["0.0.0.0/0"]
}

###################################
# ECR REPO
###################################
module "ecr" {
  source        = "./modules/ecr"
  project_name  = var.project_name
}

###################################
# STORAGE: S3 + DynamoDB
###################################
module "storage" {
  source        = "./modules/storage"
  project_name  = var.project_name
}

###################################
# EKS CLUSTER + NODES
###################################
module "eks" {
  source        = "./modules/eks"
  project_name  = var.project_name
  subnet_ids    = module.network.private_subnets
  vpc_id        = module.network.vpc_id
}

###################################
# APPLICATION LOAD BALANCER
###################################
module "alb" {
  source                = "./modules/alb"
  project_name          = var.project_name
  public_subnets        = module.network.public_subnets
  target_group_port     = 80
  vpc_id                = module.network.vpc_id
  eks_nodes_sg_id       = module.eks.node_group_sg_id
}
