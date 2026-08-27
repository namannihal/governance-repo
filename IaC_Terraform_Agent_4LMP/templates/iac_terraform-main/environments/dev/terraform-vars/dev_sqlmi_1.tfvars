org_id      = "a1a"
app_id      = "52161"
location    = "eastus2"
environment = "dev"

sql_mi = {
  sqlmi_eadb = {
    instance               = "01"
    context                = "eadb"
    create_role_assignment = true

    #### MI-specific Compute & SKU ####
    license_type       = "BasePrice"
    sku_name           = "GP_Gen5"
    storage_size_in_gb = 16384
    vcores             = 16
    timezone_id        = "Eastern Standard Time"
    proxy_override     = "Default"

    #### MI-specific HA ####
    failover_enabled                          = false
    readonly_endpoint_failover_policy_enabled = false
    failover_zone_redundant_enabled           = false
    secondary_type                            = "Geo"
    zone_redundant_enabled                    = false

    #### MI-specific Firewall ####
    firewall_private_ip_address = "10.93.196.68"

    #### MI-specific Backup ####
    storage_account_type = "LRS"
    # failover_storage_account_type = "LRS"
    # storage_GZRS_enabled          = false

    #### MI-specific Keys & Encryption ####
    expiration_date       = "2028-11-22T00:00:00Z"
    auto_rotation_enabled = true
    key_type              = "RSA-HSM"
    key_size              = 2048

    #### MI-specific Authentication & Admin ####
    administrator_login            = "lsegadmin"
    enable_entra_id_authentication = false # need additional permissions to enable this.

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

    read_write_endpoint_failover_policy = {
      mode          = "Automatic"
      grace_minutes = 30
    }

    #### MI-specific Network ####
    containers = {
      context  = "eadb"
      instance = "01"
    }
    network_config = {
      context                         = "eaddb"
      instance                        = "01"
      deploy_delegated_subnet         = true
      delegated_subnet_address_prefix = "100.72.11.0/26"
      privateendpoint_subnet_id       = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-nonrtbl-eus2-01/subnets/a1a-52161-dev-snet-eapec-eus2-01"
    }
    deploy_sqlmi_pe          = true
    deploy_sqlmi_pe_failover = false
    deploy_sqlmi_pdns        = true
    private_endpoint = {
      context  = "eadb"
      instance = "01"
      soa_record = {
        email = "test-host.microsoft.com"
      }
      private_dns_a_record = {
        name = "eadb"
        ttl  = 300
      }
    }
    firewall_private_ip_address_failover = null
    #### MI-specific Storage Account ####
    storage_config = {
      context                                = "eadb"
      instance                               = "01"
      deploy_sa_and_pe                       = true
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
    storage_size_in_gb = 8192
    vcores             = 8
    timezone_id        = "Eastern Standard Time"
    proxy_override     = "Default"

    #### MI-specific HA ####
    failover_enabled                          = false
    readonly_endpoint_failover_policy_enabled = false
    failover_zone_redundant_enabled           = false
    secondary_type                            = "Geo"
    zone_redundant_enabled                    = false

    #### MI-specific Firewall ####
    firewall_private_ip_address = "10.93.196.68"


    #### MI-specific Backup ####
    storage_account_type = "LRS"
    # failover_storage_account_type = "LRS"
    # storage_GZRS_enabled          = false

    #### MI-specific Keys & Encryption ####
    expiration_date       = "2028-11-22T00:00:00Z"
    auto_rotation_enabled = true
    key_type              = "RSA-HSM"
    key_size              = 2048

    #### MI-specific Authentication & Admin ####
    administrator_login            = "lsegadmin"
    enable_entra_id_authentication = false # need additional permissions to enable this.

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

    read_write_endpoint_failover_policy = {
      mode          = "Automatic"
      grace_minutes = 30
    }

    #### MI-specific Network ####
    containers = {
      context  = "ecdb"
      instance = "01"
    }
    network_config = {
      context                         = "ecddb"
      instance                        = "01"
      deploy_delegated_subnet         = true
      delegated_subnet_address_prefix = "100.72.3.128/26"
      privateendpoint_subnet_id       = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-nonrtbl-eus2-01/subnets/a1a-52161-dev-snet-ecpec-eus2-01"
    }
    deploy_sqlmi_pe          = true
    deploy_sqlmi_pe_failover = false
    deploy_sqlmi_pdns        = true
    private_endpoint = {
      context  = "ecdb"
      instance = "01"
    }
    firewall_private_ip_address_failover = null

    #### MI-specific Storage Account ####
    storage_config = {
      context                                = "ecdb"
      instance                               = "02"
      deploy_sa_and_pe                       = true
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
resource_group_name   = "a1a-52161-dev-rg-estimates-eus2-01"
shared_nrtbl_vnet_id  = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-nonrtbl-eus2-01"
platform_rtbl_vnet_id = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-platform-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-rtbl-eus2-01"
rt_vnet_pe_subnet_id  = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-platform-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-rtbl-eus2-01/subnets/a1a-52161-dev-snet-workload-eus2-06"

### KV Details (Shared across all MIs) ###
key_vault_config = {
  deploy_kv_and_pe = false
  key_vault_id     = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-estimates-eus2-01/providers/Microsoft.KeyVault/vaults/a1a52161devkvinfeus201"
  network_acls = {
    bypass = "AzureServices"
  }
}