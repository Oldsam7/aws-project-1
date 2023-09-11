#variable "AWS_ACCESS_KEY" {}                #declaring the variables defined in terraform.tfvars
#variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {}
variable "BUCKET" {}
variable "keypair" {}
variable "myip" {}

#vpc variables


#instance variables
variable "os" {
  default = "linux"
}
variable "instance_type" {
  default = "t2.micro"
}


#security group variables
variable "port1" {
  default = "ssh"
}
variable "port2" {
  default = "http"
}
variable "port3" {
  default = "https"
}
variable "protocol" {
  default = "tcp"
}


#s3 variables
variable "server1_userdata_key" {}
variable "server2_userdata_key" {}

#alb variables
variable "tg_port" {
  default = 80
}
variable "target_type" {
  default = "instance"
}
variable "tg_protocol" {
  default = "HTTP"
}
variable "load_balancer_type" {
  default = "application"
}

