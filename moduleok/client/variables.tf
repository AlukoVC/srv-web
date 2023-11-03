variable "client_name" {
    type = string
    description = "Required for id"
}

variable "client_subnet" {
    type = string
    description = "Client subnet"
}

variable "vpc_main" {
    type = string
    description = "Main VPC"
}

variable "deployer_keys" {
    type = string
    description = "SSH keys"
}