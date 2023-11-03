output "web_server_instance_id" {
  value = aws_instance.example.id
}

output "web_server_private_ip" {
  value = aws_instance.example.private_ip
}
