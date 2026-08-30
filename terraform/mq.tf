resource "aws_mq_broker" "rabbitmq_free_tier" {
  broker_name        = "rabbitmq-free-tier"
  engine_type        = "RabbitMQ"
  engine_version     = "3.13"
  host_instance_type = "mq.m7g.medium"

  user {
    username = var.mq_username
    password = var.mq_password
  }

  apply_immediately          = true
  auto_minor_version_upgrade = true
  deployment_mode            = "SINGLE_INSTANCE"
  publicly_accessible        = false

  # SINGLE_INSTANCE takes exactly one subnet.
  subnet_ids = [aws_subnet.private[0].id]
  #subnet_ids      = [data.aws_subnet.private.id]
  security_groups = [aws_security_group.allow_all.id]

  tags = {
    Name = "Free Tier RabbitMQ"
  }
}
