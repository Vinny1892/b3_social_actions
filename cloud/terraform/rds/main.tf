# main.tf

module "rds" {
  source    = "../modules/rds"
  db_subnet = data.aws_subnets.redezinha_subnet
}

# Outros recursos e configurações...