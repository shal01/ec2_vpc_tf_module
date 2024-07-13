variable "vpc_cidr_block" {
  description = "cidr block for vpc"
  type = string
  default = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "List of availability zones to choose from"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "sub1_cidr_block" {
  description = "cidr block for subnet1"
  type = string
  default = "10.0.0.0/24"
}

variable "sub2_cidr_block" {
  description = "cidr block for subnet2"
  type = string
  default = "10.0.1.0/24"
}

variable "sub3_cidr_block" {
  description = "cidr block for subnet3"
  type = string
  default = "10.0.2.0/24"
}

variable "region" {
  description = "region for vpc"
  type = string
  default = "us-east-1"
}

