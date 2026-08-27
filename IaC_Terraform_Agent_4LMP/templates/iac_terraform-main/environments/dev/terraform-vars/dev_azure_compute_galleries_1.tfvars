org_id      = "a1a"
app_id      = "52161"
environment = "dev"
context     = "vmimage"
instance    = "01"
location    = "eastus2"
description = "Azure Compute Gallery for VM images in dev environment"

resource_group_name = "a1a-52161-dev-rg-estimates-eus2-01"
subscription_id     = "96278378-bea2-4e84-b5a3-4b5459eb2d18"

# Key Vault ID for Disk Encryption
key_vault_id = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-estimates-eus2-01/providers/Microsoft.KeyVault/vaults/a1a52161devkvinfeus201"

# Image Definitions - Auto-generates names like: {os_name}-{os_version}-{architecture}-{image_type}
image_definitions = {
  windows_server_2022_standard-byor = {
    os_type            = "Windows"
    os_name            = "windows-server"
    os_version         = "2022-standard"
    architecture       = "x64"
    image_type         = "byor"
    publisher          = "LSEG"
    offer              = "APPAL"
    sku                = "win-byor"
    hyper_v_generation = "V2"
    security_type      = "TrustedLaunch"
    description        = "Windows Server 2022 Standard x64 BYOR Image"
  }

  windows_server_2022_standard-application = {
    os_type            = "Windows"
    os_name            = "windows-server"
    os_version         = "2022-standard"
    architecture       = "x64"
    image_type         = "application"
    publisher          = "LSEG"
    offer              = "APPAL"
    sku                = "win-app"
    hyper_v_generation = "V2"
    security_type      = "TrustedLaunch"
    description        = "Windows Server 2022 Standard x64 Application Image"
  }
  rhel-server-9-standard-x64-application = {
    os_type            = "Linux"
    os_name            = "rhel-server"
    os_version         = "9-standard"
    architecture       = "x64"
    image_type         = "application"
    publisher          = "LSEG"
    offer              = "APPAL"
    sku                = "linux-app"
    hyper_v_generation = "V2"
    security_type      = "TrustedLaunch"
    description        = "Red Hat Enterprise Linux 9 x64 Application Image"
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
