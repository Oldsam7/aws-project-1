variable "tg_port" {
  type = number
}
variable "target_type" {
  type = string
}
variable "tg_protocol" {
  type = string
}
variable "vpc_id" {}
variable "protocol_version" {
  type = string
}
variable "instance_id1" {}
variable "instance_id2" {}
variable "instance_ids" {
  type = list(any)
}
# variable "server1_id" {}
# variable "server2_id" {

# }
#variable "instance2_id" {}
variable "load_balancer_type" {
  type = string
}
variable "securitygroup_id" {}
variable "subnet1_id" {}
variable "subnet2_id" {}
variable "server1_userdata_key" {}
variable "server2_userdata_key" {}