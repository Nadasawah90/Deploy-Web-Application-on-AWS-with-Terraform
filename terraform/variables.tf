
# ============================================================
# AWS REGION
# ============================================================

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}


# ============================================================
# PROJECT
# ============================================================

variable "project_name" {
  description = "Prefix used in all resource names"
  type        = string
  default     = "vprofile"
}


# ============================================================
# VPC
# ============================================================

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}


# ============================================================
# PUBLIC SUBNETS
# ============================================================
# Used by:
# - EC2 Tomcat server
# - Application Load Balancer
#
# The current configuration creates two public subnets
# in different Availability Zones because an ALB requires
# at least two Availability Zones.

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)

  default = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]
}


# ============================================================
# PRIVATE SUBNETS
# ============================================================
# Used by:
# - RDS
# - ElastiCache
# - Amazon MQ
#
# These values are kept as variables for the Terraform
# configuration. If you are using an existing private subnet,
# the resource can instead use the existing subnet ID.

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)

  default = [
    "10.0.11.0/24",
    "10.0.12.0/24"
  ]
}


# ============================================================
# EXISTING PRIVATE SUBNET
# ============================================================
# Existing subnet currently used by ElastiCache:
#
# subnet ID = subnet-0ba063a2b58b18dc4
# CIDR      = 10.0.12.0/24
# Region    = us-east-1
#
# This variable allows you to reference the existing subnet
# without creating a new one.

variable "existing_private_subnet_id" {
  description = "Existing private subnet ID used by private services"
  type        = string
  default     = "subnet-0ba063a2b58b18dc4"
}


# ============================================================
# EC2 KEY PAIR
# ============================================================

variable "key_name" {
  description = "Name of the existing EC2 key pair in us-east-1"
  type        = string
  default     = "terraform"
}


# ============================================================
# EC2 INSTANCE
# ============================================================
# t3.micro is the Free Tier eligible instance type confirmed
# in your AWS account.

variable "instance_type" {
  description = "EC2 instance type for the Tomcat server"
  type        = string
  default     = "t3.medium"
}


# ============================================================
# SSH ACCESS
# ============================================================

variable "my_ip_cidr" {
  description = "CIDR allowed for SSH access. Use your public IP/32 for better security."
  type        = string
  default     = "0.0.0.0/0"
}


# ============================================================
# RDS DATABASE
# ============================================================

variable "db_username" {
  description = "RDS master username"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "RDS master password"
  type        = string
  sensitive   = true
  default     = "VproDbPass123"
}


# ============================================================
# AMAZON MQ / RABBITMQ
# ============================================================

variable "mq_username" {
  description = "RabbitMQ broker username"
  type        = string
  default     = "admin"
}

variable "mq_password" {
  description = "RabbitMQ broker password"
  type        = string
  sensitive   = true
  default     = "VproMqPass12345"
}


# ============================================================
# APPLICATION SOURCE CODE
# ============================================================

variable "repo_url" {
  description = "Git repository containing the vprofile application source code"
  type        = string
# default     = "https://github.com/abdelrahmanonline4/sourcecodeseniorwr.git"
  default     = "https://github.com/hkhcoder/vprofile-project.git"

}


# ============================================================
# ALB HEALTH CHECK
# ============================================================

variable "wait_for_healthy" {
  description = "Wait for the ALB target to become healthy"
  type        = bool
  default     = true
}


# ============================================================
# RHEL AMI
# ============================================================
# Leave empty to automatically find the latest RHEL 9 AMI.
#
# Current confirmed RHEL 9 AMI:
# ami-07006ea0a33e11e4e
#
# AMIs are region-specific.

variable "ami_id" {
  description = "Optional RHEL AMI ID. Leave empty for automatic RHEL 9 AMI lookup."
  type        = string
  default     = ""
}

