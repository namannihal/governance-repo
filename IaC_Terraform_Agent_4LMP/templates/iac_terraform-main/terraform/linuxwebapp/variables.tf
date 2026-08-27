#
# Copyright 2025 LSEG & Microsoft. All rights reserved.
#

#----------------------------------------------------------------------
# - LSEG Required Variables
#----------------------------------------------------------------------
variable "org_id" {
  description = "Organization ID"
  type        = string
}

variable "app_id" {
  description = "Application ID"
  type        = string
}

variable "location" {
  description = "Azure region for resources"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "context" {
  description = "Context identifier"
  type        = string
}

variable "instance" {
  description = "Instance identifier"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

# Multiple Shared App Service Plans configuration
variable "appserviceplan_configs" {
  description = "Multiple App Service Plan configurations - eclinux for main webapps, eawebjob for webjobs"
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
    context      = string
    instance     = string
    asp_key      = string # Which ASP to use from appserviceplan_configs
    app_settings = optional(map(string), {})
    site_config  = optional(any, {})
    connection_strings = optional(list(object({
      name  = string
      type  = string
      value = string
    })), [])
    private_endpoint_config = optional(object({
      instance                          = optional(string)
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

# Key Vault and Network IDs
variable "key_vault_id" {
  description = "ID of the Key Vault"
  type        = string
}

# subscriptions IDs
variable "subscription_id" {
  description = "ID of the subscriptions"
  type        = string
}

variable "webapp_subnet_id" {
  description = "ID of the subnet for web apps"
  type        = string
}

variable "privateendpoint_subnet_id" {
  description = "ID of the subnet for private endpoints"
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

variable "client_certificate_exclusion_paths" {
  description = "Paths to exclude from client certificate authentication"
  type        = string
  default     = null
}

variable "enabled" {
  description = "Enable the web app"
  type        = bool
  default     = true
}

variable "zip_deploy_file" {
  description = "Path to zip file for deployment"
  type        = string
  default     = null
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
  description = "Storage account settings"
  type        = any
  default     = {}
}

variable "backup" {
  type = object({
    name                = string
    storage_account_url = string
    enabled             = optional(bool, true)
    schedule = object({
      frequency_interval       = number
      frequency_unit           = string
      keep_at_least_one_backup = optional(bool)
      retention_period_days    = optional(number, 30)
      start_time               = optional(string)
    })
  })
  description = <<EOT
  (Optional) A `backup` block supports the following:
  name                = "(Required) The name which should be used for this Backup."
  storage_account_url = "(Required) The SAS URL to the container."
  enabled             = "(Optional) Should this backup job be enabled? Defaults to `true`."
  schedule = (Required) object({
    frequency_interval       = "(Required) How often the backup should be executed (e.g. for weekly backup, this should be set to 7 and frequency_unit should be set to Day). Not all intervals are supported on all Linux Web App SKUs. Please refer to the official documentation for appropriate values."
    frequency_unit           = "(Required) The unit of time for how often the backup should take place. Possible values include: `Day`, `Hour`."
    keep_at_least_one_backup = "(Optional) Should the service keep at least one backup, regardless of age of backup. Defaults to `false`."
    retention_period_days    = "(Optional) After how many days backups should be deleted. Defaults to `30`."
    start_time               = "(Optional) When the schedule should start working in RFC-3339 format."
  })
  EOT
  default     = null
}

variable "storage_account_config" {
  description = "Storage account configurations for creating storage accounts with Azure Files"
  type = map(object({
    context                                = string
    instance                               = string
    account_tier                           = string
    persist_access_key                     = bool
    enable_key_access                      = bool
    account_replication_type               = string
    kv_secret_expiration_date              = string
    enable_file_share_AADDS_authentication = bool
    webapp_identity_keys                   = list(string)
    primary_webapp_identity_key            = string
    private_endpoint_config = object({
      is_manual_connection = bool
      static_ip_required   = bool
    })
    file_share_config = optional(object({
      quota            = number
      enabled_protocol = string
    }))
    storage_account_key = string
  }))
  default = {}
}

# Tags
variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}