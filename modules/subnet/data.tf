

# data "aws_subnets" "public" {
  
#     filter {
#     name   = "vpc-id"
#     values = [var.vpc_id]
#   }

#   tags = {
#     Tier = "public"
#   }
# }

# data "aws_subnet" "public" {
#   for_each = toset(data.aws_subnets.public.ids)
#   id       = each.value
# }
# output "public_subnet_ids" {
#   value = data.aws_subnet.public[*].id
# }





# data "aws_subnets" "private" {
#     filter {
#     name   = "vpc-id"
#     values = [var.vpc_id]
#   }


#   tags = {
#     Tier = "private"
#   }
# }

# data "aws_subnet" "private" {
#   for_each = toset(data.aws_subnets.private.ids)
#   id       = each.value
# }

# output "private_subnet_ids" {
#   value = data.aws_subnet.private[*].id
# }



