variable "vpc_id" {}
variable "port" {
  type = map(any)
  default = {
    "ssh"   = 22
    "http"  = 80
    "https" = 443
  }
}
variable "port1" {
  type = string
}
variable "port2" {
  type = string
}
variable "port3" {
  type = string
}
variable "protocol" {
  type = string
}
variable "myip" {}
