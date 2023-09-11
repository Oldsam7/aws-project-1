#declaring input variables without assigning them any initial values, can be used to parameterize our code, allowing us to provide different values when running our terraform deployment
variable "cidr_range" {
  type = any
  default = {
    "vpc"          = "10.0.0.0/16"
    "publicsubnet" = ["10.0.1.0/24", "10.0.3.0/24"]
  }
}
variable "avail_zone" {
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}
