# GCP Project Cloud Account Onboarding Instructions


## What you'll need (NEEDS FURTHER REVIEW AND TESTING):
1. The ID of the project(s) you intend to onboard
2. Google Cloud Storage Bucket and it's name (if enabling vpc flow logs)
3. Dataflow API enabled and role & role binding assigned to Prisma Cloud service account
4. Decision as to where to execute the terraform script from (if Cloud Shell is not an option due to company security policy)
5. Review and disable any APIs in the script you do NOT want enabled (possibly due to company security policies)
