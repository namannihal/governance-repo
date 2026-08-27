org_id      = "a1a"
app_id      = "52161"
environment = "ppr"
context     = "vmimage"
instance    = "01"
location    = "centralus"
description = "Azure Compute Gallery for VM images in ppr environment"

resource_group_name = "a1a-52161-ppr-rg-estimates-cus-01"
subscription_id     = "7b8a8ffb-9be5-4786-8ba6-dd328b9d6857"

# Key Vault ID for Disk Encryption
key_vault_id = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-cus-01/providers/Microsoft.KeyVault/vaults/a1a52161pprkvinfcus01"

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

  windows_server_2022_standard-couchdb = {
    os_type            = "Windows"
    os_name            = "windows-server"
    os_version         = "2022-standard"
    architecture       = "x64"
    image_type         = "couchdb"
    publisher          = "LSEG"
    offer              = "APPAL"
    sku                = "win-couchdb"
    hyper_v_generation = "V2"
    security_type      = "TrustedLaunch"
    description        = "Windows Server 2022 Standard x64 couchdb Image"
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
    description        = "Red Hat Enterprise Linux 9 x64 Application Image"
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
