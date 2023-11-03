# EC2 Client A
resource "aws_instance" "client_A" {
  ami             = "ami-01bc990364452ab3e"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.subnet_prod_1.id
  vpc_security_group_ids = [aws_security_group.client_sg.id]
  key_name        = var.deployer_keys #aws_key_pair.deployer.key_name 
  user_data = <<-EOF
              #!/bin/bash -xe
              yum update -y
              yum install -y nginx
              systemctl start nginx
              EOF

  tags = {
    Name = var.client_name
  }
}