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
  description = "(Reqired). The Id of the Shared Resources Resource Group. This Resource group usually contains the shared resources(non-routeable vnet)."
  type        = string
}
variable "shared_nrtbl_vnet_id" {
  description = "(Reqired). The ARM Resource Id of the Non-Routeable Virtual Network in shared Resource group."
  type        = string
}
variable "privateendpoint_subnet_id" {
  type        = string
  description = "(Required) Specify the subnet id where the private endpoit will be created."
}


variable "firewall_private_ip_address" {
  description = "(Optional). Azure firewall private Ip Address. Used when creating routes to firewall during route table creation."
  type        = string
  default     = null
}

variable "storage_account_config" {
  type        = any
  description = "(Optional) Storage account configuration map"
  default     = {}
}

variable "nfsv3_enabled" {
  type        = bool
  description = "(Optional) Enable NFSv3 protocol for storage accounts."
  default     = false
}

variable "key_vault_id" {
  type        = string
  description = "(Optional) The ID of the Key Vault"
  default     = null
}

variable "app_key_vault_id" {
  type        = string
  description = "(Optional) The ID of the Key Vault for webapp - a1a52161tstkvappeus201"
  default     = null
}

variable "resource_group_name" {
  type        = string
  description = "(Optional) The name of the resource group"
  default     = null
}

variable "linux_vm_config" {
  type = any
}

variable "is_hns_enabled" {
  type        = bool
  description = "(Optional) Enable Hierarchical Namespace (HNS) for storage accounts."
  default     = false
}

variable "vm_user_login_group_id" {
  type        = string
  description = "Object ID of the ENTRA group for VM User Login role."
}

variable "vm_admin_login_group_id" {
  type        = string
  description = "Object ID of the ENTRA group for VM Administrator Login role."
}