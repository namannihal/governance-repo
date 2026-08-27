#
# Copyright 2025 LSEG & Microsoft. All rights reserved.
#

#-----------------------------
# - LSEG Required Variables
#-----------------------------
variable "org_id" {
  type        = string
  description = "(Required) Three letter code representing organization/tenant/CSP."
}

variable "app_id" {
  type        = string
  description = "(Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used."
}

variable "environment" {
  type        = string
  description = "(Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars)."
}

variable "location" {
  type        = string
  description = "(Required) Location of the resource group."
}

#-----------------------------
# - LSEG Optional Variables
#-----------------------------
variable "instance" {
  type        = string
  description = "(Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int)."
  default     = "01"
}

variable "context" {
  type        = string
  description = "(Optional) Application context information for the resource(s) (max 10 chars)."
  default     = "gallery"
}

variable "tags" {
  type        = map(any)
  description = "(Optional) Tags to be set on each resource."
  default     = {}
}

#-----------------------------
# - Solution Pattern Variable
#-----------------------------
variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the Resource group for Azure Compute Gallery creation."
}

variable "description" {
  type        = string
  description = "(Optional) Description of the Azure Compute Gallery."
  default     = "Azure Compute Gallery for VM images"
}

variable "subscription_id" {
  type        = string
  description = "(Required) The Subscription ID for the Azure resources."
}

variable "key_vault_id" {
  type        = string
  description = "(Required) The ID of the Key Vault for disk encryption."
}

variable "image_definitions" {
  type = map(object({
    os_type            = string # "Windows" or "Linux"
    os_name            = string # "windows-server" or "ubuntu" or "rhel"
    os_version         = string # "2022-standard" or "20.04-lts"
    architecture       = string # "x64" or "Arm64"
    image_type         = string # "byorimage" or "sigimage" or custom
    publisher          = string # e.g., "MicrosoftWindowsServer" or "Canonical"
    offer              = string # e.g., "WindowsServer" or "UbuntuServer"
    sku                = string # e.g., "2022-datacenter" or "20.04-LTS"
    hyper_v_generation = optional(string)
    description        = optional(string)
    security_type      = optional(string) # "TrustedLaunch" or "ConfidentialVM" or "ConfidentialVMSupported" or null
  }))
  description = "(Optional) Map of image definitions to create in the Azure Compute Gallery."
  default     = {}
}
