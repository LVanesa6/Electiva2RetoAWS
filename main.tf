provider "aws" {
  region = "us-east-1"
}

module "network" {
  source = "./modules/network"

  project_name         = var.project_name
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.3.0/24"]
  private_subnet_cidrs = ["10.0.2.0/24", "10.0.4.0/24"]
  ssh_allowed_cidrs    = ["0.0.0.0/0"]
}

module "eks" {
  source ="./modules/eks"

  subnets_id = module.network.private_subnets
}

module "vpn" {
  source = "./modules/vpn"

  vpc_id = module.network.vpc_id
  vpc_cidr = module.network.cidr_block
  shared_key = var.shared_key
  tags = {}
  azure_vpn_public_ip = var.azure_vpn_public_ip
  azure_vnet_cidr = var.azure_vnet_cidr
}