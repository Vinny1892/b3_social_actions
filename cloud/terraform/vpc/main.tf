# main.tf

module "vpc" {
  source                     = "../modules/vpc"
  vpc_cidr_block             = "10.0.0.0/16"
  public_subnet_cidr_blocks  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidr_blocks = ["10.0.3.0/24", "10.0.4.0/24"]
  availability_zone = ["us-east-1a", "us-east-1b"]
  region                     = "us-east-1"
}

# Outros recursos e configurações...
