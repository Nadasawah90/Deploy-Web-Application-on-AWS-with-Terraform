resource "aws_lb_target_group" "tg" {
  name     = "my-target-group"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    enabled             = true
    path                = "/login"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    port                = "8080"
    matcher             = "200-399"
  }
}

# This was missing: without it the target group stays empty and the ALB
# returns 503 no matter what.
resource "aws_lb_target_group_attachment" "app" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = aws_instance.rhel_instance.id
  port             = 8080
}

resource "aws_lb" "elb" {
  name                       = "my-elb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.alb.id]
  subnets                    = aws_subnet.public[*].id
  enable_deletion_protection = false

  tags = {
    Name = "${var.project_name}-alb"
  }
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.elb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}
