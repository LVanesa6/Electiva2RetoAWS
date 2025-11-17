terraform {
  backend "s3" {
    bucket = "reto2-tfstate"
    key    = "infra-aws-terraform.tfstate"
    region = "us-east-1"
    encrypt = true
  }
}