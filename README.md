# Deploy-Web-Application-on-AWS-with-Terraform

Terraform is used to create and configure the AWS infrastructure as infrastructur as aserive in one file to automate the environment .

# Application Flow: 

User → Load Balancer → Tomcat → RDS / RabbitMQ / Memcached.

# Infrastructure Flow: 

Terraform → AWS Resources → EC2 → Shell Script → Java/Tomcat Application

# Main Terraform resources include:

1- Terraform : Deploy AWS infrastructure and resources.

2- VPC: Create the network and subnets.

3- Security Groups: Control inbound and outbound traffic between components.

4- EC2: Host the Java application.

5- Shell Script: Install Java, Tomcat, and deploy the application on EC2 & Tomcat: Run the Java web application.

6- Load Balancer: Receive traffic on port 80 and forward it to Tomcat.

7- RDS: Provide the managed database for the application.

8- RabbitMQ: Provide messaging and asynchronous communication.

9- Memcached: Provide caching to improve application performance.
