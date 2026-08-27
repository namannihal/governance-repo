org_id      = "a1a"
app_id      = "52161"
location    = "eastus2"
environment = "dev"
context     = "shared"
instance    = "01"

tags = {
  mnd-applicationid      = "app-52161"
  mnd-applicationname    = "estimates_azure_dbor_dev"
  mnd-costcentre         = "52161"
  mnd-dataclassification = "restricted"
  mnd-envsubtype         = "test"
  mnd-envtype            = "dev"
  mnd-lifecycle          = "live"
  mnd-owner              = "TF-TF-IndiaEstimatesTech@lseg.com"
  mnd-projectcode        = "P011085"
  mnd-supportgroup       = "DEVELOP-ESTIMATES-COLLECT-ICA"
  cloud_provider         = "azure"
  opt-datadog            = "require"
}

#### Platform and Application Dependencies ####
resource_group_name         = "a1a-52161-dev-rg-estimates-eus2-01"
subscription_id             = "96278378-bea2-4e84-b5a3-4b5459eb2d18"
key_vault_id                = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-estimates-eus2-01/providers/Microsoft.KeyVault/vaults/a1a52161devkvappeus201"
firewall_private_ip_address = "10.93.196.68"
shared_nrtbl_vnet_id        = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-nonrtbl-eus2-01"
privateendpoint_subnet_id   = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-platform-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-rtbl-eus2-01/subnets/a1a-52161-dev-snet-workload-eus2-06"

webapp_subnet_id = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-nonrtbl-eus2-01/subnets/a1a-52161-dev-snet-ecasp2-eus2-01"

#### Multiple Shared App Service Plans Configuration ####
appserviceplan_configs = {
  # Main ASP for hvpui, actualsbre, estimatesbre, guidancebre, estimatesdi
  ecwindows = {
    context                      = "ecwindows"
    instance                     = "01"
    required_for_ase             = false
    sku_name                     = "P1v3"
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
      delegated_subnet_id_web_app     = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-nonrtbl-eus2-01/subnets/a1a-52161-dev-snet-ecasp2-eus2-01"
    }
    private_endpoint_config = {
      instance                          = "01"
      is_manual_connection              = false
      static_ip_required                = false
      private_connection_resource_alias = null
      ip_configuration                  = {}
    }
    storage_mount = {
      enabled             = true
      storage_account_key = "windows_webapp_shared"
      share_context       = "hvpui"
      share_instance      = "01"
      quota               = 100
      enabled_protocol    = "SMB"
      mount_path          = "/mounts/hvpui"
    }
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
      delegated_subnet_id_web_app     = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-nonrtbl-eus2-01/subnets/a1a-52161-dev-snet-ecasp2-eus2-01"
    }
    private_endpoint_config = {
      instance                          = "01"
      is_manual_connection              = false
      static_ip_required                = false
      private_connection_resource_alias = null
      ip_configuration                  = {}
    }
    storage_mount = {
      enabled             = true
      storage_account_key = "windows_webapp_shared"
      share_context       = "actbre"
      share_instance      = "01"
      quota               = 100
      enabled_protocol    = "SMB"
      mount_path          = "/mounts/actualsbre"
    }
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
      delegated_subnet_id_web_app     = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-nonrtbl-eus2-01/subnets/a1a-52161-dev-snet-ecasp2-eus2-01"
    }
    private_endpoint_config = {
      instance                          = "01"
      is_manual_connection              = false
      static_ip_required                = false
      private_connection_resource_alias = null
      ip_configuration                  = {}
    }
    storage_mount = {
      enabled             = true
      storage_account_key = "windows_webapp_shared"
      share_context       = "estbre"
      share_instance      = "01"
      quota               = 100
      enabled_protocol    = "SMB"
      mount_path          = "/mounts/estimatesbre"
    }
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
      delegated_subnet_id_web_app     = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-nonrtbl-eus2-01/subnets/a1a-52161-dev-snet-ecasp2-eus2-01"
    }
    private_endpoint_config = {
      instance                          = "01"
      is_manual_connection              = false
      static_ip_required                = false
      private_connection_resource_alias = null
      ip_configuration                  = {}
    }
    storage_mount = {
      enabled             = true
      storage_account_key = "windows_webapp_shared"
      share_context       = "guidbre"
      share_instance      = "01"
      quota               = 100
      enabled_protocol    = "SMB"
      mount_path          = "/mounts/guidancebre"
    }
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
      delegated_subnet_id_web_app     = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-nonrtbl-eus2-01/subnets/a1a-52161-dev-snet-ecasp2-eus2-01"
    }
    private_endpoint_config = {
      instance                          = "01"
      is_manual_connection              = false
      static_ip_required                = false
      private_connection_resource_alias = null
      ip_configuration                  = {}
    }
    storage_mount = {
      enabled             = true
      storage_account_key = "windows_webapp_shared"
      share_context       = "hvptmed"
      share_instance      = "01"
      quota               = 100
      enabled_protocol    = "SMB"
      mount_path          = "/mounts/hvptmed"
    }
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
      delegated_subnet_id_web_app     = "/subscriptions/96278378-bea2-4e84-b5a3-4b5459eb2d18/resourceGroups/a1a-52161-dev-rg-shared-eus2-01/providers/Microsoft.Network/virtualNetworks/a1a-52161-dev-vnet-nonrtbl-eus2-01/subnets/a1a-52161-dev-snet-ecasp2-eus2-01"
    }
    private_endpoint_config = {
      instance                          = "01"
      is_manual_connection              = false
      static_ip_required                = false
      private_connection_resource_alias = null
      ip_configuration                  = {}
    }
    storage_mount = {
      enabled             = true
      storage_account_key = "windows_webapp_shared"
      share_context       = "hvpdbs"
      share_instance      = "01"
      quota               = 100
      enabled_protocol    = "SMB"
      mount_path          = "/mounts/hvpdbs"
    }
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

storage_account_config = {
  # Single shared storage account for Windows webapps
  windows_webapp_shared = {
    context                                = "wwapp"
    instance                               = "01"
    account_tier                           = "Standard"
    persist_access_key                     = true
    enable_key_access                      = true
    account_replication_type               = "ZRS"
    kv_secret_expiration_date              = "2026-12-31T23:59:59Z"
    enable_file_share_AADDS_authentication = false
    webapp_identity_keys                   = ["hvpui", "actualsbre", "estimatesbre", "guidancebre", "hvptmed", "hvpdbs"]
    primary_webapp_identity_key            = "hvpui"
    private_endpoint_config = {
      is_manual_connection = false
      static_ip_required   = false
    }
  }
}

#### Storage Accounts Configuration for All Webapps ####
# NOTE: This section is deprecated - storage mounts are now generated dynamically from storage_account_config
storage_accounts = []

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