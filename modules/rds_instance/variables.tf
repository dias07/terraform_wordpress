variable "private_subnet_ids" {}
variable "security_group_id" {}
variable "name-db_subnet_group" {}



variable "engine" {
    type = string
}
variable "allocated_storage" {
    type = number
}
variable "engine_version" {
    type = string
}
variable "instance_class" {
    type = string
}
variable "username" {
    type = string
}
variable "password" {
    type = string
}
variable "parameter_group_name" {
    type = string
}
variable "skip_final_snapshot" {}


