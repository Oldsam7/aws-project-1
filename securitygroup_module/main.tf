#creating a security group
resource "aws_security_group" "ap1-sg" {
  vpc_id      = var.vpc_id
  description = "awsproject1-securitygroup"

  ingress {
    description = "Ingress for port ${var.port[var.ssh]}"
    from_port   = var.port[var.ssh]
    to_port     = var.port[var.ssh]
    protocol    = var.tcp_protocol
    cidr_blocks = var.myip //allowing traffic only from my ip
  }
  ingress {
    description = "Ingress for port ${var.port[var.http]}"
    from_port   = var.port[var.http]
    to_port     = var.port[var.http]
    protocol    = var.tcp_protocol
    cidr_blocks = ["0.0.0.0/0"] //allowing traffic from everywhere
  }
  ingress {
    description = "Ingress for port ${var.port[var.https]}"
    from_port   = var.port[var.https]
    to_port     = var.port[var.https]
    protocol    = var.tcp_protocol
    cidr_blocks = ["0.0.0.0/0"] //allowing traffic from everywhere
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