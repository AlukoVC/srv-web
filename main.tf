# main.tf

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "example-vpc"
  }
}

resource "aws_internet_gateway" "example" {
  vpc_id = aws_vpc.example.id

  tags = {
    Name = "example-internet-gateway"
  }
}

resource "aws_route_table_association" "example" {
  subnet_id      = aws_subnet.example.id
  route_table_id = aws_route_table.example.id
}

resource "aws_subnet" "example" {
  vpc_id                  = aws_vpc.example.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a" 
  map_public_ip_on_launch = true

  tags = {
    Name = "example-subnet"
  }
}

resource "aws_route_table" "example" {
  vpc_id = aws_vpc.example.id

  tags = {
    Name = "example-route-table"
  }
}

resource "aws_route" "example" {
  route_table_id            = aws_route_table.example.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.example.id
}

resource "aws_instance" "example" {
  ami           = "ami-01bc990364452ab3e"
  instance_type = "t2.micro"
  key_name      = "key-pair"
  subnet_id     =aws_subnet.example.id
  security_groups = [aws_security_group.example.id]

  tags = {
    Name = "srv-web"
  }

  user_data = <<-EOF_SCRIPT
              #!/bin/bash -xe
              yum update -y
              yum install -y httpd git
              service httpd start
              chkconfig httpd on
              git clone https://bitbucket.org/fhoubart/testphaser_aws.git /var/www/html/testphaser_aws
              cat <<EOF >> /etc/httpd/conf/httpd.conf
              <VirtualHost *:80>
                  DocumentRoot "/var/www/html/testphaser_aws/public_html/"
                  <Directory "/var/www/html/testphaser_aws/public_html/">
                      Options Indexes FollowSymLinks
                      AllowOverride All
                      Require all granted
                  </Directory>
              </VirtualHost>
              EOF
              service httpd restart
              EOF_SCRIPT
}

resource "aws_instance" "example2" {
  ami           = "ami-01bc990364452ab3e"
  instance_type = "t2.micro"
  key_name      = "key-pair"
  subnet_id     =aws_subnet.example.id
  security_groups = [aws_security_group.example.id]

  tags = {
    Name = "srv-web2"
  }

  user_data = <<-EOF_SCRIPT
              #!/bin/bash -xe
              yum update -y
              yum install -y httpd git
              service httpd start
              chkconfig httpd on
              git clone https://bitbucket.org/fhoubart/testphaser_aws.git /var/www/html/testphaser_aws
              cat <<EOF >> /etc/httpd/conf/httpd.conf
              <VirtualHost *:80>
                  DocumentRoot "/var/www/html/testphaser_aws/public_html/"
                  <Directory "/var/www/html/testphaser_aws/public_html/">
                      Options Indexes FollowSymLinks
                      AllowOverride All
                      Require all granted
                  </Directory>
              </VirtualHost>
              EOF
              service httpd restart
              EOF_SCRIPT
}

resource "aws_instance" "example3" {
  ami           = "ami-01bc990364452ab3e"
  instance_type = "t2.micro"
  key_name      = "key-pair"
  subnet_id     =aws_subnet.example.id
  security_groups = [aws_security_group.admin_security_group.id]

  tags = {
    Name = "srv-admin"
  }

  user_data = <<-EOF_SCRIPT
              #!/bin/bash -xe
              yum update -y
              EOF_SCRIPT
}

resource "aws_security_group" "example" {
  name        = "example-serveur-web"
  description = "Regles de securite pour le serveur web"
  vpc_id      = aws_vpc.example.id

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
    cidr_blocks = ["${aws_instance.example3.private_ip}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "admin_security_group" {
  name        = "admin-serveur-web"
  description = "Regles de securite pour le serveur admin"
  vpc_id      = aws_vpc.example.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "prod_server1_ip" {
  value = aws_instance.example.public_ip
}

output "prod_server2_ip" {
  value = aws_instance.example2.public_ip
}

output "admin_server_ip" {
  value = aws_instance.example3.public_ip
}