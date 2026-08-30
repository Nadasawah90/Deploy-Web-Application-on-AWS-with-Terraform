# ============================================================
# RHEL 9 AMI
# ============================================================
# AMI IDs are region-specific.
# This data source automatically finds the latest RHEL 9 AMI
# in the AWS region configured in provider.tf.
#
# If var.ami_id is provided, this data source is skipped.

data "aws_ami" "rhel9" {
  count = var.ami_id == "" ? 1 : 0

  most_recent = true
  owners      = ["309956199498"] # Red Hat

  filter {
    name   = "name"
    values = ["RHEL-9.*_HVM-*-x86_64-*-Hourly*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}


# ============================================================
# LOCAL VARIABLES
# ============================================================

locals {

  # Amazon MQ returns an endpoint such as:
  # amqps://b-1234.mq.us-east-1.amazonaws.com:5671
  #
  # The application requires only the hostname.

  rabbitmq_host = replace(
    replace(
      aws_mq_broker.rabbitmq_free_tier.instances[0].endpoints[0],
      "amqps://",
      ""
    ),
    ":5671",
    ""
  )


  # ==========================================================
  # EC2 USER DATA
  # ==========================================================
  # Pass the RDS, Memcached and RabbitMQ connection information
  # to the Tomcat installation script.

  user_data = templatefile(
    "${path.module}/templates/tomcat_setup.sh.tftpl",
    {
      repo_url = var.repo_url

      rds_host = aws_db_instance.example.address
      rds_port = aws_db_instance.example.port
      db_name  = aws_db_instance.example.db_name
      db_user  = var.db_username
      db_pass  = var.db_password

      memcached_host = aws_elasticache_cluster.example_memcached.cluster_address

      rabbitmq_host = local.rabbitmq_host
      mq_user       = var.mq_username
      mq_pass       = var.mq_password
    }
  )
}


# ============================================================
# EC2 INSTANCE
# ============================================================

resource "aws_instance" "rhel_instance" {

  # ----------------------------------------------------------
  # AMI
  # ----------------------------------------------------------
  # If ami_id is provided in variables/terraform.tfvars,
  # Terraform uses that AMI.
  #
  # Otherwise Terraform automatically selects the latest
  # RHEL 9 AMI.

  ami = var.ami_id != "" ? var.ami_id : data.aws_ami.rhel9[0].id


  # ----------------------------------------------------------
  # INSTANCE TYPE
  # ----------------------------------------------------------
  # Your variables.tf should contain:
  #
  # default = "t3.micro"

  instance_type = var.instance_type


  # ----------------------------------------------------------
  # SSH KEY PAIR
  # ----------------------------------------------------------

  key_name = var.key_name


  # ----------------------------------------------------------
  # PUBLIC SUBNET
  # ----------------------------------------------------------
  # Public subnet is used because the Tomcat server needs
  # internet access and a public IP.

  subnet_id = aws_subnet.public[0].id


  # ----------------------------------------------------------
  # SECURITY GROUP
  # ----------------------------------------------------------

  vpc_security_group_ids = [
    aws_security_group.app.id
  ]


  # ----------------------------------------------------------
  # PUBLIC IP
  # ----------------------------------------------------------

  associate_public_ip_address = true


  # ----------------------------------------------------------
  # USER DATA
  # ----------------------------------------------------------
  # This script installs/configures Tomcat and the application.

  user_data                   = local.user_data
  user_data_replace_on_change = true


  # ----------------------------------------------------------
  # ROOT DISK
  # ----------------------------------------------------------

  root_block_device {

    volume_size = 20

    volume_type = "gp3"

    delete_on_termination = true

    encrypted = true
  }


  # ----------------------------------------------------------
  # TAGS
  # ----------------------------------------------------------

  tags = {
    Name = "RHEL Instance"
  }
}


