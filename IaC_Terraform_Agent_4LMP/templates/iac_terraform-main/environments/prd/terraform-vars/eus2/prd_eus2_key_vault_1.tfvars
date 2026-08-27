#
# Terraform variables for Key Vault deployment
# Environment: PRD
# Resource: key_vault_1
#

#----------------------------------------------------------------------
# LSEG Required Variables
#----------------------------------------------------------------------
org_id      = "a1a"     # Three letter code for LSEG
app_id      = "52161"   # Application ID from Leanix (APP-52161)
environment = "prd"     # Staging environment
location    = "eastus2" # Azure region

#----------------------------------------------------------------------
# LSEG Optional Variables
#----------------------------------------------------------------------

keyvaults = {
  "keyvault-infra" = {
    instance = "01"
    context  = "inf"
    private_endpoint = {
      subnet_id            = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-prd-vnet-nonrtbl-eus2-01/subnets/a1a-52161-prd-snet-ecpec-eus2-01"
      is_manual_connection = false
      static_ip_required   = false
    }
  },
  "keyvault-app" = {
    instance = "01"
    context  = "app"
    private_endpoint = {
      subnet_id            = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-platform-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-prd-vnet-rtbl-eus2-01/subnets/a1a-52161-prd-snet-workload-eus2-06"
      is_manual_connection = false
      static_ip_required   = false
    }
  }
}

tags = {
  mnd-applicationid      = "app-52161"
  mnd-applicationname    = "estimates_azure_dbor_prd"
  mnd-costcentre         = "52161"
  mnd-dataclassification = "restricted"
  mnd-envsubtype         = "production"
  mnd-envtype            = "prd"
  mnd-lifecycle          = "live"
  mnd-owner              = "TF-TF-IndiaEstimatesTech@lseg.com"
  mnd-projectcode        = "P011085"
  mnd-supportgroup       = "DEVELOP-ESTIMATES-COLLECT-ICA"
  cloud_provider         = "azure"
  opt-datadog            = "require"
}

#----------------------------------------------------------------------
# Key Vault Configuration
#----------------------------------------------------------------------
resource_group_name             = "a1a-52161-prd-rg-prod-eus2-01"
sku_name                        = "premium"
enabled_for_deployment          = false
enabled_for_disk_encryption     = true
enabled_for_template_deployment = false

network_acls = {
  bypass                     = "AzureServices"
  default_action             = "Deny"
  ip_rules                   = []
  virtual_network_subnet_ids = []
}


