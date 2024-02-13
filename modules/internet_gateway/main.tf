
resource "aws_internet_gateway" "wordpress_ig" {
  vpc_id = var.vpc_id

  tags = {
    Name = "wordpress_ig"
  }
}
output "internet_gateway" {
  value = aws_internet_gateway.wordpress_ig.id
}

resource "aws_nat_gateway" "wordpress-ng" {

    depends_on = [
    var.subnet_ids
  ]

  allocation_id = var.eip_id
  subnet_id     = var.subnet_id

  tags = {
    Name = "wordpress-ng"
  }

}
output "nat_gateway" {
  value = aws_nat_gateway.wordpress-ng.id
} 



resource "aws_eip" "VersaLink_eip" {
  depends_on = [var.route_table]
}
output "eip_id" {
  value = aws_eip.VersaLink_eip.id
}