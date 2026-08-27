#
# Terraform variables for Key Vault deployment
# Environment: PPR
# Resource: key_vault_1
#

#----------------------------------------------------------------------
# LSEG Required Variables
#----------------------------------------------------------------------
org_id      = "a1a"       # Three letter code for LSEG
app_id      = "52161"     # Application ID from Leanix (APP-52161)
environment = "ppr"       # Development environment
location    = "centralus" # Azure region

#----------------------------------------------------------------------
# LSEG Optional Variables
#----------------------------------------------------------------------

keyvaults = {
  "keyvault-infra" = {
    instance = "01"
    context  = "inf"
  },
  "keyvault-app" = {
    instance = "01"
    context  = "app"
  }
}

tags = {
  mnd-applicationid      = "app-52161"
  mnd-applicationname    = "estimates_azure_dbor_ppr"
  mnd-costcentre         = "52161"
  mnd-dataclassification = "restricted"
  mnd-envsubtype         = "staging"
  mnd-envtype            = "ppr"
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
resource_group_name             = "a1a-52161-ppr-rg-estimates-cus-01"
sku_name                        = "premium"
enabled_for_deployment          = true
enabled_for_disk_encryption     = true
enabled_for_template_deployment = true

network_acls = {
  bypass                     = "AzureServices"
  default_action             = "Deny"
  ip_rules                   = []
  virtual_network_subnet_ids = []
}

#----------------------------------------------------------------------
# Private Endpoint Configuration
#----------------------------------------------------------------------
private_endpoint = {
  subnet_id            = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-platform-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-rtbl-cus-01/subnets/a1a-52161-ppr-snet-workload-cus-06"
  is_manual_connection = false
  static_ip_required   = false
}
