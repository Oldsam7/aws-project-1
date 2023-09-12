#variable "AWS_ACCESS_KEY" {}                #declaring the variables defined in terraform.tfvars
#variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {}
variable "BUCKET" {}
variable "keypair" {}
variable "myip" {}

#vpc variables


#instance variable
variable "os" {
  default = "linux"
}
variable "instance_type" {
  default = "t2.micro"
}


#security group variables



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
variable "protocol_version" {
  default = "HTTP1"
}
variable "load_balancer_type" {
  default = "application"
}
variable "protocol" {
  type    = string
  default = "tcp"
}


#route53 variables
variable "zone_name" {}