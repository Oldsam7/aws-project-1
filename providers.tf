terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.0.1"
      #        access_key = "${var.AWS_ACCESS_KEY}"                #referring to variables declared in vars.tf
      #        secret_key = "${var.AWS_SECRET_KEY}"
    }
  }
}

provider "aws" {
  region = var.AWS_REGION
}