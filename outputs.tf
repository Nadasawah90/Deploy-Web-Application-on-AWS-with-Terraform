output "alb_url" {
  description = "Open this in your browser - login with admin_vp / admin_vp"
  value       = "http://${aws_lb.elb.dns_name}"
}

output "ec2_public_ip" {
  description = "SSH: ssh -i terraform.pem ec2-user@<this-ip>"
  value       = aws_instance.rhel_instance.public_ip
}

output "setup_log_hint" {
  description = "How to watch the bootstrap if something goes wrong"
  value       = "ssh -i terraform.pem ec2-user@${aws_instance.rhel_instance.public_ip} 'sudo tail -f /var/log/vprofile-setup.log'"
}

output "ec2_ami_used" {
  description = "The RHEL 9 AMI resolved for this region"
  value       = aws_instance.rhel_instance.ami
}

output "rds_endpoint" {
  description = "MySQL endpoint (private, reachable from the EC2 instance only)"
  value       = aws_db_instance.example.endpoint
}

output "memcached_endpoint" {
  description = "Memcached configuration endpoint"
  value       = aws_elasticache_cluster.example_memcached.cluster_address
}

output "rabbitmq_host" {
  description = "RabbitMQ hostname written into application.properties"
  value       = local.rabbitmq_host
}

output "rabbitmq_console_url" {
  description = "RabbitMQ web console (private network only)"
  value       = aws_mq_broker.rabbitmq_free_tier.instances[0].console_url
}

output "vpc_id" {
  value = aws_vpc.main.id
}
