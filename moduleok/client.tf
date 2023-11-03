module client_dev1 {
    source = "./client"
    client_name = "Client1"
    client_subnet = "10.0.1.0/24"
    vpc_main = aws_vpc.main.id
    deployer_keys = aws_key_pair.deployer.key_name
}

module client_dev20 {
    source = "./client"
    client_name = "Client20"
    client_subnet = "10.0.20.0/24"
    vpc_main = aws_vpc.main.id
    deployer_keys = aws_key_pair.deployer.key_name
}