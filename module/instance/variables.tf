variable "ami_id" {
  description = "ID de l'AMI pour l'instance EC2"
  default     = "ami-01bc990364452ab3e"
}

variable "instance_name" {
  description = "Nom de l'instance EC2"
  default     = "srv-web"
}

variable "instance_name2" {
  description = "Nom de l'instance EC2"
  default     = "srv-web2"
}

variable "instance_type" {
  description = "Type d'instance EC2"
  default     = "t2.micro"
}

variable "key_name" {
  description = "Nom de la paire de clés pour l'instance EC2"
  default     = "key-pair"
}

variable "subnet_id" {
  description = "ID du sous-réseau pour l'instance EC2"
  # Assurez-vous de fournir une valeur appropriée au moment de l'utilisation
}

variable "security_group_ids" {
  description = "Liste des ID des groupes de sécurité pour l'instance EC2"
  # Assurez-vous de fournir une valeur appropriée au moment de l'utilisation
}

variable "user_data_script" {
  description = "Script de démarrage de l'instance EC2"
  default = <<-EOF_SCRIPT
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
