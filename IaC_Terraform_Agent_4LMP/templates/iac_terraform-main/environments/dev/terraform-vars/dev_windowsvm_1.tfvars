
org_id      = "a1a"
app_id      = "52161"
location    = "eastus2"
environment = "dev"
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
  mnd-baseimagename      = "windows-server-2022-standard-x64-application"
  cloud_provider         = "azure"
  opt-datadog            = "require"
}
key_vault_tags = {
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
#### Platform and Application Dependencies ####
resource_group_id           = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-estimates-eus2-01"
shared_nrtbl_vnet_id        = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-nonrtbl-eus2-01"
privateendpoint_subnet_id   = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-nonrtbl-eus2-01/subnets/a1a-52161-dev-snet-ecpec-eus2-01"
firewall_private_ip_address = "10.93.196.68"
resource_group_name         = "a1a-52161-dev-rg-estimates-eus2-01"
key_vault_id                = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-estimates-eus2-01/providers/Microsoft.KeyVault/vaults/a1a52161devkvinfeus201"
app_key_vault_id            = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-estimates-eus2-01/providers/Microsoft.KeyVault/vaults/a1a52161devkvappeus201"
source_image_id             = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-estimates-eus2-01/providers/Microsoft.Compute/galleries/a1a52161devsigvmimageeus201/images/windows-server-2022-standard-x64-application/versions/1.0.0"

# Enable ENTRA auth assignments
enable_entra_auth = true

# ENTRA group object IDs for VM login roles
vm_user_login_group_id  = "6b2c2503-b3d4-47b3-b7e4-86f27a223035"
vm_admin_login_group_id = "aafa07cc-436a-48e9-8fff-f0e455e7bddc"

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
    kv_secret_expiration_date              = "2028-08-27T09:49:40Z"
    enable_file_share_AADDS_authentication = false
    vm_identity_keys                       = ["ec_hvprep01", "ec_repsrv01", "ec_tassrv01", "ec_tassrv02", "ec_tassrv03", "ec_tassrv04", "ec_tagsrv01", "ec_hvpmon01", "ea_calcsrv01", "ea_calcsrv02", "ea_calcsrv03", "ea_sdisrv01", "ea_pantestsrv01", "ea_rtsubsrv01", "ea_webjobsrv01"]
    primary_vm_identity_key                = "ec_hvprep01"
    private_endpoint_config = {
      is_manual_connection = false
      static_ip_required   = false
    }
  }
}

############################################################# Windows VM ########################################################################
windows_vm = {
  ec_hvprep01 = {
    context  = "hvprep"
    instance = "01"
    zone     = "1"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-nonrtbl-eus2-01/subnets/a1a-52161-dev-snet-ecapp-eus2-01"
    }
    disk_encryption_set = {
      context         = "hvprep"
      instance        = "01"
      expiration_date = "2028-12-27T09:49:40Z"
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
    size                           = "Standard_D2ads_v5"
    admin_username                 = "lsegadmin"
    computer_name                  = "hvprepdeveus201"
    secure_boot_enabled            = true
    deploy_proximityplacementgroup = true
    os_disk = {
      storage_account_type = "Standard_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "128"
    }
    additional_disk = {
      data_disk_1 = {
        instance                       = "01"
        context                        = "hvprep"
        enable_disk_backup             = true
        storage_account_type           = "StandardSSD_LRS"
        availability_zone              = "1"
        caching                        = "ReadWrite"
        lun                            = 0
        disk_size_gb                   = "1024"
        disk_encryption_set_id         = null
        ultra_ssd_disk_iops_read_write = null
        ultra_ssd_disk_mbps_read_write = null
      }
    }
    azure_backup = {
      create_backup_vault       = true
      create_disk_backup_policy = true
      context                   = "hvprep"
      instance                  = "01"
      identity_type             = "SystemAssigned"
      expiration_date           = "2026-12-27T09:49:40Z"
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
      subnet_id           = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-nonrtbl-eus2-01/subnets/a1a-52161-dev-snet-ecapp-eus2-01"
    }
    disk_encryption_set = {
      context         = "repsrv"
      instance        = "01"
      expiration_date = "2028-03-30T09:49:40Z"
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
    size                           = "Standard_D2ads_v5"
    admin_username                 = "lsegadmin"
    computer_name                  = "repsrvdeveus201"
    secure_boot_enabled            = true
    deploy_proximityplacementgroup = true
    os_disk = {
      storage_account_type = "Standard_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "128"
    }
    azure_backup = {
      create_backup_vault       = false
      create_disk_backup_policy = true
      context                   = "repsrv"
      instance                  = "01"
      identity_type             = "SystemAssigned"
      expiration_date           = "2028-08-27T09:49:40Z"
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
      subnet_id           = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-nonrtbl-eus2-01/subnets/a1a-52161-dev-snet-ecapp-eus2-01"
    }
    disk_encryption_set = {
      context         = "tassrv"
      instance        = "01"
      expiration_date = "2028-08-27T09:49:40Z"
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
    size                           = "Standard_E2ads_v5"
    admin_username                 = "lsegadmin"
    computer_name                  = "tassrvdeveus201"
    secure_boot_enabled            = true
    deploy_proximityplacementgroup = true
    os_disk = {
      storage_account_type = "Standard_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "128"
    }
    azure_backup = {
      create_backup_vault       = false
      create_disk_backup_policy = true
      context                   = "tassrv"
      instance                  = "01"
      identity_type             = "SystemAssigned"
      expiration_date           = "2028-08-27T09:49:40Z"
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
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-nonrtbl-eus2-01/subnets/a1a-52161-dev-snet-ecapp-eus2-01"
    }
    disk_encryption_set = {
      context         = "tassrv"
      instance        = "02"
      expiration_date = "2028-08-27T09:49:40Z"
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
    size                           = "Standard_E4ads_v5"
    admin_username                 = "lsegadmin"
    computer_name                  = "tassrvdeveus202"
    secure_boot_enabled            = true
    deploy_proximityplacementgroup = true
    os_disk = {
      storage_account_type = "Standard_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "128"
    }

    azure_backup = {
      create_backup_vault       = false
      create_disk_backup_policy = true
      context                   = "tassrv"
      instance                  = "02"
      identity_type             = "SystemAssigned"
      expiration_date           = "2028-08-27T09:49:40Z"
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
      subnet_id           = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-nonrtbl-eus2-01/subnets/a1a-52161-dev-snet-ecapp-eus2-01"
    }
    disk_encryption_set = {
      context         = "tassrv"
      instance        = "03"
      expiration_date = "2028-08-27T09:49:40Z"
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
    computer_name                  = "tassrvdeveus203"
    secure_boot_enabled            = true
    deploy_proximityplacementgroup = true
    os_disk = {
      storage_account_type = "Standard_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "128"
    }
    azure_backup = {
      create_backup_vault       = false
      create_disk_backup_policy = true
      context                   = "tassrv"
      instance                  = "03"
      identity_type             = "SystemAssigned"
      expiration_date           = "2028-08-27T09:49:40Z"
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
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-nonrtbl-eus2-01/subnets/a1a-52161-dev-snet-ecapp-eus2-01"
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
    size                           = "Standard_E4ads_v5"
    admin_username                 = "lsegadmin"
    computer_name                  = "tassrvdeveus204"
    secure_boot_enabled            = true
    deploy_proximityplacementgroup = true
    os_disk = {
      storage_account_type = "Standard_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "128"
    }
    azure_backup = {
      create_backup_vault       = false
      create_disk_backup_policy = true
      context                   = "tassrv"
      instance                  = "04"
      identity_type             = "SystemAssigned"
      expiration_date           = "2028-08-27T09:49:40Z"
    }
    storage_account_key = "windows_shared"
    file_share_config = {
      quota            = 256
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
      subnet_id           = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-nonrtbl-eus2-01/subnets/a1a-52161-dev-snet-ecapp-eus2-01"
    }
    disk_encryption_set = {
      context         = "tagsrv"
      instance        = "01"
      expiration_date = "2028-08-27T09:49:40Z"
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
    computer_name                  = "tagsrvdeveus201"
    secure_boot_enabled            = true
    deploy_proximityplacementgroup = true
    os_disk = {
      storage_account_type = "Standard_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "128"
    }
    azure_backup = {
      create_backup_vault       = false
      create_disk_backup_policy = true
      context                   = "tagsrv"
      instance                  = "01"
      identity_type             = "SystemAssigned"
      expiration_date           = "2028-08-27T09:49:40Z"
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
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-nonrtbl-eus2-01/subnets/a1a-52161-dev-snet-ecapp-eus2-01"
    }
    disk_encryption_set = {
      context         = "hvpmon"
      instance        = "01"
      expiration_date = "2028-08-27T09:49:40Z"
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
    size                           = "Standard_E2ads_v5"
    admin_username                 = "lsegadmin"
    computer_name                  = "hvpmondeveus201"
    secure_boot_enabled            = true
    deploy_proximityplacementgroup = true
    os_disk = {
      storage_account_type = "Standard_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "128"
    }
    azure_backup = {
      create_backup_vault       = false
      create_disk_backup_policy = true
      context                   = "hvpmon"
      instance                  = "01"
      identity_type             = "SystemAssigned"
      expiration_date           = "2028-08-27T09:49:40Z"
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
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-nonrtbl-eus2-01/subnets/a1a-52161-dev-snet-eaapp-eus2-01"
    }
    disk_encryption_set = {
      context         = "calcsrv"
      instance        = "01"
      expiration_date = "2028-08-27T09:49:40Z"
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
    computer_name                  = "calsrvdeveus201"
    secure_boot_enabled            = true
    deploy_proximityplacementgroup = true
    os_disk = {
      storage_account_type = "Standard_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "128"
    }
    azure_backup = {
      create_backup_vault       = false
      create_disk_backup_policy = true
      context                   = "calcsrv"
      instance                  = "01"
      identity_type             = "SystemAssigned"
      expiration_date           = "2028-08-27T09:49:40Z"
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
      subnet_id           = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-nonrtbl-eus2-01/subnets/a1a-52161-dev-snet-eaapp-eus2-01"
    }
    disk_encryption_set = {
      context         = "calcsrv"
      instance        = "02"
      expiration_date = "2028-08-27T09:49:40Z"
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
    computer_name                  = "calsrvdeveus202"
    secure_boot_enabled            = true
    deploy_proximityplacementgroup = true
    os_disk = {
      storage_account_type = "Standard_LRS"
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
      expiration_date           = "2028-08-27T09:49:40Z"
    }
  }
  ea_calcsrv03 = {
    context  = "calcsrv"
    instance = "03"
    zone     = "3"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-nonrtbl-eus2-01/subnets/a1a-52161-dev-snet-eaapp-eus2-01"
    }
    disk_encryption_set = {
      context         = "calcsrv"
      instance        = "03"
      expiration_date = "2028-08-27T09:49:40Z"
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
    computer_name                  = "calsrvdeveus203"
    secure_boot_enabled            = true
    deploy_proximityplacementgroup = true
    os_disk = {
      storage_account_type = "Standard_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "128"
    }
    azure_backup = {
      create_backup_vault       = false
      create_disk_backup_policy = true
      context                   = "calcsrv"
      instance                  = "03"
      identity_type             = "SystemAssigned"
      expiration_date           = "2028-08-27T09:49:40Z"
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
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-nonrtbl-eus2-01/subnets/a1a-52161-dev-snet-eaapp-eus2-01"
    }
    disk_encryption_set = {
      context         = "sdisrv"
      instance        = "01"
      expiration_date = "2028-08-27T09:49:40Z"
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
    computer_name                  = "sdisrvdeveus201"
    secure_boot_enabled            = true
    deploy_proximityplacementgroup = true
    os_disk = {
      storage_account_type = "Standard_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "128"
    }
    azure_backup = {
      create_backup_vault       = false
      create_disk_backup_policy = true
      context                   = "sdisrv"
      instance                  = "01"
      identity_type             = "SystemAssigned"
      expiration_date           = "2028-08-27T09:49:40Z"
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
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-nonrtbl-eus2-01/subnets/a1a-52161-dev-snet-eaapp-eus2-01"
    }
    disk_encryption_set = {
      context         = "pantstsrv"
      instance        = "01"
      expiration_date = "2028-08-27T09:49:40Z"
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
    computer_name                  = "pansrvdeveus201"
    secure_boot_enabled            = true
    deploy_proximityplacementgroup = true
    os_disk = {
      storage_account_type = "Standard_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "128"
    }
    azure_backup = {
      create_backup_vault       = false
      create_disk_backup_policy = true
      context                   = "panstsrv"
      instance                  = "01"
      identity_type             = "SystemAssigned"
      expiration_date           = "2028-08-27T09:49:40Z"
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
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-nonrtbl-eus2-01/subnets/a1a-52161-dev-snet-eaapp-eus2-01"
    }
    disk_encryption_set = {
      context         = "rtsubsrv"
      instance        = "01"
      expiration_date = "2028-08-27T09:49:40Z"
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
    computer_name                  = "rtssrvdeveus201"
    secure_boot_enabled            = true
    deploy_proximityplacementgroup = true
    os_disk = {
      storage_account_type = "Standard_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "128"
    }
    azure_backup = {
      create_backup_vault       = false
      create_disk_backup_policy = true
      context                   = "rtsubsrv"
      instance                  = "01"
      identity_type             = "SystemAssigned"
      expiration_date           = "2028-08-27T09:49:40Z"
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
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-nonrtbl-eus2-01/subnets/a1a-52161-dev-snet-eaapp-eus2-01"
    }
    disk_encryption_set = {
      context         = "webjobsrv"
      instance        = "01"
      expiration_date = "2028-08-27T09:49:40Z"
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
    size                           = "Standard_D2ads_v5"
    admin_username                 = "lsegadmin"
    computer_name                  = "wjbsrvdeveus201"
    secure_boot_enabled            = true
    deploy_proximityplacementgroup = true
    os_disk = {
      storage_account_type = "Standard_LRS"
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
      context                   = "webjobsrv"
      instance                  = "01"
      identity_type             = "SystemAssigned"
      expiration_date           = "2028-08-27T09:49:40Z"
    }
  }
}