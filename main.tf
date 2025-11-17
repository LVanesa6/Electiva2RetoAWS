module "network" {
  source               = "./modules/network"
  project_name         = var.project_name
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.3.0/24"]
  private_subnet_cidrs = ["10.0.2.0/24", "10.0.4.0/24"]
  public_subnet_azs    = ["us-east-1a", "us-east-1b"]
  private_subnet_azs   = ["us-east-1a", "us-east-1b"]
}

module "ecr" {
  source       = "./modules/ecr"
  project_name = var.project_name
}

module "storage" {
  source       = "./modules/storage"
  project_name = var.project_name
}

module "eks" {
  source = "./modules/eks"

  project_name       = var.project_name
  private_subnet_ids = module.network.private_subnet_ids
  vpc_id             = module.network.vpc_id

  node_desired_capacity = 1
  node_min_size         = 1
  node_max_size         = 2
  ssh_key_name          = "" # Si tienes keypair, ponlo aquí

}

module "alb" {
  source = "./modules/alb"

  project_name      = var.project_name
  public_subnets    = module.network.public_subnet_ids
  target_group_port = 80
  vpc_id            = module.network.vpc_id
  eks_nodes_sg_id   = module.eks.node_group_sg_id

}
