variable "instance_type" {
  description = "instance type"
}

variable "ami_id" {
  description = "instance ami id"
  type = string
}

variable "instance_count" {
  description = "instance required"
  type = number
  default = 1
}

variable "key-pair" {
  description = "name of keypair"
  type = string
}

variable "region" {
  description = "instance region"
  type = string
}

variable "instance_names" {
  description = "Name of the instances"
  type        = list(string)
}


variable "subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group ID"
  type        = string
}