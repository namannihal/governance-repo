org_id      = "a1a"
app_id      = "52161"
location    = "eastus2"
environment = "tst"

# Example configuration for multiple SQL MI instances with different specifications
sql_mi = {
  sqlmi_eadb = {
    instance                                  = "01"
    context                                   = "eadb"
    license_type                              = "BasePrice"
    sku_name                                  = "GP_Gen5"
    timezone_id                               = "Eastern Standard Time"
    storage_size_in_gb                        = 16384
    vcores                                    = 16
    storage_account_type                      = "LRS"
    enable_entra_id_authentication            = false
    administrator_login                       = "lsegadmin"
    expiration_date                           = "2027-04-30T00:00:00Z"
    auto_rotation_enabled                     = true
    enable_vulnerability_assessment           = true
    zone_redundant_enabled                    = false
    failover_enabled                          = false
    readonly_endpoint_failover_policy_enabled = false
    firewall_private_ip_address               = "10.93.196.68"

    containers = {
      context  = "sqleadb"
      instance = "01"
    }

    network_config = {
      deploy_delegated_subnet   = false
      privateendpoint_subnet_id = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-platform-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-rtbl-eus2-01/subnets/a1a-52161-dev-snet-workload-eus2-06"
      delegated_subnet_id       = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-nonrtbl-eus2-01/subnets/a1a-52161-tst-snet-eaddb-eus2-01"
    }

    storage_config = {
      context                   = "eadb"
      instance                  = "01"
      deploy_sa_and_pe          = true
      deploy_sa_and_pe_failover = false
      account_tier              = "Standard"
      account_replication_type  = "LRS"
      account_kind              = "StorageV2"
      access_tier               = "Hot"
      retention_policy_days     = 30
      customer_managed_key = {
        expiration_date = "2027-04-30T00:00:00Z"
      }
      private_endpoints = {
        blob = {
          enable               = true
          is_manual_connection = false
          static_ip_required   = false
        }
      }
    }

    key_vault_config = {
      deploy_kv_and_pe          = false
      deploy_kv_and_pe_failover = false
      key_vault_id              = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-estimates-eus2-02/providers/Microsoft.KeyVault/vaults/a1a52161tstkvinfeus201"
      network_acls = {
        bypass = "AzureServices"
      }
    }

    security_alert = {
      security_alert_enabled       = false
      disabled_alerts              = ["Sql_Injection"]
      retention_days               = 0
      email_account_admins_enabled = false
      email_addresses              = []
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

    private_endpoint = {
      context  = "sqlea"
      instance = "01"
    }
    deploy_sqlmi_pe          = true
    deploy_sqlmi_pe_failover = false
    deploy_sqlmi_pdns        = true

    # Database specific configurations
    mssqlmi_db_variables = {
      main_db = {
        context  = "mdb"
        instance = "01"
        long_term_retention_policies = {
          policy_1 = {
            weekly_retention  = "P8W"
            monthly_retention = "P12M"
            yearly_retention  = "P10Y"
            week_of_year      = 1
          }
        }
      }
    }
  }
  sqlmi_ecdb = {
    context                                   = "ecdb"
    instance                                  = "01"
    license_type                              = "BasePrice"
    sku_name                                  = "GP_Gen5"
    timezone_id                               = "Eastern Standard Time"
    storage_size_in_gb                        = 6144
    vcores                                    = 8
    storage_account_type                      = "LRS"
    enable_entra_id_authentication            = false
    administrator_login                       = "lsegadmin"
    expiration_date                           = "2027-04-30T00:00:00Z"
    auto_rotation_enabled                     = true
    enable_vulnerability_assessment           = true
    zone_redundant_enabled                    = false
    failover_enabled                          = false
    readonly_endpoint_failover_policy_enabled = false
    firewall_private_ip_address               = "10.93.196.68"

    containers = {
      context  = "sqlecdb"
      instance = "01"
    }

    network_config = {
      deploy_delegated_subnet   = false
      privateendpoint_subnet_id = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-platform-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-rtbl-eus2-01/subnets/a1a-52161-dev-snet-workload-eus2-06"
      delegated_subnet_id       = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-nonrtbl-eus2-01/subnets/a1a-52161-tst-snet-ecddb-eus2-01"
    }

    storage_config = {
      context                   = "ecdb"
      instance                  = "001"
      deploy_sa_and_pe          = true
      deploy_sa_and_pe_failover = false
      account_tier              = "Standard"
      account_replication_type  = "LRS"
      account_kind              = "StorageV2"
      access_tier               = "Hot"
      retention_policy_days     = 30
      customer_managed_key = {
        expiration_date = "2027-04-30T00:00:00Z"
      }
      private_endpoints = {
        blob = {
          enable               = true
          is_manual_connection = false
          static_ip_required   = false
        }
      }
    }

    key_vault_config = {
      deploy_kv_and_pe          = false
      deploy_kv_and_pe_failover = false
      key_vault_id              = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-estimates-eus2-02/providers/Microsoft.KeyVault/vaults/a1a52161tstkvinfeus201"
      network_acls = {
        bypass = "AzureServices"
      }
    }

    security_alert = {
      security_alert_enabled       = false
      disabled_alerts              = ["Sql_Injection"]
      retention_days               = 0
      email_account_admins_enabled = false
      email_addresses              = []
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

    private_endpoint = {
      context  = "sqlec"
      instance = "01"
    }
    deploy_sqlmi_pe          = true
    deploy_sqlmi_pe_failover = false
    deploy_sqlmi_pdns        = true

    # Database specific configurations
    mssqlmi_db_variables = {
      main_db = {
        context  = "mdb"
        instance = "01"
        long_term_retention_policies = {
          policy_1 = {
            weekly_retention  = "P8W"
            monthly_retention = "P12M"
            yearly_retention  = "P10Y"
            week_of_year      = 1
          }
        }
      }
    }
  }
}

tags = {
  mnd-applicationid      = "app-52161"
  mnd-applicationname    = "estimates_azure_dbor_dev"
  mnd-costcentre         = "52161"
  mnd-dataclassification = "restricted"
  mnd-envsubtype         = "test"
  mnd-lifecycle          = "live"
  mnd-owner              = "TF-TF-IndiaEstimatesTech@lseg.com"
  mnd-projectcode        = "P011085"
  mnd-supportgroup       = "DEVELOP-ESTIMATES-COLLECT-ICA"
}

#### Platform and Application Dependencies ####
resource_group_name           = "a1a-52161-dev-rg-estimates-eus2-02"
shared_nrtbl_vnet_id          = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-nonrtbl-eus2-01"
shared_nrtbl_vnet_id_failover = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-nonrtbl-eus2-01"
platform_rtbl_vnet_id         = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-nonrtbl-eus2-01"
rt_vnet_pe_subnet_id          = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-platform-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-rtbl-eus2-01/subnets/a1a-52161-dev-snet-workload-eus2-06"