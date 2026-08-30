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
terraform files incluse : 
terraform.pem ==> key pair of instance 
vpc.tf ==> virtual priate network variables 
elb.tf ==> load balancers as the sode using to access only application using elb dns only 
variables.tf ==> all variables " instance type , rams , cpu , network , routes , source code to instance and elb using , security groups " 
using source code my : 
https://github.com/hkhcoder/vprofile-project 
on variables.tf 
memcach.tf 
rabbit.tf 

Steps : 
# on VM  
1- Download terraform form the official link of terraform  on the centos VM as bleow : 
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum -y install terraform

2- shlould be install AWS CLI to know the credential of AWS to be implement automated my ingrastructure 
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# on AWS 
1- create User IAM with administrator access 
<img width="1886" height="813" alt="image" src="https://github.com/user-attachments/assets/6b8661d1-e1c2-4ee9-97e2-44a73a044d8e" />

2-to terraform access on the AWS account should have access key and secrete key 
from the user created " create access key" 
<img width="1887" height="797" alt="image" src="https://github.com/user-attachments/assets/143d463b-b94f-4d92-96ba-9573663ed091" />

note on all files we will let terraform create new VPC and subnet network with CIDR automatiaally only using IAM creditnilas on the AWS configure and spwcicif which reqgion we will use only to deploy app .so we not need to doe the three firstly steps before as i change the file to be automated more .
3- create VPS  on AWS  " Default VPC " ==> 
<img width="887" height="202" alt="image" src="https://github.com/user-attachments/assets/9f788c2b-94ba-4ef8-957d-c154ede607a8" />

4- Default subnet 
<img width="1190" height="42" alt="image" src="https://github.com/user-attachments/assets/d2588aa8-c720-4397-b5be-5412675a0f31" />

4- edit on file vpc.tf 
with VPC id and subnet id 
issue "" missing 
<img width="1187" height="652" alt="image" src="https://github.com/user-attachments/assets/e0b03936-16fb-42c3-bd6b-0946620ae213" />
after fix it 
i have face time sync 
issue time sync :
<img width="1655" height="132" alt="image" src="https://github.com/user-attachments/assets/909dcc0d-cb50-4cf1-9b19-b4d53346e64e" />



<img width="1920" height="1040" alt="image" src="https://github.com/user-attachments/assets/c4de3fcd-250c-40ba-a842-3d314f66dd95" />

<img width="1920" height="1040" alt="image" src="https://github.com/user-attachments/assets/3d700173-fc3f-413c-8119-b41033510bd3" />

<img width="1920" height="1040" alt="image" src="https://github.com/user-attachments/assets/70734a5e-b661-4101-94c3-514972cbd6c3" />

<img width="1191" height="577" alt="image" src="https://github.com/user-attachments/assets/b3fd35dc-1423-4b7a-b4b9-b6258602bda6" />
<img width="1127" height="893" alt="image" src="https://github.com/user-attachments/assets/aca5c3d4-0d3d-4a58-a211-3a0ed6ed8dd1" />
terraform plan 

terraform apply 

# db instacne createing successfuuly : 

<img width="1550" height="247" alt="image" src="https://github.com/user-attachments/assets/fb343540-90a8-4c27-903a-32bacee07f35" />

# creating broker rabbitmq in progress : 

<img width="642" height="230" alt="image" src="https://github.com/user-attachments/assets/68f1c02b-f876-45cd-9096-4c7c31d06eae" />

<img width="1535" height="270" alt="image" src="https://github.com/user-attachments/assets/43f06998-b631-4921-add1-18a7ec8a24d5" />
# to cretae instance may be required key pair as the below error with name terrform 
<img width="1640" height="111" alt="image" src="https://github.com/user-attachments/assets/a4b54309-f489-4865-8cb5-8e4ff187f199" />
create it 
<img width="1623" height="371" alt="image" src="https://github.com/user-attachments/assets/4d79ae2e-bfa9-4b4f-82fa-4b838904a8c1" />
on VM : 
<img width="755" height="108" alt="image" src="https://github.com/user-attachments/assets/33f22cc6-2272-45a6-90a4-0106a96da102" />
check crating progress : 

<img width="1648" height="227" alt="image" src="https://github.com/user-attachments/assets/cf5b3cfb-929a-4aea-9775-78cd2b433c76" />

<img width="1597" height="363" alt="image" src="https://github.com/user-attachments/assets/6fdbaf05-befa-4c6f-8774-72c7a7397156" />

to access my app should use elb with port 80as it is forward to app instance on port 8080 : 

<img width="1307" height="162" alt="image" src="https://github.com/user-attachments/assets/c218f5ad-6cb5-44ec-ab99-b4f08cf0a74f" />
access elb : 

<img width="927" height="227" alt="image" src="https://github.com/user-attachments/assets/177e7cc5-bf5a-4ea5-82c2-2616d6e37660" />

<img width="1575" height="291" alt="image" src="https://github.com/user-attachments/assets/6b94f193-7f05-4e43-82e8-8b4aac76083e" />

<img width="1900" height="982" alt="image" src="https://github.com/user-attachments/assets/96b3ad85-dc0b-4b24-9a94-0f5e0d44704c" />









