resource "aws_instance" "example" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.subnet_id
  security_groups = var.security_group_ids

  tags = {
    Name = var.instance_name
  }

  user_data = var.user_data_script
}
