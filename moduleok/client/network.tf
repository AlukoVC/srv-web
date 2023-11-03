# Subnet Client A
resource "aws_subnet" "subnet_prod_1" {
  vpc_id     = var.vpc_main
  cidr_block = var.client_subnet

  map_public_ip_on_launch = true

  tags = {
    Name = var.client_name
  }
}

# Security Group
resource "aws_security_group" "client_sg" {
  vpc_id = var.vpc_main

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 53
    to_port     = 53
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-${var.client_name}"
  }
}