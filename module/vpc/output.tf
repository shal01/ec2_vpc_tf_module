output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "subnet_ids" {
  value = [aws_subnet.sub1.id, aws_subnet.sub2.id, aws_subnet.sub3.id]
}

output "security_group_id" {
  value = aws_security_group.tf_vpc_sg.id
}