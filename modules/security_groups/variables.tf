variable "vpc_id" {}
variable "ingress_rules" {
     description = "List of ingress rules for the security group"
  type        = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    description = string}))
}
variable "web_sg_name" {
  description = "Name for the security group"
  type        = string
}
//



variable "ingress_ports" {
  type = number
}
variable "rds_sg_name" {
  description = "Allow db traffic on public Ec2"
  type        = string
}

variable "eigress" {}
variable "protocol-db" {
  type = string
}

variable "outside_sg" {
  
}
