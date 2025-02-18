resource "aws_lb" "ass10_alb" {
  name               = "ass10-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.lb_sg_id]
  subnets            = [var.pub_subnet1_id, var.pub_subnet2_id] 

  enable_deletion_protection = false

  tags = {
    Name = "ass10-alb"
  }
}

# Create a Listener for the ALB
resource "aws_lb_listener" "ass10_listener" {
  load_balancer_arn = aws_lb.ass10_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ass10_tg.arn
  }
}