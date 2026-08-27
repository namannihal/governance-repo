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
  description = "(Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix."
}

variable "environment" {
  type        = string
  description = "(Required) The environment where the resource is deployed."
  validation {
    condition = (
      can(regex("^dev|prd|sbx|tst|ppr$", var.environment))
    )
    error_message = "The environment does not follow customer naming structure."
  }
}

variable "location" {
  type        = string
  description = "(Required) Location of the resource group."
  validation {
    condition = (
      can(regex("^[a-zA-Z0-9]{1,20}$", var.location)) || null == var.location
    )
    error_message = "Location Name is not Valid. Ensure the CLI Name is provided here."
  }
}

variable "tags" {
  type        = map(any)
  description = "(Optional) Tags to be set on each resource."
  default     = {}
}

variable "key_vault_tags" {
  type        = map(any)
  description = "(Optional) Tags to be set on each resource."
  default     = {}
}

variable "resource_group_id" {
  description = "(Required) The Id of the shared resources resource group."
  type        = string
}

variable "shared_nrtbl_vnet_id" {
  description = "(Required) The ARM Resource Id of the non-routeable virtual network in the shared resource group."
  type        = string
}

variable "privateendpoint_subnet_id" {
  type        = string
  description = "(Optional) Specify the subnet id where the private endpoint will be created."
  default     = null
}

variable "firewall_private_ip_address" {
  description = "(Optional) Azure firewall private IP address used when creating routes."
  type        = string
  default     = null
}

variable "storage_account_config" {
  type        = any
  description = "(Optional, legacy) Deprecated top-level storage account configuration map. Use windows_vm.<key>.storage_account_config for VM file shares and site_recovery.<key>.storage_account_config for external ASR cache accounts."
  default     = {}
}

variable "key_vault_id" {
  type        = string
  description = "(Optional) The ID of the Key Vault for infrastructure"
  default     = null
}

variable "source_image_id" {
  type        = string
  description = "(Required) Shared source image ID for all Windows VMs."
}

variable "resource_group_name" {
  type        = string
  description = "(Optional) The name of the resource group"
  default     = null
}

variable "windows_vm" {
  type        = any
  description = "(Required) Map of Windows VM configurations"
}

variable "vm_user_login_group_id" {
  type        = string
  description = "Object ID of the ENTRA group for VM User Login role."
}

variable "vm_admin_login_group_id" {
  type        = string
  description = "Object ID of the ENTRA group for VM Administrator Login role."
}

variable "enable_entra_auth" {
  type        = bool
  description = "(Optional) The boolean to enable entra authentication for Windows Virtual Machine."
  default     = true
}

variable "vm_agent_platform_updates_enabled" {
  type        = bool
  description = "(Optional) Specifies whether VMAgent Platform Updates is enabled. Defaults to false."
  default     = false
}

variable "manage_asr_cache_soft_delete" {
  type        = bool
  description = "(Optional) When true, patch each configured ASR cache storage account blob service so restore policy, blob soft delete, and container soft delete are disabled before ASR uses the account."
  default     = true
}

variable "post_failover_import_disks" {
  type        = bool
  description = "(Optional) Set to true after a failover/failback cycle to re-import data disks that exist in Azure but fell out of Terraform state. The import is performed per additional_disk entry for every ASR-protected VM. Reset to false for normal runs once the import apply completes."
  default     = false
}

variable "site_recovery" {
  type = map(object({
    secondary_location            = string
    resource_group_name_secondary = string
    rsv_subnet_id                 = string
    create_rsv_private_endpoint   = optional(bool, true)
    storage_account_config = optional(map(object({
      id                       = optional(string, null)
      context                  = string
      instance                 = string
      location                 = optional(string, null)
      resource_group_name      = optional(string, null)
      account_tier             = optional(string, "Standard")
      account_replication_type = optional(string, "LRS")
      enable_key_access        = optional(bool, false)
      persist_access_key       = optional(bool, false)
      use_asr_uai_for_cmk      = optional(bool, false)
      private_endpoint_config = optional(object({
        is_manual_connection = optional(bool, false)
        static_ip_required   = optional(bool, false)
        subnet_id            = optional(string, null)
      }), {})
    })), {})
    staging_storage_account_id                           = optional(string, null)
    staging_storage_account_key                          = optional(string, null)
    primary_network_id                                   = string
    target_network_id                                    = string
    target_disk_type                                     = string
    target_replica_disk_type                             = string
    target_encryption_set_id                             = optional(string, null)
    key_vault_id_secondary                               = optional(string, null)
    expiration_date                                      = string
    context                                              = optional(string, null)
    instance                                             = optional(string, null)
    sku                                                  = optional(string, "Standard")
    storage_mode_type                                    = optional(string, "GeoRedundant")
    cross_region_restore_enabled                         = optional(bool, true)
    recovery_point_retention_in_minutes                  = optional(number, 1440)
    application_consistent_snapshot_frequency_in_minutes = optional(number, 240)
    fabric_name                                          = string
    fabric_secondary_name                                = string
    protection_container_name                            = string
    protection_container_secondary_name                  = string
    replication_policy_name                              = string
    container_mapping_name                               = string
    network_mapping_name                                 = string
    replication_name                                     = string
    asr_identity_context                                 = optional(string, null)
    asr_identity_instance                                = optional(string, null)
    target_virtual_machine_name                          = optional(string, null)
    app_key_vault_id_secondary                           = optional(string, null)
    use_existing_data_disk                               = optional(bool, true)
    immutability                                         = optional(string, "Locked")
    cross_subscription_restore_state                     = optional(string, "Disabled")
    monitoring = optional(object({
      alerts_for_all_job_failures_enabled            = optional(bool, true)
      alerts_for_critical_operation_failures_enabled = optional(bool, true)
    }), null)
  }))
  description = "(Optional) Azure Site Recovery configuration keyed by Windows VM key. Use storage_account_config to create ASR cache storage accounts in-module; id remains an optional override for an existing account."
  default     = {}
}