provider "aws" {
  region = "us-east-1"
}

module "network" {
  source              = "./modules/network"
  vpc_cidr_block      = "10.0.0.0/16"
  subnet_cidr_block   = "10.0.1.0/24"
  availability_zone    = "us-east-1a"
}

module "web_server" {
  source              = "./modules/web_server"
  user_data_script    = <<-EOF_SCRIPT
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
  instance_name       = "srv-web1"
}

module "web_server" {
  source              = "./modules/web_server"
  user_data_script    = <<-EOF_SCRIPT
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
  instance_name       = "srv-web2"
}

module "web_server" {
  source              = "./modules/web_server"
  instance_name       = "srv-admin"
}

module "security_group" {
  source                      = "./modules/security_group"
  security_group_name         = "example-serveur-web"
  security_group_description  = "Regles de securite pour le serveur web"
  vpc_id                      = module.network.vpc_id
  ssh_ingress_ip              = "your_ip_here"  # Replace with your specific IP for SSH ingress
}

