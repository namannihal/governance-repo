org_id      = "a1a"
app_id      = "52161"
location    = "eastus2"
environment = "tst"

tags = {
  mnd-applicationid      = "app-52161"
  mnd-applicationname    = "estimates_azure_dbor_qa"
  mnd-costcentre         = "52161"
  mnd-dataclassification = "restricted"
  mnd-envsubtype         = "test"
  mnd-envtype            = "qa"
  mnd-lifecycle          = "live"
  mnd-owner              = "TF-TF-IndiaEstimatesTech@lseg.com"
  mnd-projectcode        = "P011085"
  mnd-supportgroup       = "DEVELOP-ESTIMATES-COLLECT-ICA"
  mnd-baseimagename      = "rhel-server-9-standard-x64-application"
  cloud_provider         = "azure"
  opt-datadog            = "require"
}

#### Platform and Application Dependencies ####
resource_group_id           = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-estimates-eus2-02"
shared_nrtbl_vnet_id        = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-nonrtbl-eus2-01"
privateendpoint_subnet_id   = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-platform-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-rtbl-eus2-01/subnets/a1a-52161-dev-snet-workload-eus2-06"
firewall_private_ip_address = "10.93.196.68"
resource_group_name         = "a1a-52161-dev-rg-estimates-eus2-02"
key_vault_id                = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-estimates-eus2-02/providers/Microsoft.KeyVault/vaults/a1a52161tstkvinfeus201"
app_key_vault_id            = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-estimates-eus2-02/providers/Microsoft.KeyVault/vaults/a1a52161tstkvappeus201"

# ENTRA group object IDs for VM login roles
vm_user_login_group_id  = "809c7b6a-9d9a-470c-a04c-d0a1eb129561"
vm_admin_login_group_id = "e9a02959-ff76-4700-8b9f-bb5b2b6ca7e7"

#### Storage Account Configuration ####
storage_account_config = {
  # Main storage account for Linux VMs file shares
  linux_shared = {
    context                                = "app"
    instance                               = "01"
    account_tier                           = "Standard"
    persist_access_key                     = true
    enable_key_access                      = true
    account_replication_type               = "ZRS"
    kv_secret_expiration_date              = "2026-12-31T23:59:59Z"
    enable_file_share_AADDS_authentication = false
    # Specify which VMs' identities to use for this storage account
    vm_identity_keys = ["ec_appsrv01", "ec_appsrv02", "ec_ftpsrv01"]
    # Primary VM identity for customer managed key (use first VM)
    primary_vm_identity_key = "ec_appsrv01"
    private_endpoint_config = {
      is_manual_connection = false
      static_ip_required   = false
    }
  }
}

############################################################# linux VM ########################################################################

linux_vm_config = {
  ec_appsrv01 = {
    context                        = "appsrv"
    instance                       = "01"
    context_private_key            = "pvkappsrv"
    instance_private_key           = "01"
    context_public_key             = "pbkappsrv"
    instance_public_key            = "01"
    admin_username                 = "lsegadmin"
    size                           = "Standard_E16ads_v5"
    zone                           = "1"
    proximity_placement_group_id   = null
    secure_boot_enabled            = true
    priority                       = "Regular"
    timezone                       = "Eastern Standard Time"
    license_type                   = null
    dedicated_host_id              = null
    dedicated_host_group_id        = null
    username                       = "lsegadmin"
    computer_name                  = "esttstappsrv01"
    vtpm_enabled                   = true
    user_data                      = null
    enable_systemassigned_identity = true
    source_image_id                = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-estimates-eus2-01/providers/Microsoft.Compute/galleries/a1a52161devsigvmimageeus201/images/rhel-server-9-standard-x64-application/versions/1.0.0"
    os_disk = {
      storage_account_type = "Premium_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "128"
    }
    network_interface = {
      dns_servers                   = null
      enable_accelerated_networking = null
      ip_configurations = [
        {
          primary                                            = true
          private_ip_address                                 = null
          private_ip_address_version                         = null
          private_ip_address_allocation                      = null
          gateway_load_balancer_frontend_ip_configuration_id = null
        }
      ]
    }
    disk_encryption_set = {
      context         = "appsrv"
      instance        = "01"
      key_type        = "RSA-HSM"
      key_size        = "2048"
      expiration_date = "2026-08-25T16:10:00Z"
    }
    termination_notification = {
      enabled = false
      timeout = "PT5M"
    }
    key_vault_config = {
      deploy_kv_and_pe               = false
      kv_secret_expiration_in_months = 12
      key_vault_id                   = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-estimates-eus2-02/providers/Microsoft.KeyVault/vaults/a1a52161tstkvinfeus201"
      network_acls = {
        bypass = "AzureServices"
      }
      private_endpoint = {
        static_ip_required = false
      }
    }
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-nonrtbl-eus2-01/subnets/a1a-52161-tst-snet-ecapp-eus2-01"
    }
    azure_backup = {
      enable_backup             = false
      create_backup_vault       = false
      create_disk_backup_policy = true
      context                   = "appsrv"
      instance                  = "01"
      identity_type             = "SystemAssigned"
      expiration_date           = "2026-08-27T09:49:40Z"
      disk_backup_policy        = null
    }
    storage_account_key = "linux_shared"
    file_share_config = {
      quota = 150
    }
    mount_azure_files = true
    mount_point       = "/app"
    mount_uid         = 1010
    mount_gid         = 100
  }
  ec_appsrv02 = {
    context                        = "appsrv"
    instance                       = "02"
    context_private_key            = "pvkappsrv"
    instance_private_key           = "02"
    context_public_key             = "pbkappsrv"
    instance_public_key            = "02"
    admin_username                 = "lsegadmin"
    size                           = "Standard_E16ads_v5"
    zone                           = "1"
    proximity_placement_group_id   = null
    secure_boot_enabled            = true
    priority                       = "Regular"
    timezone                       = "Eastern Standard Time"
    license_type                   = null
    dedicated_host_id              = null
    dedicated_host_group_id        = null
    username                       = "lsegadmin"
    computer_name                  = "esttstappsrv02"
    vtpm_enabled                   = true
    user_data                      = null
    enable_systemassigned_identity = true
    source_image_id                = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-estimates-eus2-01/providers/Microsoft.Compute/galleries/a1a52161devsigvmimageeus201/images/rhel-server-9-standard-x64-application/versions/1.0.0"
    os_disk = {
      storage_account_type = "Premium_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "128"
    }
    network_interface = {
      dns_servers                   = null
      enable_accelerated_networking = null
      ip_configurations = [
        {
          primary                                            = true
          private_ip_address                                 = null
          private_ip_address_version                         = null
          private_ip_address_allocation                      = null
          gateway_load_balancer_frontend_ip_configuration_id = null
        }
      ]
    }
    disk_encryption_set = {
      context         = "appsrv"
      instance        = "02"
      key_type        = "RSA-HSM"
      key_size        = "2048"
      expiration_date = "2026-08-25T16:10:00Z"
    }
    termination_notification = {
      enabled = false
      timeout = "PT5M"
    }
    key_vault_config = {
      deploy_kv_and_pe               = false
      kv_secret_expiration_in_months = 12
      key_vault_id                   = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-estimates-eus2-02/providers/Microsoft.KeyVault/vaults/a1a52161tstkvinfeus201"
      network_acls = {
        bypass = "AzureServices"
      }
      private_endpoint = {
        static_ip_required = false
      }
    }
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-nonrtbl-eus2-01/subnets/a1a-52161-tst-snet-ecapp-eus2-01"
    }
    azure_backup = {
      enable_backup             = false
      create_backup_vault       = false
      create_disk_backup_policy = true
      context                   = "appsrv"
      instance                  = "02"
      identity_type             = "SystemAssigned"
      expiration_date           = "2026-08-27T09:49:40Z"
      disk_backup_policy        = null
    }
    storage_account_key = "linux_shared"
    file_share_config = {
      quota = 150
    }
    mount_azure_files = true
    mount_point       = "/app"
    mount_uid         = 1010
    mount_gid         = 100
  }
  ec_ftpsrv01 = {
    context                        = "ftpsrv"
    instance                       = "01"
    context_private_key            = "pvkftpsrv"
    instance_private_key           = "01"
    context_public_key             = "pbkftpsrv"
    instance_public_key            = "01"
    admin_username                 = "lsegadmin"
    size                           = "Standard_D4as_v5"
    zone                           = "1"
    proximity_placement_group_id   = null
    secure_boot_enabled            = true
    priority                       = "Regular"
    timezone                       = "Eastern Standard Time"
    license_type                   = null
    dedicated_host_id              = null
    dedicated_host_group_id        = null
    username                       = "lsegadmin"
    computer_name                  = "esttstftpsrv01"
    vtpm_enabled                   = true
    user_data                      = null
    enable_systemassigned_identity = true
    source_image_id                = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-estimates-eus2-01/providers/Microsoft.Compute/galleries/a1a52161devsigvmimageeus201/images/rhel-server-9-standard-x64-application/versions/1.0.3"
    os_disk = {
      storage_account_type = "Standard_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "128"
    }
    network_interface = {
      dns_servers                   = null
      enable_accelerated_networking = null
      ip_configurations = [
        {
          primary                                            = true
          private_ip_address                                 = null
          private_ip_address_version                         = null
          private_ip_address_allocation                      = null
          gateway_load_balancer_frontend_ip_configuration_id = null
        }
      ]
    }
    disk_encryption_set = {
      context         = "ftpsrv"
      instance        = "01"
      key_type        = "RSA-HSM"
      key_size        = "2048"
      expiration_date = "2028-08-25T16:10:00Z"
    }
    termination_notification = {
      enabled = false
      timeout = "PT5M"
    }
    key_vault_config = {
      deploy_kv_and_pe               = false
      kv_secret_expiration_in_months = 12
      key_vault_id                   = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-estimates-eus2-01/providers/Microsoft.KeyVault/vaults/a1a52161devkvinfeus201"
      network_acls = {
        bypass = "AzureServices"
      }
      private_endpoint = {
        static_ip_required = false
      }
    }
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-platform-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-rtbl-eus2-01/subnets/a1a-52161-dev-snet-workload-eus2-06"
    }
    azure_backup = {
      enable_backup             = false
      create_backup_vault       = false
      create_disk_backup_policy = true
      context                   = "ftpsrv"
      instance                  = "01"
      identity_type             = "SystemAssigned"
      expiration_date           = "2028-08-27T09:49:40Z"
      disk_backup_policy        = null
    }
    storage_account_key = "linux_shared"
    file_share_config = {
      quota = 150
    }
    mount_azure_files = true
    mount_point       = "/app"
    mount_uid         = 1010
    mount_gid         = 100
  }
}