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
