#------------------------------------------
# - Basic Configuration
#------------------------------------------
org_id      = "a1a"
app_id      = "52161"
location    = "eastus2"
environment = "ppr"
instance    = "01"
context     = "automation"
sku_name    = "Basic"

#------------------------------------------
# - Identity Configuration
#------------------------------------------
# Using SystemAssigned identity (simple and policy-friendly)
identity = {
  type         = "SystemAssigned"
  identity_ids = null
}

#------------------------------------------
# - Tags
#------------------------------------------
tags = {
  mnd-applicationid      = "app-52161"
  mnd-applicationname    = "estimates_azure_dbor_ppr"
  mnd-costcentre         = "52161"
  mnd-dataclassification = "restricted"
  mnd-envsubtype         = "pre-production"
  mnd-envtype            = "ppr"
  mnd-lifecycle          = "live"
  mnd-owner              = "TF-TF-IndiaEstimatesTech@lseg.com"
  mnd-projectcode        = "P011085"
  mnd-supportgroup       = "DEVELOP-ESTIMATES-COLLECT-ICA"
  cloud_provider         = "azure"
  opt-datadog            = "require"
}

#------------------------------------------
# - Resource Dependencies
#------------------------------------------
resource_group_name = "a1a-52161-ppr-rg-estimates-eus2-01"

#------------------------------------------
# - Runbook Configuration
#------------------------------------------
# Single PowerShell runbook for basic automation tasks
runbook_var = {
  "runbook1" = {
    name         = "AzureVMInfo"
    runbook_type = "PowerShell"
    log_progress = "true"
    log_verbose  = "true"
    description  = "Basic PowerShell runbook to get Azure VM information"
    publish_content_link = {
      uri = "https://raw.githubusercontent.com/Azure/azure-quickstart-templates/c4935ffb69246a6058eb24f54640f53f69d3ac9f/101-automation-runbook-getvms/Runbooks/Get-AzureVMTutorial.ps1"
    }
  }
}