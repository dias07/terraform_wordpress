
resource "aws_security_group" "wordpress_sg" {
  name = var.web_sg_name
  vpc_id      = var.vpc_id
  dynamic "ingress" {
    for_each = var.ingress_rules

    content {
      description = ingress.value.description
      from_port   = ingress.value.from_port   
      to_port     = ingress.value.to_port     
      protocol    = ingress.value.protocol 
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
   dynamic "egress" {
    for_each = var.ingress_rules

    content {
      description = egress.value.description
      from_port   = egress.value.from_port   
      to_port     = egress.value.to_port     
      protocol    = egress.value.protocol 
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  tags = {
    Name = var.web_sg_name
  }
}

output "web_security_group_id" {
  value = aws_security_group.wordpress_sg.id
}




resource "aws_security_group" "rds_sg" {
  name        = var.rds_sg_name
  vpc_id      = var.vpc_id
  ingress {
    from_port = var.ingress_ports
    to_port   = var.ingress_ports
    protocol  = var.protocol-db

    security_groups = ["${var.outside_sg}"]
  }
   egress {
    from_port = var.ingress_ports
    to_port   = var.ingress_ports
    protocol  = var.protocol-db

    security_groups = ["${var.outside_sg}"]
  }

  tags = {
    Name = var.rds_sg_name
  }

}



output "rds_security_group_id" {
  value = aws_security_group.rds_sg.id
}