org_id      = "a1a"
app_id      = "52161"
location    = "eastus2"
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
  mnd-baseimagename      = "windows-server-2022-x64-a1a52161pprbyorimageeus201"
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
resource_group_id           = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-eus2-01"
shared_nrtbl_vnet_id        = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-eus2-01"
privateendpoint_subnet_id   = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-platform-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-rtbl-eus2-01/subnets/a1a-52161-ppr-snet-workload-eus2-06"
firewall_private_ip_address = "10.239.52.68"
resource_group_name         = "a1a-52161-ppr-rg-estimates-eus2-01"
key_vault_id                = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-eus2-01/providers/Microsoft.KeyVault/vaults/a1a52161pprkvinfeus201"
app_key_vault_id            = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-eus2-01/providers/Microsoft.KeyVault/vaults/a1a52161pprkvappeus201"

# Enable ENTRA auth assignments
enable_entra_auth = true

# ENTRA group object IDs for VM login roles
vm_user_login_group_id  = "16de4838-e860-44a2-873b-0019a529c357"
vm_admin_login_group_id = "c07ff11e-ae4e-4ca9-833e-509adf4f1b4e"


#### Storage Account Configuration ####
storage_account_config = {
  # Main storage account for Windows VMs file shares
  ec_hvp = {
    context                                = "hvp"
    instance                               = "01"
    account_tier                           = "Standard"
    persist_access_key                     = true
    enable_key_access                      = true
    account_replication_type               = "ZRS"
    kv_secret_expiration_date              = "2026-12-31T23:59:59Z"
    enable_file_share_AADDS_authentication = false
    # Specify which VMs' identities to use for this storage account
    vm_identity_keys = ["ec_hvpmon01"]
    # Primary VM identity for customer managed key (use first VM)
    primary_vm_identity_key = "ec_hvpmon01"
    private_endpoint_config = {
      is_manual_connection = false
      static_ip_required   = false
    }
  }
  ec_repsrv = {
    context                                = "rep"
    instance                               = "01"
    account_tier                           = "Standard"
    persist_access_key                     = true
    enable_key_access                      = true
    account_replication_type               = "ZRS"
    kv_secret_expiration_date              = "2026-12-31T23:59:59Z"
    enable_file_share_AADDS_authentication = false
    # Specify which VMs' identities to use for this storage account
    vm_identity_keys = ["ec_repsrv01"]
    # Primary VM identity for customer managed key (use first VM)
    primary_vm_identity_key = "ec_repsrv01"
    private_endpoint_config = {
      is_manual_connection = false
      static_ip_required   = false
    }
  }
  ec_tassrv = {
    context                                = "tas"
    instance                               = "01"
    account_tier                           = "Standard"
    persist_access_key                     = true
    enable_key_access                      = true
    account_replication_type               = "ZRS"
    kv_secret_expiration_date              = "2026-12-31T23:59:59Z"
    enable_file_share_AADDS_authentication = false
    # Specify which VMs' identities to use for this storage account
    vm_identity_keys = ["ec_tassrv01", "ec_tassrv02", "ec_tassrv03", "ec_tassrv04", "ec_tassrv05", "ec_tassrv06"]
    # Primary VM identity for customer managed key (use first VM)
    primary_vm_identity_key = ["ec_tassrv01", "ec_tassrv02", "ec_tassrv03", "ec_tassrv04", "ec_tassrv05", "ec_tassrv06"]
    private_endpoint_config = {
      is_manual_connection = false
      static_ip_required   = false
    }
  }
  ec_tagsrv = {
    context                                = "tag"
    instance                               = "01"
    account_tier                           = "Standard"
    persist_access_key                     = true
    enable_key_access                      = true
    account_replication_type               = "ZRS"
    kv_secret_expiration_date              = "2026-12-31T23:59:59Z"
    enable_file_share_AADDS_authentication = false
    # Specify which VMs' identities to use for this storage account
    vm_identity_keys = ["ec_tagsrv01"]
    # Primary VM identity for customer managed key (use first VM)
    primary_vm_identity_key = "ec_tagsrv01"
    private_endpoint_config = {
      is_manual_connection = false
      static_ip_required   = false
    }
  }
  ea_calcsrv = {
    context                                = "cal"
    instance                               = "01"
    account_tier                           = "Standard"
    persist_access_key                     = true
    enable_key_access                      = true
    account_replication_type               = "ZRS"
    kv_secret_expiration_date              = "2026-12-31T23:59:59Z"
    enable_file_share_AADDS_authentication = false
    # Specify which VMs' identities to use for this storage account
    vm_identity_keys = ["ea_calcsrv01", "ea_calcsrv02", "ea_calcsrv03", "ea_calcsrv04", "ea_calcsrv05", "ea_calcsrv06", "ea_calcsrv07", "ea_calcsrv08"]
    # Primary VM identity for customer managed key (use all cal VMs)
    primary_vm_identity_key = ["ea_calcsrv01", "ea_calcsrv02", "ea_calcsrv03", "ea_calcsrv04", "ea_calcsrv05", "ea_calcsrv06", "ea_calcsrv07", "ea_calcsrv08"]
    private_endpoint_config = {
      is_manual_connection = false
      static_ip_required   = false
    }
  }
  ea_sdisrv = {
    context                                = "sdi"
    instance                               = "01"
    account_tier                           = "Standard"
    persist_access_key                     = true
    enable_key_access                      = true
    account_replication_type               = "ZRS"
    kv_secret_expiration_date              = "2026-12-31T23:59:59Z"
    enable_file_share_AADDS_authentication = false
    # Specify which VMs' identities to use for this storage account
    vm_identity_keys = ["ea_sdisrv01", "ea_sdisrv02"]
    # Primary VM identity for customer managed key (use first VM)
    primary_vm_identity_key = ["ea_sdisrv01", "ea_sdisrv02"]
    private_endpoint_config = {
      is_manual_connection = false
      static_ip_required   = false
    }
  }
  ea_pantestsrv = {
    context                                = "pan"
    instance                               = "01"
    account_tier                           = "Standard"
    persist_access_key                     = true
    enable_key_access                      = true
    account_replication_type               = "ZRS"
    kv_secret_expiration_date              = "2026-12-31T23:59:59Z"
    enable_file_share_AADDS_authentication = false
    # Specify which VMs' identities to use for this storage account
    vm_identity_keys = ["ea_pantestsrv01"]
    # Primary VM identity for customer managed key (use first VM)
    primary_vm_identity_key = "ea_pantestsrv01"
    private_endpoint_config = {
      is_manual_connection = false
      static_ip_required   = false
    }
  }
  ea_rtsubsrv = {
    context                                = "rts"
    instance                               = "01"
    account_tier                           = "Standard"
    persist_access_key                     = true
    enable_key_access                      = true
    account_replication_type               = "ZRS"
    kv_secret_expiration_date              = "2026-12-31T23:59:59Z"
    enable_file_share_AADDS_authentication = false
    # Specify which VMs' identities to use for this storage account
    vm_identity_keys = ["ea_rtsubsrv01", "ea_rtsubsrv02"]
    # Primary VM identity for customer managed key (use first VM)
    primary_vm_identity_key = ["ea_rtsubsrv01", "ea_rtsubsrv02"]
    private_endpoint_config = {
      is_manual_connection = false
      static_ip_required   = false
    }
  }
  ea_webjobsrv = {
    context                                = "wjb"
    instance                               = "01"
    account_tier                           = "Standard"
    persist_access_key                     = true
    enable_key_access                      = true
    account_replication_type               = "ZRS"
    kv_secret_expiration_date              = "2026-12-31T23:59:59Z"
    enable_file_share_AADDS_authentication = false
    # Specify which VMs' identities to use for this storage account
    vm_identity_keys = ["ea_webjobsrv01"]
    # Primary VM identity for customer managed key (use first VM)
    primary_vm_identity_key = "ea_webjobsrv01"
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
      subnet_id           = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-eus2-01/subnets/a1a-52161-ppr-snet-ecapp-eus2-01"
    }
    disk_encryption_set = {
      context         = "repsrv"
      instance        = "01"
      expiration_date = "2027-03-30T09:49:40Z"
    }
    ### KV Details
    key_vault_config = {
      deploy_kv_and_pe               = false
      key_vault_id                   = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-eus2-01/providers/Microsoft.KeyVault/vaults/a1a52161pprkvinfeus201"
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
    computer_name                  = "estpprrepsrv01"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-eus2-01/providers/Microsoft.Compute/galleries/a1a52161pprsigvmimageeus201/images/windows-server-2022-x64-a1a52161pprbyorimageeus201/versions/1.0.0"
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
      disk_backup_policy        = null
    }
    storage_account_key = "ec_repsrv"
    file_share_config = {
      quota            = 128
      enabled_protocol = "SMB"
    }
    enable_backup      = false
    custom_data        = "U2V0LVRpbWVab25lIC1JZCAnRWFzdGVybiBTdGFuZGFyZCBUaW1lJw=="
    disk_backup_policy = null
  }
  ec_tassrv01 = {
    context  = "tassrv"
    instance = "01"
    zone     = "1"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-eus2-01/subnets/a1a-52161-ppr-snet-ecapp-eus2-01"
    }
    disk_encryption_set = {
      context         = "tassrv"
      instance        = "01"
      expiration_date = "2027-03-30T09:49:40Z"
    }
    ### KV Details
    key_vault_config = {
      deploy_kv_and_pe               = false
      key_vault_id                   = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-eus2-01/providers/Microsoft.KeyVault/vaults/a1a52161pprkvinfeus201"
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
    computer_name                  = "estpprtassrv01"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-eus2-01/providers/Microsoft.Compute/galleries/a1a52161pprsigvmimageeus201/images/windows-server-2022-x64-a1a52161pprbyorimageeus201/versions/1.0.0"
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
      disk_backup_policy        = null
    }
    storage_account_key = "ec_tassrv"
    file_share_config = {
      quota            = 512
      enabled_protocol = "SMB"
    }
    enable_backup      = false
    custom_data        = "U2V0LVRpbWVab25lIC1JZCAnRWFzdGVybiBTdGFuZGFyZCBUaW1lJw=="
    disk_backup_policy = null
  }
  ec_tassrv02 = {
    context  = "tassrv"
    instance = "02"
    zone     = "2"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-eus2-01/subnets/a1a-52161-ppr-snet-ecapp-eus2-01"
    }
    disk_encryption_set = {
      context         = "tassrv"
      instance        = "02"
      expiration_date = "2027-03-30T09:49:40Z"
    }
    ### KV Details
    key_vault_config = {
      deploy_kv_and_pe               = false
      key_vault_id                   = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-eus2-01/providers/Microsoft.KeyVault/vaults/a1a52161pprkvinfeus201"
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
    computer_name                  = "estpprtassrv02"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-eus2-01/providers/Microsoft.Compute/galleries/a1a52161pprsigvmimageeus201/images/windows-server-2022-x64-a1a52161pprbyorimageeus201/versions/1.0.0"
    deploy_proximityplacementgroup = true
    os_disk = {
      storage_account_type = "Premium_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "128"
    }
    storage_account_key = "ec_tassrv"
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
      disk_backup_policy        = null
    }
    enable_backup      = false
    custom_data        = "U2V0LVRpbWVab25lIC1JZCAnRWFzdGVybiBTdGFuZGFyZCBUaW1lJw=="
    disk_backup_policy = null
  }
  ec_tassrv03 = {
    context  = "tassrv"
    instance = "03"
    zone     = "3"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-eus2-01/subnets/a1a-52161-ppr-snet-ecapp-eus2-01"
    }
    disk_encryption_set = {
      context         = "tassrv"
      instance        = "03"
      expiration_date = "2027-03-30T09:49:40Z"
    }
    ### KV Details
    key_vault_config = {
      deploy_kv_and_pe               = false
      key_vault_id                   = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-eus2-01/providers/Microsoft.KeyVault/vaults/a1a52161pprkvinfeus201"
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
    computer_name                  = "estpprtassrv03"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-eus2-01/providers/Microsoft.Compute/galleries/a1a52161pprsigvmimageeus201/images/windows-server-2022-x64-a1a52161pprbyorimageeus201/versions/1.0.0"
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
      disk_backup_policy        = null
    }
    storage_account_key = "ec_tassrv"
    file_share_config = {
      quota            = 256
      enabled_protocol = "SMB"
    }
    enable_backup      = false
    custom_data        = "U2V0LVRpbWVab25lIC1JZCAnRWFzdGVybiBTdGFuZGFyZCBUaW1lJw=="
    disk_backup_policy = null
  }
  ec_tassrv04 = {
    context  = "tassrv"
    instance = "04"
    zone     = "1"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-eus2-01/subnets/a1a-52161-ppr-snet-ecapp-eus2-01"
    }
    disk_encryption_set = {
      context         = "tassrv"
      instance        = "04"
      expiration_date = "2026-12-27T09:49:40Z"
    }
    ### KV Details
    key_vault_config = {
      deploy_kv_and_pe               = false
      key_vault_id                   = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-eus2-01/providers/Microsoft.KeyVault/vaults/a1a52161pprkvinfeus201"
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
    computer_name                  = "estpprtassrv04"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-eus2-01/providers/Microsoft.Compute/galleries/a1a52161pprsigvmimageeus201/images/windows-server-2022-x64-a1a52161pprbyorimageeus201/versions/1.0.0"
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
      disk_backup_policy        = null
    }
    storage_account_key = "ec_tassrv"
    file_share_config = {
      quota            = 256
      enabled_protocol = "SMB"
    }
    enable_backup      = false
    custom_data        = "U2V0LVRpbWVab25lIC1JZCAnRWFzdGVybiBTdGFuZGFyZCBUaW1lJw=="
    disk_backup_policy = null
  }
  ec_tassrv05 = {
    context  = "tassrv"
    instance = "05"
    zone     = "2"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-eus2-01/subnets/a1a-52161-ppr-snet-ecapp-eus2-01"
    }
    disk_encryption_set = {
      context         = "tassrv"
      instance        = "05"
      expiration_date = "2026-12-27T09:49:40Z"
    }
    ### KV Details
    key_vault_config = {
      deploy_kv_and_pe               = false
      key_vault_id                   = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-eus2-01/providers/Microsoft.KeyVault/vaults/a1a52161pprkvinfeus201"
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
    computer_name                  = "estpprtassrv05"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-eus2-01/providers/Microsoft.Compute/galleries/a1a52161pprsigvmimageeus201/images/windows-server-2022-x64-a1a52161pprbyorimageeus201/versions/1.0.0"
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
      disk_backup_policy        = null
    }
    storage_account_key = "ec_tassrv"
    file_share_config = {
      quota            = 256
      enabled_protocol = "SMB"
    }
    enable_backup      = false
    custom_data        = "U2V0LVRpbWVab25lIC1JZCAnRWFzdGVybiBTdGFuZGFyZCBUaW1lJw=="
    disk_backup_policy = null
  }
  ec_tassrv06 = {
    context  = "tassrv"
    instance = "06"
    zone     = "3"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-eus2-01/subnets/a1a-52161-ppr-snet-ecapp-eus2-01"
    }
    disk_encryption_set = {
      context         = "tassrv"
      instance        = "06"
      expiration_date = "2026-12-27T09:49:40Z"
    }
    ### KV Details
    key_vault_config = {
      deploy_kv_and_pe               = false
      key_vault_id                   = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-eus2-01/providers/Microsoft.KeyVault/vaults/a1a52161pprkvinfeus201"
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
    computer_name                  = "estpprtassrv06"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-eus2-01/providers/Microsoft.Compute/galleries/a1a52161pprsigvmimageeus201/images/windows-server-2022-x64-a1a52161pprbyorimageeus201/versions/1.0.0"
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
      disk_backup_policy        = null
    }
    storage_account_key = "ec_tassrv"
    file_share_config = {
      quota            = 256
      enabled_protocol = "SMB"
    }
    enable_backup      = false
    custom_data        = "U2V0LVRpbWVab25lIC1JZCAnRWFzdGVybiBTdGFuZGFyZCBUaW1lJw=="
    disk_backup_policy = null
  }
  ec_tagsrv01 = {
    context  = "tagsrv"
    instance = "01"
    zone     = "1"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-eus2-01/subnets/a1a-52161-ppr-snet-ecapp-eus2-01"
    }
    disk_encryption_set = {
      context         = "tagsrv"
      instance        = "01"
      expiration_date = "2027-03-30T09:49:40Z"
    }
    ### KV Details
    key_vault_config = {
      deploy_kv_and_pe               = false
      key_vault_id                   = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-eus2-01/providers/Microsoft.KeyVault/vaults/a1a52161pprkvinfeus201"
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
    computer_name                  = "estpprtagsrv01"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-eus2-01/providers/Microsoft.Compute/galleries/a1a52161pprsigvmimageeus201/images/windows-server-2022-x64-a1a52161pprbyorimageeus201/versions/1.0.0"
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
      expiration_date           = "2026-08-27T09:49:40Z"
      disk_backup_policy        = null
    }
    storage_account_key = "ec_tagsrv"
    file_share_config = {
      quota            = 100
      enabled_protocol = "SMB"
    }
    enable_backup      = false
    custom_data        = "U2V0LVRpbWVab25lIC1JZCAnRWFzdGVybiBTdGFuZGFyZCBUaW1lJw=="
    disk_backup_policy = null
  }
  ec_hvpmon01 = {
    context  = "hvpmon"
    instance = "01"
    zone     = "1"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-eus2-01/subnets/a1a-52161-ppr-snet-ecapp-eus2-01"
    }
    disk_encryption_set = {
      context         = "hvpmon"
      instance        = "01"
      expiration_date = "2027-03-30T09:49:40Z"
    }
    ### KV Details
    key_vault_config = {
      deploy_kv_and_pe               = false
      key_vault_id                   = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-eus2-01/providers/Microsoft.KeyVault/vaults/a1a52161pprkvinfeus201"
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
    computer_name                  = "estpprhvpmon01"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-eus2-01/providers/Microsoft.Compute/galleries/a1a52161pprsigvmimageeus201/images/windows-server-2022-x64-a1a52161pprbyorimageeus201/versions/1.0.0"
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
      disk_backup_policy        = null
    }
    storage_account_key = "ec_hvp"
    file_share_config = {
      quota            = 128
      enabled_protocol = "SMB"
    }
    enable_backup      = false
    custom_data        = "U2V0LVRpbWVab25lIC1JZCAnRWFzdGVybiBTdGFuZGFyZCBUaW1lJw=="
    disk_backup_policy = null
  }
  ea_calcsrv01 = {
    context  = "calcsrv"
    instance = "01"
    zone     = "1"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-eus2-01/subnets/a1a-52161-ppr-snet-eaapp-eus2-01"
    }
    disk_encryption_set = {
      context         = "calcsrv"
      instance        = "01"
      expiration_date = "2027-03-30T09:49:40Z"
    }
    ### KV Details
    key_vault_config = {
      deploy_kv_and_pe               = false
      key_vault_id                   = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-eus2-01/providers/Microsoft.KeyVault/vaults/a1a52161pprkvinfeus201"
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
    computer_name                  = "estpprcalcsrv01"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-eus2-01/providers/Microsoft.Compute/galleries/a1a52161pprsigvmimageeus201/images/windows-server-2022-x64-a1a52161pprbyorimageeus201/versions/1.0.0"
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
      disk_backup_policy        = null
    }
    storage_account_key = "ea_calcsrv"
    file_share_config = {
      quota            = 100
      enabled_protocol = "SMB"
    }
    enable_backup      = false
    custom_data        = "U2V0LVRpbWVab25lIC1JZCAnRWFzdGVybiBTdGFuZGFyZCBUaW1lJw=="
    disk_backup_policy = null
  }
  ea_calcsrv02 = {
    context  = "calcsrv"
    instance = "02"
    zone     = "2"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-eus2-01/subnets/a1a-52161-ppr-snet-eaapp-eus2-01"
    }
    disk_encryption_set = {
      context         = "calcsrv"
      instance        = "02"
      expiration_date = "2027-03-30T09:49:40Z"
    }
    ### KV Details
    key_vault_config = {
      deploy_kv_and_pe               = false
      key_vault_id                   = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-eus2-01/providers/Microsoft.KeyVault/vaults/a1a52161pprkvinfeus201"
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
    computer_name                  = "estpprcalcsrv02"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-eus2-01/providers/Microsoft.Compute/galleries/a1a52161pprsigvmimageeus201/images/windows-server-2022-x64-a1a52161pprbyorimageeus201/versions/1.0.0"
    deploy_proximityplacementgroup = true
    os_disk = {
      storage_account_type = "Premium_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "128"
    }
    storage_account_key = "ea_calcsrv"
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
      disk_backup_policy        = null
    }
    enable_backup      = false
    custom_data        = "U2V0LVRpbWVab25lIC1JZCAnRWFzdGVybiBTdGFuZGFyZCBUaW1lJw=="
    disk_backup_policy = null
  }
  ea_calcsrv03 = {
    context  = "calcsrv"
    instance = "03"
    zone     = "3"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-eus2-01/subnets/a1a-52161-ppr-snet-eaapp-eus2-01"
    }
    disk_encryption_set = {
      context         = "calcsrv"
      instance        = "03"
      expiration_date = "2027-03-30T09:49:40Z"
    }
    ### KV Details
    key_vault_config = {
      deploy_kv_and_pe               = false
      key_vault_id                   = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-eus2-01/providers/Microsoft.KeyVault/vaults/a1a52161pprkvinfeus201"
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
    computer_name                  = "estpprcalcsrv03"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-eus2-01/providers/Microsoft.Compute/galleries/a1a52161pprsigvmimageeus201/images/windows-server-2022-x64-a1a52161pprbyorimageeus201/versions/1.0.0"
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
      disk_backup_policy        = null
    }
    storage_account_key = "ea_calcsrv"
    file_share_config = {
      quota            = 100
      enabled_protocol = "SMB"
    }
    enable_backup      = false
    custom_data        = "U2V0LVRpbWVab25lIC1JZCAnRWFzdGVybiBTdGFuZGFyZCBUaW1lJw=="
    disk_backup_policy = null
  }
  ea_calcsrv04 = {
    context  = "calcsrv"
    instance = "04"
    zone     = "1"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-eus2-01/subnets/a1a-52161-ppr-snet-eaapp-eus2-01"
    }
    disk_encryption_set = {
      context         = "calcsrv"
      instance        = "04"
      expiration_date = "2027-03-30T09:49:40Z"
    }
    ### KV Details
    key_vault_config = {
      deploy_kv_and_pe               = false
      key_vault_id                   = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-eus2-01/providers/Microsoft.KeyVault/vaults/a1a52161pprkvinfeus201"
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
    computer_name                  = "estpprcalcsrv04"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-eus2-01/providers/Microsoft.Compute/galleries/a1a52161pprsigvmimageeus201/images/windows-server-2022-x64-a1a52161pprbyorimageeus201/versions/1.0.0"
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
      disk_backup_policy        = null
    }
    storage_account_key = "ea_calcsrv"
    file_share_config = {
      quota            = 100
      enabled_protocol = "SMB"
    }
    enable_backup      = false
    custom_data        = "U2V0LVRpbWVab25lIC1JZCAnRWFzdGVybiBTdGFuZGFyZCBUaW1lJw=="
    disk_backup_policy = null
  }
  ea_calcsrv05 = {
    context  = "calcsrv"
    instance = "05"
    zone     = "2"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-eus2-01/subnets/a1a-52161-ppr-snet-eaapp-eus2-01"
    }
    disk_encryption_set = {
      context         = "calcsrv"
      instance        = "05"
      expiration_date = "2027-03-30T09:49:40Z"
    }
    ### KV Details
    key_vault_config = {
      deploy_kv_and_pe               = false
      key_vault_id                   = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-eus2-01/providers/Microsoft.KeyVault/vaults/a1a52161pprkvinfeus201"
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
    computer_name                  = "estpprcalcsrv05"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-eus2-01/providers/Microsoft.Compute/galleries/a1a52161pprsigvmimageeus201/images/windows-server-2022-x64-a1a52161pprbyorimageeus201/versions/1.0.0"
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
      disk_backup_policy        = null
    }
    storage_account_key = "ea_calcsrv"
    file_share_config = {
      quota            = 100
      enabled_protocol = "SMB"
    }
    enable_backup      = false
    custom_data        = "U2V0LVRpbWVab25lIC1JZCAnRWFzdGVybiBTdGFuZGFyZCBUaW1lJw=="
    disk_backup_policy = null
  }
  ea_calcsrv06 = {
    context  = "calcsrv"
    instance = "06"
    zone     = "3"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-eus2-01/subnets/a1a-52161-ppr-snet-eaapp-eus2-01"
    }
    disk_encryption_set = {
      context         = "calcsrv"
      instance        = "06"
      expiration_date = "2026-08-27T09:49:40Z"
    }
    ### KV Details
    key_vault_config = {
      deploy_kv_and_pe               = false
      key_vault_id                   = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-eus2-01/providers/Microsoft.KeyVault/vaults/a1a52161pprkvinfeus201"
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
    computer_name                  = "estpprcalcsrv06"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-eus2-01/providers/Microsoft.Compute/galleries/a1a52161pprsigvmimageeus201/images/windows-server-2022-x64-a1a52161pprbyorimageeus201/versions/1.0.0"
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
      disk_backup_policy        = null
    }
    storage_account_key = "ea_calcsrv"
    file_share_config = {
      quota            = 100
      enabled_protocol = "SMB"
    }
    enable_backup      = false
    custom_data        = "U2V0LVRpbWVab25lIC1JZCAnRWFzdGVybiBTdGFuZGFyZCBUaW1lJw=="
    disk_backup_policy = null
  }
  ea_calcsrv07 = {
    context  = "calcsrv"
    instance = "07"
    zone     = "1"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-eus2-01/subnets/a1a-52161-ppr-snet-eaapp-eus2-01"
    }
    disk_encryption_set = {
      context         = "calcsrv"
      instance        = "07"
      expiration_date = "2026-08-27T09:49:40Z"
    }
    ### KV Details
    key_vault_config = {
      deploy_kv_and_pe               = false
      key_vault_id                   = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-eus2-01/providers/Microsoft.KeyVault/vaults/a1a52161pprkvinfeus201"
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
    computer_name                  = "estpprcalcsrv07"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-eus2-01/providers/Microsoft.Compute/galleries/a1a52161pprsigvmimageeus201/images/windows-server-2022-x64-a1a52161pprbyorimageeus201/versions/1.0.0"
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
      disk_backup_policy        = null
    }
    storage_account_key = "ea_calcsrv"
    file_share_config = {
      quota            = 100
      enabled_protocol = "SMB"
    }
    enable_backup      = false
    custom_data        = "U2V0LVRpbWVab25lIC1JZCAnRWFzdGVybiBTdGFuZGFyZCBUaW1lJw=="
    disk_backup_policy = null
  }
  ea_calcsrv08 = {
    context  = "calcsrv"
    instance = "08"
    zone     = "2"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-eus2-01/subnets/a1a-52161-ppr-snet-eaapp-eus2-01"
    }
    disk_encryption_set = {
      context         = "calcsrv"
      instance        = "08"
      expiration_date = "2026-08-27T09:49:40Z"
    }
    ### KV Details
    key_vault_config = {
      deploy_kv_and_pe               = false
      key_vault_id                   = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-eus2-01/providers/Microsoft.KeyVault/vaults/a1a52161pprkvinfeus201"
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
    computer_name                  = "estpprcalcsrv08"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-eus2-01/providers/Microsoft.Compute/galleries/a1a52161pprsigvmimageeus201/images/windows-server-2022-x64-a1a52161pprbyorimageeus201/versions/1.0.0"
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
      disk_backup_policy        = null
    }
    storage_account_key = "ea_calcsrv"
    file_share_config = {
      quota            = 100
      enabled_protocol = "SMB"
    }
    enable_backup      = false
    custom_data        = "U2V0LVRpbWVab25lIC1JZCAnRWFzdGVybiBTdGFuZGFyZCBUaW1lJw=="
    disk_backup_policy = null
  }
  ea_sdisrv01 = {
    context  = "sdisrv"
    instance = "01"
    zone     = "1"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-eus2-01/subnets/a1a-52161-ppr-snet-eaapp-eus2-01"
    }
    disk_encryption_set = {
      context         = "sdisrv"
      instance        = "01"
      expiration_date = "2026-08-27T09:49:40Z"
    }
    ### KV Details
    key_vault_config = {
      deploy_kv_and_pe               = false
      key_vault_id                   = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-eus2-01/providers/Microsoft.KeyVault/vaults/a1a52161pprkvinfeus201"
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
    computer_name                  = "estpprsdisrv01"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-eus2-01/providers/Microsoft.Compute/galleries/a1a52161pprsigvmimageeus201/images/windows-server-2022-x64-a1a52161pprbyorimageeus201/versions/1.0.0"
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
      disk_backup_policy        = null
    }
    storage_account_key = "ea_sdisrv"
    file_share_config = {
      quota            = 100
      enabled_protocol = "SMB"
    }
    enable_backup      = false
    custom_data        = "U2V0LVRpbWVab25lIC1JZCAnRWFzdGVybiBTdGFuZGFyZCBUaW1lJw=="
    disk_backup_policy = null
  }
  ea_sdisrv02 = {
    context  = "sdisrv"
    instance = "02"
    zone     = "2"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-eus2-01/subnets/a1a-52161-ppr-snet-eaapp-eus2-01"
    }
    disk_encryption_set = {
      context         = "sdisrv"
      instance        = "02"
      expiration_date = "2026-08-27T09:49:40Z"
    }
    ### KV Details
    key_vault_config = {
      deploy_kv_and_pe               = false
      key_vault_id                   = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-eus2-01/providers/Microsoft.KeyVault/vaults/a1a52161pprkvinfeus201"
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
    computer_name                  = "estpprsdisrv02"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-eus2-01/providers/Microsoft.Compute/galleries/a1a52161pprsigvmimageeus201/images/windows-server-2022-x64-a1a52161pprbyorimageeus201/versions/1.0.0"
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
      disk_backup_policy        = null
    }
    storage_account_key = "ea_sdisrv"
    file_share_config = {
      quota            = 100
      enabled_protocol = "SMB"
    }
    enable_backup      = false
    custom_data        = "U2V0LVRpbWVab25lIC1JZCAnRWFzdGVybiBTdGFuZGFyZCBUaW1lJw=="
    disk_backup_policy = null
  }
  ea_pantestsrv01 = {
    context  = "pantstsrv"
    instance = "01"
    zone     = "1"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-eus2-01/subnets/a1a-52161-ppr-snet-eaapp-eus2-01"
    }
    disk_encryption_set = {
      context         = "pantstsrv"
      instance        = "01"
      expiration_date = "2026-08-27T09:49:40Z"
    }
    ### KV Details
    key_vault_config = {
      deploy_kv_and_pe               = false
      key_vault_id                   = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-eus2-01/providers/Microsoft.KeyVault/vaults/a1a52161pprkvinfeus201"
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
    computer_name                  = "estpprpantsrv01"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-eus2-01/providers/Microsoft.Compute/galleries/a1a52161pprsigvmimageeus201/images/windows-server-2022-x64-a1a52161pprbyorimageeus201/versions/1.0.0"
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
      disk_backup_policy        = null
    }
    storage_account_key = "ea_pantestsrv"
    file_share_config = {
      quota            = 2048
      enabled_protocol = "SMB"
    }
    enable_backup      = false
    custom_data        = "U2V0LVRpbWVab25lIC1JZCAnRWFzdGVybiBTdGFuZGFyZCBUaW1lJw=="
    disk_backup_policy = null
  }
  ea_rtsubsrv01 = {
    context  = "rtsubsrv"
    instance = "01"
    zone     = "1"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-eus2-01/subnets/a1a-52161-ppr-snet-eaapp-eus2-01"
    }
    disk_encryption_set = {
      context         = "rtsubsrv"
      instance        = "01"
      expiration_date = "2026-08-27T09:49:40Z"
    }
    ### KV Details
    key_vault_config = {
      deploy_kv_and_pe               = false
      key_vault_id                   = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-eus2-01/providers/Microsoft.KeyVault/vaults/a1a52161pprkvinfeus201"
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
    computer_name                  = "estpprrtsbsrv01"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-eus2-01/providers/Microsoft.Compute/galleries/a1a52161pprsigvmimageeus201/images/windows-server-2022-x64-a1a52161pprbyorimageeus201/versions/1.0.0"
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
      disk_backup_policy        = null
    }
    storage_account_key = "ea_rtsubsrv"
    file_share_config = {
      quota            = 1024
      enabled_protocol = "SMB"
    }
    enable_backup      = false
    custom_data        = "U2V0LVRpbWVab25lIC1JZCAnRWFzdGVybiBTdGFuZGFyZCBUaW1lJw=="
    disk_backup_policy = null
  }
  ea_rtsubsrv02 = {
    context  = "rtsubsrv"
    instance = "02"
    zone     = "2"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-eus2-01/subnets/a1a-52161-ppr-snet-eaapp-eus2-01"
    }
    disk_encryption_set = {
      context         = "rtsubsrv"
      instance        = "02"
      expiration_date = "2026-08-27T09:49:40Z"
    }
    ### KV Details
    key_vault_config = {
      deploy_kv_and_pe               = false
      key_vault_id                   = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-eus2-01/providers/Microsoft.KeyVault/vaults/a1a52161pprkvinfeus201"
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
    computer_name                  = "estpprrtsbsrv02"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-eus2-01/providers/Microsoft.Compute/galleries/a1a52161pprsigvmimageeus201/images/windows-server-2022-x64-a1a52161pprbyorimageeus201/versions/1.0.0"
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
      disk_backup_policy        = null
    }
    storage_account_key = "ea_rtsubsrv"
    file_share_config = {
      quota            = 1024
      enabled_protocol = "SMB"
    }
    enable_backup      = false
    custom_data        = "U2V0LVRpbWVab25lIC1JZCAnRWFzdGVybiBTdGFuZGFyZCBUaW1lJw=="
    disk_backup_policy = null
  }
  ea_webjobsrv01 = {
    context  = "webjobsrv"
    instance = "01"
    zone     = "1"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-eus2-01/subnets/a1a-52161-ppr-snet-eaapp-eus2-01"
    }
    disk_encryption_set = {
      context         = "webjobsrv"
      instance        = "01"
      expiration_date = "2027-03-30T09:49:40Z"
    }
    ### KV Details
    key_vault_config = {
      deploy_kv_and_pe               = false
      key_vault_id                   = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-eus2-01/providers/Microsoft.KeyVault/vaults/a1a52161pprkvinfeus201"
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
    computer_name                  = "estpprwjobsrv01"
    secure_boot_enabled            = true
    source_image_id                = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-eus2-01/providers/Microsoft.Compute/galleries/a1a52161pprsigvmimageeus201/images/windows-server-2022-x64-a1a52161pprbyorimageeus201/versions/1.0.0"
    deploy_proximityplacementgroup = true
    os_disk = {
      storage_account_type = "Premium_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "128"
    }
    storage_account_key = "ea_webjobsrv"
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
      disk_backup_policy        = null
    }
    enable_backup      = false
    custom_data        = "U2V0LVRpbWVab25lIC1JZCAnRWFzdGVybiBTdGFuZGFyZCBUaW1lJw=="
    disk_backup_policy = null
  }
}


