

resource "aws_route_table" "private" {
   depends_on = [var.nat_gateway]
  vpc_id = var.vpc_id

 
   route {
   cidr_block = var.cidr_block
   gateway_id = var.nat_gateway
   }
    tags = {
    Name = var.private_name_tag
  }
}

output "private_route_table_id" {
  description = "ID of the private route table"
  value       = aws_route_table.private.id
}

resource "aws_route_table" "public" {
  vpc_id = var.vpc_id


route {
   cidr_block = var.cidr_block
   gateway_id = var.internet_gateway
  }
  tags = {
    Name = var.name_tag
  }
}

output "public_route_table_id" {
  description = "ID of the public route table"
  value       = aws_route_table.public.id
}
