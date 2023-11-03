# Subnet Admin
resource "aws_subnet" "subnet_admin" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.1.254.0/24"

  map_public_ip_on_launch = true

  tags = {
    Name = "subnet_admin"
  }
}

# Security group admin
resource "aws_security_group" "admin_sg" {
  vpc_id = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "admin-sg"
  }
}

# EC2 pour Admin
resource "aws_instance" "admin" {
  ami             = "ami-01bc990364452ab3e" # Remplacez par l'AMI de votre choix
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.subnet_admin.id
  vpc_security_group_ids = [aws_security_group.admin_sg.id]
  key_name        = aws_key_pair.deployer.key_name

  tags = {
    Name = "Admin"
  }
}