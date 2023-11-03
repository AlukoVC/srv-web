resource "aws_vpc" "main" {
  cidr_block = "10.1.0.0/16"

  tags = {
    Name = "main-vpc"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}

resource "aws_route" "default_gw" {
  route_table_id         = aws_vpc.main.default_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

resource "aws_key_pair" "deployer" {
  key_name   = "admin"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDH/PA+ggWZ0aex0LNwwrhrbhnxK/QG6SmGQgf9K2fBlkcYSWmfTRMi79s9eEMx22arvlpg74cEMELeNaA7AQOVaippT6vkKoGUTpS6tC17wm2TMJKedhQUTsaGVNrWLHmS5RwClbcoEIfEUz3xItWy7bwoWralf+R34GMvXHA53U1YGRSuClyJPJQ8F2z/2aANSGyfALXZBONSpLea1ZIYcU7ZL11upE6ubvD8qaqeXR6yKae6ng5qUbN63T8A6DviJjOQ4GMk6Nh8lJ6LN/pg8TSk//E/4CpJrlx3eR8MSub4EYbMC4ziaTUDRb9IKihhw532c0kile5DdiOnepaPYsd49olCShCG2/dGTVA/yFhMERRc6cSOtqis16TBA/0SKBfIuVoG6SrdqfaTJD+KworQ6TNAUFadlkiCI+LXh1/M3B3N8ZXBduV4NRx7pMdqYSxms9VdpGSWWFawOCo5TqhbNUXeDx27SzzveVl3Z86jholkBgg4typfbpAGrLs="
}