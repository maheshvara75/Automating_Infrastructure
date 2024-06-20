# Automating_Infrastructure
Automating Infrastructure using Terraform
Table of Contents
1.	Introduction
2.	Project Objectives
3.	Project Overview
4.	Prerequisites
5.	Implementation Steps
o	Setup GitHub Repository 
o	Provisioning Infrastructure with Terraform
o	Configuration Management with Ansible
o	CI/CD Pipeline with Jenkins
6.	Conclusion
Introduction
This document outlines the project "Automating Infrastructure using Terraform" undertaken by Mahesh Vara. The primary goal of this project is to automate the provisioning and configuration of infrastructure on AWS using Terraform and Ansible, ensuring efficient and repeatable processes for managing infrastructure.
Project Objectives
•	Automate the provisioning of infrastructure on AWS using Terraform.
•	Launch an EC2 instance and configure it with Java, Python and Jenkins using Ansible.
•	Maintain infrastructure as code (IaC) in a GitHub repository.
•	Implement a Jenkins pipeline to manage and execute Terraform jobs with approval stages.
Project Overview
The project leverages Terraform for infrastructure automation to launch an EC2 instance on AWS. Ansible is used to configure the instance by installing Java, Python and Jenkins. The project environment is an Ubuntu lab instance provided by the training, equipped with necessary AWS credentials. GitHub is used for version control, and Jenkins is employed to automate the pipeline for running Terraform jobs.


Prerequisites:
1.	Ubuntu Lab Instance: Provided by the training, with AWS credentials (access key, secret key, STS token).
2.	Installed Software: Terraform, Ansible, Git, Jenkins.
3.	AWS Account: Ensure you have access keys and necessary permissions to create resources.
 
 
 
 



Implementation Steps
Step 1: Setup GitHub Repository
1.	Create a new repository in GitHub (e.g., Automating_Infrastructure).
 

2.	Clone the repository to your local machine:
git clone https://github.com/maheshvara75/Automating_Infrastructure.git
cd Automating_Infrastructure


Step 2: Provisioning Infrastructure with Terraform
1.	Directory Structure:
Automating_Infrastructure/
├── ansible/
│   ├── playbook.yaml
│   └── inventory
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── terraform.tfvars
├── Jenkinsfile
└── README.md
2.	terraform/main.tf:
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.54.1"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  token      = var.aws_session_token
}

# RSA key of size 4096 bits
resource "tls_private_key" "rsa_4096" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "key_pair" {
  key_name   = var.key_name
  public_key = tls_private_key.rsa_4096.public_key_openssh
}

resource "local_file" "private_key" {
  content = tls_private_key.rsa_4096.private_key_pem
  filename = var.key_name
  file_permission = "400"
  }

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_instance" "jenkins" {
  ami           = var.instance_ami # Ubuntu AMI
  instance_type =var.instance_type
  key_name      = aws_key_pair.key_pair.key_name

  tags = {
    Name = "project1-ec2-instance"
  }

provisioner "local-exec" {
    command = "echo '${self.public_ip}' > ../ansible/inventory"
  }
}


3.	terraform/variables.tf:
variable "aws_access_key" {
  description = "AWS_ACCESS_KEY"
  default =""
  }
variable "aws_secret_key" {
  description = "AWS_SECRET_KEY"
  default =""
  }
variable "aws_session_token" {
  description = "AWS_ACCESS_TOKEN"
  default=""
  }
variable "key_name" {
  description = "AWS_KEY_NAME"
  default =""
  }
variable "instance_ami" {
  description = "AMI ID for the EC2 instances"
  type        = string
  default     = ""
}
variable "instance_type" {
  description = "Instance type for the EC2 instances"
  type        = string
  default     = ""
}
4.	terraform/outputs.tf:
output "instance_ip" {
  value = aws_instance.jenkins.public_ip
}

5.	terraform/terraform.tfvars:
instance_ami		= "ami-04b70fa74e45c3917"
instance_type		= "t2.micro"
key_name			= "ec2pro4_pem"


Step 3: Configuration Management with Ansible
1.	ansible/playbook.yaml:
---
- hosts: all
  become: yes
  remote_user: ubuntu

  tasks:
    - name: Update and upgrade apt packages
      apt:
        update_cache: yes
        upgrade: dist

    - name: Install Java
      apt:
        name: openjdk-17-jdk
        state: present

    - name: Install Python
      apt:
        name: python3
        state: present

    - name: ensure the jenkins apt repository key is installed
      apt_key: url=https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key state=present
      become: yes

    - name: ensure the repository is configured
      apt_repository: repo='deb https://pkg.jenkins.io/debian-stable binary/' state=present
      become: yes

    - name: ensure jenkins is installed
      apt: name=jenkins update_cache=yes
      become: yes

    - name: ensure jenkins is running
      service: name=jenkins state=started
2.	ansible/inventory:
Step 4: CI/CD Pipeline with Jenkins

1.	Configure Jenkins:
  o	Install necessary plugins: Git, Ansible, Terraform.
  o	Set up credentials for GitHub and AWS in Jenkins.
  o	Create a new pipeline job in Jenkins and link it to the GitHub repository.
  o	Configure the pipeline script to use the Jenkinsfile from the repository.
Jenkinsfile:

3.	Trigger the Pipeline:
  o	Run the pipeline from Jenkins.
  o	Monitor the stages: Terraform initialization, planning, manual approval, application.
  o	Retrieve EC2 Instance Details (public IP of the EC2 instance) from the output to easy access.
 
4.	Establish Secure Connection to EC2 Instance:
  o	Use the generated key pair to connect to the EC2 instance via SSH

5.	Configure Ansible Inventory:
  o	Inventory File: Create an inventory file to specify the EC2 instance details for Ansible to manage.
 
6.	Execute Ansible Playbook:
  o	Run the Ansible playbook to configure the EC2 instance with Jenkins, Java, and Python.

Conclusion
The project "Automating Infrastructure using Terraform" demonstrates a systematic method to automate infrastructure provisioning and configuration using Terraform and Ansible, maintaining IaC in GitHub for version control and Jenkins for CI/CD automation. This approach ensures repeatable and efficient management of infrastructure, aligning with best practices in DevOps.

