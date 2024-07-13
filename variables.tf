variable "instance_type" {
  description = "instance type"
}

variable "ami_id" {
  description = "instance ami id"
  type = string
  default = "t2.micro"
}

variable "instance_count" {
  description = "instance required"
  type = number
  default = 1
}

variable "key_name" {
  description = "name of keypair"
  type = string
}

variable "region" {
  description = "instance region"
  type = string
  default = "us-east-1"
}

variable "instance_names" {
  description = "Name of the instances"
  type        = list(string)
}