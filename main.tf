provider "aws" {
  region = "us-east-1"
}

module "network" {
  source = "./modules/network"

  project_name          = "mi-red"
  vpc_cidr              = "10.0.0.0/16"
  public_subnet_cidrs   = ["10.0.1.0/24", "10.0.3.0/24"]
  private_subnet_cidrs  = ["10.0.2.0/24", "10.0.4.0/24"]
  ssh_allowed_cidrs     = ["0.0.0.0/0"]
}
