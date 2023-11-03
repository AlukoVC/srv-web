variable "ami_id" {
  description = "ID de l'AMI pour l'instance EC2"
  default     = "ami-01bc990364452ab3e"
}

variable "instance_name" {
  description = "Nom de l'instance EC2"
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
}

variable "security_group_ids" {
  description = "Liste des ID des groupes de sécurité pour l'instance EC2"
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
}

variable "subnet_cidr_block" {
  description = "CIDR block for the subnet"
}

variable "availability_zone" {
  description = "Availability zone for the subnet"
}

variable "security_group_name" {
  description = "Nom du groupe de sécurité"
}

variable "security_group_description" {
  description = "Description du groupe de sécurité"
}

variable "vpc_id" {
  description = "ID du VPC pour le groupe de sécurité"
}

variable "ssh_ingress_ip" {
  description = "Adresse IP autorisée pour SSH ingress"
}

variable "user_data_script" {
  description = "Script de démarrage de l'instance EC2"
}
