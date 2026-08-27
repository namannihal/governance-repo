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

variable "secondary_location" {
  type        = string
  description = "(Optional) The secondary region for SQL MI failover.."
  default     = null
  validation {
    condition = (
      can(regex("^[a-zA-Z0-9]{1,20}$", var.secondary_location)) || null == var.secondary_location
    )
    error_message = "Location Name is not Valid. Ensure the CLI Name is provided here."
  }
}

#-----------------------------
# - LSEG Optional Variables
#-----------------------------
variable "instance" {
  type        = string
  description = "(Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int)."
  default     = null
  validation {
    condition = (
      can(regex("^[0-9]{0,3}$", var.instance)) || null == var.instance
    )
    error_message = "The Instance does not follow customer naming structure. 0 to 3 digits are allowed."
  }
}

variable "instancepe" {
  type        = string
  description = "(Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int)."
  default     = null
  validation {
    condition = (
      can(regex("^[0-9]{0,3}$", var.instancepe)) || null == var.instancepe
    )
    error_message = "The Instance does not follow customer naming structure. 0 to 3 digits are allowed."
  }
}

variable "tags" {
  type        = map(any)
  description = "(Optional) Tags to be set on each resource."
  default     = {}
}

#-------------------------------------------
# - Platform and Application Dependencies
#-------------------------------------------
variable "resource_group_name" {
  description = "(Reqired). The name of the Shared Resources Resource Group. This Resource group usually contains the shared resources(non-routeable vnet)."
  type        = string
}

variable "resource_group_name_secondary_location" {
  description = "(Optional). The name of the Shared Resources Resource Group in the secondary region. This Resource group usually contains the shared resources(non-routeable vnet)."
  type        = string
  default     = null
}

variable "shared_nrtbl_vnet_id" {
  description = "(Reqired). The ARM Resource Id of the Non-Routeable Virtual Network in shared Resource group."
  type        = string
}

variable "shared_nrtbl_vnet_id_failover" {
  description = "(Reqired). The ARM Resource Id of the Non-Routeable Virtual Network in shared Resource group in secondary region."
  type        = string
  default     = null
}

variable "platform_rtbl_vnet_id" {
  description = "(Optional). The ARM Resource Id of the Routeable Virtual Network in platform Resource group."
  type        = string
  default     = null
}

variable "rt_vnet_pe_subnet_id" {
  description = "(Optional). The ARM Resource Id of the subnet in Routeable Virtual Network in platform Resource group."
  type        = string
  default     = null
}

// to be used only if PE for failover is enabled. needs to be added in CPD module.
variable "rt_vnet_pe_subnet_id_failover" {
  description = "(Optional). The ARM Resource Id of the subnet in Routeable Virtual Network in platform Resource group for failover instance."
  type        = string
  default     = null
}

#-------------------------------------------
# - Key Vault Variables
#-------------------------------------------
variable "key_vault_config" {
  description = <<-EOT
    Object with cofigration for the Keyvault. As defined below
        context                         = context to be used for KeyVaults being deployed resources.
        context_failover                = context to be used for KeyVaults being deployed resources in secondary region.
        instance                        = instance to be used for KeyVaults being deployed resources.
        instance_failover               = instance to be used for KeyVaults being deployed resources in secondary region.
        deploy_kv_and_pe                = (Optional). Boolean to deploy KeyVault and Private Endpoint for KeyVault. Default is true.
        deploy_kv_and_pe_failover       = (Optional). Boolean to deploy KeyVault and Private Endpoint for KeyVault in secondary region. Default is true.
        key_vault_id                    = (Optional). KeyVault ID to be used for Private Endpoint for KeyVault. Required if deploy_kv_and_pe is false.
        key_vault_id_failover           = (Optional). KeyVault ID to be used for Private Endpoint for KeyVault in secondary region. Required if deploy_kv_and_pe is false.
        enabled_for_deployment          = (Optional). Boolean to enable KeyVault for deployment. Default is false.
        enabled_for_disk_encryption     = (Optional). Boolean to enable KeyVault for disk encryption. Default is true.
        enabled_for_template_deployment = (Optional). Boolean to enable KeyVault for template deployment. Default is false.
        soft_delete_retention_days      = (Optional) The number of days that items should be retained for once soft-deleted.
        sku_name                        = (Optional). Sku name for KeyVault. Default is premium.
        network_acls = (Optional). Object with network ACLs for KeyVault. As defined below
            {
                bypass                     = (Optional). Specifies whether traffic is bypassed for Azure services. Default is None. Possible values are None, AzureServices, Logging, Metrics, or AzureServices,Logging,Metrics.
                default_action             = (Optional). Specifies the default action of allow or deny when no other rules match. Default is Deny. Possible values are Allow and Deny.
                ip_rules                   = (Optional). List of IP addresses or CIDR ranges to whitelist. Only IPV4 addresses are allowed. This list must not include IP address ranges within Azure services. This list can include IP addresses ranges from on-premises ranges.
                virtual_network_subnet_ids = (Optional). List of virtual network subnet ids to whitelist. This list must not include IP address ranges within Azure services.
            }
        private_endpoint = (Optional). Object with private endpoint configuration for KeyVault. As defined below
            {
                is_manual_connection              = (Optional). Boolean to indicate if the connection is manual. Default is false.
                static_ip_required                = (Optional). Boolean to indicate if static IP is required. Default is false.
                private_connection_resource_alias = (Optional). Resource alias of the private connection. Required if is_manual_connection is true.
                kv_ip_configuration = (Optional). Object with IP configuration for KeyVault. As defined below
                    {
                        private_ip_address = (Required). Private IP address of the IP configuration.
                        subresource_name   = (Optional). Subresource name of the IP configuration. Default is vault.
                        member_name        = (Optional). Member name of the IP configuration. Default is default.
                    }
            }
  EOT
  type = object({
    context                         = optional(string, null)
    context_failover                = optional(string, null)
    instance                        = optional(string, null)
    instance_failover               = optional(string, null)
    deploy_kv_and_pe                = optional(bool, true)
    deploy_kv_and_pe_failover       = optional(bool, true)
    key_vault_id                    = optional(string, null)
    key_vault_id_failover           = optional(string, null)
    enabled_for_deployment          = optional(bool, false)
    enabled_for_disk_encryption     = optional(bool, true)
    enabled_for_template_deployment = optional(bool, false)
    soft_delete_retention_days      = optional(number, 30)
    sku_name                        = optional(string, "premium")
    network_acls = optional(object({
      bypass                     = optional(string, "None")
      default_action             = optional(string, "Deny")
      ip_rules                   = optional(list(string), [])
      virtual_network_subnet_ids = optional(list(string), [])
    }), {})
    private_endpoint = optional(object({
      is_manual_connection              = optional(bool, false)
      static_ip_required                = optional(bool, false)
      private_connection_resource_alias = optional(string, null)
      kv_ip_configuration = optional(map(object({
        private_ip_address = string
        subresource_name   = optional(string, "vault")
        member_name        = optional(string, "default")
      })), {})
      }),
      {
        is_manual_connection              = false
        static_ip_required                = false
        private_connection_resource_alias = null
      }
    )
  })
  validation {
    condition = contains([
      "standard",
      "premium"
    ], var.key_vault_config.sku_name)
    error_message = "Sku name must be 'standard' or 'premium'."
  }
  validation {
    condition     = (var.key_vault_config.deploy_kv_and_pe == false && var.key_vault_config.key_vault_id != null) || (var.key_vault_config.deploy_kv_and_pe == true && var.key_vault_config.key_vault_id == null)
    error_message = "In key_vault_config block, when deploy_kv_and_pe is set to false, key_vault_id need not be provided and if deploy_kv_and_pe is set to true, key_vault_id need not be provided."
  }
  validation {
    condition     = var.key_vault_config.soft_delete_retention_days >= 30 && var.key_vault_config.soft_delete_retention_days <= 90
    error_message = "Soft retention period can be between 30 to 90 (the default) days."
  }
}

variable "sql_mi" {
  type        = any
  description = "(Required) Map of SQL Managed Instance configurations. Each key is an MI identifier (e.g. mi_11) and the value contains all MI-specific settings."
}

