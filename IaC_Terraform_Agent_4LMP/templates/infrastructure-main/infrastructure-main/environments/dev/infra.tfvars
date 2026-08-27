org_id                = "a1a"
app_id                = "51847"
location              = "eastus2"
environment           = "dev"
extension_environment = "dev"

tags = {
  cloud_provider      = "azure"
  opt-datadog         = "require"
  mnd-applicationname = "datacloud"
}

#### Platform and Application Dependencies ####
ingestion_resource_group_name = "a1a-51847-dev-rg-ingestion-eus2-03"
adc_resource_group_name       = "a1a-51847-dev-rg-datacloud-eus2-01"
platform_resource_group_name  = "a1a-51847-dev-rg-platform-eus2-01"
shared_resource_group_name    = "a1a-51847-dev-rg-shared-eus2-01"
key_vault_name                = "a1a51847devkvadceus201"
platform_rt_vnet_name         = "a1a-51847-dev-vnet-rtbl-eus2-01"
workload_subnet_name          = "a1a-51847-dev-snet-workload-eus2-06"
shared_nrt_vnet_name          = "a1a-51847-dev-vnet-nonrtbl-eus2-01"
ingestion_subnet_name         = "a1a-51847-dev-snet-ingestion-eus2-01"
bams_user_secret_name         = "bams-user"
bams_password_secret_name     = "bams-password"

############################################################# linux VM ########################################################################
admin_username                   = "adminuser"
username                         = "adminuser"
identity_type                    = "SystemAssigned, UserAssigned"
des_identity_type                = "SystemAssigned, UserAssigned"
script_env                       = "AZ.DEV"
golden_image_id                  = "/subscriptions/0d03b955-d606-4f60-8550-79c3b700ab22/resourceGroups/a1a-51386-dev-rg-gimage-uks-01/providers/Microsoft.Compute/galleries/a1a51386devgalgimageuks02/images/rhel-server-8.8-standard-x64-base"
deploy_proximity_placement_group = true # can have ppg only if there is no capacity reservation, if capacity reservation is enabled then ppg cannot be enabled
capacity_reservation_groups      = null # CRGs are only provisioned in prd/eastus2 and prd/gwc via base-infra

network_interface = {
  accelerated_networking_enabled = null
  ip_configurations = [
    {
      primary = true
    }
  ]
}

termination_notification = {
  enabled = false
  timeout = "PT5M"
}

azure_backup = {
  enable_backup   = false
  expiration_date = "2026-01-27T09:49:40Z"
}

super_private_dns_environment = "test.dev"

linux_vm_config = {
  vm01 = {
    routable      = false
    context       = "ingfull"
    instance      = "001"
    computer_name = "ingfull01"
    zone          = null
    disk_encryption_set = {
      context         = "ingfull01"
      instance        = "001"
      key_type        = "RSA-HSM"
      key_size        = "2048"
      expiration_date = "2027-03-11T16:10:00Z"
    }
    os_disk = {
      storage_account_type = "StandardSSD_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "127"
    }
    managed_disk = {
      disk01 = {
        context              = "ingfull01"
        instance             = "001"
        disk_size_gb         = "4096"
        storage_account_type = "StandardSSD_LRS"
        enable_disk_backup   = false
        caching              = "None"
        lun                  = 0
      }
    }
    size = "Standard_E16ads_v5"
  },
  vm02 = {
    routable      = false
    context       = "ingfull"
    instance      = "002"
    computer_name = "ingfull02"
    zone          = null
    disk_encryption_set = {
      context         = "ingfull02"
      instance        = "002"
      key_type        = "RSA-HSM"
      key_size        = "2048"
      expiration_date = "2027-03-11T16:10:00Z"
    }
    os_disk = {
      storage_account_type = "StandardSSD_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "127"
    }
    managed_disk = {
      disk01 = {
        context              = "ingfull02"
        instance             = "001"
        disk_size_gb         = "4096"
        storage_account_type = "StandardSSD_LRS"
        enable_disk_backup   = false
        caching              = "None"
        lun                  = 0
      }
    }
    size = "Standard_E16ads_v5"
  },
  vm03 = {
    routable      = false
    context       = "ingincr"
    instance      = "001"
    computer_name = "ingincr01"
    zone          = null
    disk_encryption_set = {
      context         = "ingincr01"
      instance        = "001"
      key_type        = "RSA-HSM"
      key_size        = "2048"
      expiration_date = "2027-03-11T16:10:00Z"
    }
    os_disk = {
      storage_account_type = "StandardSSD_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "127"
    }
    managed_disk = {
      disk01 = {
        context              = "ingincr01"
        instance             = "001"
        disk_size_gb         = "1024"
        storage_account_type = "StandardSSD_LRS"
        enable_disk_backup   = false
        caching              = "None"
        lun                  = 0
      }
    }
    size = "Standard_E16ads_v5"
  },
  vm04 = {
    routable      = false
    context       = "ingincr"
    instance      = "002"
    computer_name = "ingincr02"
    zone          = null
    disk_encryption_set = {
      context         = "ingincr02"
      instance        = "002"
      key_type        = "RSA-HSM"
      key_size        = "2048"
      expiration_date = "2027-03-11T16:10:00Z"
    }
    os_disk = {
      storage_account_type = "StandardSSD_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "127"
    }
    managed_disk = {
      disk01 = {
        context              = "ingincr02"
        instance             = "001"
        disk_size_gb         = "1024"
        storage_account_type = "StandardSSD_LRS"
        enable_disk_backup   = false
        caching              = "None"
        lun                  = 0
      }
    }
    size = "Standard_E16ads_v5"
  },
  vm05 = {
    routable      = false
    context       = "ingfull"
    instance      = "003"
    computer_name = "ingfull03"
    zone          = null
    disk_encryption_set = {
      context         = "ingfull03"
      instance        = "002"
      key_type        = "RSA-HSM"
      key_size        = "2048"
      expiration_date = "2027-03-11T16:10:00Z"
    }
    os_disk = {
      storage_account_type = "StandardSSD_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "127"
    }
    managed_disk = {
      disk01 = {
        context              = "ingfull03"
        instance             = "001"
        disk_size_gb         = "4096"
        storage_account_type = "StandardSSD_LRS"
        enable_disk_backup   = false
        caching              = "None"
        lun                  = 0
      }
    }
    size = "Standard_E16ads_v5"
  },
  vm06 = {
    routable      = false
    context       = "ingfull"
    instance      = "004"
    computer_name = "ingfull04"
    zone          = null
    disk_encryption_set = {
      context         = "ingfull04"
      instance        = "002"
      key_type        = "RSA-HSM"
      key_size        = "2048"
      expiration_date = "2027-03-11T16:10:00Z"
    }
    os_disk = {
      storage_account_type = "StandardSSD_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "127"
    }
    managed_disk = {
      disk01 = {
        context              = "ingfull04"
        instance             = "001"
        disk_size_gb         = "4096"
        storage_account_type = "StandardSSD_LRS"
        enable_disk_backup   = false
        caching              = "None"
        lun                  = 0
      }
    }
    size = "Standard_E16ads_v5"
  },
  vm08 = {
    routable      = true
    context       = "ingfull"
    instance      = "006"
    computer_name = "ingfull06"
    zone          = null
    disk_encryption_set = {
      context         = "ingfull06"
      instance        = "002"
      key_type        = "RSA-HSM"
      key_size        = "2048"
      expiration_date = "2027-03-11T16:10:00Z"
    }
    os_disk = {
      storage_account_type = "StandardSSD_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "127"
    }
    managed_disk = {
      disk01 = {
        context              = "ingfull06"
        instance             = "001"
        disk_size_gb         = "4096"
        storage_account_type = "StandardSSD_LRS"
        enable_disk_backup   = false
        caching              = "None"
        lun                  = 0
      }
    }
    size = "Standard_E16ads_v5"
  },
  /*
  vm09 = {
    routable      = true
    context       = "ingfull"
    instance      = "007"
    computer_name = "ingfull07"
    zone          = null
    disk_encryption_set = {
      context         = "ingfull07"
      instance        = "002"
      key_type        = "RSA-HSM"
      key_size        = "2048"
      expiration_date = "2027-03-11T16:10:00Z"
    }
    os_disk = {
      storage_account_type = "StandardSSD_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "127"
    }
    managed_disk = {
      disk01 = {
        context              = "ingfull07"
        instance             = "001"
        disk_size_gb         = "4096"
        storage_account_type = "StandardSSD_LRS"
        enable_disk_backup   = false
        caching              = "None"
        lun                  = 0
      }
    }
    size = "Standard_E16ads_v5"
  },
  */
  vm10 = {
    routable      = true
    context       = "ingincr"
    instance      = "008"
    computer_name = "ingincr08"
    zone          = null
    disk_encryption_set = {
      context         = "ingincr08"
      instance        = "002"
      key_type        = "RSA-HSM"
      key_size        = "2048"
      expiration_date = "2027-03-11T16:10:00Z"
    }
    os_disk = {
      storage_account_type = "StandardSSD_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "127"
    }
    managed_disk = {
      disk01 = {
        context              = "ingincr08"
        instance             = "001"
        disk_size_gb         = "4096"
        storage_account_type = "StandardSSD_LRS"
        enable_disk_backup   = false
        caching              = "None"
        lun                  = 0
      }
    }
    size = "Standard_E16ads_v5"
  },
  vm11 = {
    routable      = true
    context       = "ingincr"
    instance      = "009"
    computer_name = "ingincr09"
    zone          = null
    disk_encryption_set = {
      context         = "ingincr09"
      instance        = "002"
      key_type        = "RSA-HSM"
      key_size        = "2048"
      expiration_date = "2027-03-11T16:10:00Z"
    }
    os_disk = {
      storage_account_type = "StandardSSD_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "127"
    }
    managed_disk = {
      disk01 = {
        context              = "ingincr09"
        instance             = "001"
        disk_size_gb         = "4096"
        storage_account_type = "StandardSSD_LRS"
        enable_disk_backup   = false
        caching              = "None"
        lun                  = 0
      }
    }
    size = "Standard_E16ads_v5"
  }
  vm_test = {
    routable      = false
    context       = "tst02"
    instance      = "001"
    computer_name = "tst02"
    zone          = "1"
    disk_encryption_set = {
      context         = "tst02"
      instance        = "001"
      key_type        = "RSA-HSM"
      key_size        = "2048"
      expiration_date = "2027-03-11T16:10:00Z"
    }
    os_disk = {
      storage_account_type = "StandardSSD_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "127"
    }
    managed_disk = {
      disk01 = {
        context              = "tst02"
        instance             = "001"
        disk_size_gb         = "4096"
        storage_account_type = "StandardSSD_LRS"
        enable_disk_backup   = false
        caching              = "None"
        lun                  = 0
        availability_zone    = "1"
      }
    }
    size = "Standard_E16ads_v5"
  }
}

