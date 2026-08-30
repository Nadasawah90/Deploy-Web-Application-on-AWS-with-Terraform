resource "aws_elasticache_subnet_group" "main" {
  name       = "${var.project_name}-cache-subnet-group"
  subnet_ids = aws_subnet.private[*].id
  #subnet_ids = [data.aws_subnet.private.id]
  tags = {
    Name = "${var.project_name}-cache-subnet-group"
  }
}

resource "aws_elasticache_cluster" "example_memcached" {
  cluster_id           = "my-memcached-cluster"
  engine               = "memcached"
  node_type            = "cache.t3.small"
  num_cache_nodes      = 1
  parameter_group_name = "default.memcached1.6"
  engine_version       = "1.6.22"
  port                 = 11211
  az_mode              = "single-az"

  subnet_group_name  = aws_elasticache_subnet_group.main.name
  security_group_ids = [aws_security_group.allow_all.id]

  tags = {
    Name = "My Free Tier Memcached Cluster"
  }
}
