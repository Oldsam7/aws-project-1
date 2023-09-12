#target group creation
resource "aws_lb_target_group" "tg" {
  name        = "targetgroup1"
  port        = var.tg_port     #80
  target_type = var.target_type #Instance
  protocol    = var.tg_protocol #HTTP
  health_check {
    enabled             = true
    interval            = 30
    path                = "/"
    port                = var.tg_port
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 6
    protocol            = var.tg_protocol
    matcher             = "200-399"
  }
  vpc_id           = var.vpc_id
  protocol_version = var.protocol_version #HTTP1

}

# Target Group Attachment with Instance
resource "aws_alb_target_group_attachment" "tg_attachment1" {
  count            = length(var.instance_ids) >= 1 ? 1 : 0
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = var.instance_id1
  port             = var.tg_port
}

resource "aws_alb_target_group_attachment" "tg_attachment2" {
  count            = length(var.instance_ids) >= 2 ? 1 : 0
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = var.instance_id2
  port             = var.tg_port
}


#Application Load Balancer
resource "aws_lb" "lb" {
  name               = "ap1-alb"
  internal           = false
  ip_address_type    = "ipv4"
  load_balancer_type = var.load_balancer_type
  security_groups    = [aws_security_group.alb-sg.id, ]
  subnets            = [var.subnet1_id, var.subnet2_id]
}

#Listener
resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.lb.arn
  port              = var.tg_port
  protocol          = var.tg_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

#Listener Rule
resource "aws_lb_listener_rule" "listener_rule" {
  listener_arn = aws_lb_listener.listener.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}

resource "aws_security_group" "alb-sg" {
  vpc_id      = var.vpc_id
  description = "awsproject1-alb-securitygroup"

  ingress {
    description = "Ingress for port ${var.tg_port}"
    from_port   = var.tg_port
    to_port     = var.tg_port
    protocol    = var.protocol
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "alb-ap1-sg"
  }

}