module "network" {
  source = "./modules/network"

  project_name         = var.project_name
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.3.0/24"]
  private_subnet_cidrs = ["10.0.2.0/24", "10.0.4.0/24"]
  ssh_allowed_cidrs    = ["0.0.0.0/0"]
}

module "ecr" {
  source       = "./modules/ecr"
  project_name = var.project_name
}

module "storage" {
  source       = "./modules/storage"
  project_name = var.project_name
}

module "alb" {
  source         = "./modules/alb"
  project_name   = var.project_name
  vpc_id         = module.network.vpc_id
  public_sg_id   = module.network.public_sg_id
  subnets_public = module.network.public_subnets
}
