# Deploy-Web-Application-on-AWS-with-Terraform

Terraform is used to create and configure AWS infrastructure as Infrastructure as Code (IaC), automating the entire environment through configuration files.

### Application Flow: 

User → Load Balancer → Tomcat → RDS / RabbitMQ / Memcached.

### Infrastructure Flow: 

Terraform → AWS Resources → EC2 → Shell Script → Java/Tomcat Application

### Main Components
Terraform : Creates AWS infrastructure automatically.

VPC: Creates the AWS network &Creates subnets and routes.

Security Groups: Control traffic between AWS resources.

EC2: Hosts the Java/Tomcat application .

Shell Script : Installs Java& Installs Tomcat & Deploys the application 

Load Balancer : Receives traffic on port 80. & Sends traffic to Tomcat on port 8080 & Application is accessed using the Load Balancer DNS.

RDS : Provides the application database.

RabbitMQ : Provides messaging between application components.

Memcached : Provides caching to improves application performance.

### Terraform Files

terraform.pem : EC2 SSH private key.

variables.tf : Contains project variables {Instance type ,CPU and RAM, Network settings , Routes , source code ,Load Balancer settings}

vpc.tf : Creates VPC & Creates subnets & Creates routes.

sec.tf : Creates Security Groups to Controls traffic between resources.

ec2.tf : Creates the EC2 instance using shell script 

elb.tf : Creates the Load Balancer & Forwards port 80 to Tomcat port 8080.

rds.tf: Creates the RDS database.

rabbit.tf: Creates RabbitMQ.

memcach.tf : Creates Memcached.

user-data.sh : Installs Java & Installs Tomcat & Deploys the Java application.

Steps : 

## VM Preparation :  

1- Install terraform from the official link :

sudo yum install -y yum-utils

sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo

sudo yum -y install terraform

2- Install AWS CLI to configure AWS credentials and allow Terraform to automatically create and manage the AWS infrastructure.

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

unzip awscliv2.zip

sudo ./aws/install

## AWS 

1- Create User IAM with the user Administrator Access for the Terraform  testing .

<img width="1886" height="813" alt="image" src="https://github.com/user-attachments/assets/6b8661d1-e1c2-4ee9-97e2-44a73a044d8e" />

2-Access Keys : These credentials allow Terraform to access and manage AWS resources

<img width="1887" height="797" alt="image" src="https://github.com/user-attachments/assets/143d463b-b94f-4d92-96ba-9573663ed091" />

### Hint : 

1- In all Terraform files, we will let Terraform automatically create the VPC, subnets, and CIDR network , We only need to configure the AWS IAM credentials using aws configure , We only specify the AWS Region where we want to deploy the application We do not need to manually create the VPC, subnet, or network before running Terraform. The Terraform configuration is now more automated and creates the required infrastructure automatically.

3- I faced a time synchronization issue between the Terraform VM and AWS, which caused AWS authentication problems.

<img width="1655" height="132" alt="image" src="https://github.com/user-attachments/assets/909dcc0d-cb50-4cf1-9b19-b4d53346e64e" />

terraform plan 

terraform apply 

<img width="1920" height="1040" alt="image" src="https://github.com/user-attachments/assets/c4de3fcd-250c-40ba-a842-3d314f66dd95" />

<img width="1920" height="1040" alt="image" src="https://github.com/user-attachments/assets/3d700173-fc3f-413c-8119-b41033510bd3" />

<img width="1920" height="1040" alt="image" src="https://github.com/user-attachments/assets/70734a5e-b661-4101-94c3-514972cbd6c3" />

<img width="1191" height="577" alt="image" src="https://github.com/user-attachments/assets/b3fd35dc-1423-4b7a-b4b9-b6258602bda6" />

<img width="1127" height="893" alt="image" src="https://github.com/user-attachments/assets/aca5c3d4-0d3d-4a58-a211-3a0ed6ed8dd1" />

4- DB instacne createing successfuuly : 

<img width="1550" height="247" alt="image" src="https://github.com/user-attachments/assets/fb343540-90a8-4c27-903a-32bacee07f35" />

5- creating broker rabbitmq in progress : 

<img width="642" height="230" alt="image" src="https://github.com/user-attachments/assets/68f1c02b-f876-45cd-9096-4c7c31d06eae" />

<img width="1535" height="270" alt="image" src="https://github.com/user-attachments/assets/43f06998-b631-4921-add1-18a7ec8a24d5" />

6-In this project, the Key Pair name is terraform & create it : 

<img width="1640" height="111" alt="image" src="https://github.com/user-attachments/assets/a4b54309-f489-4865-8cb5-8e4ff187f199" />

<img width="1623" height="371" alt="image" src="https://github.com/user-attachments/assets/4d79ae2e-bfa9-4b4f-82fa-4b838904a8c1" />

on VM : 

<img width="755" height="108" alt="image" src="https://github.com/user-attachments/assets/33f22cc6-2272-45a6-90a4-0106a96da102" />

7- check creating is in progress : 

<img width="1648" height="227" alt="image" src="https://github.com/user-attachments/assets/cf5b3cfb-929a-4aea-9775-78cd2b433c76" />

<img width="1597" height="363" alt="image" src="https://github.com/user-attachments/assets/6fdbaf05-befa-4c6f-8774-72c7a7397156" />

8- To access the application, use the ELB on port 80, which forwards the traffic to the application instance on port 8080.

<img width="1307" height="162" alt="image" src="https://github.com/user-attachments/assets/c218f5ad-6cb5-44ec-ab99-b4f08cf0a74f" />

9- Access ELB  : 

<img width="927" height="227" alt="image" src="https://github.com/user-attachments/assets/177e7cc5-bf5a-4ea5-82c2-2616d6e37660" />

<img width="1575" height="291" alt="image" src="https://github.com/user-attachments/assets/6b94f193-7f05-4e43-82e8-8b4aac76083e" />

<img width="1900" height="982" alt="image" src="https://github.com/user-attachments/assets/96b3ad85-dc0b-4b24-9a94-0f5e0d44704c" />









