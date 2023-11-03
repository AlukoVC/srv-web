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
  ami_id              = "ami-01bc990364452ab3e"  # Change this to your desired AMI
  instance_type       = "t2.micro"
  key_name            = "key-pair"  # Change this to your key pair name
  subnet_id           = module.network.subnet_id
  security_group_ids  = [module.network.security_group_id]  # Use the security group from the network module
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
  instance_name       = "web-server-instance"
}
