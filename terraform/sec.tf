# ---------------- ALB security group ----------------

resource "aws_security_group" "alb" {
  name        = "${var.project_name}-alb-sg"
  description = "Allow HTTP from the internet to the load balancer"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-alb-sg"
  }
}

# ---------------- Application (Tomcat EC2) security group ----------------

resource "aws_security_group" "app" {
  name        = "${var.project_name}-app-sg"
  description = "Tomcat instance: 8080 from ALB, SSH from your IP"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "Tomcat from the load balancer only"
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-app-sg"
  }
}

# ---------------- Backend security group (RDS / Memcached / RabbitMQ) ----------------
# Kept under the original name "allow_all" so the other files still reference it,
# but the ingress is now limited to traffic coming from the app instance instead
# of 0.0.0.0/0. These resources live in private subnets and are not reachable
# from the internet.

resource "aws_security_group" "allow_all" {
  name        = "allow_all_traffic"
  description = "Backend services: all traffic from the app tier"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "All traffic from the application tier"
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.app.id]
  }

  ingress {
    description = "All traffic inside the VPC (self / peer backends)"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Allow All Traffic"
  }
}
