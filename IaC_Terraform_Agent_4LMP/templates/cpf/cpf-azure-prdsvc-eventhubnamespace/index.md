---
version: 1.2.3
available_versions:
  - 1.2.3
  - 1.2.2
  - 1.2.1
  - 1.2.0
  - 1.1.2
---

<!-- BEGIN_TF_DOCS -->
# Event Hub Namespace module


## Overview

This terraform module creates a Event Hub Namespace resource.

## Prerequisites

- `Resource Group`, `Virtual Network` (To be called if not existing).
- `Subnet` to be used by the Private endpoint and the VM Network Interface IP Configs.
- `Network Security Group` to be associated with the Subnet.
- `Route Table` to be associated with the Subnet.
- `Keyvault` module to store the Customer Managed Key (CMK) and other required secrets.
- `Privateendpoint` module to create a private connection to the Keyvault.
- Optional modules and resources:
  - `User Assigned Identity` modules for the identity purpose.
  - `time_sleep` resource block to wait for the secret to get created in keyvault.

## Guidance

#### Usage

###### AzureRM 3.x to 4.x Upgrade Notes for EventhubNamespace

Product Impact -- Medium

Users in azurerm 3.x migrating to 4.x  need to perform the following changes

- The deprecated `zone_redundant` property has been removed.
- The `minimum_tls_version` property now defaults to 1.2

- Wiki link for [AzureRM 4.x Upgrade](https://gitlab.dx1.lseg.com/groups/app/app-51310/azure/prdsvc/terraform/-/wikis/Terraform-AzureRM-Provider-Upgrade:-Version-3.x-to-4.x/eventhubnamespace) for details on the upgrade process.

For more details, refer to the official [AzureRM 4.x Upgrade Guide](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/4.0-upgrade-guide)

#### Others

- This module creates and manages an Event Hub Namespace in a dedicated Event Hub Cluster or a Shared Cluster.
- Due to the limitation of the current Azure API, once an EventHub Namespace has been assigned an identity, it cannot be removed.
- This module supports Geo Replication Disaster Recovery configuartion as an optional feature. When enabled, this module automatically creates a secondary Event Hub Namespace.
- This module provisions the primary Event Hub Namespace by default, and optionally creates a secondary Event Hub Namespace if required. To Create Secondary Event Hub Namespace use the disaster_recovery_config variable to provide the secondary region, Identity configuration, CMK identity details. When disaster_recovery_config is provided the module creates the secondary namespace. This module no longer supports creation of the Geo Recovery pairing  internally. To create the Event Hub Namespace Geo-disaster recovery pairing use resource block azurerm_servicebus_namespace_disaster_recovery_config separately.
- This module support the creation of Event Hub Namespace Authorisation Rules and Schema Groups as an optional feature.
- Use `key_vault_tags` variable to define additional Key Vault Keys/Secret related tags in your product, and you can not have more than 2 tags (key-value pairs), as the product gets a default of 13 tags and Key Vault child resources support only 15 tags as the maximum limit. Reference link - [Key tags](https://learn.microsoft.com/en-us/azure/key-vault/keys/about-keys-details#key-tags)
- Use the `tags` variable to define additional tags related to the product (core). Note that the product already has a default of 13 tags, so if you are adding multiple additional tags (key-value pairs), ensure the total count does not exceed the limit supported by Azure resources. [Azure Resources Tag Limitation](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/tag-support)
- Zone_redundant must be set to false if the sku is Premium. For other skus zone_redundant can be set to either true or false.
- Use `key_vault_tags` variable to define additional Key Vault Key/Secret related tags in your product. Note that azure policies are enforcing a number N of tags for all products by default. Also note that Key Vault child resources support only 15 tags as the maximum limit. Therefore, please ensure the total count of tags enforced by policy and tags applied via variable does not exceed the limit. For example, if 10 tags are enforced via Azure policy, a maximum of 5 tags can be set via the `key_vault_tags` variable. Reference link - [Key tags](https://learn.microsoft.com/en-us/azure/key-vault/keys/about-keys-details#key-tags).
- Use the `tags` variable to define additional tags related to the product (core). Note that azure policies are enforcing a number N of tags for all products by default and that additional 3 tags are set on the main product via main terraform template.
If you are assigning additional tags (key-value pairs) via the `tags` variable, please ensure the total count does not exceed the limit supported by Azure resources. Reference link - [Azure Resources Tag Limitation](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/tag-support)
- Network_rulesets will default to public network access as disabled and allow trusted azure services as true with default_action as Allow. Network ruleset can be configured to allow selected virtual network rules and allow IP Firewall rules by getting a policy exemption of AZU-EH-AC_020. When Network ruleset configured, ensure default_action set as Deny.

#### Well-Architected Framework(WAF) for Eventhubnamespace

- Wiki link [WAF for Eventhubnamespace](https://gitlab.dx1.lseg.com/groups/app/app-51310/azure/prdsvc/terraform/-/wikis/Cloud-Products-Well-Architecture-Framework-Principles---WAF/Eventhubnamespace) for details on the WAF principles (Resiliency and Disaster Recovery(DR), Security, Cost Optimization and Operation Excellence).

#### Security Considerations

- As per security controls, this module enforces public network access to be disabled, by defaulting the variable `public_network_access_enabled` value to `false`.
- Since public network access is disabled, this module enforces the value of the network_rulesets.default_action to "Allow", i.e., the value that this property automatically gets in Azure when disabling the public network access.
- Though public network access is disabled, this module does support to specify IP rules or virtual network rules to control the inbound access to the Event Hub namespace by getting a policy exemption of AZU-EH-AC_020 and then setting default_action as Deny. Access to the resource is allowed only via private endpoints.
- Private Endpoint for the Event Hub Namespace can be managed via the Private Endpoint cloud product.
- Customer-Managed-Key is only available on Eventhub namespaces with `Premium` sku.
- This module enables the mandatory Customer-Managed-Key (CMK) encryption of the Event Hub Namespace by default.
- The user can choose to create either `System Assigned Managed Identity` or `User Assigned Managed Identity` to access the CMK associated with the Event Hub Namespace. Accordingly the variable `use_system_assigned_identity` must be updated to true or false.
- The value for Identity type can be set to `SystemAssigned` , `UserAssigned` or `SystemAssigned, UserAssigned`.

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-EH-IA_010 | Azure Event Hub namespaces must have local authentication methods disabled | Event Hub namespaces should have local authentication methods (i.e. Shared Access Keys) disabled (What) within namespace Overview settings (How) in order to use modern robust and less prone to compromise authentication methods embedded within Entra ID (Why) | True | True  | Implemented by setting variable local_authentication_enabledsetting with default as false |
| 2. | AZU-EH-IA_020 | Use a Managed Identity for accessing Azure Resources | Event Hubs must enforce the use of a Managed Identity to authenticate to Azure resources where this is supported (What) within event hubs Access control settings (How) in order to remove the need to store credentials (Why) | True |True | Enforced using identity block. |
| 3. | AZU-EH-AC_010 | All Event Hub client access should be authorised using Event Hub level access permissions | All Event Hub client access should be authorised using Event Hub level access permissions (What) within event hubs Access control settings (How) in order to align all access permissions to least privilege such that if the client access credentials were compromised then the blast radius would be reduced (Why) | False | False  | Control cannot be implemented by technical configuration setting. |
| 4. | AZU-EH-AC_020 | Disable Public Network Access | Event Hubs must enforce a network guardrail (What) within namespace Networking settings (How) in order to prevent unauthorised access and data exposure to the internet (Why) | True | True | Implemented by setting variable public_network_access_enabled with default as false |
| 5. | AZU-EH-AC_030 | Event Hubs must use dedicated Consumer Group and access permissions per consuming application | Azure Event Hubs should use a dedicated Consumer Group and access permissions per consuming application (What) via event hub Consumer Group settings (How) in order to ensure consistency of event consumption and least privilege, non-repudiable consumer access (Why) | False | False | Control cannot be implemented by technical configuration setting. |
| 6. | AZU-EH-AU_010 | Send all diagnostic log categories to a central SOC Log Analytics workspace | Event Hubs must send all diagnostic logs to a central SOC Log Analytics workspace (What) within namespace Diagnostic settings (How) in order to support a security investigation after a security incident (Why) | False | False | To be implemented via policy |
| 7. | AZU-EH-AU_030 | Sending diagnostic logs to a partner solution requires CyberSecurity risk assessment and approval | Sending diagnostic logs to a partner solution requires CyberSecurity risk assessment and approval (What) within Diagnostic settings (How) in order to prevent sensitive data leakage to third parties outside of LSEG control (Why) | False | False | Control cannot be implemented by technical configuration setting.  |
| 8. | AZU-EH-SC_010 | Must use a dedicated CMK for Event Hubs Transparent Data Encryption that is persisted in an HSM backed Key Vault | Use a dedicated Event Hubs LSEG managed encryption at rest key persisted in an HSM backed Key Vault (What) within namespace Encryption settings (How) in order should Microsoft's key management platform become compromised LSEG can revoke access to exfiltrated encrypted data (Why) | True | True | CMK is generated and integrated in module for the Key Vault provided. This is not applicable for `standard` sku type and pester has been modified as needed |
| 9. | AZU-EH-SC_020 | Use a minimum of TLS version 1.2 for network connections to the Event Hubs control and data planes | Event Hubs must enforce a minimum TLS version of 1.2 (What) within its namespace Configuration settings (How) in order to use modern techniques to establish robust encrypted data channels over untrusted networks (Why) | True | True | Implemented by setting `minimum_tls_version = "1.2"` |
| 10. | AZU-EH-SC_030 | Azure App Deployment must not be able to corrupt the centrally managed private link private DNS zones when making a private endpoint for Event Hubs | Azure App Deployment must not be able to corrupt the centrally managed private link private DNS zones when making a private endpoint for Event Hubs | False | False | To be implemented via policy. |

## Changelog

- [azure-prdsvc-terraform-eventhubnamespace](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/event-hubs/event-hubs-features#namespace)

### Terraform Docs

- [azurerm_eventhub_namespace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_namespace)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.5.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm) | >=4.33 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) | >=4.33 |

## Resources

| Name | Type |
|------|------|
| [azurerm_eventhub_namespace.secondary](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_namespace) | resource |
| [azurerm_eventhub_namespace.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_namespace) | resource |
| [azurerm_eventhub_namespace_authorization_rule.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_namespace_authorization_rule) | resource |
| [azurerm_eventhub_namespace_customer_managed_key.secondary](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_namespace_customer_managed_key) | resource |
| [azurerm_eventhub_namespace_customer_managed_key.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_namespace_customer_managed_key) | resource |
| [azurerm_eventhub_namespace_schema_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_namespace_schema_group) | resource |
| [azurerm_key_vault_key.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key) | resource |
| [azurerm_role_assignment.this_cmk](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.this_cmk_secondary](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_authorization_rules"></a> [authorization_rules](#input_authorization_rules) | (Optional) A map of Event Hub Namespace Authorization Rules configuation objects as defined below:<br/>object({<br/>  name   = "(Required) Specifies the name of the Authorization Rule."<br/>  listen = "(Optional) Grants listen access to this this Authorization Rule."<br/>  send   = "(Optional) Grants send access to this this Authorization Rule."<br/>  manage = "(Optional) Grants manage access to this this Authorization Rule. When this property is true - both listen and send must be too."<br/>}) | <pre>map(object({<br/>    name   = string<br/>    listen = optional(bool, false)<br/>    send   = optional(bool, false)<br/>    manage = optional(bool, false)<br/>  }))</pre> | `null` | no |
| <a name="input_auto_inflate_enabled"></a> [auto_inflate_enabled](#input_auto_inflate_enabled) | (Optional) Is Auto Inflate enabled for the EventHub Namespace? | `bool` | `false` | no |
| <a name="input_capacity"></a> [capacity](#input_capacity) | (Optional) Specifies the Capacity / Throughput Units for a Standard SKU namespace. Default capacity has a maximum of 2, but can be increased in blocks of 2 on a committed purchase basis. Defaults to 1. | `number` | `1` | no |
| <a name="input_cmk_key_name"></a> [cmk_key_name](#input_cmk_key_name) | (optional) Key name to be used (max 127 chars) | `string` | `null` | no |
| <a name="input_cmk_rotation_policy"></a> [cmk_rotation_policy](#input_cmk_rotation_policy) | (Optional) A rotation policy block as defined below<br/>object({<br/>  notify_before_expiry = "(Optional) Expire a Key Vault Key after given duration as an ISO 8601 duration."<br/>  time_before_expiry   = "(Optional) Rotate automatically at a duration before expiry as an ISO 8601 duration."<br/>  time_after_creation  = "(Optional) Rotate automatically at a duration before expiry as an ISO 8601 duration."<br/>  expire_after         = "(Optional) Expire a Key Vault Key after given duration as an ISO 8601 duration."<br/>}) | <pre>object({<br/>    notify_before_expiry = string<br/>    time_before_expiry   = string<br/>    time_after_creation  = optional(string, null)<br/>    expire_after         = string<br/>  })</pre> | <pre>{<br/>  "expire_after": "P365D",<br/>  "notify_before_expiry": "P358D",<br/>  "time_after_creation": null,<br/>  "time_before_expiry": "P7D"<br/>}</pre> | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_create_role_assignment"></a> [create_role_assignment](#input_create_role_assignment) | Whether to create the Key Vault Crypto Service Encryption User role assignment. Set to false if the role assignment already exists. | `bool` | `true` | no |
| <a name="input_customer_managed_key"></a> [customer_managed_key](#input_customer_managed_key) | (Required) An customer_managed_key block as defined below<br/>object({<br/>  key_vault_id                      = "(Required) The resource ID of the Key Vault where the Key Vault Key resides."<br/>  expiration_date                   = "(Required) Expiration UTC datetime (Y-m-d'T'H:M:S'Z')."<br/>  identity_id                       = "(Optional) The resource ID of the User Assigned Identity that has access to the key. Required if `use_system_assigned_identity` is set to false."<br/>  identity_principal_id             = "(Optional) The principal ID of the User Assigned Identity that has access to the key. Required if `use_system_assigned_identity` is set to false."<br/>  infrastructure_encryption_enabled = "(Required) Used to specify whether enable Infrastructure Encryption (Double Encryption). Changing this forces a new resource to be created."<br/>  use_system_assigned_identity      = "(Required) Indicate that system assigned identity should be used for CMK or not. Defaults to `false`"<br/>}) | <pre>object({<br/>    key_vault_id                      = string<br/>    expiration_date                   = string<br/>    identity_id                       = optional(string, null)<br/>    identity_principal_id             = optional(string, null)<br/>    infrastructure_encryption_enabled = bool<br/>    use_system_assigned_identity      = bool<br/>  })</pre> | n/a | yes |
| <a name="input_dedicated_cluster_id"></a> [dedicated_cluster_id](#input_dedicated_cluster_id) | (Optional) Specifies the ID of the EventHub Dedicated Cluster where this Namespace should created. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_disaster_recovery_config"></a> [disaster_recovery_config](#input_disaster_recovery_config) | (Optional) A disaster recovery configuration block as defined below. These value are required only when you need to create a secondary Event Hub Namespace for the Disaster Recovery.<br/>object({<br/>  secondary_region      = "(Required) The name of the Azure region where the secondary event hub namespace will be created. Please choose among the reginal pairs only.<br/>  identity = object({<br/>    type         = "(Optional) Specifies the type of Managed Service Identity that should be configured on this Event Hub Namespace. Possible values are `SystemAssigned` or `UserAssigned`. Defaults to `SystemAssigned`"<br/>    identity_ids = "(Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this EventHub namespace."<br/>  })<br/>  customer_managed_key = object({<br/>  identity_id                       = "(Optional) The resource ID of the User Assigned Identity that has access to the key. Required if `use_system_assigned_identity` is set to false."<br/>  identity_principal_id             = "(Optional) The principal ID of the User Assigned Identity that has access to the key. Required if `use_system_assigned_identity` is set to false."<br/>  })<br/>  })<br/>  network_rulesets = object({<br/>    default_action                = "(Optional) The default action of the network ruleset. Possible values are `Allow` and `Deny`. Defaults to `Allow`."<br/>    trusted_service_access_enabled = "(Optional) Whether Trusted Microsoft Services are allowed to bypass firewall. Defaults to true."<br/>    virtual_network_rule          = "(Optional) A list of Virtual Network Rule objects as defined below."<br/>    list(object({<br/>      subnet_id = "(Required) The ID of the Subnet to which this Virtual Network Rule applies."<br/>      ignore_missing_virtual_network_service_endpoint = "(Optional) Whether to ignore missing Virtual Network Service Endpoint. Defaults to true."<br/>    }))<br/>    ip_rule                       = "(Optional) A list of IP Rule objects as defined below."<br/>    list(object({<br/>      ip_mask = "(Required) The IP Mask to which this IP Rule applies."<br/>      action  = "(Optional) The action of the IP Rule. Possible values are `Allow` and `Deny`. Defaults to `Allow`."<br/>    }))<br/>  }) | <pre>object({<br/>    secondary_region              = string<br/>    secondary_resource_group_name = string<br/>    identity = object({<br/>      type         = optional(string, "SystemAssigned")<br/>      identity_ids = optional(list(string), null)<br/>    })<br/>    customer_managed_key = object({<br/>      identity_id           = optional(string, null)<br/>      identity_principal_id = optional(string, null)<br/>    })<br/>    network_rulesets = optional(object({<br/>      default_action                 = optional(string, "Allow")<br/>      trusted_service_access_enabled = optional(bool, true)<br/>      virtual_network_rule = optional(list(object({<br/>        subnet_id                                       = string<br/>        ignore_missing_virtual_network_service_endpoint = optional(bool, true)<br/>      })), [])<br/>      ip_rule = optional(list(object({<br/>        ip_mask = string<br/>        action  = optional(string, "Allow")<br/>      })), [])<br/>      }), {<br/>      default_action                 = "Allow"<br/>      trusted_service_access_enabled = true<br/>      virtual_network_rule           = []<br/>      ip_rule                        = []<br/>    })<br/>  })</pre> | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_identity"></a> [identity](#input_identity) | (Optional) An identity block as defined below<br/>object({<br/>  type         = "(Required) Specifies the type of Managed Service Identity that should be configured on this Event Hub Namespace. Possible values are SystemAssigned or UserAssigned."<br/>  identity_ids = "(Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this EventHub namespace."<br/>}) | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string))<br/>  })</pre> | <pre>{<br/>  "identity_ids": null,<br/>  "type": "SystemAssigned"<br/>}</pre> | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_key_vault_tags"></a> [key_vault_tags](#input_key_vault_tags) | (Optional) Key Vault related tags to be set on key vault child resources. | `map(any)` | `{}` | no |
| <a name="input_local_authentication_enabled"></a> [local_authentication_enabled](#input_local_authentication_enabled) | (Optional) Enable or disable local authentication for Event Hub Namespace. Defaults to false. | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_maximum_throughput_units"></a> [maximum_throughput_units](#input_maximum_throughput_units) | (Optional) Specifies the maximum number of throughput units when Auto Inflate is Enabled. Valid values range from 1 - 20. | `number` | `null` | no |
| <a name="input_minimum_tls_version"></a> [minimum_tls_version](#input_minimum_tls_version) | (Optional) The minimum supported TLS version for this EventHub Namespace. Valid values are: 1.0, 1.1 and 1.2. Defaults to 1.2. | `string` | `"1.2"` | no |
| <a name="input_namespace_schema_group"></a> [namespace_schema_group](#input_namespace_schema_group) | (Optional) A map of Event Hub Namespace Schema Group objects as defined below:<br/>object({<br/>  name                 = "(Required) Specifies the name of this schema group. Changing this forces a new resource to be created."<br/>  schema_compatibility = "(Optional) Specifies the compatibility of this schema group. Possible values are `None`, `Backward`, `Forward`."<br/>  schema_type          = "(Optional) Specifies the Type of this schema group. Possible values are `Avro`, `Unknown`."<br/>}) | <pre>map(object({<br/>    name                 = string<br/>    schema_compatibility = optional(string, "Backward")<br/>    schema_type          = optional(string, "Avro")<br/>  }))</pre> | `null` | no |
| <a name="input_network_rulesets"></a> [network_rulesets](#input_network_rulesets) | (Optional) An object of network_rulesets block as defined below.<br/>object({<br/>  default_action                = "(Optional) The default action of the network ruleset. Possible values are `Allow` and `Deny`. Defaults to `Allow`."<br/>  trusted_service_access_enabled = "(Optional) Whether Trusted Microsoft Services are allowed to bypass firewall. Defaults to true."<br/>  virtual_network_rule          = "(Optional) A list of Virtual Network Rule objects as defined below."<br/>  list(object({<br/>    subnet_id = "(Required) The ID of the Subnet to which this Virtual Network Rule applies."<br/>    ignore_missing_virtual_network_service_endpoint = "(Optional) Whether to ignore missing Virtual Network Service Endpoint. Defaults to true."<br/>  }))<br/>  ip_rule                       = "(Optional) A list of IP Rule objects as defined below."<br/>  list(object({<br/>    ip_mask = "(Required) The IP Mask to which this IP Rule applies."<br/>    action  = "(Optional) The action of the IP Rule. Possible values are `Allow` and `Deny`. Defaults to `Allow`."<br/>  }))<br/> }) | <pre>object({<br/>    default_action                 = optional(string, "Allow")<br/>    trusted_service_access_enabled = optional(bool, true)<br/>    virtual_network_rule = optional(list(object({<br/>      subnet_id                                       = string<br/>      ignore_missing_virtual_network_service_endpoint = optional(bool, true)<br/>    })), [])<br/>    ip_rule = optional(list(object({<br/>      ip_mask = string<br/>      action  = optional(string, "Allow")<br/>    })), [])<br/>  })</pre> | <pre>{<br/>  "default_action": "Allow",<br/>  "ip_rule": [],<br/>  "trusted_service_access_enabled": true,<br/>  "virtual_network_rule": []<br/>}</pre> | no |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_public_network_access_enabled"></a> [public_network_access_enabled](#input_public_network_access_enabled) | (Optional) Enable or disable public network access for Event Hub Namespace. Defaults to false. | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input_sku) | (Optional) Defines which tier to use. Valid options are Basic, Standard, and Premium. Please note that setting this field to Premium will force the creation of a new resource. | `string` | `"Standard"` | no |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |
| <a name="input_trusted_service_access_enabled"></a> [trusted_service_access_enabled](#input_trusted_service_access_enabled) | (Optional) Whether Trusted Microsoft Services are allowed to bypass firewall. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_default_primary_connection_string"></a> [default_primary_connection_string](#output_default_primary_connection_string) | The Event Hub Namespace default primary connection string. |
| <a name="output_id"></a> [id](#output_id) | The ID of the created Event Hub Namespace. |
| <a name="output_name"></a> [name](#output_name) | The name of the created Event Hub Namespace. |
| <a name="output_resource"></a> [resource](#output_resource) | The Event Hub Namespace resource. |
| <a name="output_secondary_id"></a> [secondary_id](#output_secondary_id) | The ID of the Service Bus Namespace created. |
<!-- END_TF_DOCS -->
