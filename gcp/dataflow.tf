variable "flowlog_compression_project" {
  type = string
  default = ""
}

variable "custom_role_flowlog_compression_permissions_project" {
  type = list
  default = [
    "iam.serviceAccounts.actAs",
    "compute.networks.create",
    "compute.subnetworks.create",
    "compute.firewalls.create",
    "compute.networks.updatepolicy"
  ]
}

##############################
# Creating custom role
# on PROJECT level
##############################
resource "google_project_iam_custom_role" "prisma_cloud_custom_role_flowlog_compression" {
  project     = var.project_id
  count       = var.flowlog_compression_project != "enabled" ? 1 : 0
  role_id     = "prismaCloudFlowLogCompressor${random_string.unique_id.result}"
  title       = "Prisma Cloud Flow Logs Compressor ${random_string.unique_id.result}"
  description = "This is a custom role created for Prisma Cloud. Contains granular permission which is needed for flow logs compression"
  permissions = var.custom_role_flowlog_compression_permissions_project
}

##############################
# Attaching role permissions
# to the service account
##############################
resource "google_project_iam_member" "bind_role_dataflow-admin" {
  project = var.project_id
  count  = var.flowlog_compression_project == "enabled" ? 1 : 0
  role    = "roles/dataflow.admin"
  member = "serviceAccount:${google_service_account.prisma_cloud_service_account.email}"
}

resource "google_project_iam_member" "bind-role-prisma-cloud-flowlog-compressor" {
  project = var.project_id
  role    = "projects/${var.project_id}/roles/${google_project_iam_custom_role.prisma_cloud_custom_role_flowlog_compression.role_id}"
  member  = "serviceAccount:${google_service_account.prisma_cloud_service_account.email}"
}

###################
# Enable Services
###################
resource "google_project_service" "enable_dataflow" {
  project = var.project_id
  service = "dataflow.googleapis.com"
  disable_on_destroy = false
}