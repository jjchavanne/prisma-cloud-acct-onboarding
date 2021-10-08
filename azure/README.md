# Azure Cloud Account Onboarding

**Goal:** Fast & Easy Onboarding
   
These instructions are simply to help speed the cloud account onboarding process by supplementing the current [Prisma Cloud Azure onboarding documentation](https://docs.paloaltonetworks.com/prisma/prisma-cloud/prisma-cloud-admin/connect-your-cloud-platform-to-prisma-cloud/onboard-your-azure-account/add-azure-cloud-account-on-prisma-cloud.html) with some additional automation advice and helpful tips.

## Prerequisites:

1. Completed the [Prerequisites](https://github.com/jjchavanne/prisma-cloud-acct-onboarding/blob/main/README.md#1----prerequisities--assumptions) on the Main README page.
2. Know which [Account Group](https://docs.paloaltonetworks.com/prisma/prisma-cloud/prisma-cloud-admin/manage-prisma-cloud-administrators/create-account-groups) you will use for this particular Cloud Account.
3. Completed the relevant [Terraform Getting Started Tutorials](https://github.com/jjchavanne/prisma-cloud-acct-onboarding#21---identify-or-create-prisma-cloud-account-groups) or have equivalent Terraform knowledge.
4. Decide if you want to enable Azure NSG (Network Security Group) Flow Logs.

## Enabling NSG Flow Logs
This is optional, however enabling NSG Flow Logs are highly recommended and a secuirty best practice.  Note however, separate NSG Flow Logs are required for each region corresponding with a storage account per NSG in the same region.  For the example below, we are only enabling a single region for demonstration purposes.   NOTE: If you are not prepared to do this now, you can [Update an Onboarded Azure Cloud Account] and enable NSG Flow Logs at a later time.

### NSG Flow Logs - OPTION 1: Manually via the Azure Console
Complete Steps 7-10 from: [Setup Your Azure Subscription for Prisma Cloud](https://docs.paloaltonetworks.com/prisma/prisma-cloud/prisma-cloud-admin/connect-your-cloud-platform-to-prisma-cloud/onboard-your-azure-account/set-up-your-azure-account.html#id3c86dfb2-8ffb-4a60-9416-f15c5cec3ed6).  

### NSG Flow Logs - OPTION 2 - Create NSG Flow Log from single terraform file change
With this option, we will update our original terraform file from the Terraform Getting Started tutorial.
The updated code snippet is taken directly from here: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_watcher_flow_log
- NOTE: Several changes have been made from the above example.
  - Added a new VNET
  - Changed the Retention period to 15 days (per Prisma Cloud doc recommendation).
  - **YOU** must additionally change the Storage Account name as it **Must be unique across Azure**. Replace `"ReplaceMustBeUnique"` under the resource "azurerm_storage_account" below.
  - In this example, we've also removed the log anayltics pieces from the original terraform example (as this could create additional costs).  This is optional.   

Copy and Edit the code snippet in your environment as needed:
```
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
Type **yes** to apply changes

## Onboard Account to Azure
Complete the [Add Azure Subscription to Prisma Cloud](https://docs.paloaltonetworks.com/prisma/prisma-cloud/prisma-cloud-admin/connect-your-cloud-platform-to-prisma-cloud/onboard-your-azure-account/add-azure-cloud-account-on-prisma-cloud.html) steps.   
NOTE: Regarding the step to "Ingest & Monitor Network Security Group flow logs", you should have already completed this section as per the NSG Flow Log steps above.

---

### Congratulations!!! You onboarded an Azure Cloud Account to Prisma Cloud
As it mentions in the last step of the Prisma Cloud doc, you need to wait some time before the ingestion of data completes.   
This is a great time to get lunch, take a nap, or whatever else you might enjoy during this time.   
   
Thanks and I hope you found these instructions helpful.

