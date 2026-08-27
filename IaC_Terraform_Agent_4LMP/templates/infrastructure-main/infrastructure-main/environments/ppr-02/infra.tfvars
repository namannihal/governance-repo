org_id                = "a1a"
app_id                = "51847"
location              = "uksouth"
environment           = "ppr"
extension_environment = "ppr-02"

tags = {
  cloud_provider      = "azure"
  opt-datadog         = "require"
  mnd-applicationname = "datacloud"
}

#### Platform and Application Dependencies ####
ingestion_resource_group_name = "a1a-51847-ppr-rg-ingestion-uks-03"
adc_resource_group_name       = "a1a-51847-ppr-rg-datacloud-uks-01"
platform_resource_group_name  = "a1a-51847-ppr-rg-platform-uks-01"
shared_resource_group_name    = "a1a-51847-ppr-rg-shared-uks-01"
key_vault_name                = "a1a51847pprkvadcuks01"
platform_rt_vnet_name         = "a1a-51847-ppr-vnet-rtbl-uks-01"
workload_subnet_name          = "a1a-51847-ppr-snet-workload-uks-06"
shared_nrt_vnet_name          = "a1a-51847-ppr-vnet-nonrtbl-uks-01"
ingestion_subnet_name         = "a1a-51847-ppr-snet-ingestion-uks-01"
bams_user_secret_name         = "bams-user"
bams_password_secret_name     = "bams-password"

############################################################# linux VM ########################################################################
admin_username                   = "adminuser"
username                         = "adminuser"
identity_type                    = "SystemAssigned, UserAssigned"
des_identity_type                = "SystemAssigned, UserAssigned"
script_env                       = "AZ.PPR.UKS"
golden_image_id                  = "/subscriptions/0048b14f-cb7c-4a41-a4f9-9613cbadccac/resourceGroups/a1a-51386-ppr-rg-gimage-uks-01/providers/Microsoft.Compute/galleries/a1a51386pprgalgimageuks01/images/rhel-server-8.8-standard-x64-base"
deploy_proximity_placement_group = true # can have ppg only if there is no capacity reservation, if capacity reservation is enabled then ppg cannot be enabled
capacity_reservation_groups      = null # CRGs are only provisioned in prd/eastus2 and prd/gwc via base-infra

network_interface = {
  accelerated_networking_enabled = true
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

super_private_dns_environment = "staging.ppr"

linux_vm_config = {
  vm01 = {
    routable      = false
    context       = "ingfull"
    instance      = "001"
    computer_name = "ingfull01"
    zone          = "1"
    disk_encryption_set = {
      context         = "ingfull01"
      instance        = "001"
      key_type        = "RSA-HSM"
      key_size        = "2048"
      expiration_date = "2026-03-11T16:10:00Z"
    }
    os_disk = {
      storage_account_type = "Premium_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "127"
    }
    managed_disk = {
      disk01 = {
        context              = "ingfull01"
        instance             = "001"
        disk_size_gb         = "4096"
        storage_account_type = "Premium_LRS"
        enable_disk_backup   = false
        caching              = "None"
        lun                  = 0
        availability_zone    = "1"
      }
    }
    size = "Standard_E16as_v5"
  },
  vm02 = {
    routable      = false
    context       = "ingfull"
    instance      = "002"
    computer_name = "ingfull02"
    zone          = "2"
    disk_encryption_set = {
      context         = "ingfull02"
      instance        = "001"
      key_type        = "RSA-HSM"
      key_size        = "2048"
      expiration_date = "2026-03-11T16:10:00Z"
    }
    os_disk = {
      storage_account_type = "Premium_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "127"
    }
    managed_disk = {
      disk01 = {
        context              = "ingfull02"
        instance             = "001"
        disk_size_gb         = "4096"
        storage_account_type = "Premium_LRS"
        enable_disk_backup   = false
        caching              = "None"
        lun                  = 0
        availability_zone    = "2"
      }
    }
    size = "Standard_E16as_v5"
  },
  vm03 = {
    routable      = false
    context       = "ingfull"
    instance      = "003"
    computer_name = "ingfull03"
    zone          = "3"
    disk_encryption_set = {
      context         = "ingfull03"
      instance        = "001"
      key_type        = "RSA-HSM"
      key_size        = "2048"
      expiration_date = "2026-03-11T16:10:00Z"
    }
    os_disk = {
      storage_account_type = "Premium_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "127"
    }
    managed_disk = {
      disk01 = {
        context              = "ingfull03"
        instance             = "001"
        disk_size_gb         = "4096"
        storage_account_type = "Premium_LRS"
        enable_disk_backup   = false
        caching              = "None"
        lun                  = 0
        availability_zone    = "3"
      }
    }
    size = "Standard_E16as_v5"
  },
  vm04 = {
    routable      = false
    context       = "ingfull"
    instance      = "004"
    computer_name = "ingfull04"
    zone          = "1"
    disk_encryption_set = {
      context         = "ingfull04"
      instance        = "001"
      key_type        = "RSA-HSM"
      key_size        = "2048"
      expiration_date = "2026-03-11T16:10:00Z"
    }
    os_disk = {
      storage_account_type = "Premium_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "127"
    }
    managed_disk = {
      disk01 = {
        context              = "ingfull04"
        instance             = "001"
        disk_size_gb         = "4096"
        storage_account_type = "Premium_LRS"
        enable_disk_backup   = false
        caching              = "None"
        lun                  = 0
        availability_zone    = "1"
      }
    }
    size = "Standard_E16as_v5"
  },
  vm05 = {
    routable      = true
    context       = "ingfull"
    instance      = "005"
    computer_name = "ingfull05"
    zone          = "1"
    disk_encryption_set = {
      context         = "ingfull05"
      instance        = "001"
      key_type        = "RSA-HSM"
      key_size        = "2048"
      expiration_date = "2026-03-11T16:10:00Z"
    }
    os_disk = {
      storage_account_type = "Premium_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "127"
    }
    managed_disk = {
      disk01 = {
        context              = "ingfull05"
        instance             = "001"
        disk_size_gb         = "4096"
        storage_account_type = "Premium_LRS"
        enable_disk_backup   = false
        caching              = "None"
        lun                  = 0
        availability_zone    = "1"
      }
    }
    size = "Standard_E16as_v5"
  },
  vm06 = {
    routable      = false
    context       = "ingincr"
    instance      = "001"
    computer_name = "ingincr01"
    zone          = "1"
    disk_encryption_set = {
      context         = "ingincr01"
      instance        = "001"
      key_type        = "RSA-HSM"
      key_size        = "2048"
      expiration_date = "2026-03-11T16:10:00Z"
    }
    os_disk = {
      storage_account_type = "Premium_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "127"
    }
    managed_disk = {
      disk01 = {
        context              = "ingincr01"
        instance             = "001"
        disk_size_gb         = "1024"
        storage_account_type = "Premium_LRS"
        enable_disk_backup   = false
        caching              = "None"
        lun                  = 0
        availability_zone    = "1"
      }
    }
    size = "Standard_E16as_v5"
  },
  vm07 = {
    routable      = false
    context       = "ingincr"
    instance      = "002"
    computer_name = "ingincr02"
    zone          = "2"
    disk_encryption_set = {
      context         = "ingincr02"
      instance        = "001"
      key_type        = "RSA-HSM"
      key_size        = "2048"
      expiration_date = "2026-03-11T16:10:00Z"
    }
    os_disk = {
      storage_account_type = "Premium_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "127"
    }
    managed_disk = {
      disk01 = {
        context              = "ingincr02"
        instance             = "001"
        disk_size_gb         = "1024"
        storage_account_type = "Premium_LRS"
        enable_disk_backup   = false
        caching              = "None"
        lun                  = 0
        availability_zone    = "2"
      }
    }
    size = "Standard_E16as_v5"
  },
  vm08 = {
    routable      = false
    context       = "ingincr"
    instance      = "003"
    computer_name = "ingincr03"
    zone          = "3"
    disk_encryption_set = {
      context         = "ingincr03"
      instance        = "001"
      key_type        = "RSA-HSM"
      key_size        = "2048"
      expiration_date = "2026-03-11T16:10:00Z"
    }
    os_disk = {
      storage_account_type = "Premium_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "127"
    }
    managed_disk = {
      disk01 = {
        context              = "ingincr03"
        instance             = "001"
        disk_size_gb         = "1024"
        storage_account_type = "Premium_LRS"
        enable_disk_backup   = false
        caching              = "None"
        lun                  = 0
        availability_zone    = "3"
      }
    }
    size = "Standard_E16as_v5"
  },
  vm09 = {
    routable      = false
    context       = "ingincr"
    instance      = "004"
    computer_name = "ingincr04"
    zone          = "1"
    disk_encryption_set = {
      context         = "ingincr04"
      instance        = "001"
      key_type        = "RSA-HSM"
      key_size        = "2048"
      expiration_date = "2026-03-11T16:10:00Z"
    }
    os_disk = {
      storage_account_type = "Premium_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "127"
    }
    managed_disk = {
      disk01 = {
        context              = "ingincr04"
        instance             = "001"
        disk_size_gb         = "1024"
        storage_account_type = "Premium_LRS"
        enable_disk_backup   = false
        caching              = "None"
        lun                  = 0
        availability_zone    = "1"
      }
    }
    size = "Standard_E16as_v5"
  },
  vm10 = {
    routable      = false
    context       = "ingincr"
    instance      = "005"
    computer_name = "ingincr05"
    zone          = "2"
    disk_encryption_set = {
      context         = "ingincr05"
      instance        = "001"
      key_type        = "RSA-HSM"
      key_size        = "2048"
      expiration_date = "2026-03-11T16:10:00Z"
    }
    os_disk = {
      storage_account_type = "Premium_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "127"
    }
    managed_disk = {
      disk01 = {
        context              = "ingincr05"
        instance             = "001"
        disk_size_gb         = "1024"
        storage_account_type = "Premium_LRS"
        enable_disk_backup   = false
        caching              = "None"
        lun                  = 0
        availability_zone    = "2"
      }
    }
    size = "Standard_E16as_v5"
  },
  vm11 = {
    routable      = false
    context       = "ingincr"
    instance      = "006"
    computer_name = "ingincr06"
    zone          = "3"
    disk_encryption_set = {
      context         = "ingincr06"
      instance        = "001"
      key_type        = "RSA-HSM"
      key_size        = "2048"
      expiration_date = "2026-03-11T16:10:00Z"
    }
    os_disk = {
      storage_account_type = "Premium_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "127"
    }
    managed_disk = {
      disk01 = {
        context              = "ingincr06"
        instance             = "001"
        disk_size_gb         = "1024"
        storage_account_type = "Premium_LRS"
        enable_disk_backup   = false
        caching              = "None"
        lun                  = 0
        availability_zone    = "3"
      }
    }
    size = "Standard_E16as_v5"
  },
  vm12 = {
    routable      = false
    context       = "ingincr"
    instance      = "007"
    computer_name = "ingincr07"
    zone          = "1"
    disk_encryption_set = {
      context         = "ingincr07"
      instance        = "001"
      key_type        = "RSA-HSM"
      key_size        = "2048"
      expiration_date = "2026-03-11T16:10:00Z"
    }
    os_disk = {
      storage_account_type = "Premium_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "127"
    }
    managed_disk = {
      disk01 = {
        context              = "ingincr07"
        instance             = "001"
        disk_size_gb         = "1024"
        storage_account_type = "Premium_LRS"
        enable_disk_backup   = false
        caching              = "None"
        lun                  = 0
        availability_zone    = "1"
      }
    }
    size = "Standard_E16as_v5"
  },
  vm13 = {
    routable      = true
    context       = "ingincr"
    instance      = "008"
    computer_name = "ingincr08"
    zone          = "1"
    disk_encryption_set = {
      context         = "ingincr08"
      instance        = "001"
      key_type        = "RSA-HSM"
      key_size        = "2048"
      expiration_date = "2026-03-11T16:10:00Z"
    }
    os_disk = {
      storage_account_type = "Premium_LRS"
      caching              = "ReadWrite"
      disk_size_gb         = "127"
    }
    managed_disk = {
      disk01 = {
        context              = "ingincr08"
        instance             = "001"
        disk_size_gb         = "1024"
        storage_account_type = "Premium_LRS"
        enable_disk_backup   = false
        caching              = "None"
        lun                  = 0
        availability_zone    = "1"
      }
    }
    size = "Standard_E16as_v5"
  }
}