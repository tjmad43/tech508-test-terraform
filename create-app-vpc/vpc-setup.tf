# Details of VPC setup in vpcs.md

# VPC
resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr

  tags = {
    Name = var.vpc_name
  }
}

# subnets
resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.pub_subnet_cidr
  availability_zone = "eu-west-1a"

  tags = {
    Name = var.pub_subnet_name
  }

}
resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.priv_subnet_cidr
  availability_zone = "eu-west-1b"

  tags = {
    Name = var.priv_subnet_name
  }

}

# internet gateway
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.ig_name
  }
}

# public route table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }

  tags = {
    Name = var.rt_name
  }
}

# Associate route table with subnet
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}