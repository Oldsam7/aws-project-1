#target group creation
resource "aws_lb_target_group" "tg" {
  name        = "targetgroup1"
  port        = var.tg_port
  target_type = var.target_type
  protocol    = var.tg_protocol
  vpc_id      = var.vpc_id

}

# Target Group Attachment with Instance
resource "aws_alb_target_group_attachment" "tg_attachment1" {
  count            = length(var.instance_id) >= 1 ? 1 : 0
  target_group_arn = aws_lb_target_group.tg.arn
#  target_id        = element(tolist(module.server1, 0).id)
  target_id        = element(var.instance_id, 0)
}

resource "aws_alb_target_group_attachment" "tg_attachment2" {
  count            = length(var.instance_id) >= 2 ? 1 : 0
  target_group_arn = aws_lb_target_group.tg.arn
#  target_id        = element(var.instance2_id, 1)
  target_id        = element(var.instance_id, 1)
}


#Application Load Balancer
resource "aws_lb" "lb" {
  name               = "ALB"
  internal           = false
  load_balancer_type = var.load_balancer_type
  security_groups    = [var.securitygroup_id, ]
  subnets            = [var.subnet1_id, var.subnet2_id]
}

#Listener
resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.lb.arn
  port              = var.tg_port
  protocol          = var.tg_protocol

  default_action {
    type = "redirect"

    redirect {
      port             = "443"
      protocol         = "HTTPS"
      status_code = "HTTP_301"
    }
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
      values = ["${var.server1_userdata_key}", "${var.server2_userdata_key}"]
    }
  }
}