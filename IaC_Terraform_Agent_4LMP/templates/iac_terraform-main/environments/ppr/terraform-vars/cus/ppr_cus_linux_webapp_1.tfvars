org_id      = "a1a"
app_id      = "52161"
location    = "centralus"
environment = "ppr"
context     = "shared"
instance    = "01"

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

#### Platform and Application Dependencies ####
resource_group_name       = "a1a-52161-ppr-rg-estimates-cus-01"
privateendpoint_subnet_id = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-platform-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-rtbl-cus-01/subnets/a1a-52161-ppr-snet-workload-cus-06"
#### Multiple Shared App Service Plans Configuration ####
appserviceplan_configs = {
  eclinux = {
    context                      = "eclinux"
    instance                     = "01"
    required_for_ase             = false
    sku_name                     = "P3v3"
    os_type                      = "Linux"
    app_service_environment_id   = null
    ase_sku_name                 = null
    worker_count                 = 2
    maximum_elastic_worker_count = null
    per_site_scaling_enabled     = false
    zone_balancing_enabled       = true
    autoscale_enabled            = true
    autoscale_min_capacity       = 2
    autoscale_default_capacity   = 2
    autoscale_max_capacity       = 3
    autoscale_scale_in_cpu       = 30
    autoscale_scale_out_cpu      = 70
  }
}

subscription_id  = "7b8a8ffb-9be5-4786-8ba6-dd328b9d6857"
key_vault_id     = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-cus-01/providers/Microsoft.KeyVault/vaults/a1a52161pprkvappcus01"
webapp_subnet_id = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-cus-01/subnets/a1a-52161-ppr-snet-ecasp1-cus-01"

#### Multiple Web Apps Configuration ####
webapp_config = {
  qdctweb = {
    context  = "qdctweb"
    instance = "01"
    asp_key  = "eclinux" # Use the eclinux ASP
    site_config = {
      always_on                              = true
      api_definition_url                     = null
      api_management_api_id                  = null
      app_command_line                       = null
      app_scale_limit                        = null
      application_insights_connection_string = null
      application_insights_key               = null
      default_documents                      = null
      ftps_state                             = "Disabled"
      health_check_path                      = null
      health_check_eviction_time_in_min      = null
      http2_enabled                          = true
      load_balancing_mode                    = "LeastRequests"
      local_mysql_enabled                    = false
      managed_pipeline_mode                  = "Integrated"
      minimum_tls_version                    = "1.2"
      remote_debugging_enabled               = false
      remote_debugging_version               = null
      scm_minimum_tls_version                = "1.2"
      scm_use_main_ip_restrictions           = false
      use_32_bit_worker                      = false
      vnet_route_all_enabled                 = false
      websockets_enabled                     = false
      worker_count                           = 1
      ip_restrictions                        = []
      scm_ip_restrictions                    = []
      application_stack = {
        java_server         = "TOMCAT"
        java_server_version = "11.0"
        java_version        = "21"
      }
      cors = {
        allowed_origins = [
          "https://mlworkspace.azure.ai"
        ]
        support_credentials = false
      }
    }
    app_settings = {
      "TZ"                                  = "America/New_York"
      "WEBSITE_PORT"                        = "80"
      "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
    }
    connection_strings = [{
      name  = "db_connection_string"
      type  = "SQLServer"
      value = "Data Source=server;Initial Catalog=database;User ID=user;Password=password"
    }]
    key_vault_config = {
      deploy_kv_and_pe               = false
      kv_secret_expiration_in_months = 12
      network_acls = {
        bypass = "AzureServices"
      }
      adf_cmk_expiration_date = "2025-06-22T00:00:00Z"
      adf_key_opts            = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]
    }
    network_config = {
      deploy_delegated_subnet_web_app = false
      delegated_subnet_id_web_app     = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-cus-01/subnets/a1a-52161-ppr-snet-ecasp1-cus-01"
    }
    private_endpoint_config = {
      instance                          = "01"
      is_manual_connection              = false
      static_ip_required                = false
      private_connection_resource_alias = null
      ip_configuration                  = {}
    }
  }
  collectionui = {
    context  = "collection"
    instance = "01"
    asp_key  = "eclinux" # Use the eclinux ASP
    site_config = {
      always_on                              = true
      api_definition_url                     = null
      api_management_api_id                  = null
      app_command_line                       = null
      app_scale_limit                        = null
      application_insights_connection_string = null
      application_insights_key               = null
      default_documents                      = null
      ftps_state                             = "Disabled"
      health_check_path                      = null
      health_check_eviction_time_in_min      = null
      http2_enabled                          = true
      load_balancing_mode                    = "LeastRequests"
      local_mysql_enabled                    = false
      managed_pipeline_mode                  = "Integrated"
      minimum_tls_version                    = "1.2"
      remote_debugging_enabled               = false
      remote_debugging_version               = null
      scm_minimum_tls_version                = "1.2"
      scm_use_main_ip_restrictions           = false
      use_32_bit_worker                      = false
      vnet_route_all_enabled                 = false
      websockets_enabled                     = false
      worker_count                           = 1
      ip_restrictions                        = []
      scm_ip_restrictions                    = []
      application_stack = {
        java_server         = "TOMCAT"
        java_server_version = "11.0"
        java_version        = "21"
      }
      cors = {
        allowed_origins = [
          "https://mlworkspace.azure.ai"
        ]
        support_credentials = false
      }
    }
    app_settings = {
      "TZ"                                  = "America/New_York"
      "WEBSITE_PORT"                        = "80"
      "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
    }
    connection_strings = [{
      name  = "api_connection_string"
      type  = "Custom"
      value = "https://api.example.com/hvp"
    }]
    key_vault_config = {
      deploy_kv_and_pe               = false
      kv_secret_expiration_in_months = 12
      network_acls = {
        bypass = "AzureServices"
      }
      adf_cmk_expiration_date = "2025-06-22T00:00:00Z"
      adf_key_opts            = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]
    }
    network_config = {
      deploy_delegated_subnet_web_app = false
      delegated_subnet_id_web_app     = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-cus-01/subnets/a1a-52161-ppr-snet-ecasp1-cus-01"
    }
    private_endpoint_config = {
      instance                          = "01"
      is_manual_connection              = false
      static_ip_required                = false
      private_connection_resource_alias = null
      ip_configuration                  = {}
    }
  }
  guidance = {
    context  = "guidance"
    instance = "01"
    asp_key  = "eclinux" # Use the eclinux ASP
    site_config = {
      always_on                              = true
      api_definition_url                     = null
      api_management_api_id                  = null
      app_command_line                       = null
      app_scale_limit                        = null
      application_insights_connection_string = null
      application_insights_key               = null
      default_documents                      = null
      ftps_state                             = "Disabled"
      health_check_path                      = null
      health_check_eviction_time_in_min      = null
      http2_enabled                          = true
      load_balancing_mode                    = "LeastRequests"
      local_mysql_enabled                    = false
      managed_pipeline_mode                  = "Integrated"
      minimum_tls_version                    = "1.2"
      remote_debugging_enabled               = false
      remote_debugging_version               = null
      scm_minimum_tls_version                = "1.2"
      scm_use_main_ip_restrictions           = false
      use_32_bit_worker                      = false
      vnet_route_all_enabled                 = false
      websockets_enabled                     = false
      worker_count                           = 1
      ip_restrictions                        = []
      scm_ip_restrictions                    = []
      application_stack = {
        java_server         = "TOMCAT"
        java_server_version = "11.0"
        java_version        = "21"
      }
      cors = {
        allowed_origins = [
          "https://mlworkspace.azure.ai"
        ]
        support_credentials = false
      }
    }
    app_settings = {
      "TZ"                                  = "America/New_York"
      "WEBSITE_PORT"                        = "80"
      "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
    }
    connection_strings = [{
      name  = "api_connection_string"
      type  = "Custom"
      value = "https://api.example.com/hvp"
    }]
    key_vault_config = {
      deploy_kv_and_pe               = false
      kv_secret_expiration_in_months = 12
      network_acls = {
        bypass = "AzureServices"
      }
      adf_cmk_expiration_date = "2025-06-22T00:00:00Z"
      adf_key_opts            = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]
    }
    network_config = {
      deploy_delegated_subnet_web_app = false
      delegated_subnet_id_web_app     = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-cus-01/subnets/a1a-52161-ppr-snet-ecasp1-cus-01"
    }
    private_endpoint_config = {
      instance                          = "01"
      is_manual_connection              = false
      static_ip_required                = false
      private_connection_resource_alias = null
      ip_configuration                  = {}
    }
  }

  brkrxlsrv = {
    context  = "brkrxlsrv"
    instance = "01"
    asp_key  = "eclinux" # Use the eclinux ASP
    site_config = {
      always_on                              = true
      api_definition_url                     = null
      api_management_api_id                  = null
      app_command_line                       = null
      app_scale_limit                        = null
      application_insights_connection_string = null
      application_insights_key               = null
      default_documents                      = null
      ftps_state                             = "Disabled"
      health_check_path                      = null
      health_check_eviction_time_in_min      = null
      http2_enabled                          = true
      load_balancing_mode                    = "LeastRequests"
      local_mysql_enabled                    = false
      managed_pipeline_mode                  = "Integrated"
      minimum_tls_version                    = "1.2"
      remote_debugging_enabled               = false
      remote_debugging_version               = null
      scm_minimum_tls_version                = "1.2"
      scm_use_main_ip_restrictions           = false
      use_32_bit_worker                      = false
      vnet_route_all_enabled                 = false
      websockets_enabled                     = false
      worker_count                           = 1
      ip_restrictions                        = []
      scm_ip_restrictions                    = []
      application_stack = {
        java_server         = "TOMCAT"
        java_server_version = "11.0"
        java_version        = "21"
      }
      cors = {
        allowed_origins = [
          "https://mlworkspace.azure.ai"
        ]
        support_credentials = false
      }
    }
    app_settings = {
      "TZ"                                  = "America/New_York"
      "WEBSITE_PORT"                        = "80"
      "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
    }
    connection_strings = [{
      name  = "api_connection_string"
      type  = "Custom"
      value = "https://api.example.com/hvp"
    }]
    key_vault_config = {
      deploy_kv_and_pe               = false
      kv_secret_expiration_in_months = 12
      network_acls = {
        bypass = "AzureServices"
      }
      adf_cmk_expiration_date = "2025-06-22T00:00:00Z"
      adf_key_opts            = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]
    }
    network_config = {
      deploy_delegated_subnet_web_app = false
      delegated_subnet_id_web_app     = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-cus-01/subnets/a1a-52161-ppr-snet-ecasp1-cus-01"
    }
    private_endpoint_config = {
      instance                          = "01"
      is_manual_connection              = false
      static_ip_required                = false
      private_connection_resource_alias = null
      ip_configuration                  = {}
    }
  }

  brkrui = {
    context  = "brkrui"
    instance = "01"
    asp_key  = "eclinux" # Use the eclinux ASP
    site_config = {
      always_on                              = true
      api_definition_url                     = null
      api_management_api_id                  = null
      app_command_line                       = null
      app_scale_limit                        = null
      application_insights_connection_string = null
      application_insights_key               = null
      default_documents                      = null
      ftps_state                             = "Disabled"
      health_check_path                      = null
      health_check_eviction_time_in_min      = null
      http2_enabled                          = true
      load_balancing_mode                    = "LeastRequests"
      local_mysql_enabled                    = false
      managed_pipeline_mode                  = "Integrated"
      minimum_tls_version                    = "1.2"
      remote_debugging_enabled               = false
      remote_debugging_version               = null
      scm_minimum_tls_version                = "1.2"
      scm_use_main_ip_restrictions           = false
      use_32_bit_worker                      = false
      vnet_route_all_enabled                 = false
      websockets_enabled                     = false
      worker_count                           = 1
      ip_restrictions                        = []
      scm_ip_restrictions                    = []
      application_stack = {
        node_version = "18-lts"

      }
      cors = {
        allowed_origins = [
          "https://mlworkspace.azure.ai"
        ]
        support_credentials = false
      }
    }
    app_settings = {
      "TZ"                                  = "America/New_York"
      "WEBSITE_PORT"                        = "80"
      "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
    }
    connection_strings = [{
      name  = "api_connection_string"
      type  = "Custom"
      value = "https://api.example.com/hvp"
    }]
    key_vault_config = {
      deploy_kv_and_pe               = false
      kv_secret_expiration_in_months = 12
      network_acls = {
        bypass = "AzureServices"
      }
      adf_cmk_expiration_date = "2025-06-22T00:00:00Z"
      adf_key_opts            = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]
    }
    network_config = {
      deploy_delegated_subnet_web_app = false
      delegated_subnet_id_web_app     = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-cus-01/subnets/a1a-52161-ppr-snet-ecasp1-cus-01"
    }
    private_endpoint_config = {
      instance                          = "01"
      is_manual_connection              = false
      static_ip_required                = false
      private_connection_resource_alias = null
      ip_configuration                  = {}
    }
  }
}

#### Shared Logging Configuration ####
logs = {
  file_system_level       = "Warning"
  detailed_error_messages = true
  failed_request_tracing  = false
  http_logs = {
    file_system = {
      retention_in_days = 30
      retention_in_mb   = 100
    }
  }
}

#### Shared Sticky Settings ####
sticky_settings = {
  app_setting_names       = ["WEBSITE_DNS_SERVER", "WEBSITE_PORT"]
  connection_string_names = null
}

#### Additional Global Settings ####
client_affinity_enabled            = true
client_certificate_enabled         = false
client_certificate_mode            = "Required"
client_certificate_exclusion_paths = null
enabled                            = true
zip_deploy_file                    = null
auth_settings = {
  enabled = false
}

# Storage accounts for mounting Azure Files (generated dynamically in main.tf)  
# storage_accounts = []  # This is now generated dynamically in main.tf

enable_system_assigned_identity = true

#### Storage Account Configuration ####
storage_account_config = {
  # Storage account for qdctweb webapp
  ec_qdctweb = {
    context                                = "qdctw"
    instance                               = "01"
    account_tier                           = "Standard"
    persist_access_key                     = true
    enable_key_access                      = true
    account_replication_type               = "ZRS"
    kv_secret_expiration_date              = "2026-12-31T23:59:59Z"
    enable_file_share_AADDS_authentication = false
    webapp_identity_keys                   = ["qdctweb"]
    primary_webapp_identity_key            = "qdctweb"
    private_endpoint_config = {
      is_manual_connection = false
      static_ip_required   = false
    }
    # Azure Files configuration
    file_share_config = {
      quota            = 100
      enabled_protocol = "SMB"
    }
    storage_account_key = "ec_qdctweb"
  }

  # Storage account for collectionui webapp
  ec_collectionui = {
    context                                = "colui"
    instance                               = "01"
    account_tier                           = "Standard"
    persist_access_key                     = true
    enable_key_access                      = true
    account_replication_type               = "ZRS"
    kv_secret_expiration_date              = "2026-12-31T23:59:59Z"
    enable_file_share_AADDS_authentication = false
    webapp_identity_keys                   = ["collectionui"]
    primary_webapp_identity_key            = "collectionui"
    private_endpoint_config = {
      is_manual_connection = false
      static_ip_required   = false
    }
    # Azure Files configuration
    file_share_config = {
      quota            = 100
      enabled_protocol = "SMB"
    }
    storage_account_key = "ec_collectionui"
  }

  # Storage account for guidance webapp
  ec_guidance = {
    context                                = "guid"
    instance                               = "01"
    account_tier                           = "Standard"
    persist_access_key                     = true
    enable_key_access                      = true
    account_replication_type               = "ZRS"
    kv_secret_expiration_date              = "2026-12-31T23:59:59Z"
    enable_file_share_AADDS_authentication = false
    webapp_identity_keys                   = ["guidance"]
    primary_webapp_identity_key            = "guidance"
    private_endpoint_config = {
      is_manual_connection = false
      static_ip_required   = false
    }
    # Azure Files configuration
    file_share_config = {
      quota            = 100
      enabled_protocol = "SMB"
    }
    storage_account_key = "ec_guidance"
  }

  # Storage account for brkrxlsrv webapp
  ec_brkrxlsrv = {
    context                                = "brkrx"
    instance                               = "01"
    account_tier                           = "Standard"
    persist_access_key                     = true
    enable_key_access                      = true
    account_replication_type               = "ZRS"
    kv_secret_expiration_date              = "2026-12-31T23:59:59Z"
    enable_file_share_AADDS_authentication = false
    webapp_identity_keys                   = ["brkrxlsrv"]
    primary_webapp_identity_key            = "brkrxlsrv"
    private_endpoint_config = {
      is_manual_connection = false
      static_ip_required   = false
    }
    # Azure Files configuration
    file_share_config = {
      quota            = 100
      enabled_protocol = "SMB"
    }
    storage_account_key = "ec_brkrxlsrv"
  }

  # Storage account for brkrui webapp
  ec_brkrui = {
    context                                = "brkui"
    instance                               = "01"
    account_tier                           = "Standard"
    persist_access_key                     = true
    enable_key_access                      = true
    account_replication_type               = "ZRS"
    kv_secret_expiration_date              = "2026-12-31T23:59:59Z"
    enable_file_share_AADDS_authentication = false
    webapp_identity_keys                   = ["brkrui"]
    primary_webapp_identity_key            = "brkrui"
    private_endpoint_config = {
      is_manual_connection = false
      static_ip_required   = false
    }
    # Azure Files configuration
    file_share_config = {
      quota            = 100
      enabled_protocol = "SMB"
    }
    storage_account_key = "ec_brkrui"
  }
}