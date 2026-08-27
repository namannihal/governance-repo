org_id             = "a1a"
app_id             = "52161"
location           = "eastus2"
secondary_location = "centralus"
environment        = "prd"

sql_mi = {
  sqlmi_eadb = {
    instance               = "01"
    context                = "eadb"
    create_role_assignment = true

    #### MI-specific Compute & SKU ####
    license_type       = "BasePrice"
    sku_name           = "GP_Gen5"
    storage_size_in_gb = 10240
    vcores             = 24
    timezone_id        = "Eastern Standard Time"
    # collation          = "SQL_Latin1_General_CP1_CI_AS"
    proxy_override = "Default"

    #### MI-specific Failover & HA ####
    failover_enabled                          = true
    readonly_endpoint_failover_policy_enabled = false
    zone_redundant_enabled                    = false
    failover_zone_redundant_enabled           = false
    secondary_type                            = "Geo"
    read_write_endpoint_failover_policy = {
      mode          = "Manual"
      grace_minutes = null
    }

    #### MI-specific Firewall ####
    firewall_private_ip_address          = "10.117.216.68"
    firewall_private_ip_address_failover = "10.150.66.68"

    #### MI-specific Backup ####
    storage_account_type          = "GRS"
    failover_storage_account_type = "GRS"
    # storage_GZRS_enabled          = false
    # failover_storage_GZRS_enabled = true

    #### MI-specific Keys & Encryption ####
    expiration_date       = "2028-11-22T00:00:00Z"
    auto_rotation_enabled = true
    key_type              = "RSA-HSM"
    key_size              = 2048

    #### MI-specific Authentication & Admin ####
    administrator_login            = "lsegadmin"
    enable_entra_id_authentication = true # need additional permissions to enable this.
    azuread_authentication_only    = false
    admin_email                    = "EAC-DB-ADMIN-PRD"
    admin_object_id                = "ad756dec-e9e7-47d2-8631-c5ee582d0760"

    #### MI-specific Security & Vulnerability ####
    enable_vulnerability_assessment = false
    security_alert = {
      security_alert_enabled       = false
      disabled_alerts              = ["Sql_Injection"]
      retention_days               = 10
      email_account_admins_enabled = true
      email_addresses              = ["security@lseg.com"]
      enabled                      = false
    }
    recurring_scans = {
      recurring_scans_enabled = true
      recurring_scans_admins  = true
      recurring_scans_email   = ["security@lseg.com"]
    }

    #### MI-specific Network ####
    containers = {
      context  = "eadb"
      instance = "01"
    }
    network_config = {
      context                                  = "eaddb"
      instance                                 = "01"
      deploy_delegated_subnet                  = true
      deploy_delegated_subnet_failover         = true
      delegated_subnet_address_prefix          = "100.72.11.0/26"
      delegated_subnet_address_prefix_failover = "100.69.11.0/26"
      privateendpoint_subnet_id                = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-prd-vnet-nonrtbl-eus2-01/subnets/a1a-52161-prd-snet-eapec-eus2-01"
      privateendpoint_subnet_id_failover       = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-prd-vnet-nonrtbl-cus-01/subnets/a1a-52161-prd-snet-eapec-cus-01"
    }
    deploy_sqlmi_pe          = true
    deploy_sqlmi_pe_failover = true
    # deploy_sqlmi_pdns        = true
    # private_dns_zone_name    = "17dfbaf610dd.database.windows.net"
    private_endpoint = {
      context  = "eadb"
      instance = "01"
      soa_record = {
        email = "host.microsoft.com"
      }
      private_dns_a_record = {
        name = "eadb"
        ttl  = 300
      }
    }
    private_endpoint_failover = {
      context  = "eadb"
      instance = "01"
      soa_record = {
        email = "host.microsoft.com"
      }
      private_dns_a_record = {
        name = "eadb"
        ttl  = 300
      }
    }

    #### MI-specific Storage Account ####
    storage_config = {
      context                                = "eadb"
      context_failover                       = "eadb"
      instance                               = "01"
      instance_failover                      = "01"
      deploy_sa_and_pe                       = true
      deploy_sa_and_pe_failover              = true
      enable_file_share_AADDS_authentication = false
      customer_managed_key = {
        expiration_date = "2028-11-22T00:00:00Z"
      }
    }

    #### MI-specific Database Variables ####
    mssqlmi_db_variables = {
      main_db = {
        context        = "mdb"
        instance       = "01"
        retention_days = 35
        long_term_retention_policies = {
          policy_1 = {
            weekly_retention  = "P5W"
            monthly_retention = "P12M"
            yearly_retention  = "P7Y"
            week_of_year      = "1"
          }
        }
      }
    }
  }

  sqlmi_ecdb = {
    instance               = "01"
    context                = "ecdb"
    create_role_assignment = true

    #### MI-specific Compute & SKU ####
    license_type       = "BasePrice"
    sku_name           = "GP_Gen5"
    storage_size_in_gb = 10240
    vcores             = 64
    timezone_id        = "Eastern Standard Time"
    proxy_override     = "Default"

    #### MI-specific Failover & HA ####
    failover_enabled                          = true
    readonly_endpoint_failover_policy_enabled = false
    zone_redundant_enabled                    = false
    failover_zone_redundant_enabled           = false
    secondary_type                            = "Geo"
    read_write_endpoint_failover_policy = {
      mode          = "Manual"
      grace_minutes = null
    }

    #### MI-specific Firewall ####
    firewall_private_ip_address          = "10.117.216.68"
    firewall_private_ip_address_failover = "10.150.66.68"

    #### MI-specific Backup ####
    storage_account_type          = "GRS"
    failover_storage_account_type = "GRS"
    # storage_GZRS_enabled          = false
    # failover_storage_GZRS_enabled = false

    #### MI-specific Keys & Encryption ####
    expiration_date       = "2028-11-22T00:00:00Z"
    auto_rotation_enabled = true
    key_type              = "RSA-HSM"
    key_size              = 2048

    #### MI-specific Authentication & Admin ####
    administrator_login            = "lsegadmin"
    enable_entra_id_authentication = true # need additional permissions to enable this.
    azuread_authentication_only    = false
    admin_email                    = "EAC-DB-ADMIN-PRD"
    admin_object_id                = "ad756dec-e9e7-47d2-8631-c5ee582d0760"

    #### MI-specific Security & Vulnerability ####
    enable_vulnerability_assessment = false
    security_alert = {
      security_alert_enabled       = false
      disabled_alerts              = ["Sql_Injection"]
      retention_days               = 10
      email_account_admins_enabled = true
      email_addresses              = ["security@lseg.com"]
      enabled                      = false
    }
    recurring_scans = {
      recurring_scans_enabled = true
      recurring_scans_admins  = true
      recurring_scans_email   = ["security@lseg.com"]
    }

    #### MI-specific Network ####
    containers = {
      context  = "ecdb"
      instance = "01"
    }
    network_config = {
      context                                  = "ecddb"
      instance                                 = "01"
      deploy_delegated_subnet                  = true
      deploy_delegated_subnet_failover         = true
      delegated_subnet_address_prefix          = "100.72.3.128/26"
      delegated_subnet_address_prefix_failover = "100.69.3.128/26"
      privateendpoint_subnet_id                = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-prd-vnet-nonrtbl-eus2-01/subnets/a1a-52161-prd-snet-ecpec-eus2-01"
      privateendpoint_subnet_id_failover       = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-prd-vnet-nonrtbl-cus-01/subnets/a1a-52161-prd-snet-ecpec-cus-01"
    }
    deploy_sqlmi_pe          = true
    deploy_sqlmi_pe_failover = true
    # deploy_sqlmi_pdns        = true
    # private_dns_zone_name    = "008c1cf25a9b.database.windows.net"
    private_endpoint = {
      context  = "ecdb"
      instance = "01"
      soa_record = {
        email = "host.microsoft.com" #Todo: confirm email address for SOA record
      }
      private_dns_a_record = {
        name = "ecdb"
        ttl  = 300
      }
    }
    private_endpoint_failover = {
      context  = "ecdb"
      instance = "001"
      soa_record = {
        email = "host.microsoft.com" #Todo: confirm email address for SOA record
      }
      private_dns_a_record = {
        name = "ecdb"
        ttl  = 300
      }
    }

    #### MI-specific Storage Account ####
    storage_config = {
      context                                = "ecdb"
      context_failover                       = "ecdb"
      instance                               = "001"
      instance_failover                      = "001"
      deploy_sa_and_pe                       = true
      deploy_sa_and_pe_failover              = true
      enable_file_share_AADDS_authentication = false
      customer_managed_key = {
        expiration_date = "2028-11-22T00:00:00Z"
      }
    }

    #### MI-specific Database Variables ####
    mssqlmi_db_variables = {
      main_db = {
        context        = "mdb"
        instance       = "01"
        retention_days = 35
        long_term_retention_policies = {
          policy_1 = {
            weekly_retention  = "P5W"
            monthly_retention = "P12M"
            yearly_retention  = "P7Y"
            week_of_year      = "1"
          }
        }
      }
    }
  }

  sqlmi_eadb_tesmsg = {
    instance               = "01"
    context                = "eatdb"
    create_role_assignment = true

    #### MI-specific Compute & SKU ####
    license_type       = "BasePrice"
    sku_name           = "GP_Gen5"
    storage_size_in_gb = 12000
    vcores             = 24
    timezone_id        = "Eastern Standard Time"
    # collation          = "SQL_Latin1_General_CP1_CI_AS"
    proxy_override = "Default"

    #### MI-specific Failover & HA ####
    failover_enabled                          = true
    readonly_endpoint_failover_policy_enabled = false
    zone_redundant_enabled                    = false
    failover_zone_redundant_enabled           = false
    secondary_type                            = "Geo"
    read_write_endpoint_failover_policy = {
      mode          = "Manual"
      grace_minutes = null
    }

    #### MI-specific Firewall ####
    firewall_private_ip_address          = "10.117.216.68"
    firewall_private_ip_address_failover = "10.150.66.68"

    #### MI-specific Backup ####
    storage_account_type          = "GRS"
    failover_storage_account_type = "GRS"
    # storage_GZRS_enabled          = false
    # failover_storage_GZRS_enabled = true

    #### MI-specific Keys & Encryption ####
    expiration_date       = "2028-11-22T00:00:00Z"
    auto_rotation_enabled = true
    key_type              = "RSA-HSM"
    key_size              = 2048

    #### MI-specific Authentication & Admin ####
    administrator_login            = "lsegadmin"
    enable_entra_id_authentication = true # need additional permissions to enable this.
    azuread_authentication_only    = false
    admin_email                    = "EAC-DB-ADMIN-PRD"
    admin_object_id                = "ad756dec-e9e7-47d2-8631-c5ee582d0760"

    #### MI-specific Security & Vulnerability ####
    enable_vulnerability_assessment = false
    security_alert = {
      security_alert_enabled       = false
      disabled_alerts              = ["Sql_Injection"]
      retention_days               = 10
      email_account_admins_enabled = true
      email_addresses              = ["security@lseg.com"]
      enabled                      = false
    }
    recurring_scans = {
      recurring_scans_enabled = true
      recurring_scans_admins  = true
      recurring_scans_email   = ["security@lseg.com"]
    }

    #### MI-specific Network ####
    containers = {
      context  = "eatdb"
      instance = "01"
    }
    network_config = {
      context                                  = "eatdb"
      instance                                 = "01"
      deploy_delegated_subnet                  = true
      deploy_delegated_subnet_failover         = true
      delegated_subnet_address_prefix          = "100.72.3.192/26"
      delegated_subnet_address_prefix_failover = "100.69.3.192/26"
      privateendpoint_subnet_id                = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-prd-vnet-nonrtbl-eus2-01/subnets/a1a-52161-prd-snet-eapec-eus2-01"
      privateendpoint_subnet_id_failover       = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-prd-vnet-nonrtbl-cus-01/subnets/a1a-52161-prd-snet-eapec-cus-01"
    }
    deploy_sqlmi_pe          = true
    deploy_sqlmi_pe_failover = true
    # deploy_sqlmi_pdns        = true
    # private_dns_zone_name    = "17dfbaf610dd.database.windows.net"
    private_endpoint = {
      context  = "eatdb"
      instance = "01"
      soa_record = {
        email = "host.microsoft.com"
      }
      private_dns_a_record = {
        name = "eatdb"
        ttl  = 300
      }
    }
    private_endpoint_failover = {
      context  = "eatdb"
      instance = "01"
      soa_record = {
        email = "host.microsoft.com"
      }
      private_dns_a_record = {
        name = "eatdb"
        ttl  = 300
      }
    }

    #### MI-specific Storage Account ####
    storage_config = {
      context                                = "eatdb"
      context_failover                       = "eatdb"
      instance                               = "02"
      instance_failover                      = "02"
      deploy_sa_and_pe                       = true
      deploy_sa_and_pe_failover              = true
      enable_file_share_AADDS_authentication = false
      customer_managed_key = {
        expiration_date = "2028-11-22T00:00:00Z"
      }
    }

    #### MI-specific Database Variables ####
    mssqlmi_db_variables = {
      main_db = {
        context        = "mdb"
        instance       = "01"
        retention_days = 35
        long_term_retention_policies = {
          policy_1 = {
            weekly_retention  = "P5W"
            monthly_retention = "P12M"
            yearly_retention  = "P7Y"
            week_of_year      = "1"
          }
        }
      }
    }
  }
}

tags = {}

#### Platform and Application Dependencies ####
resource_group_name                    = "a1a-52161-prd-rg-prod-eus2-01"
resource_group_name_secondary_location = "a1a-52161-prd-rg-prod-cus-01"
shared_nrtbl_vnet_id                   = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-prd-vnet-nonrtbl-eus2-01"
shared_nrtbl_vnet_id_failover          = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-prd-vnet-nonrtbl-cus-01"
platform_rtbl_vnet_id                  = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-platform-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-prd-vnet-rtbl-eus2-01"
rt_vnet_pe_subnet_id                   = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-platform-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-prd-vnet-rtbl-eus2-01/subnets/a1a-52161-prd-snet-workload-eus2-06"
rt_vnet_pe_subnet_id_failover          = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-platform-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-prd-vnet-rtbl-cus-01/subnets/a1a-52161-prd-snet-workload-cus-06"

### KV Details (Shared across all MIs) ###
key_vault_config = {
  deploy_kv_and_pe          = false
  deploy_kv_and_pe_failover = false
  key_vault_id              = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-prod-eus2-01/providers/Microsoft.KeyVault/vaults/a1a52161prdkvinfeus201"
  key_vault_id_failover     = "/subscriptions/ff741a46-f3b9-47fb-a826-3c5acb77a45a/resourceGroups/a1a-52161-prd-rg-prod-cus-01/providers/Microsoft.KeyVault/vaults/a1a52161prdkvinfcus01"
  network_acls = {
    bypass = "AzureServices"
  }
}
