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
resource_group_name         = "a1a-52161-ppr-rg-estimates-cus-01"
subscription_id             = "7b8a8ffb-9be5-4786-8ba6-dd328b9d6857"
key_vault_id                = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-cus-01/providers/Microsoft.KeyVault/vaults/a1a52161pprkvappcus01"
firewall_private_ip_address = "10.239.4.68"
shared_nrtbl_vnet_id        = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-cus-01"
privateendpoint_subnet_id   = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-platform-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-rtbl-cus-01/subnets/a1a-52161-ppr-snet-workload-cus-06"

webapp_subnet_id = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-cus-01/subnets/a1a-52161-ppr-snet-ecasp2-cus-01"

#### Multiple Shared App Service Plans Configuration ####
appserviceplan_configs = {
  # Main ASP for hvpui, actualsbre, estimatesbre, guidancebre, estimatesdi
  ecwindows = {
    context                      = "ecwindows"
    instance                     = "01"
    required_for_ase             = false
    sku_name                     = "P2v3"
    os_type                      = "Windows"
    app_service_environment_id   = null
    ase_sku_name                 = null
    worker_count                 = 1
    maximum_elastic_worker_count = null
    per_site_scaling_enabled     = false
    zone_balancing_enabled       = false
  }
}

#### Windows Web Apps Configuration  ####
webapp_config = {
  hvpui = {
    context  = "hvpui"
    instance = "01"
    asp_key  = "ecwindows" # Use the ecwindows ASP
    site_config = {
      always_on                         = true
      app_scale_limit                   = 2
      default_documents                 = ["index.html"]
      health_check_path                 = "/health"
      health_check_eviction_time_in_min = 5
      load_balancing_mode               = "LeastRequests"
      ftps_state                        = "Disabled"
      managed_pipeline_mode             = "Integrated"
      scm_use_main_ip_restrictions      = false
      use_32_bit_worker                 = false
      websockets_enabled                = false
      worker_count                      = 1
      ip_restrictions                   = []
      scm_ip_restrictions               = []
      application_stack = {
        current_stack  = "dotnet"
        dotnet_version = "v4.0"
      }
      cors = {
        allowed_origins = [
          "https://mlworkspace.azure.ai"
        ]
        support_credentials = false
      }
      virtual_application = {
        va1 = {
          physical_path     = "site\\wwwroot\\app1"
          preload           = true
          virtual_directory = {}
          virtual_path      = "/"
        }
      }
    }
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
      delegated_subnet_id_web_app     = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-cus-01/subnets/a1a-52161-ppr-snet-ecasp2-cus-01"
    }
    private_endpoint_config = {
      instance                          = "01"
      is_manual_connection              = false
      static_ip_required                = false
      private_connection_resource_alias = null
      ip_configuration                  = {}
    }
    # File share configuration for webapp
    file_share_config = {
      quota            = 200
      enabled_protocol = "SMB"
    }
    # Storage account key to use from storage_account_config
    storage_account_key = "hvpui"
  }
  actualsbre = {
    context  = "actualsbre"
    instance = "01"
    asp_key  = "ecwindows" # Use the ecwindows ASP
    site_config = {
      always_on                         = true
      app_scale_limit                   = 2
      default_documents                 = ["index.html"]
      health_check_path                 = "/health"
      health_check_eviction_time_in_min = 5
      load_balancing_mode               = "LeastRequests"
      ftps_state                        = "Disabled"
      managed_pipeline_mode             = "Integrated"
      scm_use_main_ip_restrictions      = false
      use_32_bit_worker                 = false
      websockets_enabled                = false
      worker_count                      = 1
      ip_restrictions                   = []
      scm_ip_restrictions               = []
      application_stack = {
        current_stack  = "dotnet"
        dotnet_version = "v4.0"
      }
      cors = {
        allowed_origins = [
          "https://mlworkspace.azure.ai"
        ]
        support_credentials = false
      }
      virtual_application = {
        va1 = {
          physical_path     = "site\\wwwroot\\app1"
          preload           = true
          virtual_directory = {}
          virtual_path      = "/"
        }
      }
    }
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
      delegated_subnet_id_web_app     = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-cus-01/subnets/a1a-52161-ppr-snet-ecasp2-cus-01"
    }
    private_endpoint_config = {
      instance                          = "01"
      is_manual_connection              = false
      static_ip_required                = false
      private_connection_resource_alias = null
      ip_configuration                  = {}
    }
    # File share configuration for webapp
    file_share_config = {
      quota            = 200
      enabled_protocol = "SMB"
    }
    # Storage account key to use from storage_account_config
    storage_account_key = "actualsbre"
  }
  estimatesbre = {
    context  = "estbre"
    instance = "01"
    asp_key  = "ecwindows" # Use the ecwindows ASP
    site_config = {
      always_on                         = true
      app_scale_limit                   = 2
      default_documents                 = ["index.html"]
      health_check_path                 = "/health"
      health_check_eviction_time_in_min = 5
      load_balancing_mode               = "LeastRequests"
      ftps_state                        = "Disabled"
      managed_pipeline_mode             = "Integrated"
      scm_use_main_ip_restrictions      = false
      use_32_bit_worker                 = false
      websockets_enabled                = false
      worker_count                      = 1
      ip_restrictions                   = []
      scm_ip_restrictions               = []
      application_stack = {
        current_stack  = "dotnet"
        dotnet_version = "v4.0"
      }
      cors = {
        allowed_origins = [
          "https://mlworkspace.azure.ai"
        ]
        support_credentials = false
      }
      virtual_application = {
        va1 = {
          physical_path     = "site\\wwwroot\\app1"
          preload           = true
          virtual_directory = {}
          virtual_path      = "/"
        }
      }
    }
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
      delegated_subnet_id_web_app     = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-cus-01/subnets/a1a-52161-ppr-snet-ecasp2-cus-01"
    }
    private_endpoint_config = {
      instance                          = "01"
      is_manual_connection              = false
      static_ip_required                = false
      private_connection_resource_alias = null
      ip_configuration                  = {}
    }
    # File share configuration for webapp
    file_share_config = {
      quota            = 200
      enabled_protocol = "SMB"
    }
    # Storage account key to use from storage_account_config
    storage_account_key = "estbre"
  }
  guidancebre = {
    context  = "guidbre"
    instance = "01"
    asp_key  = "ecwindows" # Use the ecwindows ASP
    site_config = {
      always_on                         = true
      app_scale_limit                   = 2
      default_documents                 = ["index.html"]
      health_check_path                 = "/health"
      health_check_eviction_time_in_min = 5
      load_balancing_mode               = "LeastRequests"
      ftps_state                        = "Disabled"
      managed_pipeline_mode             = "Integrated"
      scm_use_main_ip_restrictions      = false
      use_32_bit_worker                 = false
      websockets_enabled                = false
      worker_count                      = 1
      ip_restrictions                   = []
      scm_ip_restrictions               = []
      application_stack = {
        current_stack  = "dotnet"
        dotnet_version = "v4.0"
      }
      cors = {
        allowed_origins = [
          "https://mlworkspace.azure.ai"
        ]
        support_credentials = false
      }
      virtual_application = {
        va1 = {
          physical_path     = "site\\wwwroot\\app1"
          preload           = true
          virtual_directory = {}
          virtual_path      = "/"
        }
      }
    }
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
      delegated_subnet_id_web_app     = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-cus-01/subnets/a1a-52161-ppr-snet-ecasp2-cus-01"
    }
    private_endpoint_config = {
      instance                          = "01"
      is_manual_connection              = false
      static_ip_required                = false
      private_connection_resource_alias = null
      ip_configuration                  = {}
    }
    # File share configuration for webapp
    file_share_config = {
      quota            = 200
      enabled_protocol = "SMB"
    }
    # Storage account key to use from storage_account_config
    storage_account_key = "guidbre"
  }
  hvptmed = {
    context  = "hvptmed"
    instance = "01"
    asp_key  = "ecwindows" # Use the ecwindows ASP
    site_config = {
      always_on                         = true
      app_scale_limit                   = 2
      default_documents                 = ["index.html"]
      health_check_path                 = "/health"
      health_check_eviction_time_in_min = 5
      load_balancing_mode               = "LeastRequests"
      ftps_state                        = "Disabled"
      managed_pipeline_mode             = "Integrated"
      scm_use_main_ip_restrictions      = false
      use_32_bit_worker                 = false
      websockets_enabled                = false
      worker_count                      = 1
      ip_restrictions                   = []
      scm_ip_restrictions               = []
      application_stack = {
        current_stack  = "dotnet"
        dotnet_version = "v4.0"
      }
      cors = {
        allowed_origins = [
          "https://mlworkspace.azure.ai"
        ]
        support_credentials = false
      }
      virtual_application = {
        va1 = {
          physical_path     = "site\\wwwroot\\app1"
          preload           = true
          virtual_directory = {}
          virtual_path      = "/"
        }
      }
    }
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
      delegated_subnet_id_web_app     = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-cus-01/subnets/a1a-52161-ppr-snet-ecasp2-cus-01"
    }
    private_endpoint_config = {
      instance                          = "01"
      is_manual_connection              = false
      static_ip_required                = false
      private_connection_resource_alias = null
      ip_configuration                  = {}
    }
    # File share configuration for webapp
    file_share_config = {
      quota            = 200
      enabled_protocol = "SMB"
    }
    # Storage account key to use from storage_account_config
    storage_account_key = "hvptmed"
  }
  hvpdbs = {
    context  = "hvpdbs"
    instance = "01"
    asp_key  = "ecwindows" # Use the ecwindows ASP
    site_config = {
      always_on                         = true
      app_scale_limit                   = 2
      default_documents                 = ["index.html"]
      health_check_path                 = "/health"
      health_check_eviction_time_in_min = 5
      load_balancing_mode               = "LeastRequests"
      ftps_state                        = "Disabled"
      managed_pipeline_mode             = "Integrated"
      scm_use_main_ip_restrictions      = false
      use_32_bit_worker                 = false
      websockets_enabled                = false
      worker_count                      = 1
      ip_restrictions                   = []
      scm_ip_restrictions               = []
      application_stack = {
        current_stack  = "dotnet"
        dotnet_version = "v4.0"
      }
      cors = {
        allowed_origins = [
          "https://mlworkspace.azure.ai"
        ]
        support_credentials = false
      }
      virtual_application = {
        va1 = {
          physical_path     = "site\\wwwroot\\app1"
          preload           = true
          virtual_directory = {}
          virtual_path      = "/"
        }
      }
    }
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
      delegated_subnet_id_web_app     = "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-shared-cus-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-ppr-vnet-nonrtbl-cus-01/subnets/a1a-52161-ppr-snet-ecasp2-cus-01"
    }
    private_endpoint_config = {
      instance                          = "01"
      is_manual_connection              = false
      static_ip_required                = false
      private_connection_resource_alias = null
      ip_configuration                  = {}
    }
    # File share configuration for webapp
    file_share_config = {
      quota            = 200
      enabled_protocol = "SMB"
    }
    # Storage account key to use from storage_account_config
    storage_account_key = "hvpdbs"
  }
}

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

sticky_settings = {
  app_setting_names       = ["WEBSITE_DNS_SERVER", "WEBSITE_PORT"]
  connection_string_names = null
}

enable_system_assigned_identity = true

# Additional variables for Windows webapp module
deploy_app_service_env     = false
appserviceenv_config       = null
client_affinity_enabled    = false
client_certificate_enabled = false
client_certificate_mode    = "Required"
enabled                    = true
app_settings = {
  "WEBSITE_DNS_SERVER" = "168.63.129.16"
  "WEBSITE_PORT"       = "80"
}
connection_strings = []
auth_settings      = null

#### Storage Account Configuration for File Shares ####
storage_account_config = {
  # Storage account for hvpui webapp
  hvpui = {
    context                                = "hvpui"
    instance                               = "01"
    account_tier                           = "Standard"
    persist_access_key                     = true
    enable_key_access                      = true
    account_replication_type               = "ZRS"
    kv_secret_expiration_date              = "2026-12-31T23:59:59Z"
    enable_file_share_AADDS_authentication = false
    # Specify which webapp identities to use for this storage account
    webapp_identity_keys = ["hvpui"]
    # Primary webapp identity for customer managed key
    primary_webapp_identity_key = "hvpui"
    private_endpoint_config = {
      is_manual_connection = false
      static_ip_required   = false
    }
    # Azure Files configuration
    file_share_config = {
      quota            = 100
      enabled_protocol = "SMB"
    }
  }
  # Storage account for hvptmed webapp
  hvptmed = {
    context                                = "hvptm"
    instance                               = "01"
    account_tier                           = "Standard"
    persist_access_key                     = true
    enable_key_access                      = true
    account_replication_type               = "ZRS"
    kv_secret_expiration_date              = "2026-12-31T23:59:59Z"
    enable_file_share_AADDS_authentication = false
    # Specify which webapp identities to use for this storage account
    webapp_identity_keys = ["hvptmed"]
    # Primary webapp identity for customer managed key
    primary_webapp_identity_key = "hvptmed"
    private_endpoint_config = {
      is_manual_connection = false
      static_ip_required   = false
    }
    # Azure Files configuration
    file_share_config = {
      quota            = 100
      enabled_protocol = "SMB"
    }
  }
  # Storage account for hvpdbs webapp
  hvpdbs = {
    context                                = "hvpdb"
    instance                               = "01"
    account_tier                           = "Standard"
    persist_access_key                     = true
    enable_key_access                      = true
    account_replication_type               = "ZRS"
    kv_secret_expiration_date              = "2026-12-31T23:59:59Z"
    enable_file_share_AADDS_authentication = false
    # Specify which webapp identities to use for this storage account
    webapp_identity_keys = ["hvpdbs"]
    # Primary webapp identity for customer managed key
    primary_webapp_identity_key = "hvpdbs"
    private_endpoint_config = {
      is_manual_connection = false
      static_ip_required   = false
    }
    # Azure Files configuration
    file_share_config = {
      quota            = 100
      enabled_protocol = "SMB"
    }
  }
  # Storage account for guidancebre webapp
  guidbre = {
    context                                = "gudbr"
    instance                               = "01"
    account_tier                           = "Standard"
    persist_access_key                     = true
    enable_key_access                      = true
    account_replication_type               = "ZRS"
    kv_secret_expiration_date              = "2026-12-31T23:59:59Z"
    enable_file_share_AADDS_authentication = false
    # Specify which webapp identities to use for this storage account
    webapp_identity_keys = ["guidancebre"]
    # Primary webapp identity for customer managed key
    primary_webapp_identity_key = "guidancebre"
    private_endpoint_config = {
      is_manual_connection = false
      static_ip_required   = false
    }
    # Azure Files configuration
    file_share_config = {
      quota            = 100
      enabled_protocol = "SMB"
    }
  }
  # Storage account for estimatesbre webapp
  estbre = {
    context                                = "estbr"
    instance                               = "01"
    account_tier                           = "Standard"
    persist_access_key                     = true
    enable_key_access                      = true
    account_replication_type               = "ZRS"
    kv_secret_expiration_date              = "2026-12-31T23:59:59Z"
    enable_file_share_AADDS_authentication = false
    # Specify which webapp identities to use for this storage account
    webapp_identity_keys = ["estimatesbre"]
    # Primary webapp identity for customer managed key
    primary_webapp_identity_key = "estimatesbre"
    private_endpoint_config = {
      is_manual_connection = false
      static_ip_required   = false
    }
    # Azure Files configuration
    file_share_config = {
      quota            = 100
      enabled_protocol = "SMB"
    }
  }
  # Storage account for actualsbre webapp
  actualsbre = {
    context                                = "actbr"
    instance                               = "01"
    account_tier                           = "Standard"
    persist_access_key                     = true
    enable_key_access                      = true
    account_replication_type               = "ZRS"
    kv_secret_expiration_date              = "2026-12-31T23:59:59Z"
    enable_file_share_AADDS_authentication = false
    # Specify which webapp identities to use for this storage account
    webapp_identity_keys = ["actualsbre"]
    # Primary webapp identity for customer managed key
    primary_webapp_identity_key = "actualsbre"
    private_endpoint_config = {
      is_manual_connection = false
      static_ip_required   = false
    }
    # Azure Files configuration
    file_share_config = {
      quota            = 100
      enabled_protocol = "SMB"
    }
  }
}

#### Storage Accounts Configuration for All Webapps ####
# NOTE: This section is deprecated - storage mounts are now generated dynamically from storage_account_config
storage_accounts = []
