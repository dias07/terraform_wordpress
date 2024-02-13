
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = var.name-db_subnet_group
  subnet_ids = flatten([var.private_subnet_ids])
  
  tags = {
    Name = var.name-db_subnet_group
  }
}

resource "aws_db_instance" "mysql" {
  engine               = var.engine
  allocated_storage    = var.allocated_storage
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  username             = var.username
  password             = var.password
  parameter_group_name = var.parameter_group_name
  skip_final_snapshot  = var.skip_final_snapshot



  vpc_security_group_ids = ["${var.security_group_id}"]
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.id

}

