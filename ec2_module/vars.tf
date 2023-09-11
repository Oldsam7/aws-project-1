variable "instance_count" {
  type = number
}
variable "ami" {
  type = map(any)
  default = {
    linux   = "ami-01c647eace872fc02"
    windows = "ami-09301a37d119fe4c5"
    macos   = "ami-08ca62760f6daf67c"
  }
}
variable "os" {
  type = string
}
variable "instance_type" {
  type = string
}
variable "keypair" {
  type = string
}
variable "subnet_id" {}
variable "sg_id" {
  type = set(string)
}
variable "source_dest_check" {
  type = bool
}
variable "associate_public_ip_address" {
  type = bool
}
variable "iam_instance_profile" {}
variable "user_data" {
  type = string
}