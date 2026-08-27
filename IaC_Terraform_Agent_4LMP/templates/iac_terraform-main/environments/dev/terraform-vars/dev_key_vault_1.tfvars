#
# Terraform variables for Key Vault deployment
# Environment: dev
# Resource: key_vault_1
#

#----------------------------------------------------------------------
# LSEG Required Variables
#----------------------------------------------------------------------
org_id      = "a1a"     # Three letter code for LSEG
app_id      = "52161"   # Application ID from Leanix (APP-52161)
environment = "dev"     # Development environment
location    = "eastus2" # Azure region

#----------------------------------------------------------------------
# LSEG Optional Variables
#----------------------------------------------------------------------
#instance = "01"  # Instance number
#context  = "inf" # Application context for Key Vault

keyvaults = {
  "keyvault-infra" = {
    instance = "01"
    context  = "inf"
    private_endpoint = {
      subnet_id            = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-nonrtbl-eus2-01/subnets/a1a-52161-dev-snet-ecpec-eus2-01"
      is_manual_connection = false
      static_ip_required   = false
    }
  },
  "keyvault-app" = {
    instance = "01"
    context  = "app"
    private_endpoint = {
      subnet_id            = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-platform-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-rtbl-eus2-01/subnets/a1a-52161-dev-snet-workload-eus2-06"
      is_manual_connection = false
      static_ip_required   = false
    }
  }
}

tags = {
  mnd-applicationid      = "app-52161"
  mnd-applicationname    = "estimates_azure_dbor_dev"
  mnd-costcentre         = "52161"
  mnd-dataclassification = "restricted"
  mnd-envsubtype         = "test"
  mnd-envtype            = "dev"
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
resource_group_name             = "a1a-52161-dev-rg-estimates-eus2-01"
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
  subnet_id            = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-platform-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-rtbl-eus2-01/subnets/a1a-52161-dev-snet-workload-eus2-06"
  is_manual_connection = false
  static_ip_required   = false
}
