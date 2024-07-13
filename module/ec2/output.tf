output "ec_instance_public_ip" {
  value =  aws_instance.cicd[*].public_ip
}

output "ec_instance_state" {
  value =  aws_instance.cicd[*].availability_zone
}