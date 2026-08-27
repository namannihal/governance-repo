variable "subscription_id" {
  type        = string
  description = "(Required) The Azure Subscription ID to use."
}
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

variable "resource_group_name" {
  type        = string
  description = "(Required) Name of the Resource Group in which to create the resource."
}

#-----------------------------
# - LSEG Optional Variables
#-----------------------------
variable "instance" {
  type        = string
  description = "(Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int)."
  default     = null
}

variable "context" {
  type        = string
  description = "(Optional) Application context information for the resource(s) (max 10 chars)."
  default     = null
}

variable "tags" {
  type        = map(any)
  description = "(Optional) Tags to be set on each resource."
  default     = {}
}

# #--------------------------
# # - Application gateway Variables
# #--------------------------
# variable "zones" {
#   type        = list(number)
#   description = "(Optional) Specifies a list of Availability Zones in which this Application Gateway should be located. Changing this forces a new Application Gateway to be created."
#   default     = null
# }

# variable "capacity" {
#   type        = number
#   description = "(Optional) The Capacity of the SKU to use for this Application Gateway. When using a V1 SKU this value must be between 1 and 32, and 1 to 125 for a V2 SKU. This property is optional if autoscale_configuration is set."
#   default     = null
# }

# variable "sku_name" {
#   description = "The Name of the SKU to use for this Application Gateway. Possible values are Standard_v2 and WAF_v2."
#   type        = string
#   default     = "WAF_v2"

#   validation {
#     condition     = contains(["Standard_v2", "WAF_v2"], var.sku_name)
#     error_message = "Valid values for sku_name are Standard_v2 and WAF_v2."
#   }
# }

# variable "sku_tier" {
#   description = "The Tier of the SKU to use for this Application Gateway. Possible values are Standard_v2 and WAF_v2."
#   type        = string
#   default     = "WAF_v2"

#   validation {
#     condition     = contains(["Standard_v2", "WAF_v2"], var.sku_tier)
#     error_message = "Valid values for sku_tier are Standard_v2 and WAF_v2."
#   }
# }

# variable "fips_enabled" {
#   type        = bool
#   default     = null
#   description = "(Optional) Is FIPS enabled on the Application Gateway?"
# }

# variable "global" {
#   type = object({
#     request_buffering_enabled  = bool
#     response_buffering_enabled = bool
#   })
#   default     = null
#   description = <<-EOT
#   (Optional) object containing variable for global configuration
#   object({
#     request_buffering_enabled  = "(Required) Whether Application Gateway's Request buffer is enabled."
#     response_buffering_enabled = "(Required) Whether Application Gateway's Response buffer is enabled."
#   })
#   EOT
# }

# variable "private_link_configuration" {
#   type = list(object({
#     name = string
#     ip_configuration = list(object({
#       name                          = string
#       subnet_id                     = string
#       private_ip_address_allocation = string
#       primary                       = bool
#       private_ip_address            = optional(string)
#     }))
#   }))
#   default     = null
#   description = <<-EOT
#   (Optional) list of object containing variable for private link configuration.
#   object({
#     name  = "(Required) The name of the private link configuration."
#     ip_configuration = list(object({
#       name                          = "(Required) The name of the IP configuration."
#       subnet_id                     = "(Required) The ID of the subnet the private link configuration should connect to."
#       private_ip_address_allocation = "(Required) The allocation method used for the Private IP Address. Possible values are Dynamic and Static."
#       primary                       = "(Required) Is this the Primary IP Configuration?"
#       private_ip_address            = "(optional) The Static IP Address which should be used"
#     })
#   })
#   EOT
# }

# variable "trusted_client_certificate" {
#   type = list(object({
#     name = string
#     data = string
#   }))
#   default     = null
#   description = <<-EOT
#   (Optional) list of object containing variable for trusted client certificate configuration
#   object({
#     name  = "(Required) The name of the Trusted Client Certificate that is unique within this Application Gateway."
#     data  = "(Required) The base-64 encoded certificate."
#   })
#   EOT
# }

# variable "trusted_root_certificate" {
#   type = list(object({
#     name                = string
#     data                = optional(string)
#     key_vault_secret_id = optional(string)
#   }))
#   default     = null
#   description = <<-EOT
#   (Optional) list of object containing variable for trusted root certificate configuration
#   object({
#     name                = "(Required) The Name of the Trusted Root Certificate to use."
#     data                = "(Optional) The contents of the Trusted Root Certificate which should be used. Required if key_vault_secret_id is not set."
#     key_vault_secret_id = "(Optional) The Secret ID of (base-64 encoded unencrypted pfx) Secret or Certificate object stored in Azure KeyVault. You need to enable soft delete for the Key Vault to use this feature. Required if data is not set."
#   })
#   EOT
# }

# variable "autoscale_configuration" {
#   type = object({
#     min_capacity = number
#     max_capacity = optional(number)
#   })
#   default     = null
#   description = <<-EOT
#   (Optional) Map containing variable autoscale_configuration of application gateway
#   object({
#     min_capacity = "(Required) Minimum capacity for autoscaling. Accepted values are in the range 0 to 100."
#     max_capacity = "(Optional) Maximum capacity for autoscaling. Accepted values are in the range 2 to 125."
#   })
#   EOT
# }

# variable "gateway_ip_configurations" {
#   type = list(object({
#     name      = string
#     subnet_id = string
#   }))
#   description = <<-EOT
#   (Required) Map containing gateway_ip_configurations of application gateway
#   object({
#     Name      = "(Required) The Name of this Gateway IP Configuration."
#     subnet_id = "(Required) The ID of the Subnet which the Application Gateway should be connected to."
#   })
#   EOT
# }

# variable "frontend_ports" {
#   type = list(object({
#     name = string
#     port = number
#   }))
#   description = <<-EOT
#   (Required) The Name and port used for this Frontend Port
#   object({
#     Name = "(Required) The name of the Frontend Port."
#     port = "(Required) The port used for this Frontend Port."
#   })
#   EOT
# }

# variable "frontend_ip_configurations" {
#   type = map(object({
#     name                            = string
#     subnet_id                       = optional(string)
#     private_ip_address              = optional(string)
#     private_ip_address_allocation   = optional(string)
#     public_ip_address_id            = optional(string)
#     private_link_configuration_name = optional(string)
#   }))
#   description = <<-EOT
#   (Required) Map containing frontend IP configurations
#   object({
#     Name                          = "(Required) The name of the Frontend IP Configuration."
#     subnet_id                     = "(Optional) The ID of the Subnet."
#     private_ip_address            = "(Optional) The Private IP Address to use for the Application Gateway."
#     private_ip_address_allocation = "(Optional) The Allocation Method for the Private IP Address. Possible values are Dynamic and Static."
#     public_ip_address_id          = "(Optional) The ID of a Public IP Address which the Application Gateway should use. The allocation method for the Public IP Address depends on the sku of this Application Gateway"
#   })
#   EOT
# }

# variable "backend_address_pools" {
#   type = list(object({
#     name         = string
#     fqdns        = optional(list(string))
#     ip_addresses = optional(list(string))
#   }))
#   description = <<-EOT
#   (Required) Map containing backend_address_pool of application gateway
#   object({
#     name         = "(Required) The name of the Backend Address Pool."
#     fqdns        = "(Optional) A list of FQDN's which should be part of the Backend Address Pool."
#     ip_addresses = "(Optional) A list of IP Addresses which should be part of the Backend Address Pool."
#   })
#   EOT
# }

# variable "backend_http_settings" {
#   type = list(object({
#     name                                = string
#     cookie_based_affinity               = string
#     path                                = optional(string)
#     port                                = number
#     request_timeout                     = optional(number)
#     probe_name                          = optional(string)
#     host_name                           = optional(string)
#     pick_host_name_from_backend_address = optional(bool, false)
#     affinity_cookie_name                = optional(string)
#     trusted_root_certificate_names      = optional(list(string))
#     authentication_certificate = optional(list(object({
#       name = string
#     })), [])
#     connection_draining = optional(object({
#       enabled           = bool
#       drain_timeout_sec = number
#     }), null)
#   }))
#   description = <<-EOT
#   (Required) Map containing backend_http_settings of application gateway
#   object({
#     name                                = "(Required) The name of the Backend HTTP Settings Collection."
#     cookie_based_affinity               = "(Required) Is Cookie-Based Affinity enabled? Possible values are Enabled and Disabled"
#     path                                = "(Optional) The Path which should be used as a prefix for all HTTP requests."
#     port                                = "(Required) The port which should be used for this Backend HTTP Settings Collection."
#     request_timeout                     = "(Optional) The request timeout in seconds, which must be between 1 and 86400 seconds. Defaults to 30."
#     probe_name                          = "(Optional) The name of an associated HTTP Probe."
#     host_name                           = "(Optional) Host header to be sent to backend servers. Cannot be set if pick_host_name_from_backend_address is set to True."
#     pick_host_name_from_backend_address = "(Optional) Whether host header should be picked from the host name of the backend server. Defaults to false."
#     affinity_cookie_name                = "(Optional) The name of the affinity cookie."
#     trusted_root_certificate_names      = "(Optional) A list of trusted_root_certificate names."
#     authentication_certificate          = optional(list(object({
#       name                              = "(Required) The Name of the Authentication Certificate to use."
#       data                              = "(Required) The contents of the Authentication Certificate which should be used."
#     })))
#     connection_draining = optional(object({
#         enabled           = "(Required) If connection draining is enabled or not."
#         drain_timeout_sec = "(Required) The number of seconds connection draining is active. Acceptable values are from 1 second to 3600 seconds." 
#     }))
#   })
#   EOT
#   validation {
#     condition     = alltrue([for setting in var.backend_http_settings : (setting.pick_host_name_from_backend_address == false || setting.host_name == "")])
#     error_message = "If pick_host_name_from_backend_address is True, host_name cannot be set."
#   }
# }

# variable "http_listeners" {
#   type = list(object({
#     name                           = string
#     frontend_ip_configuration_name = string
#     frontend_port_name             = string
#     ssl_certificate_name           = optional(string)
#     protocol                       = string
#     require_sni                    = optional(bool)
#     listener_type                  = optional(string)
#     host_name                      = optional(string) # Required if listener_type = MultiSite and host_names = null
#     host_names                     = optional(list(string), null)
#     firewall_policy_id             = optional(string)
#     ssl_profile_name               = optional(string)
#     custom_error_configuration = optional(list(object({
#       status_code           = string
#       custom_error_page_url = string
#     })), null)
#   }))
#   validation {
#     condition = alltrue([
#       for listener in var.http_listeners :
#       listener.host_names == null ? true : alltrue([
#         for host in listener.host_names : !contains(["*", "?"], host)
#       ])
#     ])
#     error_message = "Application Gateway listeners must specify FQDNs and not use wildcards such as `*` or `?`"
#   }
#   description = <<-EOT
#   (Required) Map containing http_listeners of application gateway
#   object({
#     name                           = "(Required) The Name of the HTTP Listener"
#     frontend_ip_configuration_name = "(Required) The Name of the Frontend IP Configuration used for this HTTP Listener."
#     frontend_port_name             = "(Required) The Name of the Frontend Port use for this HTTP Listener."
#     ssl_certificate_name           = "(Optional) The name of the associated SSL Certificate which should be used for this HTTP Listener."
#     protocol                       = "(Required) The Protocol to use for this HTTP Listener. Possible values are Http and Https."
#     require_sni                    = "(Optional) Should Server Name Indication be Required? Defaults to false."
#     listener_type                  = "(Optional) The listener type which should be used. Possible values are MultiSite and Basic."
#     host_name                      = "(Optional) The Hostname which should be used for this HTTP Listener. Setting this value changes Listener Type to 'Multi site'."
#     firewall_policy_id             = "(Optional) The firewall policy id which should be used as a HTTP Listener."
#     ssl_profile_name               = "(Optional) The name of the associated SSL Profile which should be used for this HTTP Listener."
#     custom_error_configuration     = list(object({
#       status_code                  = "(Required) Status code of the application gateway customer error. Possible values are HttpStatus403 and HttpStatus502"
#       custom_error_page_url        = "(Required) Error page URL of the application gateway customer error."
#     }))
#   })
#   EOT
# }

# variable "request_routing_rules" {
#   type = list(object({
#     name                        = string
#     rule_type                   = string
#     listener_name               = string
#     backend_address_pool_name   = optional(string)
#     priority                    = optional(number)
#     backend_http_settings_name  = optional(string)
#     redirect_configuration_name = optional(string)
#     url_path_map_name           = optional(string)
#     rewrite_rule_set_name       = optional(string)
#   }))
#   description = <<-EOT
#   (Required) Map containing request_routing_rules of application gateway
#   object({
#     name                        = "(Required) The Name of this Request Routing Rule."
#     rule_type                   = "(Required) The Type of Routing that should be used for this Rule. Possible values are Basic and PathBasedRouting."
#     listener_name               = "(Required) The Name of the HTTP Listener which should be used for this Routing Rule."
#     backend_address_pool_name   = "(Optional) The Name of the Backend Address Pool which should be used for this Routing Rule. Cannot be set if redirect_configuration_name is set."
#     priority                    = "(Optional) Rule evaluation order can be dictated by specifying an integer value from 1 to 20000 with 1 being the highest priority and 20000 being the lowest priority."
#     backend_http_settings_name  = "(Optional) The Name of the Backend HTTP Settings Collection which should be used for this Routing Rule. Cannot be set if redirect_configuration_name is set."
#     redirect_configuration_name = "(Optional) The Name of the Redirect Configuration which should be used for this Routing Rule. Cannot be set if either backend_address_pool_name or backend_http_settings_name is set."
#     url_path_map_name           = "(Optional) The Name of the URL Path Map which should be associated with this Routing Rule."
#     rewrite_rule_set_name       = "(Optional) The Name of the Rewrite Rule Set which should be used for this Routing Rule. Only valid for v2 SKUs."
#   })
#   EOT
# }

# variable "url_path_maps" {
#   type = list(object({
#     name                                = string
#     default_backend_http_settings_name  = optional(string)
#     default_backend_address_pool_name   = optional(string)
#     default_redirect_configuration_name = optional(string)
#     default_rewrite_rule_set_name       = optional(string)
#     path_rules = list(object({
#       name                        = string
#       paths                       = list(string)
#       backend_http_settings_name  = optional(string)
#       backend_address_pool_name   = optional(string)
#       redirect_configuration_name = optional(string)
#       rewrite_rule_set_name       = optional(string)
#       firewall_policy_id          = optional(string)
#     }))
#   }))
#   default     = []
#   description = <<-EOT
#   (Optional) List of object containing url path maps of application gateway
#   object({
#     name                                = "(Required) The Name of the URL Path Map."
#     default_backend_http_settings_name  = "(Optional) The Name of the Default Backend HTTP Settings Collection which should be used for this URL Path Map. Cannot be set if default_redirect_configuration_name is set."
#     default_backend_address_pool_name   = "(Optional) The Name of the Default Backend Address Pool which should be used for this URL Path Map. Cannot be set if default_redirect_configuration_name is set."
#     default_redirect_configuration_name = "(Optional) The Name of the Default Redirect Configuration which should be used for this URL Path Map. Cannot be set if either default_backend_address_pool_name or default_backend_http_settings_name is set."
#     default_rewrite_rule_set_name       = "(Optional) The Name of the Default Rewrite Rule Set which should be used for this URL Path Map. Only valid for v2 SKUs."
#     path_rules = list(object({
#       name                              = "(Required) The Name of the Path Rule."
#       paths                             = "(Required) A list of Paths used in this Path Rule."
#       backend_http_settings_name  = "(Optional) The Name of the Backend HTTP Settings Collection to use for this Path Rule. Cannot be set if redirect_configuration_name is set."
#       backend_address_pool_name   = "(Optional) The Name of the Backend Address Pool to use for this Path Rule. Cannot be set if redirect_configuration_name is set."
#       redirect_configuration_name = "(Optional) The Name of a Redirect Configuration to use for this Path Rule. Cannot be set if backend_address_pool_name or backend_http_settings_name is set."
#       rewrite_rule_set_name       = "(Optional) The Name of the Rewrite Rule Set which should be used for this URL Path Map. Only valid for v2 SKUs."
#       firewall_policy_id          = "(Optional) The ID of the Web Application Firewall Policy which should be used as an HTTP Listener."
#     }))
#   })
#   EOT
# }

# variable "probes" {
#   type = list(object({
#     name                                      = string
#     path                                      = string
#     interval                                  = number
#     protocol                                  = string
#     timeout                                   = number
#     unhealthy_threshold                       = optional(number)
#     host                                      = optional(string)
#     pick_host_name_from_backend_http_settings = optional(bool)
#     port                                      = optional(number)
#     minimum_servers                           = optional(number, 0)
#     match = optional(object({
#       body        = optional(string, null)
#       status_code = list(string)
#       }), { status_code = ["200-399"] }
#     )
#   }))
#   default     = []
#   description = <<-EOT
#   (Required) Map containing probes of application gateway
#   object({
#     name                                      = "(Required) The Name of the Probe."
#     path                                      = "(Required) The Type of Routing that should be used for this Rule. Possible values are Basic and PathBasedRouting."
#     interval                                  = "(Required) The Interval between two consecutive probes in seconds. Possible values range from 1 second to a maximum of 86,400 seconds."
#     protocol                                  = "(Required) The Protocol used for this Probe. Possible values are Http and Https."
#     timeout                                   = "(Required) The Timeout used for this Probe, which indicates when a probe becomes unhealthy. Possible values range from 1 second to a maximum of 86,400 seconds."
#     unhealthy_threshold                       = "(Required) The Unhealthy Threshold for this Probe, which indicates the amount of retries which should be attempted before a node is deemed unhealthy. Possible values are from 1 to 20."
#     host                                      = "(Optional) The Hostname used for this Probe. If the Application Gateway is configured for a single site, by default the Host name should be specified as 127.0.0.1, unless otherwise configured in custom probe. Cannot be set if pick_host_name_from_backend_http_settings is set to true."
#     pick_host_name_from_backend_http_settings = "(Optional) Whether the host header should be picked from the backend HTTP settings. Defaults to false."
#     port                                      = "(Optional) Custom port which will be used for probing the backend servers. The valid value ranges from 1 to 65535. In case not set, port from HTTP settings will be used. This property is valid for Standard_v2 and WAF_v2 only."
#     minimum_servers                           = "(Optional) The minimum number of servers that are always marked as healthy."
#     match = optional(object({
#       body        = "(Optional) A snippet from the Response Body which must be present in the Response."
#       status_code = "(Required) A list of allowed status codes for this Health Probe."
#     }))
#   })
#   EOT
# }

# variable "redirect_configurations" {
#   type = list(object({
#     name                 = string
#     redirect_type        = string
#     target_listener_name = optional(string)
#     target_url           = optional(string)
#     include_path         = optional(bool)
#     include_query_string = optional(bool)
#   }))
#   default     = []
#   description = <<-EOT
#   (Required) Map containing redirect_configurations of application gateway
#   object({
#     name                 = "(Required) Unique name of the redirect configuration block"
#     redirect_type        = "(Required) The type of redirect. Possible values are Permanent, Temporary, Found and SeeOther"
#     target_listener_name = "Optional) The name of the listener to redirect to. Cannot be set if target_url is set."
#     target_url           = "(Optional) The Url to redirect the request to. Cannot be set if target_listener_name is set."
#     include_path         = "(Optional) Whether or not to include the path in the redirected Url. Defaults to false"
#     include_query_string = "(Optional) Whether or not to include the query string in the redirected Url. Default to false"
#   })
#   EOT
# }

# variable "rewrite_rule_sets" {
#   type = list(object({
#     name = string
#     rewrite_rules = optional(list(object({
#       name          = string
#       rule_sequence = number
#       conditions = optional(list(object({
#         variable    = string
#         pattern     = string
#         ignore_case = optional(bool)
#         negate      = optional(bool)
#       })))
#       request_header_configurations = optional(list(object({
#         header_name  = string
#         header_value = string
#       })))
#       response_header_configurations = optional(list(object({
#         header_name  = string
#         header_value = string
#       })))
#       url = optional(object({
#         path         = optional(string, null)
#         query_string = optional(string, null)
#         components   = optional(string, null)
#         reroute      = optional(string, null)
#       }), null)
#     })))
#   }))

#   default = [
#     {
#       name = "lseg-security-headers-rewrite"
#       rewrite_rules = [
#         {
#           name          = "remove-server-headers"
#           rule_sequence = 100
#           response_header_configurations = [
#             {
#               header_name  = "Server"
#               header_value = ""
#             },
#             {
#               header_name  = "X-Powered-By"
#               header_value = ""
#             },
#             {
#               header_name  = "X-AspNet-Version"
#               header_value = ""
#             },
#             {
#               header_name  = "X-AspNetMvc-Version"
#               header_value = ""
#             }
#           ]
#         }
#       ]
#     }
#   ]

#   description = <<-EOT
#   list(object({
#     name = "(Required) Unique name of the rewrite rule set block"
#     rewrite_rules = optional(list(object({ 
#        name          = "(Required) Unique name of the rewrite rule block"
#        rule_sequence = "(Required) Rule sequence of the rewrite rule that determines the order of execution in a set."
#         conditions =  optional(list(object({
#           variable    = "(Required) The variable of the condition."
#           pattern     = "(Required) The pattern, either fixed string or regular expression, that evaluates the truthfulness of the condition"
#           ignore_case = "(Optional) Perform a case in-sensitive comparison."
#           negate      = "(Optional) Negate the result of the condition evaluation."
#         })))
#         request_header_configurations = optional(list(object({
#           header_name  = "(Required) Header name of the header configuration."
#           header_value = " (Required) Header value of the header configuration. To delete a request header set this property to an empty string."
#         }))) 
#         response_header_configurations = optional(list(object({
#           header_name  = "(Required) Header name of the header configuration."
#           header_value = "(Required) Header value of the header configuration. To delete a response header set this property to an empty string."
#         })))
#         url = optional(object({
#           path         = "(Optional) The URL path to rewrite."
#           query_string = "(Optional) The query string to rewrite."
#           components   = "(Optional) The components used to rewrite the URL. Possible values are path_only and query_string_only to limit the rewrite to the URL Path or URL Query String only."
#           reroute      = "(Optional) Whether the URL path map should be reevaluated after this rewrite has been applied."
#       }))
#       })))
#   }))
#   EOT
# }

# variable "ssl_profile" {
#   type = object({
#     name                                 = string
#     trusted_client_certificate_names     = optional(list(string), [])
#     verify_client_cert_issuer_dn         = optional(bool, false)
#     verify_client_certificate_revocation = optional(string)
#     ssl_policy = optional(object({
#       disabled_protocols   = optional(list(string), [])
#       policy_type          = optional(string)
#       policy_name          = optional(string, "AppGwSslPolicy20220101")
#       cipher_suites        = optional(list(string), [])
#       min_protocol_version = optional(string, "TLSv1_2")
#     }))
#   })

#   validation {
#     condition     = var.ssl_profile == null ? true : var.ssl_profile.ssl_policy == null ? true : alltrue([for cipher in var.ssl_profile.ssl_policy.cipher_suites : contains(["TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384", "TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256", "TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384", "TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256", "TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA384", "TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256", "TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256"], cipher)])
#     error_message = "The Chosen cipher suit is not aligned with LSEG security standards."
#   }

#   default     = null
#   description = <<-EOT
#   "(Optional) Application Gateway SSL profile"
#   object({
#     name                                 = "(Required) The name of the SSL Profile that is unique within this Application Gateway."
#     trusted_client_certificate_names     = "(Optional) The name of the Trusted Client Certificate that will be used to authenticate requests from clients."
#     verify_client_cert_issuer_dn         = "(Optional) Should client certificate issuer DN be verified? Defaults to false."
#     verify_client_certificate_revocation = "(Optional) Specify the method to check client certificate revocation status. Possible value is OCSP."
#     ssl_policy                           = "(Optional) a ssl_policy block"
#     disabled_protocols                   = "(Optional) A list of SSL Protocols which should be disabled on this Application Gateway. Possible values are TLSv1_0, TLSv1_1, TLSv1_2 and TLSv1_3."
#     policy_type                          = "(Optional) The Type of the Policy. Possible values are Predefined, Custom and CustomV2."
#     policy_name                          = "(Optional) The Name of the Policy e.g AppGwSslPolicy20170401S. Required if policy_type is set to Predefined. Possible values can change over time and are published here https://docs.microsoft.com/azure/application-gateway/application-gateway-ssl-policy-overview. Not compatible with disabled_protocols."
#     cipher_suites                        = "(Optional) A List of accepted cipher suites. for Possible values please refer https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_gateway#cipher_suites"
#     min_protocol_version                 = "(Optional) The minimal TLS version. Possible values are TLSv1_0, TLSv1_1, TLSv1_2 and TLSv1_3."
#   })
#   EOT
# }

# variable "firewall_policy_id" {
#   type        = string
#   description = "(Optional) ID of a Web Application Firewall Policy"
# }

# variable "identity_ids" {
#   type        = list(string)
#   description = "(Optional) A list of User Assigned Managed Identity IDs to be assigned to this Firewall Policy"
#   default     = null
# }

# variable "ssl_certificates" {
#   type = list(object({
#     name                = string
#     key_vault_secret_id = optional(string)
#     data                = optional(string)
#     password            = optional(string)
#   }))
#   description = "(Required) List of SSL certificates data for Application gateway"
# }

# variable "network_interface_ids" {
#   type = map(object({
#     network_interface_id  = string
#     ip_configuration_name = string
#   }))
#   default     = {}
#   description = <<-EOT
#   "(Optional) Map containing network_interface_id parameters"
#   object({
#     network_interface_id  = "(Required) The ID of the Network Interface. Changing this forces a new resource to be created."
#     ip_configuration_name = "(Required) The Name of the IP Configuration within the Network Interface which should be connected to the Backend Address Pool. Changing this forces a new resource to be created."
#   })
#   EOT
# }

#--------------------------
# - Required Variables for Application Gateway
#--------------------------
variable "agw_subnet_id" {
  type        = string
  description = "(Required) The ID of the Subnet which the Application Gateway should be connected to."
}

variable "keyvault_id" {
  type        = string
  description = "(Required) the ID of the Keyvault where WAF secrets are stored."
}

variable "waf_mode" {
  type        = string
  description = "(Required) The Web Application Firewall Mode. Possible values are Detection and Prevention."
  default     = "Prevention"
  validation {
    condition     = contains(["Detection", "Prevention"], var.waf_mode)
    error_message = "WAF mode must be either Detection or Prevention."
  }
}

variable "zones" {
  type        = list(string)
  description = "(Optional) Specifies a list of Availability Zones in which this Application Gateway should be located."
  default     = null
}

variable "capacity" {
  type        = number
  description = "(Optional) The Capacity of the SKU to use for this Application Gateway."
  default     = 2
}

variable "custom_rules" {
  type = map(object({
    action                         = string
    priority                       = number
    rule_type                      = string
    name                           = optional(string)
    enabled                        = optional(bool, true)
    rate_limit_threshold           = optional(number, 100)
    rate_limit_duration_in_minutes = optional(number, 1)
    group_rate_limit_by            = optional(string)
    match_conditions = map(object({
      match_values       = optional(list(string))
      operator           = string
      negation_condition = optional(bool, false)
      transforms         = optional(list(string), [])
      match_variables = map(object({
        variable_name = string
        selector      = optional(string)
      }))
    }))
  }))
  default     = {}
  description = "(Optional) One or more custom_rules blocks for WAF policy."
}

variable "backend_address_pools" {
  type = list(object({
    name         = string
    fqdns        = optional(list(string))
    ip_addresses = optional(list(string))
  }))
  description = "(Required) List of backend address pools."
}

variable "backend_http_settings" {
  type = list(object({
    name                                = string
    cookie_based_affinity               = string
    path                                = optional(string, "/")
    port                                = number
    protocol                            = optional(string, "Https")
    request_timeout                     = optional(number, 30)
    probe_name                          = optional(string)
    host_name                           = optional(string)
    pick_host_name_from_backend_address = optional(bool, false)
    # Required when backend uses HTTPS with a private/self-signed CA (e.g. CouchDB port 6984).
    # List the trusted_root_certificate names defined in var.trusted_root_certificates.
    trusted_root_certificate_names = optional(list(string), [])
    connection_draining = optional(object({
      enabled           = bool
      drain_timeout_sec = number
    }))
  }))
  description = "(Required) List of backend HTTP settings."
}

variable "http_listeners" {
  type = list(object({
    name                           = string
    frontend_ip_configuration_name = string
    frontend_port_name             = string
    protocol                       = string
    ssl_certificate_name           = optional(string)
    require_sni                    = optional(bool, false)
    listener_type                  = optional(string, "Basic")
    host_name                      = optional(string)
    host_names                     = optional(list(string))
    firewall_policy_id             = optional(string)
  }))
  description = "(Required) List of HTTP listeners."
}

variable "probes" {
  type = list(object({
    name                                      = string
    path                                      = string
    protocol                                  = string
    port                                      = optional(number)
    host                                      = optional(string)
    interval                                  = optional(number, 30)
    timeout                                   = optional(number, 30)
    unhealthy_threshold                       = optional(number, 3)
    pick_host_name_from_backend_http_settings = optional(bool, false)
    match = optional(object({
      body        = optional(string)
      status_code = list(string)
    }))
  }))
  description = "(Required) List of health probes."
}

variable "request_routing_rules" {
  type = list(object({
    name                        = string
    rule_type                   = string
    listener_name               = string
    priority                    = number
    backend_address_pool_name   = optional(string)
    backend_http_settings_name  = optional(string)
    rewrite_rule_set_name       = optional(string)
    redirect_configuration_name = optional(string)
    url_path_map_name           = optional(string)
  }))
  description = "(Required) List of request routing rules."
}

variable "ssl_certificates" {
  type = list(object({
    name                = string
    key_vault_secret_id = optional(string)
    path_of_certificate = optional(string)
    data                = optional(string)
    password            = optional(string)
  }))
  description = "(Required) List of SSL certificates for Application Gateway. Certificate payloads supplied through data, path_of_certificate, or TF_VAR_*_cert are expected to be base64-encoded PFX content."
}

variable "cert_password" {
  type        = string
  description = "(Optional) Shared password used with the base64-encoded PFX payload for App Gateway inline mode and AKV certificate import."
  default     = ""
  sensitive   = true
}

variable "couchdb_cert" {
  type        = string
  default     = ""
  description = "(Optional) Base64-encoded PFX payload from the previous stage for couchdb-cert."
  sensitive   = true
}

variable "qdct_cert" {
  type        = string
  default     = ""
  description = "(Optional) Base64-encoded PFX payload from the previous stage for qdct_cert."
  sensitive   = true
}

variable "hvpweb_cert" {
  type        = string
  default     = ""
  description = "(Optional) Base64-encoded PFX payload from the previous stage for hvpweb_cert."
  sensitive   = true
}

variable "guidancebre_cert" {
  type        = string
  default     = ""
  description = "(Optional) Base64-encoded PFX payload from the previous stage for guidancebre_cert."
  sensitive   = true
}

variable "estimatessdi_cert" {
  type        = string
  default     = ""
  description = "(Optional) Base64-encoded PFX payload from the previous stage for estimatessdi_cert."
  sensitive   = true
}

variable "estimatesbre_cert" {
  type        = string
  default     = ""
  description = "(Optional) Base64-encoded PFX payload from the previous stage for estimatesbre_cert."
  sensitive   = true
}

variable "brokerxl_cert" {
  type        = string
  default     = ""
  description = "(Optional) Base64-encoded PFX payload from the previous stage for brokerxl_cert."
  sensitive   = true
}

variable "broker_cert" {
  type        = string
  default     = ""
  description = "(Optional) Base64-encoded PFX payload from the previous stage for broker_cert."
  sensitive   = true
}

variable "guidance_cert" {
  type        = string
  default     = ""
  description = "(Optional) Base64-encoded PFX payload from the previous stage for guidance_cert."
  sensitive   = true
}

variable "collection_cert" {
  type        = string
  default     = ""
  description = "(Optional) Base64-encoded PFX payload from the previous stage for collection_cert."
  sensitive   = true
}

variable "actualsbre_cert" {
  type        = string
  default     = ""
  description = "(Optional) Base64-encoded PFX payload from the previous stage for actualsbre_cert."
  sensitive   = true
}

variable "qdct_dev_cert" {
  type        = string
  default     = ""
  description = "(Optional) Base64-encoded PFX payload from the previous stage for qdct-cert-dev."
  sensitive   = true
}

variable "hvpweb_dev_cert" {
  type        = string
  default     = ""
  description = "(Optional) Base64-encoded PFX payload from the previous stage for hvpweb-cert-dev."
  sensitive   = true
}

variable "guidancebre_dev_cert" {
  type        = string
  default     = ""
  description = "(Optional) Base64-encoded PFX payload from the previous stage for guidancebre-cert-dev."
  sensitive   = true
}

variable "estimatessdi_dev_cert" {
  type        = string
  default     = ""
  description = "(Optional) Base64-encoded PFX payload from the previous stage for estimatessdi-cert-dev."
  sensitive   = true
}

variable "estimatesbre_dev_cert" {
  type        = string
  default     = ""
  description = "(Optional) Base64-encoded PFX payload from the previous stage for estimatesbre-cert-dev."
  sensitive   = true
}

variable "brokerxl_dev_cert" {
  type        = string
  default     = ""
  description = "(Optional) Base64-encoded PFX payload from the previous stage for brokerxl-cert-dev."
  sensitive   = true
}

variable "broker_dev_cert" {
  type        = string
  default     = ""
  description = "(Optional) Base64-encoded PFX payload from the previous stage for broker-cert-dev."
  sensitive   = true
}

variable "guidance_dev_cert" {
  type        = string
  default     = ""
  description = "(Optional) Base64-encoded PFX payload from the previous stage for guidance-cert-dev."
  sensitive   = true
}

variable "collection_dev_cert" {
  type        = string
  default     = ""
  description = "(Optional) Base64-encoded PFX payload from the previous stage for collection-cert-dev."
  sensitive   = true
}

variable "actualsbre_dev_cert" {
  type        = string
  default     = ""
  description = "(Optional) Base64-encoded PFX payload from the previous stage for actualsbre-cert-dev."
  sensitive   = true
}

# ---------------------------------------------------------------------------
# Trusted Root Certificates — used to validate backend HTTPS connections.
# Only required for CouchDB (port 6984) which uses a private CA.
# CA cert data is auto-extracted from var.couchdb_cert (PFX) at apply time
# by scripts/extract-ca-cert.sh — no separate HashiCorp Vault entry needed.
# ---------------------------------------------------------------------------
variable "trusted_root_certificates" {
  type = list(object({
    name = string
  }))
  default     = []
  description = "(Optional) Names for trusted root certificates. CA cert is auto-extracted from the CouchDB PFX by scripts/extract-ca-cert.sh at apply time."
}

variable "qdct_qa_cert" {
  type        = string
  default     = ""
  description = "(Optional) Base64-encoded PFX payload from the previous stage for qdct-cert-qa."
  sensitive   = true
}

variable "hvpweb_qa_cert" {
  type        = string
  default     = ""
  description = "(Optional) Base64-encoded PFX payload from the previous stage for hvpweb-cert-qa."
  sensitive   = true
}

variable "guidancebre_qa_cert" {
  type        = string
  default     = ""
  description = "(Optional) Base64-encoded PFX payload from the previous stage for guidancebre-cert-qa."
  sensitive   = true
}

variable "estimatessdi_qa_cert" {
  type        = string
  default     = ""
  description = "(Optional) Base64-encoded PFX payload from the previous stage for estimatessdi-cert-qa."
  sensitive   = true
}

variable "estimatesbre_qa_cert" {
  type        = string
  default     = ""
  description = "(Optional) Base64-encoded PFX payload from the previous stage for estimatesbre-cert-qa."
  sensitive   = true
}

variable "brokerxl_qa_cert" {
  type        = string
  default     = ""
  description = "(Optional) Base64-encoded PFX payload from the previous stage for brokerxl-cert-qa."
  sensitive   = true
}

variable "broker_qa_cert" {
  type        = string
  default     = ""
  description = "(Optional) Base64-encoded PFX payload from the previous stage for broker-cert-qa."
  sensitive   = true
}

variable "guidance_qa_cert" {
  type        = string
  default     = ""
  description = "(Optional) Base64-encoded PFX payload from the previous stage for guidance-cert-qa."
  sensitive   = true
}

variable "collection_qa_cert" {
  type        = string
  default     = ""
  description = "(Optional) Base64-encoded PFX payload from the previous stage for collection-cert-qa."
  sensitive   = true
}

variable "actualsbre_qa_cert" {
  type        = string
  default     = ""
  description = "(Optional) Base64-encoded PFX payload from the previous stage for actualsbre-cert-qa."
  sensitive   = true
}

variable "use_keyvault_certificates" {
  type        = bool
  description = "(Optional) Whether to use KeyVault for storing certificates. If true, managed identity will be created."
  default     = false
}

variable "identity_ids" {
  type        = list(string)
  description = "(Optional) A list of User Assigned Managed Identity IDs to be assigned to this Application Gateway"
  default     = null
}

variable "private_ip_address" {
  type        = string
  description = "(Required) The private IP address to use for the Application Gateway frontend configuration."
}
