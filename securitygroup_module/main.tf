#creating a security group
resource "aws_security_group" "ap1-sg" {
  vpc_id      = var.vpc_id
  description = "awsproject1-securitygroup"

  ingress {
      description = "Ingress for port ${var.port[var.port1]}"
      from_port   = var.port[var.port1]
      to_port     = var.port[var.port1]
      protocol    = var.protocol
      cidr_blocks = var.myip
    }
  ingress {
      description = "Ingress for port ${var.port[var.port2]}"
      from_port   = var.port[var.port2]
      to_port     = var.port[var.port2]
      protocol    = var.protocol
      cidr_blocks = var.myip
    }
  ingress {
      description = "Ingress for port ${var.port[var.port3]}"
      from_port   = var.port[var.port3]
      to_port     = var.port[var.port3]
      protocol    = var.protocol
      cidr_blocks = var.myip
    }

  egress {
    description = "Egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "ap1-sg"
  }

}