# GCP Project Cloud Account Onboarding Instructions
Doc ref: [Onboard Your Google Cloud Platform (GCP) Account](https://docs.paloaltonetworks.com/prisma/prisma-cloud/prisma-cloud-admin/connect-your-cloud-platform-to-prisma-cloud/onboard-your-gcp-account.html)

## What you'll need (NEEDS FURTHER REVIEW AND TESTING):
1. The ID of the project(s) you intend to onboard
2. Google Cloud Storage Bucket and it's name (if enabling vpc flow logs)
3. Dataflow API enabled and role & role binding assigned to Prisma Cloud service account
4. Decision as to where to execute the terraform script from (if Cloud Shell is not an option due to company security policy)
5. Review and disable any APIs in the script you do NOT want enabled (possibly due to company security policies)

## NOTES:
### Manual steps (as of now) - all these steps are optional
1. Creation of GCS bucket for VPC Flow logs - *via console* - instructions on PC docs not given
2. Enable VPC Flow logs, logging sink, and assigning lifecycle rule - *via console* and required for every subnet.  These may already be enabled. - instructions: [Enable Flow Logs for GCP Projects](https://docs.paloaltonetworks.com/prisma/prisma-cloud/prisma-cloud-admin/connect-your-cloud-platform-to-prisma-cloud/onboard-your-gcp-account/enable-flow-logs-for-gcp-projects.html)
3. Enabling Dataflow API & Assigning role and binding for Dataflow to the service account- *via console* - instructions: [Flow Log Compression on GCP](https://docs.paloaltonetworks.com/prisma/prisma-cloud/prisma-cloud-admin/connect-your-cloud-platform-to-prisma-cloud/onboard-your-gcp-account/dataflow-compression.html)
4. Create network resources for Dataflow (**not clear - investigate**). https://docs.paloaltonetworks.com/prisma/prisma-cloud/prisma-cloud-admin/connect-your-cloud-platform-to-prisma-cloud/onboard-your-gcp-account/dataflow-compression.html


### Only when all the above is sorted should you proceed with the actual onboarding steps
[Add Your GCP Project to Prisma Cloud](https://docs.paloaltonetworks.com/prisma/prisma-cloud/prisma-cloud-admin/connect-your-cloud-platform-to-prisma-cloud/onboard-your-gcp-account/add-your-gcp-projects-to-prisma-cloud.html)

- Complete Steps 1-6.  
- At step 7, after downloading the terraform template, review template and make necessary changes such as:
  - disabling/commenting out the enabling of any APIs you do not want used.
  - 
