#--------------------------
# Subnet Variables
#--------------------------
variable "subnets" {
  type = map(object({
    context           = string
    address_prefix    = string
    service_endpoints = optional(list(string), [])
    routes = map(object({
      name                   = string
      address_prefix         = string
      next_hop_type          = string
      next_hop_in_ip_address = string
    }))
    security_rules = map(object({
      name                                       = string
      description                                = optional(string)
      priority                                   = number
      direction                                  = string
      access                                     = string
      protocol                                   = string
      source_port_range                          = optional(string)
      source_port_ranges                         = optional(list(string))
      destination_port_range                     = optional(string)
      destination_port_ranges                    = optional(list(string))
      source_address_prefix                      = optional(string)
      source_address_prefixes                    = optional(list(string))
      destination_address_prefix                 = optional(string)
      destination_address_prefixes               = optional(list(string))
      source_application_security_group_ids      = list(string)
      destination_application_security_group_ids = list(string)
    }))
    delegation = list(object({
      delegation_name         = string
      service_delegation_name = string
      actions                 = list(string)
    }))
  }))
  description = "(Required) Subnet definitions."
}
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
    error_message = "The org ID does not follow naming structure."
  }
}

variable "app_id" {
  type        = string
  description = "(Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-123456', for the purpose of naming resources only 6 number will be used."
  validation {
    condition = (
      can(regex("^[0-9]{5}$", var.app_id))
    )
    error_message = "The app ID does not follow naming structure."
  }
}

variable "environment" {
  type        = string
  description = "(Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars)."
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

variable "location_short" {
  type        = string
  description = "(Required) Short name of location of the resource group."
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
    error_message = "The Instance does not follow naming structure. 0 to 3 digits are allowed."
  }
}

variable "context" {
  type        = string
  description = "(Optional) Application context information for the resource(s) (max 10 chars)."
  default     = null
  validation {
    condition = (
      can(regex("^[a-zA-Z0-9]{1,10}$", var.context)) || null == var.context
    )
    error_message = "The context does not follow naming structure."
  }
}

variable "tags" {
  type        = map(any)
  description = "(Optional) Tags to be set on each resource."
  default     = {}
}

variable "resource_group_name" {
  type        = string
  description = "(Required) Name of the Resource Group in which to create the resource."
}

variable "virtual_network_id" {
  type        = string
  description = "(Required) The ID of the Virtual Network to associate with subnets."
}

#--------------------------
# Route Table Variables
#--------------------------
variable "routable_rules" {
  type = map(map(object({
    name                   = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = string
  })))
  description = "(Optional) The routes in the route table"
  default     = {}
}