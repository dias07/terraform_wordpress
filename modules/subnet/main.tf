

resource "aws_subnet" "public" {
  count            = length(var.public_cidr_blocks)
  vpc_id           = var.vpc_id
  cidr_block       = element(var.public_cidr_blocks, count.index)
  availability_zone = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true
  
  tags = {
  Name =  "public-subnet-${count.index+1}"
  }
}

resource "aws_route_table_association" "wordpress-rt-assoc1" {
  count = length(var.public_cidr_blocks)
  subnet_id      = element(aws_subnet.public[*].id, count.index)
  route_table_id = var.public_route_table_id
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

resource "aws_subnet" "private" {
  count            = length(var.availability_zones)
  vpc_id           = var.vpc_id
  cidr_block       = element(var.private_cidr_blocks, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = {
  Name =  "private-subnet-${count.index+1}"
  }
}

resource "aws_route_table_association" "rds-rt-assoc1" {
  count = length(var.private_cidr_blocks)
  subnet_id      = element(aws_subnet.private[*].id, count.index)
  route_table_id = var.private_route_table_id

}


output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}