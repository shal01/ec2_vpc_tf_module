terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~>5"
    }
  }
}

resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    "key" = "cicd"
  }
}

resource "random_shuffle" "az" {
  input        = var.availability_zones
  result_count = 1
}

resource "aws_subnet" "sub1" {
   vpc_id = aws_vpc.vpc.id
   cidr_block = var.sub1_cidr_block
   availability_zone = random_shuffle.az.result[0]
   map_public_ip_on_launch = true   
}

resource "aws_subnet" "sub2" {
   vpc_id = aws_vpc.vpc.id
   cidr_block = var.sub2_cidr_block
   availability_zone = "us-east-1"
   map_public_ip_on_launch = true   
}

resource "aws_subnet" "sub3" {
   vpc_id = aws_vpc.vpc.id
   cidr_block = var.sub3_cidr_block
   availability_zone = "us-east-1"
   map_public_ip_on_launch = true   
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "my-igw"
  }
}

resource "aws_route_table" "my-rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "my-rt"
  }
}

resource "aws_route_table_association" "rt-association-sub1" {
  subnet_id = aws_subnet.sub1.id
  route_table_id = aws_route_table.my-rt.id
}

resource "aws_route_table_association" "rt-association-sub2" {
  subnet_id = aws_subnet.sub2.id
  route_table_id = aws_route_table.my-rt.id
}

resource "aws_route_table_association" "rt-association-sub3" {
  subnet_id = aws_subnet.sub3.id
  route_table_id = aws_route_table.my-rt.id
}

resource "aws_security_group" "tf_vpc_sg" {
  name        = "tf_vpc_sg"
  description = "Allow TCP inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.vpc.id

  tags = {
    Name = "tf_vpc_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "tf_vpc_sg_ipv4_http" {
  security_group_id = aws_security_group.tf_vpc_sg.id
  cidr_ipv4         = aws_vpc.vpc.id
  from_port         = 80
  ip_protocol       = "HTTP"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "tf_vpc_sg_ipv4_ssh" {
  security_group_id = aws_security_group.tf_vpc_sg.id
  cidr_ipv4         = aws_vpc.vpc.id
  from_port         = 22
  ip_protocol       = "SSH"
  to_port           = 22
}


resource "aws_vpc_security_group_egress_rule" "tf_vpc_sg_ipv4" {
  security_group_id = aws_security_group.tf_vpc_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
