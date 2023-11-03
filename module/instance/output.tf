output "web_server_instance_id" {
  value = aws_instance.example.id
}

output "web_server_private_ip" {
  value = aws_instance.example.private_ip
}

output "vpc_id" {
  value = aws_vpc.example.id
}

output "subnet_id" {
  value = aws_subnet.example.id
}

