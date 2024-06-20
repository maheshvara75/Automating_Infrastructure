# Automating Infrastructure using Terraform

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

# Introduction
     This document outlines the project "Automating Infrastructure using Terraform" undertaken by Mahesh Vara. The primary goal of this project is to automate the provisioning and configuration of infrastructure on AWS using Terraform and Ansible, ensuring efficient and repeatable processes for managing infrastructure.

# Project Objectives
   •	Automate the provisioning of infrastructure on AWS using Terraform.
   •	Launch an EC2 instance and configure it with Java, Python and Jenkins using Ansible.
   •	Maintain infrastructure as code (IaC) in a GitHub repository.
   •	Implement a Jenkins pipeline to manage and execute Terraform jobs with approval stages.

# Project Overview
     The project leverages Terraform for infrastructure automation to launch an EC2 instance on AWS. Ansible is used to configure the instance by installing Java, Python and Jenkins. The project environment is an Ubuntu lab instance provided by the training, equipped with necessary AWS credentials. GitHub is used for version control, and Jenkins is employed to automate the pipeline for running Terraform jobs.


# Prerequisites:
1.	Ubuntu Lab Instance: Provided by the training, with AWS credentials (access key, secret key, STS token).
2.	Installed Software: Terraform, Ansible, Git, Jenkins.
3.	AWS Account: Ensure you have access keys and necessary permissions to create resources.
 
# Implementation Steps

Step 1: Setup GitHub Repository
            o	Create a new repository in GitHub and Clone the repository to your local machine.

Step 2: Provisioning Infrastructure with Terraform       

Step 3: Configuration Management with Ansible Playbook and Inventory file

Step 4: CI/CD Pipeline with Jenkins

       1.	Configure Jenkins:
            o	Install necessary plugins: Git, Ansible, Terraform.
            o	Set up credentials for GitHub and AWS in Jenkins.
            o	Create a new pipeline job in Jenkins and link it to the GitHub repository.
            o	Configure the pipeline script to use the Jenkinsfile from the repository.
            
       2.	Trigger the Pipeline:
            o	Run the pipeline from Jenkins.
            o	Monitor the stages: Terraform initialization, planning, manual approval, application.
            o	Retrieve EC2 Instance Details (public IP of the EC2 instance) from the output to easy access.
            
       3.	Establish Secure Connection to EC2 Instance:
            o	Use the generated key pair to connect to the EC2 instance via SSH
            
       4.	Configure Ansible Inventory:
            o	Inventory File: Create an inventory file to specify the EC2 instance details for Ansible to manage.
            
       5.	Execute Ansible Playbook:
            o	Run the Ansible playbook to configure the EC2 instance with Jenkins, Java, and Python.

# Conclusion
      The project "Automating Infrastructure using Terraform" demonstrates a systematic method to automate infrastructure provisioning and configuration using Terraform and Ansible, maintaining IaC in GitHub for version control and Jenkins for CI/CD automation. This approach ensures repeatable and efficient management of infrastructure, aligning with best practices in DevOps.

