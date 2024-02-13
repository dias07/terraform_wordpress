data "aws_ami" "selected" {
  most_recent = true

  filter {
    name   = "image-id"
    values = [var.ec2_ami]
  }
}

output "selected_ami_id" {
  value = data.aws_ami.selected.id
}
