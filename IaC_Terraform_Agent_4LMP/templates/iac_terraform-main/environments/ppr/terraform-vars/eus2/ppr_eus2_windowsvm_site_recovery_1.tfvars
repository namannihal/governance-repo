org_id      = "a1a"
app_id      = "52161"
location    = "eastus2"
environment = "ppr"

# Set to true after a failover/failback cycle to re-import data disks into state.
# Reset to false after successful apply.
post_failover_import_disks = false

# ASR cache accounts must have blob and container soft delete disabled before
# replication can be enabled.
manage_asr_cache_soft_delete = true

# Keep this aligned with the live VM so Terraform converges instead of
# repeatedly trying to disable platform-managed VM agent updates.
vm_agent_platform_updates_enabled = true

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

resource_group_id           = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-eus2-01"
shared_nrtbl_vnet_id        = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-eus2-01"
privateendpoint_subnet_id   = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-platform-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-rtbl-eus2-01/subnets/a1a-52161-ppr-snet-workload-eus2-06"
firewall_private_ip_address = "10.239.52.68"
resource_group_name         = "a1a-52161-ppr-rg-estimates-eus2-01"
key_vault_id                = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-eus2-01/providers/Microsoft.KeyVault/vaults/a1a52161pprkvinfeus201"
source_image_id             = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-eus2-01/providers/Microsoft.Compute/galleries/a1a52161pprsigvmimageeus201/images/windows-server-2022-standard-x64-a1a52161pprsivmimageeus201/versions/1.0.0"

enable_entra_auth = true

vm_user_login_group_id  = "16de4838-e860-44a2-873b-0019a529c357"
vm_admin_login_group_id = "c07ff11e-ae4e-4ca9-833e-509adf4f1b4e"

windows_vm = {
  ec_hvprep01 = {
    context  = "hvprep"
    instance = "01"
    zone     = "1"
    network_config = {
      use_existing_subnet = true
      subnet_id           = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-eus2-01/subnets/a1a-52161-ppr-snet-ecapp-eus2-01"
    }
    disk_encryption_set = {
      context         = "hvprep"
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
    size                           = "Standard_D4ads_v5"
    admin_username                 = "lsegadmin"
    computer_name                  = "hvprepppreus201"
    timezone                       = "Eastern Standard Time"
    secure_boot_enabled            = true
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
      enable_backup             = true
      expiration_date           = "2027-03-30T09:49:40Z"
      backup_vault_id           = "<replace-with-backup-rsv-resource-id>"
      backup_policy_id          = "<replace-with-backup-policy-resource-id>"
      backup_vm_name            = "a1a-52161-ppr-vm-hvprep-eus2-01"
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
    storage_account_config = {
      context                                = "hvpre"
      instance                               = "01"
      account_tier                           = "Standard"
      persist_access_key                     = true
      enable_key_access                      = true
      account_replication_type               = "ZRS"
      kv_secret_expiration_date              = "2028-12-31T23:59:59Z"
      enable_file_share_AADDS_authentication = false
      vm_identity_keys                       = ["ec_hvprep01"]
      primary_vm_identity_key                = "ec_hvprep01"
      private_endpoint_config = {
        subnet_id = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-eus2-01/subnets/a1a-52161-ppr-snet-ecpec-eus2-01"
      }
    }
    file_share_config = {
      name             = "a1a-52161-ppr-sts-hvprep-eus2-01"
      quota            = 1000
      enabled_protocol = "SMB"
    }
    mount_azure_files  = true
    mount_drive_letter = "Z"
  }
}

site_recovery = {
  ec_hvprep01 = {
    context                       = "hvprep"
    instance                      = "01"
    secondary_location            = "centralus"
    resource_group_name_secondary = "a1a-52161-ppr-rg-estimates-cus-01"
    rsv_subnet_id                 = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-cus-01/subnets/a1a-52161-ppr-snet-ecpec-cus-01"
    staging_storage_account_key   = "vmasr"
    storage_account_config = {
      vmasr = {
        context             = "vmasr"
        instance            = "01"
        location            = "eastus2"
        resource_group_name = "a1a-52161-ppr-rg-estimates-eus2-01"
        use_asr_uai_for_cmk = true
        private_endpoint_config = {
          subnet_id = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-eus2-01/subnets/a1a-52161-ppr-snet-ecpec-eus2-01"
        }
      }
      vmasr_cus = {
        context             = "vmasr"
        instance            = "01"
        location            = "centralus"
        resource_group_name = "a1a-52161-ppr-rg-estimates-cus-01"
        use_asr_uai_for_cmk = true
        private_endpoint_config = {
          subnet_id = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-cus-01/subnets/a1a-52161-ppr-snet-eaapp-cus-01"
        }
      }
    }
    primary_network_id                  = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-eus2-01"
    target_network_id                   = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-cus-01"
    target_disk_type                    = "Premium_LRS"
    target_replica_disk_type            = "Premium_LRS"
    target_encryption_set_id            = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-cus-01/providers/Microsoft.Compute/diskEncryptionSets/a1a-52161-ppr-des-hvprep-cus-01"
    key_vault_id_secondary              = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-cus-01/providers/Microsoft.KeyVault/vaults/a1a52161pprkvinfcus01"
    sku                                 = "Standard"
    storage_mode_type                   = "ZoneRedundant"
    cross_region_restore_enabled        = false
    fabric_name                         = "ppr-hvprep-01-pri-fabric"
    fabric_secondary_name               = "ppr-hvprep-01-dr-fabric"
    protection_container_name           = "ppr-hvprep-01-pri-pc"
    protection_container_secondary_name = "ppr-hvprep-01-dr-pc"
    replication_policy_name             = "ppr-hvprep-01-policy"
    container_mapping_name              = "ppr-hvprep-01-pc-map"
    network_mapping_name                = "ppr-hvprep-01-net-map"
    replication_name                    = "a1a-52161-ppr-vm-hvprep-eus2-01-replication"
    target_virtual_machine_name         = "a1a-52161-ppr-vm-hvprep-cus-01"
    expiration_date                     = "2027-05-30T09:49:40Z"
  }
}
