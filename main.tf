terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "vpc" {
  source              = "./module/vpc"
  availability_zones  = ["us-east-1a", "us-east-1b", "us-east-1c"]
  sub1_cidr_block     = "10.0.1.0/24"
  sub2_cidr_block     = "10.0.2.0/24"
  sub3_cidr_block     = "10.0.3.0/24"
}

module "ec2" {
  source = "./module/ec2"
  instance_count = var.instance_count
  instance_type = var.instance_type
  instance_names = var.instance_names
  region = var.region
  ami_id = var.ami_id
  key-pair = var.key_name
  subnet_ids         = module.vpc.subnet_ids
  security_group_id  = module.vpc.security_group_id
}