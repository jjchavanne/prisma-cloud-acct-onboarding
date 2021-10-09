# Azure Cloud Account (Subscription Only) Onboarding

**Goal:** Fast & Easy Azure Cloud Account Onboarding
   
1 - [Getting Started](#head1)   
2 - [Enabling NSG Flow Logs - Optional but Highly Recommended](#head2)   
3 - [Onboard Account to Azure](#head3)   
4 - [Troubleshooting](#head4)   
   
## 1 - <a name="head1"></a> Getting Started 
Before onboarding you must do the following:
   
1. Ensure you have met the [Prerequisites on the Main README page](../README.md#1----prerequisities--assumptions).
2. Know which [Account Group](https://docs.paloaltonetworks.com/prisma/prisma-cloud/prisma-cloud-admin/manage-prisma-cloud-administrators/create-account-groups) you will assign this particular Cloud Account.
3. Decide if you want to ingest Azure NSG (Network Security Group) Flow Logs.

## 2 - <a name="head2"></a> Enabling NSG Flow Logs 
This is optional and can be [updated later](https://docs.paloaltonetworks.com/prisma/prisma-cloud/prisma-cloud-admin/connect-your-cloud-platform-to-prisma-cloud/onboard-your-azure-account/update-an-onboarded-azure-account.html), however enabling NSG Flow Logs are **highly recommended and a security best practice**.
   
- **IMPORTANT NOTE:** Separate NSG Flow Logs are required for each region corresponding with a storage account per NSG in the same region.  
   
For the example below, we are only enabling a single region for demonstration purposes.

### OPTION 1: Manual - via the Azure Console
Complete Steps 7-10 from: [Setup Your Azure Subscription for Prisma Cloud](https://docs.paloaltonetworks.com/prisma/prisma-cloud/prisma-cloud-admin/connect-your-cloud-platform-to-prisma-cloud/onboard-your-azure-account/set-up-your-azure-account.html#id3c86dfb2-8ffb-4a60-9416-f15c5cec3ed6).  

### OPTION 2: Automated - via Terraform (Recommended Option)
With this option, you can use the below code snippet as a template and run Terraform to apply all changes.

As mentioned in the [Terraform Azure Build Infrastrucutre Tutorial](https://learn.hashicorp.com/tutorials/terraform/azure-build?in=terraform/azure-get-started#prerequisites).  
Ensure you:
1. Have Terraform installed.
2. Can authenticate via the Azure CLI to your Cloud Account.

This code snippet is taken directly from the [Terraform Registry](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_watcher_flow_log) with several modifications:
   - Added Azure Provider
   - Added a new VNET
   - Changed the Retention period to 15 days (per Prisma Cloud doc recommendation).
   - Removed the log anayltics pieces (as this could create additional costs).  This is optional.   
   
Copy and Edit the code snippet in your environment, noting that **YOU** must change the Storage Account name as it **Must be unique across Azure**.
- Replace `"ReplaceMustBeUnique"` under the resource "azurerm_storage_account" below.

```
# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }
  }

  required_version = ">= 0.14.9"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "test" {
  name     = "myPCResourceGroup"
  location = "eastus2"
  tags = {
    environment = "Prisma Cloud Getting Started"
    team        = "DevSecOps"
  }
}

# Create a virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = "myPCVnet"
  address_space       = ["10.0.0.0/16"]
  location            = "eastus2"
  resource_group_name = azurerm_resource_group.test.name
}

resource "azurerm_network_security_group" "test" {
  name                = "acctestnsg"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name
}

resource "azurerm_network_watcher" "test" {
  name                = "acctestnw"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name
}

resource "azurerm_storage_account" "test" {
  name                = "ReplaceMustBeUnique"
  resource_group_name = azurerm_resource_group.test.name
  location            = azurerm_resource_group.test.location

  account_tier              = "Standard"
  account_kind              = "StorageV2"
  account_replication_type  = "LRS"
  enable_https_traffic_only = true
}

resource "azurerm_network_watcher_flow_log" "test" {
  network_watcher_name = azurerm_network_watcher.test.name
  resource_group_name  = azurerm_resource_group.test.name

  network_security_group_id = azurerm_network_security_group.test.id
  storage_account_id        = azurerm_storage_account.test.id
  enabled                   = true

  retention_policy {
    enabled = true
    days    = 15
  }
}
```
   
Run terraform commands to apply changes:   
`terraform init`  
`terraform apply`  
   
Type `yes` to apply changes

## 3 - <a name="head3"></a> Onboard Account to Azure
Complete the [Add Azure Subscription to Prisma Cloud](https://docs.paloaltonetworks.com/prisma/prisma-cloud/prisma-cloud-admin/connect-your-cloud-platform-to-prisma-cloud/onboard-your-azure-account/add-azure-cloud-account-on-prisma-cloud.html) steps.   
   
NOTE: Regarding the step to "Ingest & Monitor Network Security Group flow logs", you should have already completed this section as per the NSG Flow Log steps above.

## 4 - <a name="head4"></a> Troubleshooting
Onboarding Issues: [Troubleshoot Azure Account Onboarding](https://docs.paloaltonetworks.com/prisma/prisma-cloud/prisma-cloud-admin/connect-your-cloud-platform-to-prisma-cloud/onboard-your-azure-account/troubleshoot-azure-account-onboarding.html)
   
Terraform Issues: [Troubleshoot common problems when using Terraform on Azure](https://docs.microsoft.com/en-us/azure/developer/terraform/troubleshoot)
   
Other Common Issues, noting that each environment is unique.
- Ensure all proper authentication.
- Keep things simple and avoid going through Proxies if possible.
- If you get an error message you don't understand, Google it.  Often someone else will have posted about a similar error message as well.

---

### Congratulations!!!  You onboarded an Azure Cloud Account to Prisma Cloud
As it mentions in the last step of the Prisma Cloud doc, you need to wait some time before the ingestion of data completes.   
This is a great time to get lunch, take a nap, or whatever else you might enjoy during this time.   
   
Thanks and I hope you found these instructions helpful.

