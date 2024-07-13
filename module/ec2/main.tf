terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~>5"
    }
  }
}

resource "aws_instance" "cicd" {
  count = var.instance_count
  ami = var.ami_id
  instance_type = var.instance_type
  subnet_id     = element(var.subnet_ids, count.index % length(var.subnet_ids))
  vpc_security_group_ids = [var.security_group_id]

  tags = {
    Name = var.instance_names[count.index]
  }
}

