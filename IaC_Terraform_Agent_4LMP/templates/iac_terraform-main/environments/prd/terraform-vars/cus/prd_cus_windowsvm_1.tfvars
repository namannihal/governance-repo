org_id      = "a1a"
app_id      = "52161"
location    = "centralus"
environment = "prd"
tags = {
  mnd-applicationid      = "app-52161"
  mnd-applicationname    = "Estimates_Azure_(DBoR)"
  mnd-costcentre         = "52161"
  mnd-dataclassification = "restricted"
  mnd-envsubtype         = "staging"
  mnd-envtype            = "prd"
  mnd-lifecycle          = "live"
  mnd-owner              = "TF-TF-IndiaEstimatesTech@lseg.com"
  mnd-projectcode        = "P011085"
  mnd-supportgroup       = "DEVELOP-ESTIMATES-COLLECT-ICA"
  cloud_provider         = "azure"
  opt-datadog            = "require"
}
key_vault_tags = {
  mnd-applicationid      = "app-52161"
  mnd-applicationname    = "Estimates_Azure_(DBoR)"
  mnd-costcentre         = "52161"
  mnd-dataclassification = "restricted"
  mnd-envsubtype         = "staging"
  mnd-envtype            = "prd"
  mnd-lifecycle          = "live"
  mnd-owner              = "TF-TF-IndiaEstimatesTech@lseg.com"
  mnd-projectcode        = "P011085"
  mnd-supportgroup       = "DEVELOP-ESTIMATES-COLLECT-ICA"
  cloud_provider         = "azure"
  opt-datadog            = "require"
}
#### Platform and Application Dependencies ####
resource_group_id           = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-prod-cus-01"
shared_nrtbl_vnet_id        = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-prd-vnet-nonrtbl-cus-01"
privateendpoint_subnet_id   = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-platform-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-prd-vnet-rtbl-cus-01/subnets/a1a-52161-prd-snet-workload-cus-06"
firewall_private_ip_address = "10.150.66.68"
resource_group_name         = "a1a-52161-prd-rg-prod-cus-01"
key_vault_id                = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-prod-cus-01/providers/Microsoft.KeyVault/vaults/a1a52161prdkvinfcus01"
app_key_vault_id            = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-prod-cus-01/providers/Microsoft.KeyVault/vaults/a1a52161prdkvappcus01"
source_image_id             = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-prod-cus-01/providers/Microsoft.Compute/galleries/a1a52161prdsigvmimagecus01/images/windows-server-2022-standard-x64-application/versions/1.0.1"
#Enable ENTRA auth assignments
enable_entra_auth = true

# ENTRA group object IDs for VM login roles
vm_user_login_group_id  = "ab78ef0a-5ca5-40dc-8011-db32a7fa5fa9"
vm_admin_login_group_id = "19a2a2db-ec5d-4928-82d4-3a60c39957f4"

# VM Agent Platform Updates
vm_agent_platform_updates_enabled = true


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
    vm_identity_keys                       = ["ec_trmser01", "ec_hvpmon01", "ec_hvprep01", "ec_repsrv01", "ec_tassrv01", "ec_tassrv02", "ec_tassrv03", "ec_tassrv04", "ec_tassrv05", "ec_tassrv06", "ec_actbre01", "ea_calcsrv01", "ea_calcsrv02", "ea_calcsrv03", "ea_calcsrv04", "ea_calcsrv05", "ea_calcsrv06", "ea_calcsrv07", "ea_calcsrv08", "ea_sdisrv01", "ea_sdisrv02", "ea_pantestsrv01", "ea_rtsubsrv01", "ea_rtsubsrv02", "ea_webjobsrv01"]
    primary_vm_identity_key                = "ec_trmser01"
    private_endpoint_config = {
      is_manual_connection = false
      static_ip_required   = false
    }
  }

}


############################################################# Windows VM ########################################################################
windows_vm = {
  ec_trmser01 = {
    context  = "trmser"
    instance = "01"
    zone     = "1"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-prd-vnet-nonrtbl-cus-01/subnets/a1a-52161-prd-snet-ecapp-cus-01"
    }
    disk_encryption_set = {
      context         = "trmser"
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
    size                           = "Standard_E4ads_v5"
    admin_username                 = "lsegadmin"
    computer_name                  = "termserprdcus1"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-prod-cus-01/providers/Microsoft.Compute/galleries/a1a52161prdsigvmimagecus01/images/windows-server-2022-standard-x64-application/versions/1.0.1"
    deploy_proximityplacementgroup = true
    os_disk = {
      storage_account_type = "Premium_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "128"
    }
    additional_disk = {
      data_disk_1 = {
        instance                       = "01"
        context                        = "trmser"
        enable_disk_backup             = true
        storage_account_type           = "StandardSSD_LRS"
        availability_zone              = "1"
        caching                        = "ReadWrite"
        lun                            = 0
        disk_size_gb                   = "1536"
        disk_encryption_set_id         = null
        ultra_ssd_disk_iops_read_write = null
        ultra_ssd_disk_mbps_read_write = null
      }
    }
    azure_backup = {
      create_backup_vault       = false
      create_disk_backup_policy = true
      context                   = "trmser"
      instance                  = "01"
      identity_type             = "SystemAssigned"
      expiration_date           = "2026-12-27T09:49:40Z"
    }
    storage_account_key = "windows_shared"
    file_share_config = {
      quota            = 200
      enabled_protocol = "SMB"
    }
    mount_azure_files  = true
    mount_drive_letter = "Z"
  }
  ec_hvprep01 = {
    context  = "hvprep"
    instance = "01"
    zone     = "1"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-prd-vnet-nonrtbl-cus-01/subnets/a1a-52161-prd-snet-ecapp-cus-01"
    }
    disk_encryption_set = {
      context         = "hvprep"
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
    computer_name                  = "hvprepprdcus1"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-prod-cus-01/providers/Microsoft.Compute/galleries/a1a52161prdsigvmimagecus01/images/windows-server-2022-standard-x64-application/versions/1.0.1"
    deploy_proximityplacementgroup = true
    os_disk = {
      storage_account_type = "Premium_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "128"
    }
    additional_disk = {
      data_disk_1 = {
        instance                       = "01"
        context                        = "hvprep"
        enable_disk_backup             = true
        storage_account_type           = "Premium_LRS"
        availability_zone              = "1"
        caching                        = "ReadWrite"
        lun                            = 0
        disk_size_gb                   = "2048"
        disk_encryption_set_id         = null
        ultra_ssd_disk_iops_read_write = 7500
        ultra_ssd_disk_mbps_read_write = 250
      }
    }
    azure_backup = {
      create_backup_vault       = true
      create_disk_backup_policy = true
      context                   = "hvprep"
      instance                  = "01"
      identity_type             = "SystemAssigned"
      expiration_date           = "2027-03-30T09:49:40Z"
      disk_backup_policy = {
        backup_repeating_time_intervals = ["R/2023-11-22T11:40:16+00:00/P1D"]
        default_retention_duration      = "P7D"
        time_zone                       = "Eastern Standard Time"
        retention_rule = [
          {
            name     = "Weekly"
            duration = "P7D"
            priority = 20
            criteria = {
              absolute_criteria = "FirstOfWeek"
            }
          }
        ]
      }
    }
    storage_account_key = "windows_shared"
    file_share_config = {
      quota            = 200
      enabled_protocol = "SMB"
    }
    mount_azure_files  = true
    mount_drive_letter = "Z"
  }
  ec_repsrv01 = {
    context  = "repsrv"
    instance = "01"
    zone     = "1"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-prd-vnet-nonrtbl-cus-01/subnets/a1a-52161-prd-snet-ecapp-cus-01"
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
    computer_name                  = "repsrvprdcus01"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-prod-cus-01/providers/Microsoft.Compute/galleries/a1a52161prdsigvmimagecus01/images/windows-server-2022-standard-x64-application/versions/1.0.1"
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
      expiration_date           = "2026-08-27T09:49:40Z"
    }
    storage_account_key = "windows_shared"
    file_share_config = {
      quota            = 128
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
      subnet_id           = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-prd-vnet-nonrtbl-cus-01/subnets/a1a-52161-prd-snet-ecapp-cus-01"
    }
    disk_encryption_set = {
      context         = "tassrv"
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
    computer_name                  = "tassrvprdcus1"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-prod-cus-01/providers/Microsoft.Compute/galleries/a1a52161prdsigvmimagecus01/images/windows-server-2022-standard-x64-application/versions/1.0.1"
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
      expiration_date           = "2026-08-27T09:49:40Z"
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
      subnet_id           = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-prd-vnet-nonrtbl-cus-01/subnets/a1a-52161-prd-snet-ecapp-cus-01"
    }
    disk_encryption_set = {
      context         = "tassrv"
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
    size                           = "Standard_D8ads_v5"
    admin_username                 = "lsegadmin"
    computer_name                  = "tassrvprdcus2"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-prod-cus-01/providers/Microsoft.Compute/galleries/a1a52161prdsigvmimagecus01/images/windows-server-2022-standard-x64-application/versions/1.0.1"
    deploy_proximityplacementgroup = true
    os_disk = {
      storage_account_type = "Premium_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "128"
    }
    storage_account_key = "windows_shared"
    file_share_config = {
      quota            = 256
      enabled_protocol = "SMB"
    }
    azure_backup = {
      create_backup_vault       = false
      create_disk_backup_policy = true
      context                   = "tassrv"
      instance                  = "02"
      identity_type             = "SystemAssigned"
      expiration_date           = "2026-08-27T09:49:40Z"
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
      subnet_id           = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-prd-vnet-nonrtbl-cus-01/subnets/a1a-52161-prd-snet-ecapp-cus-01"
    }
    disk_encryption_set = {
      context         = "tassrv"
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
    size                           = "Standard_D64as_v5"
    admin_username                 = "lsegadmin"
    computer_name                  = "tassrvprdcus3"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-prod-cus-01/providers/Microsoft.Compute/galleries/a1a52161prdsigvmimagecus01/images/windows-server-2022-standard-x64-application/versions/1.0.1"
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
      expiration_date           = "2026-08-27T09:49:40Z"
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
      subnet_id           = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-prd-vnet-nonrtbl-cus-01/subnets/a1a-52161-prd-snet-ecapp-cus-01"
    }
    disk_encryption_set = {
      context         = "tassrv"
      instance        = "04"
      expiration_date = "2026-12-27T09:49:40Z"
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
    size                           = "Standard_D64as_v5"
    admin_username                 = "lsegadmin"
    computer_name                  = "tassrvprdcus4"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-prod-cus-01/providers/Microsoft.Compute/galleries/a1a52161prdsigvmimagecus01/images/windows-server-2022-standard-x64-application/versions/1.0.1"
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
      expiration_date           = "2026-08-27T09:49:40Z"
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
    zone     = "2"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-prd-vnet-nonrtbl-cus-01/subnets/a1a-52161-prd-snet-ecapp-cus-01"
    }
    disk_encryption_set = {
      context         = "tassrv"
      instance        = "05"
      expiration_date = "2026-12-27T09:49:40Z"
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
    size                           = "Standard_D64as_v5"
    admin_username                 = "lsegadmin"
    computer_name                  = "tassrvprdcus5"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-prod-cus-01/providers/Microsoft.Compute/galleries/a1a52161prdsigvmimagecus01/images/windows-server-2022-standard-x64-application/versions/1.0.1"
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
      expiration_date           = "2026-08-27T09:49:40Z"
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
      subnet_id           = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-prd-vnet-nonrtbl-cus-01/subnets/a1a-52161-prd-snet-ecapp-cus-01"
    }
    disk_encryption_set = {
      context         = "tassrv"
      instance        = "06"
      expiration_date = "2026-12-27T09:49:40Z"
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
    computer_name                  = "tassrvprdcus6"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-prod-cus-01/providers/Microsoft.Compute/galleries/a1a52161prdsigvmimagecus01/images/windows-server-2022-standard-x64-application/versions/1.0.1"
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
      expiration_date           = "2026-08-27T09:49:40Z"
    }
    storage_account_key = "windows_shared"
    file_share_config = {
      quota            = 256
      enabled_protocol = "SMB"
    }
    mount_azure_files  = true
    mount_drive_letter = "Z"
  }
  ec_actbre01 = {
    context  = "actbre"
    instance = "01"
    zone     = "1"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-prd-vnet-nonrtbl-cus-01/subnets/a1a-52161-prd-snet-ecapp-cus-01"
    }
    disk_encryption_set = {
      context         = "actbre"
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
    computer_name                  = "actbreprdcus1"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-prod-cus-01/providers/Microsoft.Compute/galleries/a1a52161prdsigvmimagecus01/images/windows-server-2022-standard-x64-application/versions/1.0.1"
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
      expiration_date           = "2026-08-27T09:49:40Z"
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
      subnet_id           = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-prd-vnet-nonrtbl-cus-01/subnets/a1a-52161-prd-snet-ecapp-cus-01"
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
    computer_name                  = "hvpmonprdcus1"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-prod-cus-01/providers/Microsoft.Compute/galleries/a1a52161prdsigvmimagecus01/images/windows-server-2022-standard-x64-application/versions/1.0.1"
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
      expiration_date           = "2026-08-27T09:49:40Z"
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
      subnet_id           = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-prd-vnet-nonrtbl-cus-01/subnets/a1a-52161-prd-snet-eaapp-cus-01"
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
    computer_name                  = "calcsrvprdcus1"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-prod-cus-01/providers/Microsoft.Compute/galleries/a1a52161prdsigvmimagecus01/images/windows-server-2022-standard-x64-application/versions/1.0.1"
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
      expiration_date           = "2026-08-27T09:49:40Z"
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
      subnet_id           = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-prd-vnet-nonrtbl-cus-01/subnets/a1a-52161-prd-snet-eaapp-cus-01"
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
    computer_name                  = "calcsrvprdcus2"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-prod-cus-01/providers/Microsoft.Compute/galleries/a1a52161prdsigvmimagecus01/images/windows-server-2022-standard-x64-application/versions/1.0.1"
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
    azure_backup = {
      create_backup_vault       = false
      create_disk_backup_policy = true
      context                   = "calcsrv"
      instance                  = "02"
      identity_type             = "SystemAssigned"
      expiration_date           = "2026-08-27T09:49:40Z"
    }
    mount_azure_files  = true
    mount_drive_letter = "Z"
  }
  ea_calcsrv03 = {
    context  = "calcsrv"
    instance = "03"
    zone     = "3"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-prd-vnet-nonrtbl-cus-01/subnets/a1a-52161-prd-snet-eaapp-cus-01"
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
    computer_name                  = "calcsrvprdcus3"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-prod-cus-01/providers/Microsoft.Compute/galleries/a1a52161prdsigvmimagecus01/images/windows-server-2022-standard-x64-application/versions/1.0.1"
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
      expiration_date           = "2026-08-27T09:49:40Z"
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
      subnet_id           = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-prd-vnet-nonrtbl-cus-01/subnets/a1a-52161-prd-snet-eaapp-cus-01"
    }
    disk_encryption_set = {
      context         = "calcsrv"
      instance        = "04"
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
    computer_name                  = "calcsrvprdcus4"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-prod-cus-01/providers/Microsoft.Compute/galleries/a1a52161prdsigvmimagecus01/images/windows-server-2022-standard-x64-application/versions/1.0.1"
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
      expiration_date           = "2026-08-27T09:49:40Z"
    }
    storage_account_key = "windows_shared"
    file_share_config = {
      quota            = 100
      enabled_protocol = "SMB"
    }
    mount_azure_files  = true
    mount_drive_letter = "Z"
  }
  ea_calcsrv05 = {
    context  = "calcsrv"
    instance = "05"
    zone     = "2"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-prd-vnet-nonrtbl-cus-01/subnets/a1a-52161-prd-snet-eaapp-cus-01"
    }
    disk_encryption_set = {
      context         = "calcsrv"
      instance        = "05"
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
    computer_name                  = "calcsrvprdcus5"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-prod-cus-01/providers/Microsoft.Compute/galleries/a1a52161prdsigvmimagecus01/images/windows-server-2022-standard-x64-application/versions/1.0.1"
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
      expiration_date           = "2026-08-27T09:49:40Z"
    }
    storage_account_key = "windows_shared"
    file_share_config = {
      quota            = 100
      enabled_protocol = "SMB"
    }
    mount_azure_files  = true
    mount_drive_letter = "Z"
  }
  ea_calcsrv06 = {
    context  = "calcsrv"
    instance = "06"
    zone     = "3"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-prd-vnet-nonrtbl-cus-01/subnets/a1a-52161-prd-snet-eaapp-cus-01"
    }
    disk_encryption_set = {
      context         = "calcsrv"
      instance        = "06"
      expiration_date = "2026-08-27T09:49:40Z"
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
    computer_name                  = "calcsrvprdcus6"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-prod-cus-01/providers/Microsoft.Compute/galleries/a1a52161prdsigvmimagecus01/images/windows-server-2022-standard-x64-application/versions/1.0.1"
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
      expiration_date           = "2026-08-27T09:49:40Z"
    }
    storage_account_key = "windows_shared"
    file_share_config = {
      quota            = 100
      enabled_protocol = "SMB"
    }
    mount_azure_files  = true
    mount_drive_letter = "Z"
  }
  ea_calcsrv07 = {
    context  = "calcsrv"
    instance = "07"
    zone     = "1"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-prd-vnet-nonrtbl-cus-01/subnets/a1a-52161-prd-snet-eaapp-cus-01"
    }
    disk_encryption_set = {
      context         = "calcsrv"
      instance        = "07"
      expiration_date = "2026-08-27T09:49:40Z"
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
    computer_name                  = "calcsrvprdcus7"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-prod-cus-01/providers/Microsoft.Compute/galleries/a1a52161prdsigvmimagecus01/images/windows-server-2022-standard-x64-application/versions/1.0.1"
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
      expiration_date           = "2026-08-27T09:49:40Z"
    }
    storage_account_key = "windows_shared"
    file_share_config = {
      quota            = 100
      enabled_protocol = "SMB"
    }
    mount_azure_files  = true
    mount_drive_letter = "Z"
  }
  ea_calcsrv08 = {
    context  = "calcsrv"
    instance = "08"
    zone     = "2"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-prd-vnet-nonrtbl-cus-01/subnets/a1a-52161-prd-snet-eaapp-cus-01"
    }
    disk_encryption_set = {
      context         = "calcsrv"
      instance        = "08"
      expiration_date = "2026-08-27T09:49:40Z"
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
    computer_name                  = "calcsrvprdcus8"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-prod-cus-01/providers/Microsoft.Compute/galleries/a1a52161prdsigvmimagecus01/images/windows-server-2022-standard-x64-application/versions/1.0.1"
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
      expiration_date           = "2026-08-27T09:49:40Z"
    }
    storage_account_key = "windows_shared"
    file_share_config = {
      quota            = 100
      enabled_protocol = "SMB"
    }
    mount_azure_files  = true
    mount_drive_letter = "Z"
  }
  ea_sdisrv01 = {
    context  = "sdisrv"
    instance = "01"
    zone     = "1"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-prd-vnet-nonrtbl-cus-01/subnets/a1a-52161-prd-snet-eaapp-cus-01"
    }
    disk_encryption_set = {
      context         = "sdisrv"
      instance        = "01"
      expiration_date = "2026-08-27T09:49:40Z"
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
    computer_name                  = "sdisrvprdcus1"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-prod-cus-01/providers/Microsoft.Compute/galleries/a1a52161prdsigvmimagecus01/images/windows-server-2022-standard-x64-application/versions/1.0.1"
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
      expiration_date           = "2026-08-27T09:49:40Z"
    }
    storage_account_key = "windows_shared"
    file_share_config = {
      quota            = 100
      enabled_protocol = "SMB"
    }
    mount_azure_files  = true
    mount_drive_letter = "Z"
  }
  ea_sdisrv02 = {
    context  = "sdisrv"
    instance = "02"
    zone     = "2"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-prd-vnet-nonrtbl-cus-01/subnets/a1a-52161-prd-snet-eaapp-cus-01"
    }
    disk_encryption_set = {
      context         = "sdisrv"
      instance        = "02"
      expiration_date = "2026-08-27T09:49:40Z"
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
    computer_name                  = "sdisrvprdcus2"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-prod-cus-01/providers/Microsoft.Compute/galleries/a1a52161prdsigvmimagecus01/images/windows-server-2022-standard-x64-application/versions/1.0.1"
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
      expiration_date           = "2026-08-27T09:49:40Z"
    }
    storage_account_key = "windows_shared"
    file_share_config = {
      quota            = 100
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
      subnet_id           = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-prd-vnet-nonrtbl-cus-01/subnets/a1a-52161-prd-snet-eaapp-cus-01"
    }
    disk_encryption_set = {
      context         = "pantstsrv"
      instance        = "01"
      expiration_date = "2026-08-27T09:49:40Z"
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
    computer_name                  = "pantsrvprdcus1"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-prod-cus-01/providers/Microsoft.Compute/galleries/a1a52161prdsigvmimagecus01/images/windows-server-2022-standard-x64-application/versions/1.0.1"
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
      expiration_date           = "2026-08-27T09:49:40Z"
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
      subnet_id           = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-prd-vnet-nonrtbl-cus-01/subnets/a1a-52161-prd-snet-eaapp-cus-01"
    }
    disk_encryption_set = {
      context         = "rtsubsrv"
      instance        = "01"
      expiration_date = "2026-08-27T09:49:40Z"
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
    computer_name                  = "rtsubsrvprdcus1"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-prod-cus-01/providers/Microsoft.Compute/galleries/a1a52161prdsigvmimagecus01/images/windows-server-2022-standard-x64-application/versions/1.0.1"
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
      expiration_date           = "2026-08-27T09:49:40Z"
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
    zone     = "2"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-prd-vnet-nonrtbl-cus-01/subnets/a1a-52161-prd-snet-eaapp-cus-01"
    }
    disk_encryption_set = {
      context         = "rtsubsrv"
      instance        = "02"
      expiration_date = "2026-08-27T09:49:40Z"
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
    computer_name                  = "rtsubsrvprdcus2"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-prod-cus-01/providers/Microsoft.Compute/galleries/a1a52161prdsigvmimagecus01/images/windows-server-2022-standard-x64-application/versions/1.0.1"
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
      expiration_date           = "2026-08-27T09:49:40Z"
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
      subnet_id           = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-prd-vnet-nonrtbl-cus-01/subnets/a1a-52161-prd-snet-eaapp-cus-01"
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
    size                           = "Standard_D4ads_v5"
    admin_username                 = "lsegadmin"
    computer_name                  = "webjbsrvprdcus1"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-prod-cus-01/providers/Microsoft.Compute/galleries/a1a52161prdsigvmimagecus01/images/windows-server-2022-standard-x64-application/versions/1.0.1"
    deploy_proximityplacementgroup = true
    os_disk = {
      storage_account_type = "Premium_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "128"
    }
    storage_account_key = "windows_shared"
    file_share_config = {
      quota            = 50
      enabled_protocol = "SMB"
    }
    azure_backup = {
      create_backup_vault       = false
      create_disk_backup_policy = true
      context                   = "webjobsrv"
      instance                  = "01"
      identity_type             = "SystemAssigned"
      expiration_date           = "2026-08-27T09:49:40Z"
    }
    mount_azure_files  = true
    mount_drive_letter = "Z"
  }
}


