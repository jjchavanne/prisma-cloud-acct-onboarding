# Azure Cloud Account Onboarding

## Add additional infrastructure
We will build on the Terraform Getting Started tutorials from the main section.

### OPTION 1 - If using NSG Flow Logs
1. Verify or enable Network Watcher & Insights Provider: https://docs.microsoft.com/en-us/azure/network-watcher/network-watcher-nsg-flow-logging-portal#enable-network-watcher
2. Enable NSG Flow Logs: Terraform Ref: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_watcher_flow_log
3. Create a Storage Account for NGS Flow Logs.  Terraform Ref: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account
4. 

### OPTION 2 - Create NSG Flow Log from single terraform file change
With this option, we will update our original terraform file from the Getting Started tutorial.
The updated code snippet is taken directly from here: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_watcher_flow_log
- NOTE: Several changes have been made from the above example.
  - Added a new VNET
  - Changed the Retention period to 15 days (per Prisma Cloud doc recommendation).
  - **YOU** must additionally change the Storage Account name as it **Must be unique across Azure**
  - In this example, we've also removed the log anayltics pieces from the original terraform example (as this could create additional costs).  This is optional.
Edit the code snippet:
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
