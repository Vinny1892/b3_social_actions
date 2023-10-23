# vpc_module.tf

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
}

variable "public_subnet_cidr_blocks" {
  type        = list(string)
  description = "CIDR blocks for public subnets"
}

variable "private_subnet_cidr_blocks" {
  type        = list(string)
  description = "CIDR blocks for private subnets"
}

variable "region" {
  description = "AWS region"
}


variable "availability_zone" {
  
}
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "MainVPC"
  }
}

resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidr_blocks)

  cidr_block        = var.public_subnet_cidr_blocks[count.index]
  vpc_id            = aws_vpc.main.id
  availability_zone =  var.availability_zone[count.index] # AZ naming convention

  map_public_ip_on_launch = true

  tags = {
    type_subnet = "public"
    Name        = "PublicSubnet-${count.index + 1}"
  }
}

resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidr_blocks)

  cidr_block        = var.private_subnet_cidr_blocks[count.index]
  vpc_id            = aws_vpc.main.id
  availability_zone = "us-east-1a" # AZ naming convention

  tags = {
    Name = "PrivateSubnet-${count.index + 1}"
  }
}

resource "aws_security_group" "example" {
  # ... other configuration ...
  description = "seila"
  vpc_id = aws_vpc.main.id


  egress {
    description = "TLS from VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
     cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
     cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    Name = "securitygroupzinho"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
}


resource "aws_route_table" "r" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "my-routing-table"
  }
}

#route table connect to public subnet
resource "aws_route_table_association" "a" {
  count = length(var.public_subnet_cidr_blocks)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.r.id
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat-gateway-eip.id
  subnet_id     = aws_subnet.public[0].id

}

resource "aws_eip" "nat-gateway-eip" {
 domain = "vpc"
}

resource "aws_route_table" "nat_gateway_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name = "Route Table for NAT Gateway"
  }

}


resource "aws_route_table_association" "nat_gateway_rt_assoc" {
    count = length(var.private_subnet_cidr_blocks)

#  Private Subnet ID for adding this route table to the DHCP server of Private subnet!
  subnet_id      = aws_subnet.private[count.index].id

# Route Table ID
  route_table_id = aws_route_table.nat_gateway_rt.id
}