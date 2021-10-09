# Onboarding Cloud Accounts to Prisma Cloud

**Goal:** Fast & Easy Onboarding

Specifically, to speed the cloud account onboarding process by supplementing the current [Prisma Cloud onboarding documentation](https://docs.paloaltonetworks.com/prisma/prisma-cloud/prisma-cloud-admin/connect-your-cloud-platform-to-prisma-cloud/cloud-account-onboarding.html) with some additional automation advice (using Terraform), examples, and helpful tips. 
   

1 - [Prerequisities & Assumptions](#head1)   
2 - [Get Started with Teraform - OPTIONAL](#head2)   
3 - [Onboarding Cloud Accounts](#head3)    

---

## 1 - <a name="head1"></a> Prerequisities & Assumptions

1. [Access to a Prisma Cloud Tenant](https://docs.paloaltonetworks.com/prisma/prisma-cloud/prisma-cloud-admin/get-started-with-prisma-cloud/access-prisma-cloud.html).
2. [Prisma Cloud Role](https://docs.paloaltonetworks.com/prisma/prisma-cloud/prisma-cloud-admin/manage-prisma-cloud-administrators/prisma-cloud-administrator-roles.html) that allows Cloud Account Onboarding.
3. [Prisma Cloud Account Group](https://docs.paloaltonetworks.com/prisma/prisma-cloud/prisma-cloud-admin/manage-prisma-cloud-administrators/create-account-groups).
4. Access to relevant Public Cloud Account(s).
5. Relevant Public Cloud Account credentials required (will vary depending on requirements for each account and will be further explained in separate sections).

## 2 - <a name="head2"></a> Get Started with Terraform (*Optional*):

Complete or review the [Hashicorp Learn Terraform 'Get Started' Tutorials](https://learn.hashicorp.com/terraform) for each Cloud Provider you plan to use.  These will be the basis for the additional Terraform automation steps I outline in the individual Cloud Account Onboarding sections found in this repo. 
   
NOTE: At a minimum, complete up and through the *Change Infrastrucutre* Tutorial in the relevant Cloud Provider you choose.  
   
If you already have this knowledge, skip directly to [Section 3 - Onboarding Cloud Accounts](#head3)

If you are not familiar with Terraform, it is one of the most widely used **Infrastructure as Code** open source software tools.  Use of IaC is highly recommended vs. enabling infrastrucutre manually through a console or Cloud CLI directly.  A major benefit of Terraform is being cloud agnostic which means it can be used across all the major cloud providers and even Docker, making Terraform is a great choice for **IaC tooling**. 

### 2.1 - Terraform Setup & Prerequisities

Under each *'Build Infrastructure'* Tutorial ensure to complete these **Prerequisites** for the relevant Cloud Provider you are using.
- Terraform installed on a remote system (i.e. VM or laptop)
- Cloud Vendor's SDK/CLI installed
- Access to relevant Public Cloud Account(s)
- Relevant Public Cloud Account credentials required

### 2.2 - Building Infrastructure
Follow the relevant Hashicorp Terraform ***'Build Infrastructure'*** & ***'Change Infrastructure'*** learn tutorials.  Once you have successfully built some infrastructure, you can move on to onboarding a Cloud Account into Prisma Cloud.

## 3 - <a name="head3"></a> Onboarding Cloud Accounts

Select the relevant Cloud Account Provider to complete the onboarding steps to Prisma Cloud:
* Amazon
* [Azure](azure)
* [GCP](gcp)

