data "aws_vpc" "redezinha" {
  filter {
    name   = "tag:Name"
    values = ["MainVPC"]
  }
}


data "aws_subnets" "redezinha_subnet" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.redezinha.id]
  }
  filter {
    name   = "tag:type_subnet"
    values = ["public"]
  }
}

data "aws_security_groups" "security_groupzinho" {
  tags = {
    Name = "securitygroupzinho"
  }
}