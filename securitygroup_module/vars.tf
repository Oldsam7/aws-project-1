variable "vpc_id" {}
variable "port" {
  type = map(any)
  default = {
    "22"  = 22
    "80"  = 80
    "443" = 443
  }
}
variable "ssh" {
  type    = number
  default = 22
}
variable "http" {
  type    = number
  default = 80
}
variable "https" {
  type    = number
  default = 443
}
variable "tcp_protocol" {
  type    = string
  default = "tcp"
}
variable "myip" {}
