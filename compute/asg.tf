resource "aws_autoscaling_group" "ass10_asg" {
  launch_template {
    id      = aws_launch_template.ass10_lt.id
    version = "$Latest"
  }

  min_size           = 1
  max_size           = 2
  desired_capacity   = 2
  vpc_zone_identifier = [var.pri_subnet1_id,var.pri_subnet2_id] 

  target_group_arns = [aws_lb_target_group.ass10_tg.arn]

  health_check_type         = "ELB"
  health_check_grace_period = 300

  tag {
    key                 = "Name"
    value               = "ass10-instance"
    propagate_at_launch = true
  }
}