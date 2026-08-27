#
# Copyright 2024 LSEG & Microsoft. All rights reserved.
#

#----------------------------------------------------------------------
# - LSEG Required Variables
#----------------------------------------------------------------------
variable "org_id" {
  type        = string
  description = "(Required) Three letter code representing organization/tenant/CSP."
  validation {
    condition = (
      can(regex("^a[0-9][a-z]$", var.org_id))
    )
    error_message = "The org ID does not follow customer naming structure."
  }
}

variable "app_id" {
  type        = string
  description = "(Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used."
}

variable "location" {
  type        = string
  description = "(Required) Location of the resource group."
  validation {
    condition = (
      can(regex("^[a-z0-9]+$", var.location))
    )
    error_message = "Location Name is not Valid. Ensure the CLI Name is provided here."
  }
}

variable "location_short" {
  type        = string
  description = "(Required) Short name of location of the resource group."
  default     = "eus2"
}

variable "environment" {
  type        = string
  description = "(Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars)."
  validation {
    condition = (
      can(regex("^[a-z]{2,3}$", var.environment))
    )
    error_message = "The environment does not follow customer naming structure."
  }
}

variable "context" {
  type        = string
  description = "(Optional) Application context information for the resource(s) (max 10 chars)."
  default     = null
  validation {
    condition = (
      var.context == null || can(regex("^[a-z0-9]{1,10}$", var.context))
    )
    error_message = "The context does not follow customer naming structure."
  }
}

variable "instance" {
  type        = string
  description = "(Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int)."
  default     = null
  validation {
    condition = (
      var.instance == null || can(regex("^[0-9]{1,3}$", var.instance))
    )
    error_message = "The Instance does not follow customer naming structure. 0 to 3 digits are allowed."
  }
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

# Multiple Shared App Service Plans configuration
variable "appserviceplan_configs" {
  description = "Multiple App Service Plan configurations - ecwin for main webapps, eawebjobs for webjobs"
  type = map(object({
    context                      = string
    instance                     = string
    required_for_ase             = optional(bool, false)
    sku_name                     = string
    os_type                      = string
    app_service_environment_id   = optional(string, null)
    ase_sku_name                 = optional(string, null)
    worker_count                 = optional(number, null)
    maximum_elastic_worker_count = optional(number, null)
    per_site_scaling_enabled     = optional(bool, false)
    zone_balancing_enabled       = optional(bool, false)
  }))
}

# Web App configuration
variable "webapp_config" {
  description = "Configuration for multiple web apps with ASP assignments"
  type = map(object({
    context  = string
    instance = string
    asp_key  = string # Which ASP to use from appserviceplan_configs
    site_config = object({
      always_on                         = optional(bool, true)
      app_scale_limit                   = optional(number, 2)
      default_documents                 = optional(list(string), ["index.html"])
      health_check_path                 = optional(string)
      health_check_eviction_time_in_min = optional(number)
      load_balancing_mode               = optional(string, "LeastRequests")
      ftps_state                        = optional(string, "Disabled")
      managed_pipeline_mode             = optional(string, "Integrated")
      scm_use_main_ip_restrictions      = optional(bool, false)
      use_32_bit_worker                 = optional(bool, true)
      websockets_enabled                = optional(bool, false)
      worker_count                      = optional(number, 1)
      ip_restrictions                   = optional(list(any), [])
      scm_ip_restrictions               = optional(list(any), [])
      application_stack = object({
        current_stack  = optional(string)
        dotnet_version = optional(string)
      })
      cors = optional(object({
        allowed_origins     = optional(list(string), [])
        support_credentials = optional(bool, false)
      }))
      virtual_application = optional(map(object({
        physical_path     = string
        preload           = optional(bool, true)
        virtual_directory = optional(map(any), {})
        virtual_path      = string
      })), {})
    })
    key_vault_config = object({
      deploy_kv_and_pe               = optional(bool, false)
      key_vault_id                   = optional(string)
      kv_secret_expiration_in_months = optional(number, 12)
      network_acls = optional(object({
        bypass = optional(string, "AzureServices")
      }))
      adf_cmk_expiration_date = optional(string)
      adf_key_opts            = optional(list(string), ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"])
    })
    network_config = object({
      deploy_delegated_subnet_web_app = optional(bool, false)
      delegated_subnet_id_web_app     = string
    })
    private_endpoint_config = optional(object({
      instance                          = string
      is_manual_connection              = optional(bool, false)
      static_ip_required                = optional(bool, false)
      private_connection_resource_alias = optional(string)
      ip_configuration                  = optional(map(any), {})
    }))
    storage_mount = optional(object({
      enabled             = optional(bool, false)
      storage_account_key = optional(string)
      share_context       = optional(string)
      share_instance      = optional(string)
      quota               = optional(number, 100)
      enabled_protocol    = optional(string, "SMB")
      mount_path          = optional(string)
    }))
  }))
}

variable "privateendpoint_subnet_id" {
  description = "ID of the subnet for private endpoints"
  type        = string
}

variable "shared_nrtbl_vnet_id" {
  description = "ID of the shared non-routable VNet"
  type        = string
}

# subscriptions IDs
variable "subscription_id" {
  description = "ID of the subscriptions"
  type        = string
}

variable "firewall_private_ip_address" {
  description = "Private IP address of the firewall"
  type        = string
}

# Optional web app settings
variable "client_affinity_enabled" {
  description = "Enable client affinity"
  type        = bool
  default     = false
}

variable "client_certificate_enabled" {
  description = "Enable client certificate authentication"
  type        = bool
  default     = false
}

variable "client_certificate_mode" {
  description = "Client certificate mode"
  type        = string
  default     = "Required"
}

variable "enabled" {
  description = "Enable the web app"
  type        = bool
  default     = true
}

variable "enable_system_assigned_identity" {
  description = "Enable system assigned identity"
  type        = bool
  default     = false
}

variable "auth_settings" {
  description = "Authentication settings"
  type        = any
  default     = {}
}

variable "auth_settings_v2" {
  description = "Authentication settings v2"
  type        = any
  default     = null
}

variable "sticky_settings" {
  description = "Sticky settings"
  type        = any
  default     = {}
}

variable "logs" {
  description = "Log settings"
  type        = any
  default     = {}
}

variable "storage_accounts" {
  description = "Storage account settings (deprecated - use storage_account_config instead)"
  type        = list(any)
  default     = []
}

variable "storage_account_config" {
  description = "Storage account configuration for file shares"
  type        = any
  default     = {}
}

variable "backup" {
  description = "Backup settings"
  type        = any
  default     = null
}

# Additional variables for Windows webapp module
variable "deploy_app_service_env" {
  description = "Deploy App Service Environment"
  type        = bool
  default     = false
}

variable "client_certificate_exclusion_paths" {
  description = "Paths to exclude from client certificate authentication"
  type        = string
  default     = null
}

variable "zip_deploy_file" {
  description = "Path to zip file for deployment"
  type        = string
  default     = null
}

variable "virtual_network_backup_restore_enabled" {
  description = "Enable virtual network backup and restore"
  type        = bool
  default     = false
}

variable "virtualnetwork_content_share_enabled" {
  description = "Enable virtual network content share"
  type        = bool
  default     = false
}

variable "appserviceenv_config" {
  description = "App Service Environment configuration"
  type        = any
  default     = null
}

variable "app_settings" {
  description = "Global app settings"
  type        = map(string)
  default     = {}
}

variable "connection_strings" {
  description = "Global connection strings"
  type = list(object({
    name  = string
    type  = string
    value = string
  }))
  default = []
}

variable "key_vault_id" {
  description = "Key Vault ID for storage account customer managed keys"
  type        = string
}

# Tags
variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}