org_id      = "a1a"
app_id      = "52161"
location    = "centralus"
environment = "ppr"
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
  mnd-baseimagename      = "windows-server-2022-standard-x64-application"
  cloud_provider         = "azure"
  opt-datadog            = "require"
}
key_vault_tags = {
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
#### Platform and Application Dependencies ####
resource_group_id           = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-cus-01"
shared_nrtbl_vnet_id        = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-cus-01"
privateendpoint_subnet_id   = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-platform-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-rtbl-cus-01/subnets/a1a-52161-ppr-snet-workload-cus-06"
firewall_private_ip_address = "10.203.116.68"
resource_group_name         = "a1a-52161-ppr-rg-estimates-cus-01"
key_vault_id                = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-cus-01/providers/Microsoft.KeyVault/vaults/a1a52161pprkvinfcus01"
app_key_vault_id            = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-cus-01/providers/Microsoft.KeyVault/vaults/a1a52161pprkvappcus01"
source_image_id             = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-cus-01/providers/Microsoft.Compute/galleries/a1a52161pprsigvmimagecus01/images/windows-server-2022-standard-x64-application/versions/1.0.0"

# Enable ENTRA auth assignments
enable_entra_auth = true

# ENTRA group object IDs for VM login roles
vm_user_login_group_id  = "16de4838-e860-44a2-873b-0019a529c357"
vm_admin_login_group_id = "c07ff11e-ae4e-4ca9-833e-509adf4f1b4e"

#### Storage Account Configuration ####
storage_account_config = {
  # Single shared storage account for all Windows VMs file shares
  windows_shared = {
    context                                = "wvm"
    instance                               = "01"
    account_tier                           = "Standard"
    persist_access_key                     = true
    enable_key_access                      = true
    account_replication_type               = "ZRS"
    kv_secret_expiration_date              = "2026-12-31T23:59:59Z"
    enable_file_share_AADDS_authentication = false
    vm_identity_keys                       = ["ec_repsrv01", "ec_tassrv01", "ec_tassrv02", "ec_tassrv03", "ec_tassrv04", "ec_tassrv06", "ec_actbre01", "ec_hvpmon01", "ea_calcsrv01", "ea_calcsrv02", "ea_calcsrv03", "ea_sdisrv01", "ea_sdisrv02", "ea_pantestsrv01", "ea_rtsubsrv01", "ea_rtsubsrv02", "ea_webjobsrv01", "ec_tagsrv01"]
    primary_vm_identity_key                = "ec_repsrv01"
    private_endpoint_config = {
      is_manual_connection = false
      static_ip_required   = false
    }
  }
}

############################################################# Windows VM ########################################################################
windows_vm = {
  ec_repsrv01 = {
    context  = "repsrv"
    instance = "01"
    zone     = "1"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-cus-01/subnets/a1a-52161-ppr-snet-ecapp-cus-01"
    }
    disk_encryption_set = {
      context         = "repsrv"
      instance        = "01"
      expiration_date = "2027-03-30T09:49:40Z"
    }
    ### KV Details
    key_vault_config = {
      deploy_kv_and_pe               = false
      kv_secret_expiration_in_months = 12
      network_acls = {
        bypass = "AzureServices"
      }
      private_endpoint = {
        static_ip_required = false
      }
    }
    size                           = "Standard_D4ads_v5"
    admin_username                 = "lsegadmin"
    computer_name                  = "repsrvpprcus01"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-cus-01/providers/Microsoft.Compute/galleries/a1a52161pprsigvmimagecus01/images/windows-server-2022-standard-x64-application/versions/1.0.0"
    deploy_proximityplacementgroup = true
    os_disk = {
      storage_account_type = "Premium_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "128"
    }
    azure_backup = {
      create_backup_vault       = false
      create_disk_backup_policy = true
      context                   = "repsrv"
      instance                  = "01"
      identity_type             = "SystemAssigned"
      expiration_date           = "2027-03-30T09:49:40Z"
    }
    storage_account_key = "windows_shared"
    file_share_config = {
      quota            = 128
      enabled_protocol = "SMB"
    }
    mount_azure_files  = true
    mount_drive_letter = "Z"
  }
  ec_tagsrv01 = {
    context  = "tagsrv"
    instance = "01"
    zone     = "1"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-cus-01/subnets/a1a-52161-ppr-snet-ecapp-cus-01"
    }
    disk_encryption_set = {
      context         = "tagsrv"
      instance        = "01"
      expiration_date = "2027-03-30T09:49:40Z"
    }
    key_vault_config = {
      deploy_kv_and_pe               = false
      kv_secret_expiration_in_months = 12
      network_acls = {
        bypass = "AzureServices"
      }
      private_endpoint = {
        static_ip_required = false
      }
    }
    size                           = "Standard_D8ads_v5"
    admin_username                 = "lsegadmin"
    computer_name                  = "tagsrvpprcus01"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-cus-01/providers/Microsoft.Compute/galleries/a1a52161pprsigvmimagecus01/images/windows-server-2022-standard-x64-application/versions/1.0.0"
    deploy_proximityplacementgroup = true
    os_disk = {
      storage_account_type = "Premium_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "128"
    }
    azure_backup = {
      create_backup_vault       = false
      create_disk_backup_policy = true
      context                   = "tagsrv"
      instance                  = "01"
      identity_type             = "SystemAssigned"
      expiration_date           = "2027-03-30T09:49:40Z"
    }
    storage_account_key = "windows_shared"
    file_share_config = {
      quota            = 512
      enabled_protocol = "SMB"
    }
    mount_azure_files  = true
    mount_drive_letter = "Z"
  }
  ec_tassrv01 = {
    context  = "tassrv"
    instance = "01"
    zone     = "1"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-cus-01/subnets/a1a-52161-ppr-snet-ecapp-cus-01"
    }
    disk_encryption_set = {
      context         = "tassrv"
      instance        = "01"
      expiration_date = "2027-03-30T09:49:40Z"
    }
    key_vault_config = {
      deploy_kv_and_pe               = false
      kv_secret_expiration_in_months = 12
      network_acls = {
        bypass = "AzureServices"
      }
      private_endpoint = {
        static_ip_required = false
      }
    }
    size                           = "Standard_D8ads_v5"
    admin_username                 = "lsegadmin"
    computer_name                  = "tassrvpprcus01"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-cus-01/providers/Microsoft.Compute/galleries/a1a52161pprsigvmimagecus01/images/windows-server-2022-standard-x64-application/versions/1.0.0"
    deploy_proximityplacementgroup = true
    os_disk = {
      storage_account_type = "Premium_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "128"
    }
    azure_backup = {
      create_backup_vault       = false
      create_disk_backup_policy = true
      context                   = "tassrv"
      instance                  = "01"
      identity_type             = "SystemAssigned"
      expiration_date           = "2027-03-30T09:49:40Z"
    }
    storage_account_key = "windows_shared"
    file_share_config = {
      quota            = 512
      enabled_protocol = "SMB"
    }
    mount_azure_files  = true
    mount_drive_letter = "Z"
  }
  ec_tassrv02 = {
    context  = "tassrv"
    instance = "02"
    zone     = "2"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-cus-01/subnets/a1a-52161-ppr-snet-ecapp-cus-01"
    }
    disk_encryption_set = {
      context         = "tassrv"
      instance        = "02"
      expiration_date = "2027-03-30T09:49:40Z"
    }
    key_vault_config = {
      deploy_kv_and_pe               = false
      kv_secret_expiration_in_months = 12
      network_acls = {
        bypass = "AzureServices"
      }
      private_endpoint = {
        static_ip_required = false
      }
    }
    size                           = "Standard_D64as_v5"
    admin_username                 = "lsegadmin"
    computer_name                  = "tassrvpprcus02"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-cus-01/providers/Microsoft.Compute/galleries/a1a52161pprsigvmimagecus01/images/windows-server-2022-standard-x64-application/versions/1.0.0"
    deploy_proximityplacementgroup = true
    os_disk = {
      storage_account_type = "Premium_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "128"
    }
    azure_backup = {
      create_backup_vault       = false
      create_disk_backup_policy = true
      context                   = "tassrv"
      instance                  = "02"
      identity_type             = "SystemAssigned"
      expiration_date           = "2027-03-30T09:49:40Z"
    }
    storage_account_key = "windows_shared"
    file_share_config = {
      quota            = 256
      enabled_protocol = "SMB"
    }
    mount_azure_files  = true
    mount_drive_letter = "Z"
  }
  ec_tassrv03 = {
    context  = "tassrv"
    instance = "03"
    zone     = "3"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-cus-01/subnets/a1a-52161-ppr-snet-ecapp-cus-01"
    }
    disk_encryption_set = {
      context         = "tassrv"
      instance        = "03"
      expiration_date = "2027-03-30T09:49:40Z"
    }
    key_vault_config = {
      deploy_kv_and_pe               = false
      kv_secret_expiration_in_months = 12
      network_acls = {
        bypass = "AzureServices"
      }
      private_endpoint = {
        static_ip_required = false
      }
    }
    size                           = "Standard_D64as_v5"
    admin_username                 = "lsegadmin"
    computer_name                  = "tassrvpprcus03"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-cus-01/providers/Microsoft.Compute/galleries/a1a52161pprsigvmimagecus01/images/windows-server-2022-standard-x64-application/versions/1.0.0"
    deploy_proximityplacementgroup = true
    os_disk = {
      storage_account_type = "Premium_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "128"
    }
    azure_backup = {
      create_backup_vault       = false
      create_disk_backup_policy = true
      context                   = "tassrv"
      instance                  = "03"
      identity_type             = "SystemAssigned"
      expiration_date           = "2027-03-30T09:49:40Z"
    }
    storage_account_key = "windows_shared"
    file_share_config = {
      quota            = 256
      enabled_protocol = "SMB"
    }
    mount_azure_files  = true
    mount_drive_letter = "Z"
  }

  ec_tassrv06 = {
    context  = "tassrv"
    instance = "06"
    zone     = "3"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-cus-01/subnets/a1a-52161-ppr-snet-ecapp-cus-01"
    }
    disk_encryption_set = {
      context         = "tassrv"
      instance        = "06"
      expiration_date = "2027-03-30T09:49:40Z"
    }
    key_vault_config = {
      deploy_kv_and_pe               = false
      kv_secret_expiration_in_months = 12
      network_acls = {
        bypass = "AzureServices"
      }
      private_endpoint = {
        static_ip_required = false
      }
    }
    size                           = "Standard_D64as_v5"
    admin_username                 = "lsegadmin"
    computer_name                  = "tassrvpprcus06"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-cus-01/providers/Microsoft.Compute/galleries/a1a52161pprsigvmimagecus01/images/windows-server-2022-standard-x64-application/versions/1.0.0"
    deploy_proximityplacementgroup = true
    os_disk = {
      storage_account_type = "Premium_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "128"
    }
    azure_backup = {
      create_backup_vault       = false
      create_disk_backup_policy = true
      context                   = "tassrv"
      instance                  = "06"
      identity_type             = "SystemAssigned"
      expiration_date           = "2027-03-30T09:49:40Z"
    }
    storage_account_key = "windows_shared"
    file_share_config = {
      quota            = 256
      enabled_protocol = "SMB"
    }
    mount_azure_files  = true
    mount_drive_letter = "Z"
  }
  ec_tassrv04 = {
    context  = "tassrv"
    instance = "04"
    zone     = "1"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-cus-01/subnets/a1a-52161-ppr-snet-ecapp-cus-01"
    }
    disk_encryption_set = {
      context         = "tassrv"
      instance        = "04"
      expiration_date = "2027-03-30T09:49:40Z"
    }
    key_vault_config = {
      deploy_kv_and_pe               = false
      kv_secret_expiration_in_months = 12
      network_acls = {
        bypass = "AzureServices"
      }
      private_endpoint = {
        static_ip_required = false
      }
    }
    size                           = "Standard_F4s_v2"
    admin_username                 = "lsegadmin"
    computer_name                  = "tassrvpprcus04"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-cus-01/providers/Microsoft.Compute/galleries/a1a52161pprsigvmimagecus01/images/windows-server-2022-standard-x64-application/versions/1.0.0"
    deploy_proximityplacementgroup = true
    os_disk = {
      storage_account_type = "Premium_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "128"
    }
    azure_backup = {
      create_backup_vault       = false
      create_disk_backup_policy = true
      context                   = "tassrv"
      instance                  = "04"
      identity_type             = "SystemAssigned"
      expiration_date           = "2027-03-30T09:49:40Z"
    }
    storage_account_key = "windows_shared"
    file_share_config = {
      quota            = 256
      enabled_protocol = "SMB"
    }
    mount_azure_files  = true
    mount_drive_letter = "Z"
  }
  ec_tassrv05 = {
    context  = "tassrv"
    instance = "05"
    zone     = "1"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-cus-01/subnets/a1a-52161-ppr-snet-ecapp-cus-01"
    }
    disk_encryption_set = {
      context         = "tassrv"
      instance        = "05"
      expiration_date = "2027-03-30T09:49:40Z"
    }
    key_vault_config = {
      deploy_kv_and_pe               = false
      kv_secret_expiration_in_months = 12
      network_acls = {
        bypass = "AzureServices"
      }
      private_endpoint = {
        static_ip_required = false
      }
    }
    size                           = "Standard_D8ads_v5"
    admin_username                 = "lsegadmin"
    computer_name                  = "tassrvpprcus05"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-cus-01/providers/Microsoft.Compute/galleries/a1a52161pprsigvmimagecus01/images/windows-server-2022-standard-x64-application/versions/1.0.0"
    deploy_proximityplacementgroup = true
    os_disk = {
      storage_account_type = "Premium_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "128"
    }
    azure_backup = {
      create_backup_vault       = false
      create_disk_backup_policy = true
      context                   = "tassrv"
      instance                  = "05"
      identity_type             = "SystemAssigned"
      expiration_date           = "2027-03-30T09:49:40Z"
    }
  }
  ec_actbre01 = {
    context  = "actbre"
    instance = "01"
    zone     = "1"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-cus-01/subnets/a1a-52161-ppr-snet-ecapp-cus-01"
    }
    disk_encryption_set = {
      context         = "actbre"
      instance        = "01"
      expiration_date = "2027-03-30T09:49:40Z"
    }
    key_vault_config = {
      deploy_kv_and_pe               = false
      kv_secret_expiration_in_months = 12
      network_acls = {
        bypass = "AzureServices"
      }
      private_endpoint = {
        static_ip_required = false
      }
    }
    size                           = "Standard_D8ads_v5"
    admin_username                 = "lsegadmin"
    computer_name                  = "actbrepprcus01"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-cus-01/providers/Microsoft.Compute/galleries/a1a52161pprsigvmimagecus01/images/windows-server-2022-standard-x64-application/versions/1.0.0"
    deploy_proximityplacementgroup = true
    os_disk = {
      storage_account_type = "Premium_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "128"
    }
    azure_backup = {
      create_backup_vault       = false
      create_disk_backup_policy = true
      context                   = "actbre"
      instance                  = "01"
      identity_type             = "SystemAssigned"
      expiration_date           = "2027-03-30T09:49:40Z"
    }
    storage_account_key = "windows_shared"
    file_share_config = {
      quota            = 100
      enabled_protocol = "SMB"
    }
    mount_azure_files  = true
    mount_drive_letter = "Z"
  }
  ec_hvpmon01 = {
    context  = "hvpmon"
    instance = "01"
    zone     = "1"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-cus-01/subnets/a1a-52161-ppr-snet-ecapp-cus-01"
    }
    disk_encryption_set = {
      context         = "hvpmon"
      instance        = "01"
      expiration_date = "2027-03-30T09:49:40Z"
    }
    ### KV Details
    key_vault_config = {
      deploy_kv_and_pe               = false
      kv_secret_expiration_in_months = 12
      network_acls = {
        bypass = "AzureServices"
      }
      private_endpoint = {
        static_ip_required = false
      }
    }
    size                           = "Standard_D8ads_v5"
    admin_username                 = "lsegadmin"
    computer_name                  = "hvpmonpprcus01"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-cus-01/providers/Microsoft.Compute/galleries/a1a52161pprsigvmimagecus01/images/windows-server-2022-standard-x64-application/versions/1.0.0"
    deploy_proximityplacementgroup = true
    os_disk = {
      storage_account_type = "Premium_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "128"
    }
    azure_backup = {
      create_backup_vault       = false
      create_disk_backup_policy = true
      context                   = "hvpmon"
      instance                  = "01"
      identity_type             = "SystemAssigned"
      expiration_date           = "2027-03-30T09:49:40Z"
    }
    storage_account_key = "windows_shared"
    file_share_config = {
      quota            = 128
      enabled_protocol = "SMB"
    }
    mount_azure_files  = true
    mount_drive_letter = "Z"
  }
  ea_calcsrv01 = {
    context  = "calcsrv"
    instance = "01"
    zone     = "1"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-cus-01/subnets/a1a-52161-ppr-snet-eaapp-cus-01"
    }
    disk_encryption_set = {
      context         = "calcsrv"
      instance        = "01"
      expiration_date = "2027-03-30T09:49:40Z"
    }
    ### KV Details
    key_vault_config = {
      deploy_kv_and_pe               = false
      kv_secret_expiration_in_months = 12
      network_acls = {
        bypass = "AzureServices"
      }
      private_endpoint = {
        static_ip_required = false
      }
    }
    size                           = "Standard_E8ads_v5"
    admin_username                 = "lsegadmin"
    computer_name                  = "calsrvpprcus01"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-cus-01/providers/Microsoft.Compute/galleries/a1a52161pprsigvmimagecus01/images/windows-server-2022-standard-x64-application/versions/1.0.0"
    deploy_proximityplacementgroup = true
    os_disk = {
      storage_account_type = "Premium_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "128"
    }
    azure_backup = {
      create_backup_vault       = false
      create_disk_backup_policy = true
      context                   = "calcsrv"
      instance                  = "01"
      identity_type             = "SystemAssigned"
      expiration_date           = "2027-03-30T09:49:40Z"
    }
    storage_account_key = "windows_shared"
    file_share_config = {
      quota            = 100
      enabled_protocol = "SMB"
    }
    mount_azure_files  = true
    mount_drive_letter = "Z"
  }
  ea_calcsrv02 = {
    context  = "calcsrv"
    instance = "02"
    zone     = "2"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-cus-01/subnets/a1a-52161-ppr-snet-eaapp-cus-01"
    }
    disk_encryption_set = {
      context         = "calcsrv"
      instance        = "02"
      expiration_date = "2027-03-30T09:49:40Z"
    }
    ### KV Details
    key_vault_config = {
      deploy_kv_and_pe               = false
      kv_secret_expiration_in_months = 12
      network_acls = {
        bypass = "AzureServices"
      }
      private_endpoint = {
        static_ip_required = false
      }
    }
    size                           = "Standard_E8ads_v5"
    admin_username                 = "lsegadmin"
    computer_name                  = "calsrvpprcus02"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-cus-01/providers/Microsoft.Compute/galleries/a1a52161pprsigvmimagecus01/images/windows-server-2022-standard-x64-application/versions/1.0.0"
    deploy_proximityplacementgroup = true
    os_disk = {
      storage_account_type = "Premium_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "128"
    }
    storage_account_key = "windows_shared"
    file_share_config = {
      quota            = 100
      enabled_protocol = "SMB"
    }
    mount_azure_files  = true
    mount_drive_letter = "Z"
    azure_backup = {
      create_backup_vault       = false
      create_disk_backup_policy = true
      context                   = "calcsrv"
      instance                  = "02"
      identity_type             = "SystemAssigned"
      expiration_date           = "2027-03-30T09:49:40Z"
    }
  }
  ea_calcsrv03 = {
    context  = "calcsrv"
    instance = "03"
    zone     = "3"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-cus-01/subnets/a1a-52161-ppr-snet-eaapp-cus-01"
    }
    disk_encryption_set = {
      context         = "calcsrv"
      instance        = "03"
      expiration_date = "2027-03-30T09:49:40Z"
    }
    ### KV Details
    key_vault_config = {
      deploy_kv_and_pe               = false
      kv_secret_expiration_in_months = 12
      network_acls = {
        bypass = "AzureServices"
      }
      private_endpoint = {
        static_ip_required = false
      }
    }
    size                           = "Standard_E8ads_v5"
    admin_username                 = "lsegadmin"
    computer_name                  = "calsrvpprcus03"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-cus-01/providers/Microsoft.Compute/galleries/a1a52161pprsigvmimagecus01/images/windows-server-2022-standard-x64-application/versions/1.0.0"
    deploy_proximityplacementgroup = true
    os_disk = {
      storage_account_type = "Premium_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "128"
    }
    azure_backup = {
      create_backup_vault       = false
      create_disk_backup_policy = true
      context                   = "calcsrv"
      instance                  = "03"
      identity_type             = "SystemAssigned"
      expiration_date           = "2027-03-30T09:49:40Z"
    }
    storage_account_key = "windows_shared"
    file_share_config = {
      quota            = 100
      enabled_protocol = "SMB"
    }

    mount_azure_files  = true
    mount_drive_letter = "Z"

  }
  ea_calcsrv04 = {
    context  = "calcsrv"
    instance = "04"
    zone     = "1"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-cus-01/subnets/a1a-52161-ppr-snet-eaapp-cus-01"
    }
    disk_encryption_set = {
      context         = "calcsrv"
      instance        = "04"
      expiration_date = "2027-03-30T09:49:40Z"
    }
    key_vault_config = {
      deploy_kv_and_pe               = false
      kv_secret_expiration_in_months = 12
      network_acls = {
        bypass = "AzureServices"
      }
      private_endpoint = {
        static_ip_required = false
      }
    }
    size                           = "Standard_E8ads_v5"
    admin_username                 = "lsegadmin"
    computer_name                  = "calsrvpprcus04"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-cus-01/providers/Microsoft.Compute/galleries/a1a52161pprsigvmimagecus01/images/windows-server-2022-standard-x64-application/versions/1.0.0"
    deploy_proximityplacementgroup = true
    os_disk = {
      storage_account_type = "Premium_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "128"
    }
    azure_backup = {
      create_backup_vault       = false
      create_disk_backup_policy = true
      context                   = "calcsrv"
      instance                  = "04"
      identity_type             = "SystemAssigned"
      expiration_date           = "2027-03-30T09:49:40Z"
    }
  }
  ea_calcsrv05 = {
    context  = "calcsrv"
    instance = "05"
    zone     = "1"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-cus-01/subnets/a1a-52161-ppr-snet-eaapp-cus-01"
    }
    disk_encryption_set = {
      context         = "calcsrv"
      instance        = "05"
      expiration_date = "2027-03-30T09:49:40Z"
    }
    key_vault_config = {
      deploy_kv_and_pe               = false
      kv_secret_expiration_in_months = 12
      network_acls = {
        bypass = "AzureServices"
      }
      private_endpoint = {
        static_ip_required = false
      }
    }
    size                           = "Standard_E8ads_v5"
    admin_username                 = "lsegadmin"
    computer_name                  = "calsrvpprcus05"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-cus-01/providers/Microsoft.Compute/galleries/a1a52161pprsigvmimagecus01/images/windows-server-2022-standard-x64-application/versions/1.0.0"
    deploy_proximityplacementgroup = true
    os_disk = {
      storage_account_type = "Premium_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "128"
    }
    azure_backup = {
      create_backup_vault       = false
      create_disk_backup_policy = true
      context                   = "calcsrv"
      instance                  = "05"
      identity_type             = "SystemAssigned"
      expiration_date           = "2027-03-30T09:49:40Z"
    }
  }
  ea_calcsrv06 = {
    context  = "calcsrv"
    instance = "06"
    zone     = "1"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-cus-01/subnets/a1a-52161-ppr-snet-eaapp-cus-01"
    }
    disk_encryption_set = {
      context         = "calcsrv"
      instance        = "06"
      expiration_date = "2027-03-30T09:49:40Z"
    }
    key_vault_config = {
      deploy_kv_and_pe               = false
      kv_secret_expiration_in_months = 12
      network_acls = {
        bypass = "AzureServices"
      }
      private_endpoint = {
        static_ip_required = false
      }
    }
    size                           = "Standard_E8ads_v5"
    admin_username                 = "lsegadmin"
    computer_name                  = "calsrvpprcus06"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-cus-01/providers/Microsoft.Compute/galleries/a1a52161pprsigvmimagecus01/images/windows-server-2022-standard-x64-application/versions/1.0.0"
    deploy_proximityplacementgroup = true
    os_disk = {
      storage_account_type = "Premium_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "128"
    }
    azure_backup = {
      create_backup_vault       = false
      create_disk_backup_policy = true
      context                   = "calcsrv"
      instance                  = "06"
      identity_type             = "SystemAssigned"
      expiration_date           = "2027-03-30T09:49:40Z"
    }
  }
  ea_calcsrv07 = {
    context  = "calcsrv"
    instance = "07"
    zone     = "1"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-cus-01/subnets/a1a-52161-ppr-snet-eaapp-cus-01"
    }
    disk_encryption_set = {
      context         = "calcsrv"
      instance        = "07"
      expiration_date = "2027-03-30T09:49:40Z"
    }
    key_vault_config = {
      deploy_kv_and_pe               = false
      kv_secret_expiration_in_months = 12
      network_acls = {
        bypass = "AzureServices"
      }
      private_endpoint = {
        static_ip_required = false
      }
    }
    size                           = "Standard_E8ads_v5"
    admin_username                 = "lsegadmin"
    computer_name                  = "calsrvpprcus07"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-cus-01/providers/Microsoft.Compute/galleries/a1a52161pprsigvmimagecus01/images/windows-server-2022-standard-x64-application/versions/1.0.0"
    deploy_proximityplacementgroup = true
    os_disk = {
      storage_account_type = "Premium_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "128"
    }
    azure_backup = {
      create_backup_vault       = false
      create_disk_backup_policy = true
      context                   = "calcsrv"
      instance                  = "07"
      identity_type             = "SystemAssigned"
      expiration_date           = "2027-03-30T09:49:40Z"
    }
  }
  ea_calcsrv08 = {
    context  = "calcsrv"
    instance = "08"
    zone     = "1"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-cus-01/subnets/a1a-52161-ppr-snet-eaapp-cus-01"
    }
    disk_encryption_set = {
      context         = "calcsrv"
      instance        = "08"
      expiration_date = "2027-03-30T09:49:40Z"
    }
    key_vault_config = {
      deploy_kv_and_pe               = false
      kv_secret_expiration_in_months = 12
      network_acls = {
        bypass = "AzureServices"
      }
      private_endpoint = {
        static_ip_required = false
      }
    }
    size                           = "Standard_E8ads_v5"
    admin_username                 = "lsegadmin"
    computer_name                  = "calsrvpprcus08"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-cus-01/providers/Microsoft.Compute/galleries/a1a52161pprsigvmimagecus01/images/windows-server-2022-standard-x64-application/versions/1.0.0"
    deploy_proximityplacementgroup = true
    os_disk = {
      storage_account_type = "Premium_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "128"
    }
    azure_backup = {
      create_backup_vault       = false
      create_disk_backup_policy = true
      context                   = "calcsrv"
      instance                  = "08"
      identity_type             = "SystemAssigned"
      expiration_date           = "2027-03-30T09:49:40Z"
    }
  }

  ea_sdisrv01 = {
    context  = "sdisrv"
    instance = "01"
    zone     = "1"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-cus-01/subnets/a1a-52161-ppr-snet-eaapp-cus-01"
    }
    disk_encryption_set = {
      context         = "sdisrv"
      instance        = "01"
      expiration_date = "2027-03-30T09:49:40Z"
    }
    ### KV Details
    key_vault_config = {
      deploy_kv_and_pe               = false
      kv_secret_expiration_in_months = 12
      network_acls = {
        bypass = "AzureServices"
      }
      private_endpoint = {
        static_ip_required = false
      }
    }
    size                           = "Standard_E8ads_v5"
    admin_username                 = "lsegadmin"
    computer_name                  = "sdisrvpprcus01"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-cus-01/providers/Microsoft.Compute/galleries/a1a52161pprsigvmimagecus01/images/windows-server-2022-standard-x64-application/versions/1.0.0"
    deploy_proximityplacementgroup = true
    os_disk = {
      storage_account_type = "Premium_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "128"
    }
    azure_backup = {
      create_backup_vault       = false
      create_disk_backup_policy = true
      context                   = "sdisrv"
      instance                  = "01"
      identity_type             = "SystemAssigned"
      expiration_date           = "2027-03-30T09:49:40Z"
    }
    storage_account_key = "windows_shared"
    file_share_config = {
      quota            = 650
      enabled_protocol = "SMB"
    }
    mount_azure_files  = true
    mount_drive_letter = "Z"
  }
  ea_sdisrv02 = {
    context  = "sdisrv"
    instance = "02"
    zone     = "1"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-cus-01/subnets/a1a-52161-ppr-snet-eaapp-cus-01"
    }
    disk_encryption_set = {
      context         = "sdisrv"
      instance        = "02"
      expiration_date = "2027-03-30T09:49:40Z"
    }
    ### KV Details
    key_vault_config = {
      deploy_kv_and_pe               = false
      kv_secret_expiration_in_months = 12
      network_acls = {
        bypass = "AzureServices"
      }
      private_endpoint = {
        static_ip_required = false
      }
    }
    size                           = "Standard_E8ads_v5"
    admin_username                 = "lsegadmin"
    computer_name                  = "sdisrvpprcus02"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-cus-01/providers/Microsoft.Compute/galleries/a1a52161pprsigvmimagecus01/images/windows-server-2022-standard-x64-application/versions/1.0.0"
    deploy_proximityplacementgroup = true
    os_disk = {
      storage_account_type = "Premium_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "128"
    }
    azure_backup = {
      create_backup_vault       = false
      create_disk_backup_policy = true
      context                   = "sdisrv"
      instance                  = "02"
      identity_type             = "SystemAssigned"
      expiration_date           = "2027-03-30T09:49:40Z"
    }
    storage_account_key = "windows_shared"
    file_share_config = {
      quota            = 650
      enabled_protocol = "SMB"
    }
    mount_azure_files  = true
    mount_drive_letter = "Z"
  }
  ea_pantestsrv01 = {
    context  = "pantstsrv"
    instance = "01"
    zone     = "1"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-cus-01/subnets/a1a-52161-ppr-snet-eaapp-cus-01"
    }
    disk_encryption_set = {
      context         = "pantstsrv"
      instance        = "01"
      expiration_date = "2027-03-30T09:49:40Z"
    }
    ### KV Details
    key_vault_config = {
      deploy_kv_and_pe               = false
      kv_secret_expiration_in_months = 12
      network_acls = {
        bypass = "AzureServices"
      }
      private_endpoint = {
        static_ip_required = false
      }
    }
    size                           = "Standard_E8ads_v5"
    admin_username                 = "lsegadmin"
    computer_name                  = "pansrvpprcus01"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-cus-01/providers/Microsoft.Compute/galleries/a1a52161pprsigvmimagecus01/images/windows-server-2022-standard-x64-application/versions/1.0.0"
    deploy_proximityplacementgroup = true
    os_disk = {
      storage_account_type = "Premium_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "128"
    }
    azure_backup = {
      create_backup_vault       = false
      create_disk_backup_policy = true
      context                   = "pantstsrv"
      instance                  = "01"
      identity_type             = "SystemAssigned"
      expiration_date           = "2027-03-30T09:49:40Z"
    }
    storage_account_key = "windows_shared"
    file_share_config = {
      quota            = 2048
      enabled_protocol = "SMB"
    }
    mount_azure_files  = true
    mount_drive_letter = "Z"
  }
  ea_rtsubsrv01 = {
    context  = "rtsubsrv"
    instance = "01"
    zone     = "1"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-cus-01/subnets/a1a-52161-ppr-snet-eaapp-cus-01"
    }
    disk_encryption_set = {
      context         = "rtsubsrv"
      instance        = "01"
      expiration_date = "2027-03-30T09:49:40Z"
    }
    ### KV Details
    key_vault_config = {
      deploy_kv_and_pe               = false
      kv_secret_expiration_in_months = 12
      network_acls = {
        bypass = "AzureServices"
      }
      private_endpoint = {
        static_ip_required = false
      }
    }
    size                           = "Standard_E16ads_v5"
    admin_username                 = "lsegadmin"
    computer_name                  = "rtssrvpprcus01"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-cus-01/providers/Microsoft.Compute/galleries/a1a52161pprsigvmimagecus01/images/windows-server-2022-standard-x64-application/versions/1.0.0"
    deploy_proximityplacementgroup = true
    os_disk = {
      storage_account_type = "Premium_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "128"
    }
    azure_backup = {
      create_backup_vault       = false
      create_disk_backup_policy = true
      context                   = "rtsubsrv"
      instance                  = "01"
      identity_type             = "SystemAssigned"
      expiration_date           = "2027-03-30T09:49:40Z"
    }
    storage_account_key = "windows_shared"
    file_share_config = {
      quota            = 1024
      enabled_protocol = "SMB"
    }
    mount_azure_files  = true
    mount_drive_letter = "Z"
  }
  ea_rtsubsrv02 = {
    context  = "rtsubsrv"
    instance = "02"
    zone     = "1"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-cus-01/subnets/a1a-52161-ppr-snet-eaapp-cus-01"
    }
    disk_encryption_set = {
      context         = "rtsubsrv"
      instance        = "02"
      expiration_date = "2027-03-30T09:49:40Z"
    }
    ### KV Details
    key_vault_config = {
      deploy_kv_and_pe               = false
      kv_secret_expiration_in_months = 12
      network_acls = {
        bypass = "AzureServices"
      }
      private_endpoint = {
        static_ip_required = false
      }
    }
    size                           = "Standard_E16ads_v5"
    admin_username                 = "lsegadmin"
    computer_name                  = "rtssrvpprcus02"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-cus-01/providers/Microsoft.Compute/galleries/a1a52161pprsigvmimagecus01/images/windows-server-2022-standard-x64-application/versions/1.0.0"
    deploy_proximityplacementgroup = true
    os_disk = {
      storage_account_type = "Premium_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "128"
    }
    azure_backup = {
      create_backup_vault       = false
      create_disk_backup_policy = true
      context                   = "rtsubsrv"
      instance                  = "02"
      identity_type             = "SystemAssigned"
      expiration_date           = "2027-03-30T09:49:40Z"
    }
    storage_account_key = "windows_shared"
    file_share_config = {
      quota            = 1024
      enabled_protocol = "SMB"
    }
    mount_azure_files  = true
    mount_drive_letter = "Z"
  }
  ea_webjobsrv01 = {
    context  = "webjobsrv"
    instance = "01"
    zone     = "1"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-cus-01/subnets/a1a-52161-ppr-snet-eaapp-cus-01"
    }
    disk_encryption_set = {
      context         = "webjobsrv"
      instance        = "01"
      expiration_date = "2027-03-30T09:49:40Z"
    }
    ### KV Details
    key_vault_config = {
      deploy_kv_and_pe               = false
      kv_secret_expiration_in_months = 12
      network_acls = {
        bypass = "AzureServices"
      }
      private_endpoint = {
        static_ip_required = false
      }
    }
    size                           = "Standard_F4s_v2"
    admin_username                 = "lsegadmin"
    computer_name                  = "wjbsrvpprcus01"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-cus-01/providers/Microsoft.Compute/galleries/a1a52161pprsigvmimagecus01/images/windows-server-2022-standard-x64-application/versions/1.0.0"
    deploy_proximityplacementgroup = true
    os_disk = {
      storage_account_type = "Premium_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "128"
    }
    storage_account_key = "windows_shared"
    file_share_config = {
      quota            = 250
      enabled_protocol = "SMB"
    }
    mount_azure_files  = true
    mount_drive_letter = "Z"
    azure_backup = {
      create_backup_vault       = false
      create_disk_backup_policy = true
      context                   = "webjobsrv"
      instance                  = "01"
      identity_type             = "SystemAssigned"
      expiration_date           = "2027-03-30T09:49:40Z"
    }
  }
}
