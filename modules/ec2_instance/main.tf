resource "aws_key_pair" "ter-key" {
  key_name   = "ter-key"
  public_key = var.key_pair
}



resource "aws_instance" "wordpress_ec2" {
  ami           = data.aws_ami.selected.id
  instance_type          = var.type_of_instance
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  # security_groups        = var.security_group_id
  key_name               = var.key_pair_name
  associate_public_ip_address = true
  user_data = var.user_data

  tags = {
    Name = "wordpress-ec2"
  }
  depends_on = [
    var.key_pair_name
  ]
}




