# Onboarding Cloud Accounts to Prisma Cloud
Instructions for onboarding cloud accounts to Prisma Cloud that includes optional directions on setting up New Cloud Infrastructure with Terraform.

## Objectives:
1. [Create New Infrastrucutre](#head1) using Terraform to setup new cloud infrastructure across various major cloud providers (optional)
2. [Onboarding Cloud Accounts](#head2) into Prisma Cloud (Cloud Native Security Platform from Palo Alto Networks).

## 1 - <a name="head1"></a> Create New Infrastructure with Terraform (optional):
Before onboarding a cloud account, it is recommended you have some minimal infrastructure active on your cloud account.  If you intend to start with any new cloud account(s), you can follow the below tutorials from Hashicorp to create basic infrastructure.  If you are not familiar with Terraform, it is one of the most widely used **Infrastructure as Code** open source software tools and is recommended vs. enabling infrastrucutre manually through a console or Cloud CLI directly.  Terraform is also cloud agnostic and is supported across all the major cloud providers as well tools like Docker, making it a great choice for **IaC tooling**. 

### 1.1 - Setup & Prerequisities
*The below are based on the Hashicorp Learn Terraform 'Get Started' Tutorials.  
Visit https://learn.hashicorp.com/terraform and follow the Cloud Provider tutorial you want to use.*
  
Under each *'Build Infrastructure'* Tutorial ensure to complete these **Prerequisites** for the relevant Cloud Provider you are using.
- Terraform installed on a remote system (i.e. VM or laptop)
- Cloud Vendor's SDK/CLI installed
- Access to relevant Cloud Account(s)
- Relevant Cloud Account credentials required 

### 1.2 - Building Infrastructure
Follow the relevant Hashicorp Terraform *'Build Infrastructure'* learn tutorial.  Once you have successfully built some infrastructure, you can move on to the 2nd objective of onboarding a Cloud Account into Prisma Cloud.

## 2 - <a name="head2"></a> Onboarding Cloud Accounts

### 2.1 - Identify or Create Prisma Cloud Account Groups
Ensure you have identified which Prisma Cloud **Account Group** you will assign your Public Cloud Account to or create a new one.   
   
To create new groups, refer to: [Create and Manage Account Groups on Prisma Cloud](https://docs.paloaltonetworks.com/prisma/prisma-cloud/prisma-cloud-admin/manage-prisma-cloud-administrators/create-account-groups)

### 2.2 - Cloud Account Onboarding
Onboard your Cloud Account(s) by following the [Prisma Cloud onboarding documentation](https://docs.paloaltonetworks.com/prisma/prisma-cloud/prisma-cloud-admin/connect-your-cloud-platform-to-prisma-cloud/cloud-account-onboarding.html).

