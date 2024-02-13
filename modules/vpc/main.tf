resource "aws_vpc" "wordpress_vpc" {
  cidr_block = var.cidr_block_of_vpc

  tags = {
    Name = "wordpress-vpc"
  }
}

output "vpc_id" {
  value = aws_vpc.wordpress_vpc.id
}
