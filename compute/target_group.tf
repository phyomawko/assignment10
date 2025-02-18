resource "aws_lb_target_group" "ass10_tg" {
  name        = "ass10-tg"
  protocol    = "HTTP"
  port        = 80
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
    matcher             = "200"
  }

  tags = {
    Name = "ass10-target-group"
  }
}