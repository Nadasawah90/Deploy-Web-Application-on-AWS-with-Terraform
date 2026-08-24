# Deploy-Web-Application-on-AWS-with-Terraform

Terraform is used to create and configure AWS infrastructure as Infrastructure as Code (IaC), automating the entire environment through configuration files.

# Application Flow: 

User → Load Balancer → Tomcat → RDS / RabbitMQ / Memcached.

# Infrastructure Flow: 

Terraform → AWS Resources → EC2 → Shell Script → Java/Tomcat Application

# Main Terraform resources include:

1- Terraform : Deploy AWS infrastructure and resources.

2- VPC: Create the network and subnets.

3- Security Groups: Control inbound and outbound traffic between components.

4- EC2: Host the Java application.

5- Shell Script: Install Java, Tomcat, and deploy the application on EC2 .
6- Load Balancer: Receive traffic on port 80 and forward it to Tomcat.

7- RDS: Provide the managed database for the application.

8- RabbitMQ: Provide messaging and asynchronous communication.

9- Memcached: Provide caching to improve application performance.

Steps : 
# on my linux PC 
1- Download terraform form the official link of terraform  on the centos VM as bleow : 
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum -y install terraform

2- shlould be install AWS CLI to know the credential of AWS to be implement automated my ingrastructure 
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# on AWS 
-create User IAM with administrator access 

-to terrafor access on the AWS account should have access key and secrete key 
fromm the user created " create access key" 

####### 
- create VPS  on AWS  
