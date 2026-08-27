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
#variable "instance" {
#  type        = string
#  description = "(Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int)."
#  default     = null
#}

#variable "context" {
#  type        = string
#  description = "(Optional) Application context information for the resource(s) (max 10 chars)."
#  default     = null
#}

variable "tags" {
  type        = map(any)
  description = "(Optional) Tags to be set on each resource."
  default     = {}
}

variable "keyvaults" {
  type = map(object({
    instance = string
    context  = string
    private_endpoint = object({
      subnet_id            = string
      is_manual_connection = optional(bool, false)
      static_ip_required   = optional(bool, false)
    })
  }))
}

#-----------------------------
# - Solution Pattern Variable
#-----------------------------
variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the Resource group for key vault creation."
}

variable "sku_name" {
  type        = string
  description = "(Optional) The Name of the Sku used for the Key Vault. Possible values are standard and premium."
  default     = "premium"
}

variable "enabled_for_deployment" {
  type        = bool
  description = "(Optional) Specifies whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault."
  default     = false
}

variable "enabled_for_disk_encryption" {
  type        = bool
  description = "(Optional) Specifies whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys."
  default     = false
}

variable "enabled_for_template_deployment" {
  type        = bool
  description = "(Optional) Specifies whether Azure Resource Manager is permitted to retrieve secrets from the key vault."
  default     = false
}

variable "network_acls" {
  type = object({
    bypass                     = optional(string, "None")
    default_action             = optional(string, "Deny")
    ip_rules                   = optional(list(string), [])
    virtual_network_subnet_ids = optional(list(string), [])
  })
  default     = {}
  nullable    = true
  description = <<-EOT
  (Optional) The network ACL configuration for the Key Vault.
  If not specified then the Key Vault will be created with a firewall that blocks access.
  Specify `null` to create the Key Vault with no firewall.

  - `bypass` - (Optional) Should Azure Services bypass the ACL. Possible values are `AzureServices` and `None`. Defaults to `None`.
  - `default_action` - (Optional) The default action when no rule matches. Possible values are `Allow` and `Deny`. Defaults to `Deny`.
  - `ip_rules` - (Optional) A list of IP rules in CIDR format. Defaults to `[]`.
  - `virtual_network_subnet_ids` - (Optional) When using with Service Endpoints, a list of subnet IDs to associate with the Key Vault. Defaults to `[]`.
  EOT
}

# variable "private_endpoint" {
#   type = object({
#     subnet_id                         = string
#     is_manual_connection              = optional(bool, false)
#     static_ip_required                = optional(bool, false)
#     private_connection_resource_id    = optional(string, null)
#     private_connection_resource_alias = optional(string, null)
#     ip_configuration = optional(map(object({
#       private_ip_address = string
#       subresource_name   = optional(string, "vault")
#       member_name        = optional(string, "default")
#     })), {})
#   })
#   description = <<-EOT
#   (Required) Private Endpoint variables for Keyvault:
#     subnet_id                         = "(Required) The ID of the Subnet from which Private IP Addresses will be allocated for this Private Endpoint. Changing this forces a new resource to be created."
#     is_manual_connection              = "(Optional) Does the Private Endpoint require Manual Approval from the remote resource owner? Changing this forces a new resource to be created."
#     static_ip_required                = "(Optional) Whether a Static IP is required to be assigned to Private Endpoint or not."
#     private_connection_resource_id    = "(Optional) The ID of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to. One of `private_connection_resource_id` or `private_connection_resource_alias` must be specified. Changing this forces a new resource to be created."
#     private_connection_resource_alias = "(Optional) The Service Alias of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to. One of private_connection_resource_id or private_connection_resource_alias must be specified. Changing this forces a new resource to be created."
#     ip_configuration = (Optional) map(object({
#     private_ip_address = "(Required) Specifies the static IP address within the private endpoint's subnet to be used. Changing this forces a new resource to be created."
#     subresource_name   = "(Optional) Specifies the subresource this IP address applies to."
#     member_name        = "(Optional) Specifies the member name this IP address applies to."
#   }))
#   EOT
# }

variable "key_vault_keys" {
  type = map(object({
    key_number      = string
    key_type        = optional(string, "RSA-HSM")
    key_size        = optional(number, 4096)
    not_before_date = optional(string, null)
    expiration_date = string
    key_opts        = list(string)
    rotation_policy = object({
      notify_before_expiry = string
      time_before_expiry   = string
      time_after_creation  = optional(string, null)
      expire_after         = string
    })
  }))
  description = <<-EOT
  (Optional) A map of Key vault key object variables:
    key_number = "(Required) Specifies key number for multiple keys to be created."
    key_type   = "(Optional) Specifies the Key Type to use for the Key Vault Key."
    key_size   = "(Optional) Specifies the Size of the RSA key to create in bytes. Allowed values are 1024, 2048, 3072 or 4096."
    not_before_date = "(Optional) Key not usable before the provided UTC datetime (Y-m-d'T'H:M:S'Z')."
    expiration_date = "(Required) Expiration UTC datetime (Y-m-d'T'H:M:S'Z')."
    key_opts        = "(Required) A list of JSON web key operations. Possible values include: decrypt, encrypt, sign, unwrapKey, verify and wrapKey."
    rotation_policy = (Optional) object({
      notify_before_expiry = "(Required) Expire a Key Vault Key after given duration as an ISO 8601 duration."
      time_before_expiry   = "(Required) Rotate automatically at a duration before expiry as an ISO 8601 duration."
      time_after_creation  = "(Optional) Rotate automatically at a duration after create as an ISO 8601 duration."
      expire_after         = "(Required) Expire a Key Vault Key after given duration as an ISO 8601 duration.
    })
  EOT
  default     = {}
}

variable "key_vault_secrets" {
  type = map(object({
    secret_number   = string
    value           = string
    content_type    = optional(string, null)
    not_before_date = optional(string, null)
    expiration_date = optional(string, null)
  }))
  description = <<-EOT
   (Optional) A map of key vault secrets to be created with following variables:
     secret_number   = "(Required) Specifies secret number for multiple secrets to be created."
     value           = "(Required) Specifies the value of the Key Vault Secret. Changing this will create a new version of the Key Vault Secret."
     content_type    = "(Optional) Specifies the content type of the Key Vault Secret."
     not_before_date = "(Optional) Key not usable before the provided UTC datetime (Y-m-d'T'H:M:S'Z')."
     expiration_date = "(Optional) Expiration UTC datetime (Y-m-d'T'H:M:S'Z')."
   EOT
  default     = {}
}

variable "key_vault_certificates" {
  type = map(object({
    cert_number            = string
    path_of_certificate    = optional(string, null)
    issuer_parameters_name = string
    ec_key_required        = bool
    curve                  = optional(string, "P-256")
    key_type               = string
    key_size               = optional(number, 2048)
    reuse_key              = bool
    action_type            = string
    content_type           = string
    key_usage              = list(string)
    trigger = object({
      days_before_expiry  = optional(number, null)
      lifetime_percentage = optional(string, null)
    })
    x509_certificate_properties = object({
      extended_key_usage = optional(list(string))
      subject            = string
      subject_alternative_names = object({
        dns_names = optional(list(string))
        emails    = optional(list(string))
        upns      = optional(list(string))
      })
      validity_in_months = string
    })
  }))
  description = <<-EOT
  (Optional) A map of Key vault certificates to be created using following variables:
    cert_number            = "(Required) Specifies certificate number for multiple certificates to be created."
    import_certificate     = "(Required) Choose to import certificate or to generate one."
    path_of_certificate    = "(Optional) Provide the path of the existing certificate. (Required) in case of import_certificate as True."
    issuer_parameters_name = "(Required) The name of the Certificate Issuer. Changing this forces a new resource to be created."
    ec_key_required        = "(Required) Do you want to create an `EC` key?"
    curve                  = "(Optional) Specifies the curve to use when creating an EC key. Possible values are P-256, P-256K, P-384, and P-521.This field will be required in a future release if key_type is EC or EC-HSM. Changing this forces a new resource to be created."
    key_type               = "(Required) Specifies the type of key. Changing this forces a new resource to be created."
    key_size               = "(Optional) The size of the key used in the certificate. This property is required when using RSA keys. Changing this forces a new resource to be created."
    reuse_key              = "(Required) Is the key reusable? Changing this forces a new resource to be created."
    action_type            = "(Required) The Type of action to be performed when the lifetime trigger is triggerec. Changing this forces a new resource to be created."
    content_type           = "(Required) The Content-Type of the Certificate, such as application/x-pkcs12 for a PFX or application/x-pem-file for a PEM. Changing this forces a new resource to be created."
    key_usage              = "(Required) A list of uses associated with this Key. Possible values are cRLSign, dataEncipherment, decipherOnly, digitalSignature, encipherOnly, keyAgreement, keyCertSign, keyEncipherment and nonRepudiation. Changing this forces a new resource to be created."
    trigger = object({
      days_before_expiry  = optional(number, null)
      lifetime_percentage = optional(string, null)
    })
    x509_certificate_properties = object({
      extended_key_usage = "(Optional) A list of Extended/Enhanced Key Usages. Changing this forces a new resource to be created."
      subject            = "(Required) The Certificate's Subject. Changing this forces a new resource to be created."
      subject_alternative_names = list(object({
        dns_names = "(Optional) A list of alternative DNS names (FQDNs) identified by the Certificate. Changing this forces a new resource to be created."
        emails    = "(Optional) A list of email addresses identified by this Certificate. Changing this forces a new resource to be created."
        upns      = "(Optional) A list of User Principal Names identified by the Certificate. Changing this forces a new resource to be created."
      }))
      validity_in_months = "(Required) The Certificates Validity Period in Months. Changing this forces a new resource to be created."
    })
  }))
  EOT
  default     = {}
}