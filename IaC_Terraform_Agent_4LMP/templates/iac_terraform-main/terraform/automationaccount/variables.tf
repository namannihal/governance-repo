#
# Copyright 2025 LSEG & Microsoft. All rights reserved.
#

#------------------------------------------
# - Mandatory Variables
#------------------------------------------
variable "org_id" {
  description = "(Required) Three letter code representing organization/tenant/CSP."
  type        = string
}

variable "app_id" {
  description = "(Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix."
  type        = string
}

variable "environment" {
  description = "(Required) The environment where the resource is deployed. Given as abbreviation (max 3 chars)."
  type        = string
}

variable "location" {
  description = "(Required) Location of the resource group."
  type        = string
}

variable "resource_group_name" {
  description = "(Required) Name of the Resource Group in which to create the automation account."
  type        = string
}

variable "sku_name" {
  description = "(Required) The SKU of the account. Possible values are Basic and Free."
  type        = string
  default     = "Basic"
}

variable "identity" {
  description = <<-EOT
    (Optional) An identity block:
    - type: Specifies the type of Managed Service Identity (SystemAssigned or UserAssigned)
    - identity_ids: List of User Assigned Managed Identity IDs (required when type is UserAssigned)
  EOT
  type = object({
    type         = string
    identity_ids = optional(list(string))
  })
  default = {
    type         = "SystemAssigned"
    identity_ids = null
  }
}

#------------------------------------------
# - Optional Variables
#------------------------------------------
variable "context" {
  description = "(Optional) Application context information for the resource(s) (max 10 chars)."
  type        = string
  default     = null
}

variable "instance" {
  description = "(Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int)."
  type        = string
  default     = null
}

variable "tags" {
  description = "(Optional) Tags to be set on each resource."
  type        = map(any)
  default     = {}
}

#------------------------------------------
# - Runbook Configuration
#------------------------------------------
variable "runbook_var" {
  description = <<-EOT
    (Optional) Runbook configuration map. Each entry defines a runbook with:
    - name: Runbook name
    - runbook_type: Type (PowerShell, PowerShellWorkflow, Python3, etc.)
    - log_progress: Enable progress logging (true/false)
    - log_verbose: Enable verbose logging (true/false)
    - description: Runbook description
    - publish_content_link: Content source URI and optional version/hash
    - content: Direct runbook content (alternative to publish_content_link)
  EOT
  type = map(object({
    name         = string
    runbook_type = string
    log_progress = string
    log_verbose  = string
    publish_content_link = optional(object({
      uri     = string
      version = optional(string, null)
      hash = optional(object({
        algorithm = string
        value     = string
      }), null)
    }), null)
    description              = optional(string, null)
    content                  = optional(string, null)
    log_activity_trace_level = optional(number)
    draft = optional(object({
      edit_mode_enabled = optional(bool, false)
      content_link = optional(object({
        uri     = string
        version = optional(string, null)
        hash = optional(object({
          algorithm = string
          value     = string
        }), null)
      }), null)
      output_types = optional(string, null)
      parameters = optional(list(object({
        key           = string
        type          = string
        mandatory     = optional(bool, false)
        position      = optional(string, null)
        default_value = optional(string, null)
      })), null)
    }), null)
  }))
  default = null
}

#------------------------------------------
# - Optional Automation Variables
#------------------------------------------
variable "int_var" {
  description = "(Optional) Map of integer automation variables."
  type = map(object({
    name        = string
    description = optional(string, null)
    value       = optional(number, null)
  }))
  default = null
}

variable "int_var_iterator" {
  description = "(Optional) Set of keys from int_var to iterate over. Required when int_var contains sensitive values."
  type        = set(string)
  default     = []
}

variable "bool_var" {
  description = "(Optional) Map of boolean automation variables."
  type = map(object({
    name        = string
    description = optional(string, null)
    value       = optional(bool, null)
  }))
  default = null
}

variable "bool_var_iterator" {
  description = "(Optional) Set of keys from bool_var to iterate over. Required when bool_var contains sensitive values."
  type        = set(string)
  default     = []
}

variable "string_var" {
  description = "(Optional) Map of string automation variables."
  type = map(object({
    name        = string
    description = optional(string, null)
    value       = optional(string, null)
  }))
  default = null
}

variable "string_var_iterator" {
  description = "(Optional) Set of keys from string_var to iterate over. Required when string_var contains sensitive values."
  type        = set(string)
  default     = []
}

variable "object_var" {
  description = "(Optional) Map of object automation variables."
  type = map(object({
    name        = string
    description = optional(string, null)
    value       = optional(string, null)
  }))
  default = null
}

variable "object_var_iterator" {
  description = "(Optional) Set of keys from object_var to iterate over. Required when object_var contains sensitive values."
  type        = set(string)
  default     = []
}

variable "datetime_var" {
  description = "(Optional) Map of datetime automation variables."
  type = map(object({
    name        = string
    description = optional(string, null)
    value       = optional(string, null)
  }))
  default = null
}

#------------------------------------------
# - Webhook Configuration
#------------------------------------------
variable "webhook_var" {
  description = "(Optional) Map of webhook configurations for runbooks."
  type = map(object({
    name                = string
    expiry_time         = string
    enabled             = optional(bool, true)
    runbook_name        = string
    run_on_worker_group = optional(string, null)
    parameters          = optional(map(any), {})
    uri                 = optional(string, null)
  }))
  default = null
}

#------------------------------------------
# - Credential Configuration
#------------------------------------------
variable "credential_var" {
  description = "(Optional) Map of credential configurations. Note: Policy may restrict credential storage."
  type = map(object({
    name        = string
    username    = string
    password    = string
    description = optional(string, null)
  }))
  default = null
}

variable "credential_var_iterator" {
  description = "(Optional) Set of keys from credential_var to iterate over. Required when credential_var contains sensitive values."
  type        = set(string)
  default     = []
}

#------------------------------------------
# - Hybrid Worker Configuration
#------------------------------------------
variable "hybrid_runbook_worker_group_var" {
  description = "(Optional) Map of hybrid runbook worker groups."
  type = map(object({
    name            = string
    credential_name = optional(string)
  }))
  default = null
}

variable "hybrid_runbook_worker_var" {
  description = "(Optional) Map of hybrid runbook workers."
  type = map(object({
    worker_group_name = string
    worker_id         = string
    vm_resource_id    = string
  }))
  default = null
}

#------------------------------------------
# - Encryption Configuration
#------------------------------------------
variable "encryption" {
  description = "(Optional) Customer-managed key encryption configuration."
  type = object({
    key_vault_key_id          = string
    user_assigned_identity_id = optional(string, null)
  })
  default = null
}
