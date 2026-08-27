#
# Copyright 2025 LSEG & Microsoft. All rights reserved.
#

#-----------------------------
# - LSEG Required Variables
#-----------------------------
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
variable "environment" {
  type        = string
  description = "(Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars)."
  validation {
    condition = (
      can(regex("^dev|ppr|prd$", var.environment))
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
variable "extension_environment" {
  type        = string
  description = "(Required) The environment where scripts uploaded to BAMS. It should match ENV variable in CI/CD pipeline."
  validation {
    condition = (
      can(regex("^dev|ppr-01|ppr-02|prd-01|prd-02", var.extension_environment))
    )
    error_message = "The extension environment is not valid, check allowed values."
  }
}

#-----------------------------
# - LSEG Optional Variables
#-----------------------------

variable "tags" {
  type        = map(any)
  description = "(Optional) Tags to be set on each resource."
  default     = {}
}


#-------------------------------------------
# - Platform and Application Dependencies
#-------------------------------------------
variable "ingestion_resource_group_name" {
  description = "(Reqired). The name of the Shared Resources Resource Group. This Resource group usually contains the shared resources(application resources)."
  type        = string
}

variable "adc_resource_group_name" {
  description = "(Reqired). The name of the Shared Resources Resource Group. This Resource group usually contains the shared resources(application resources)."
  type        = string
}

variable "platform_resource_group_name" {
  description = "(Reqired). The name of the Platform Resources Resource Group. This Resource group usually contains the platform resources(routeable vnet)."
  type        = string
}

variable "shared_resource_group_name" {
  description = "(Reqired). The name of the Shared Network Resources Resource Group. This Resource group usually contains the shared resources(non-routeable vnet)."
  type        = string
}

variable "key_vault_name" {
  description = "(Reqired). The name of the Keyvault Resource."
  type        = string
}

variable "platform_rt_vnet_name" {
  description = "(Reqired). The name of the Routable VNet Resource."
  type        = string
}

variable "workload_subnet_name" {
  description = "(Reqired). The name of the Routable Workload Subnet Resource."
  type        = string
}

variable "shared_nrt_vnet_name" {
  description = "(Reqired). The name of the Non Routable VNet Resource."
  type        = string
}

variable "ingestion_subnet_name" {
  description = "(Reqired). The name of the Non Routable Ingestion Subnet Resource."
  type        = string
}

variable "bams_user_secret_name" {
  description = "(Reqired). The name of the Keyvault secret for BAMS User."
  type        = string
}

variable "bams_password_secret_name" {
  description = "(Reqired). The name of the Keyvault secret for BAMS Password."
  type        = string
}

#--------------------------------------
# - Linux Virtual Machine Variables
#--------------------------------------
variable "admin_username" {
  type        = string
  description = "(Required) The username of the local administrator used for the Virtual Machine."
}

variable "username" {
  type        = string
  description = "(Required) The Username for which this Public SSH Key should be configured. Changing this forces a new resource to be created."
}

variable "network_interface" {
  type = object({
    ip_configurations = list(object({
      private_ip_address                                 = optional(string)
      private_ip_address_version                         = optional(string, "IPv4")
      private_ip_address_allocation                      = optional(string, "Dynamic")
      primary                                            = optional(bool, false)
      gateway_load_balancer_frontend_ip_configuration_id = optional(string)
    }))
    dns_servers                    = optional(list(string))
    edge_zone                      = optional(string)
    accelerated_networking_enabled = optional(bool, false)
    internal_dns_name_label        = optional(string)
  })
  default = {
    ip_configurations = [
      {
        private_ip_address                                 = null
        private_ip_address_version                         = null
        private_ip_address_allocation                      = null
        subnet_id                                          = null
        primary                                            = true
        gateway_load_balancer_frontend_ip_configuration_id = null
      }
    ]
    dns_servers                    = null
    edge_zone                      = null
    accelerated_networking_enabled = null
    internal_dns_name_label        = null
  }
  description = <<-EOT
   A Network Interface that should be created and attached to this Virtual Machine.
   ip_configurations = list(object({
     private_ip_address                                 = "(Optional) The Static IP Address which should be used. When `private_ip_address_allocation` is set to `Static` this field can be configured."
     private_ip_address_version                         = "(Optional) The IP Version to use. Possible values are `IPv4` or `IPv6`. Defaults to `IPv4`."
     private_ip_address_allocation                      = "(Required) The allocation method used for the Private IP Address. Possible values are `Dynamic` and `Static`. Defaults to `Dynamic`."
     subnet_id                                          = "(Required) The ID of the Subnet where the VM Network Interface should be located in."
     primary                                            = "(Optional) Is this the Primary IP Configuration? Must be `true` for the first `ip_configuration`. Defaults to `false`."
     gateway_load_balancer_frontend_ip_configuration_id = "(Optional) The Frontend IP Configuration ID of a Gateway SKU Load Balancer."
   }))
   dns_servers                    = "(Optional) A list of IP Addresses defining the DNS Servers which should be used for this Network Interface. Configuring DNS Servers on the Network Interface will override the DNS Servers defined on the Virtual Network."
   edge_zone                      = "(Optional) Specifies the Edge Zone within the Azure Region where this Network Interface should exist. Changing this forces a new Network Interface to be created."
   accelerated_networking_enabled = "(Optional) Should Accelerated Networking be enabled? Defaults to `false`. Only certain Virtual Machine sizes are supported for Accelerated Networking - [more information can be found in this document](https://docs.microsoft.com/azure/virtual-network/create-vm-accelerated-networking-cli). To use Accelerated Networking in an Availability Set, the Availability Set must be deployed onto an Accelerated Networking enabled cluster."
   internal_dns_name_label        = "(Optional) The (relative) DNS Name used for internal communications between Virtual Machines in the same Virtual Network."
   EOT
  validation {
    condition     = var.network_interface == null ? true : var.network_interface.ip_configurations == null ? false : length(var.network_interface.ip_configurations) > 0
    error_message = "`network_interface.ip_configurations` cannot be `null` or empty."
  }
}

variable "identity_type" {
  type        = string
  default     = "UserAssigned"
  description = "(Optional). Identity type to use for the Virtual Machine. Possible values are 'UserAssigned' or 'SystemAssigned, UserAssigned'."
}

variable "des_identity_type" {
  type    = string
  default = "SystemAssigned"
}

variable "termination_notification" {
  type = object({
    enabled = bool
    timeout = string
  })
  default     = null
  description = <<-EOT
   (Optional) A termination_notification block supports the following
   object({
     enabled = "(Required) Should the termination notification be enabled on this Virtual Machine?"
     timeout = "(Optional) Length of time (in minutes, between 5 and 15) a notification to be sent to the VM on the instance metadata server till the VM gets deleted. The time duration should be specified in ISO 8601 format. Defaults to PT5M."
   })
   EOT
}

variable "azure_backup" {
  description = <<-EOT
    (Required) Configuration for the Azure backup for the windows VM backup Data Disk.
      ({
        enable_backup                   = (Required) Boolean to enable Azure disk backup for windows VM Backup Disk.
        context                         = (Optional) Context to be used for Azure Backup.
        soft_delete_state               = (Optional) The soft delete setting controls the protection of backup instances. Available options are AlwaysOn, On, and Off. It is strongly recommended to use AlwaysOn, as disabling it may leave backups vulnerable to accidental deletion. Users are fully responsible for ensuring the safety and recoverability of their backup data.
        instance                        = (Optional) Instance to be used for Azure Backup.
        create_disk_backup_policy       = (Optional) Set to true to enable VM backup policy, false otherwise.
        existing_disk_backup_policy_id  = (Optional) Existing back up policy resource id (if any).
        datastore_type                  = (Optional) Specifies the type of the data store.Possible values are ArchiveStore, SnapshotStore and VaultStore.
        redundancy                      = (Optional) Specifies the backup storage redundancy. Possible values are GeoRedundant and LocallyRedundant.
        existing_backup_vault_id        = (Optional) The ID of the an existing Backup Vault.
        backup_repeating_time_intervals = (Optional) Specifies a list of repeating time interval.It should follow ISO 8601 repeating time interval . Changing this forces a new Backup Policy Disk to be created.
        default_retention_duration      = (Optional) The duration of default retention rule. It should follow ISO 8601 duration format.
        rulename                        = (Optional) The name which should be used for this retention rule.
        duration                        = (Optional) Duration of deletion after given timespan.
        priority                        = (Optional) Retention Tag priority.
        absolute_criteria               = (Optional) Possible values are FirstOfDay and FirstOfWeek.
        retentiondurationindays         = (Optional) Soft Delete retention Duration in Days.
        expiration_date                 = (Required) Expiration UTC datetime (Y-m-d'T'H:M:S'Z').
        immutability_state              = (Optional) Immutability state of the backup vault. Possible values are Locked, Unlocked, Disabled. Use 'Unlocked' for testing to allow easier cleanup. Default is set to 'Disabled'.
        encryption_state                = (Optional) Encryption state of the backup vault. Possible values are Enabled, Disabled. Default is set to 'Disabled'.
        existing_backup_vault_id        = (Optional) The ID of the an existing Backup Vault.
        enable_resource_group_role_assignment = (Optional) Set true if you are using an existing back up vault and need the role Disk Snapshot Contributor assigned to the managed identity of the vault with the scope set as the resource group of the VM.
        vault_identity_principal_id  = (Optional) principal Id of the managed identity of the vault with the scope set as the resource group of the VM.
      })
  EOT
  type = object({
    context                               = optional(string, null)
    instance                              = optional(string, null)
    enable_backup                         = optional(bool, true)
    create_disk_backup_policy             = optional(bool, true)
    existing_disk_backup_policy_id        = optional(string, null)
    create_backup_vault                   = optional(bool, true)
    soft_delete_state                     = optional(string, "AlwaysOn")
    datastore_type                        = optional(string, "VaultStore")
    redundancy                            = optional(string, "LocallyRedundant")
    existing_backup_vault_id              = optional(string, null)
    backup_repeating_time_intervals       = optional(list(string), ["R/2023-11-22T11:40:16+00:00/PT4H"])
    vault_identity_principal_id           = optional(string, null)
    enable_resource_group_role_assignment = optional(bool, false)
    retentiondurationindays               = optional(number, 30)
    expiration_date                       = string
    immutability_state                    = optional(string, "Disabled")
    encryption_state                      = optional(string, "Disabled")
    cmk_rotation_policy = optional(object({
      notify_before_expiry = string
      time_before_expiry   = string
      time_after_creation  = optional(string, null)
      expire_after         = string
      }), {
      notify_before_expiry = "P358D"
      time_before_expiry   = "P7D"
      time_after_creation  = null
      expire_after         = "P365D"
    })
    cross_subscription_restore_state = optional(string, "Disabled")
    disk_backup_policy = optional(object({
      backup_repeating_time_intervals = list(string)
      default_retention_duration      = string
      time_zone                       = string
      retention_rule = list(object({
        name     = optional(string, null)
        duration = optional(string, null)
        priority = optional(number, 0)
        criteria = object({
          absolute_criteria = optional(string, null)
        })
      }))
    }), null)
  })
}


variable "linux_vm_config" {
  type = any
}

variable "script_env" {
  type        = string
  description = "(Optional) Environment from where scripts needs to be fetched."
  default     = null
}

variable "super_private_dns_environment" {
  type        = string
  description = "(Required) Environment Name of Super Private DNS"
}

variable "golden_image_id" {
  type        = string
  description = "(Required) The ID of the golden image to be used for this Virtual Machine."
}

variable "capacity_reservation_groups" {
  description = "(Optional) Capacity Reservation Group configuration. Set to null when no CRG is required. CRGs are provisioned via base-infra — this module only attaches VMs to an existing CRG (reference mode). When provided, capacity_reservation_group_id must be set."
  type = object({
    context                            = optional(string, null)
    instance                           = optional(string, null)
    zones                              = optional(list(string), null)
    deploy_capacity_reservation_groups = optional(bool, false)
    capacity_reservation_group_id      = optional(string, null)
    reservations = optional(map(object({
      sku = optional(object({
        name     = string
        capacity = string
      }))
      zone = optional(string)
    })), {})
  })
  default = null
  validation {
    condition     = var.capacity_reservation_groups == null || try(var.capacity_reservation_groups.capacity_reservation_group_id != null, false)
    error_message = "capacity_reservation_groups.capacity_reservation_group_id must be set when capacity_reservation_groups is provided. CRGs are provisioned via base-infra — ensure the CRG ARM ID is available before referencing it here."
  }
}

#Proximity Placement Group is not supported with capacity reservation, so this variable is used to control the deployment of proximity placement group based on whether capacity reservation is enabled or not, if capacity reservation is enabled then proximity placement group will not be deployed and vice versa.
variable "deploy_proximity_placement_group" {
  type    = bool
  default = false
}
