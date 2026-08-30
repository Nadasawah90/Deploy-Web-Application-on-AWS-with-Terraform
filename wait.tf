# Without this, terraform apply returns while the instance is still installing
# Maven dependencies, and opening the ALB URL gives a 503. This blocks until the
# target group reports the instance healthy.
#
# The AWS CLI waiter gives up after ~10 minutes, which is sometimes shorter than
# a cold Maven build, so it is retried once for a ~20 minute ceiling.
# Set wait_for_healthy = false in terraform.tfvars to skip this entirely.

resource "terraform_data" "wait_for_app" {
  count = var.wait_for_healthy ? 1 : 0

  depends_on = [
    aws_lb_target_group_attachment.app,
    aws_lb_listener.listener,
  ]

  triggers_replace = [
    aws_instance.rhel_instance.id,
  ]

  provisioner "local-exec" {
    command = "aws elbv2 wait target-in-service --region ${var.region} --target-group-arn ${aws_lb_target_group.tg.arn} --targets Id=${aws_instance.rhel_instance.id},Port=8080 || aws elbv2 wait target-in-service --region ${var.region} --target-group-arn ${aws_lb_target_group.tg.arn} --targets Id=${aws_instance.rhel_instance.id},Port=8080"
  }
}
