---
version: 1.2.3
available_versions:
  - 1.2.3
  - 1.2.2
  - 1.2.1
  - 1.2.0
  - 1.1.1
---

<!-- BEGIN_TF_DOCS -->
# Service Bus Namespace module


## Overview

This terraform module creates a Service Bus Namespace and associated resources.

## Prerequisites

- A `key vault` to store the Customer Managed Key and other required secrets.
- A Subnet in the targeted Virtual Network for various private endpoints created for the dependent resources.

## Prerequisites

- `Resource Group`, `Virtual Network` (To be called if not existing).
- `Subnet` to be used by the Private endpoint.
- `Network Security Group` to be associated with the Subnet.
- `Route Table` to be associated with the Subnet.
- `Key Vault` to store the Customer Managed Key (CMK) and other required secrets.
- `Private Endpoint` to create a private connection to the Keyvault.
- Optional modules and resources:
  - `User Assigned Identity` for identity purposes. Two may be required if enabling gro-replication.
  - `time_sleep` resource block to wait for the key vault private endpoint to be registered.

## Guidance

#### Usage

##### AzureRM 3.x to 4.x Upgrade Notes for servic bus namespace

Product Impact -- Low

Users in azurerm 3.x migrating to 4.x  need to perform the following changes

- The deprecated `zone_redundant` property has been removed.

- Wiki link for [AzureRM 4.x Upgrade](https://gitlab.dx1.lseg.com/groups/app/app-51310/azure/prdsvc/terraform/-/wikis/Terraform-AzureRM-Provider-Upgrade:-Version-3.x-to-4.x/servicbusnamespace) for details on the upgrade process.

For more details, refer to the official [AzureRM 4.x Upgrade Guide](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/4.0-upgrade-guide)

#### Others

- At least one of the 3 permissions below needs to be set for Service Bus Authorization Rules: `listen`, `send` or `manage`
- If a pre-created User Assigned Managed Identity is assigned to the Namespace, then it should have the role **"Key Vault Crypto Service Encryption User"** assigned with the Scope being the Key Vault.
- The assigned messaging units (capacity) are always a multiplier of the amount of partitions (premium_messaging_partitions) in a namespace, and are equally distributed across the partitions. For example, in a namespace with 16MU and 4 partitions, each partition will be assigned 4MU.
- This module provisions the **primary Service Bus namespace by default**, and optionally creates a **secondary namespace** if required. To Create Secondary Service Bus Nampespace use the `disaster_recovery_config` variable to provide the secondary region, Identity configuration, CMK identity details. When `disaster_recovery_config` is provided the module creates the secondary namespace. This module no longer supports creation of the Geo Recovery pairing  internally. To create the Service Bus Geo-disaster recovery pairing use resource block `azurerm_servicebus_namespace_disaster_recovery_config` separately.
- When using the Service Bus Geo-disaster recovery feature, ensure not to pair a partitioned namespace with a non-partitioned namespace.
- Use `key_vault_tags` variable to define additional Key Vault Key/Secret related tags in your product. Note that azure policies are enforcing a number N of tags for all products by default. Also note that Key Vault child resources support only 15 tags as the maximum limit. Therefore, please ensure the total count of tags enforced by policy and tags applied via variable does not exceed the limit. For example, if 10 tags are enforced via Azure policy, a maximum of 5 tags can be set via the `key_vault_tags` variable. Reference link - [Key tags](https://learn.microsoft.com/en-us/azure/key-vault/keys/about-keys-details#key-tags).
- Use the `tags` variable to define additional tags related to the product (core). Note that azure policies are enforcing a number N of tags for all products by default and that additional 3 tags are set on the main product via main terraform template.
If you are assigning additional tags (key-value pairs) via the `tags` variable, please ensure the total count does not exceed the limit supported by Azure resources. Reference link - [Azure Resources Tag Limitation](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/tag-support)

#### Well-Architected Framework(WAF) for Servicebusnamespace

- Wiki link [WAF for Servicebusnamespace](https://gitlab.dx1.lseg.com/groups/app/app-51310/azure/prdsvc/terraform/-/wikis/Cloud-Products-Well-Architecture-Framework-Principles---WAF/Servicebusnamespace) for details on the WAF principles (Resiliency and Disaster Recovery(DR), Security, Cost Optimization and Operation Excellence).

#### Security Considerations

- This version creates only `Premium` Tier Service Bus to enforce the control **AZU-SB-AC_020: Disable Public Network Access** as the creation of Private Endpoint is only supported in Premium Tier. All the controls are implemented as per `Premium` Tier.
- Once customer-managed key encryption has been enabled, it cannot be disabled.
- The default name of the key vault key created for customer-managed key encryption, is using the primary service bus namespace name suffixed by `-key`.
- When using the Service Bus Geo-disaster recovery feature the same key vault key is used for both customer-managed key encryption of the primary and the secondary namespace.

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-SB-IA_010 | Azure Service Bus namespaces must have local authentication methods disabled | Service Bus namespaces should have local authentication methods disabled (What) within Overview settings (How) in order to use modern robust and less prone to compromise authentication methods embedded within Entra ID (Why) | True | True | Implemented by setting `local_auth_enabled = false`. |
| 2. | AZU-SB-IA_020 | Use a Managed Identity for accessing Azure Resources | Service Bus must enforce the use of a Managed Identity to authenticate to Azure resources where this is supported (What) within target Access control settings (How) in order to remove the need to store credentials (Why) | True | True | Enforced using `identity` block. |
| 3. | AZU-SB-AC_020 | Disable Public Network Access | Service Bus must enforce a network guardrail (What) within Networking settings (How) in order to prevent unauthorised access and data exposure to the internet (Why) | True | True | Implemented by setting `public_network_access_enabled = false`. |
| 4. | AZU-SB-AU_010 | Send all diagnostic log categories to a central SOC Log Analytics workspace | Service Bus must send all diagnostic logs to a central SOC Log Analytics workspace (What) within Diagnostic settings (How) in order to support a security investigation after a security incident (Why) | False | False | To be implemented via policy. |
| 5. | AZU-SB-AU_020 | Send all diagnostic log categories to a central SOC Storage Account | Service Bus must send all diagnostic logs to a central SOC Storage Account (What) within Diagnostic settings (How) In order to provide an immutable copy to adhere to compliance requirements (Why) | False | False | To be implemented via policy. |
| 6. | AZU-SB-CP_010 | Enable MU auto-inflation up to an appropriate maximum | Enable Messaging Unit auto-inflation up to an appropriate maximum (What) within Scale settings (How) in order to ensure appropriate service availability where necessary by allowing Service Hubs to auto-scale under load (whilst setting a maximum scale to avoid DoW attacks) (Why) | False | False | Control cannot be implemented by technical configuration. Only MU Capacity can be configured using `capacity`. |
| 7. | AZU-SB-SC_010 | Must use a dedicated CMK for Service Bus Transparent Data Encryption that is persisted in an HSM backed Key Vault | Use a dedicated Service Bus LSEG managed encryption at rest key persisted in an HSM backed Key Vault (What) within Encryption settings (How) in order should Microsoft's key management platform become compromised LSEG can revoke access to exfiltrated encrypted data (Why) | True | True | CMK is generated and integrated in module for the Key Vault provided. |
| 8. | AZU-SB-SC_020 | Use a minimum of TLS version 1.2 for network connections to the Service Bus control and data planes | Service Bus must enforce a minimum TLS version of 1.2 (What) within its Configuration settings (How) in order to use modern techniques to establish robust encrypted data channels over untrusted networks (Why) | True | True | Implemented by setting `minimum_tls_version = "1.2"`. |
| 9. | AZU-SB-SC_030 | Azure App Deployment must not be able to corrupt the centrally managed private link private DNS zones when making a private endpoint for Service Bus | Service Bus must have an Azure DeployIfNotExists policy to update the centrally managed private link private DNS zones with its private A record (What) via Policy to management group mapping (How) to ensure there is no ability for the Azure App Deployment team to have authorisation over these zones that could allow them to corrupt this file and impact service availability (Why) | False | False | To be implemented via policy. |
| 10. | AZU-SB-SC_040 | Service Bus must have a data classification tag | Service Bus must have a data classification tag (What) via its Tags settings (How) in order to differentiate assets technical control requirements and to assist Security Operations in prioritising possible data breach mitigation responses (Why) | False | False | To be implemented via policy. Any additional tags can be added using `tags`. |

## SMCF Controls

| S. No.  | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|---------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types.<br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc.<br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC<br><br>Documentation | True | This control will be implemented using resource naming module.<br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames) |
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC<br><br>Policy | True | This control will be implemented using `tags` parameter.<br><br>This control is achieved by custom policy as described in the [clear listing page](https://dev.azure.com/LSEGroup/Foundation/_git/azu-plat-policy) from where it inherits all the mandatory tags. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties.<br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration. | Policies<br><br>Iac<br><br>Policies<br><br>Iac | True | This control will be implemented by having all the `Mandate` and most of the `Optional` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring) | SMCF-OPS-03-02: Define and automate resource operation and security log collection<br><br><br>SMCF-OPS-03-03: Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs) | Policy<br><br><br>Documentation<br><br><br>Documentation | True | This control will be implemented by `DINE` Policy.<br><br><br>[Monitoring Azure Service Bus](https://learn.microsoft.com/en-us/azure/service-bus-messaging/monitor-service-bus?tabs=AzureDiagnostics)<br><br><br>[Cloud monitoring service level objectives](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/monitor/service-level-objectives)<br><br>[Supported Metrics for Service Bus](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-servicebus-namespaces-metrics) |
| 5. | [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC<br><br>Documentation | False | This control is implemented through the Service Bus Geo-disaster recovery feature, which can be enabled via the `disaster_recovery_config` variable.<br><br>[Azure Service Bus Geo-disaster recovery](https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-geo-dr) |
| 6. | [SMCF-OPS-07: Resource Protection](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-07-01: Prevent accidental or malicious deletion of production resources<br><br>SMCF-OPS-07-02: Prevent accidental misconfiguration of key production resources | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard based on application team requirement.<br><br>[Lock your resources to protect your infrastructure](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json) |
| 7. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package and has a JIT implementation in place.<br><br>[Service Bus authentication and authorization](https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-authentication-and-authorization) |

## Changelog

[azure_prdsvc_terraform_servicebusnamespace](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-messaging-overview)
- [Premium Messaging Partitions](https://learn.microsoft.com/en-us/azure/service-bus-messaging/enable-partitions-premium)

### Terraform Docs

- [azurerm_servicebus_namespace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_namespace.html)

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
| [azurerm_key_vault_key.this_cmk](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key) | resource |
| [azurerm_role_assignment.this_cmk](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.this_cmk_secondary](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_servicebus_namespace.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_namespace) | resource |
| [azurerm_servicebus_namespace.this_secondary](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_namespace) | resource |
| [azurerm_servicebus_namespace_authorization_rule.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_namespace_authorization_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_authorization_rules"></a> [authorization_rules](#input_authorization_rules) | (Optional) A map of servicebus_namespace_authorization_rule object as defined below. This creates a `azurerm_servicebus_namespace_authorization_rule` for each item in the map:<br/>Key   = "(Required) Specifies the name of the Service Bus Namespace Authorization Rule. Should be unique for each namespace."<br/>Value = object({<br/>  listen = "(Optional) Grants listen access to this this Authorization Rule. Defaults to `false`."<br/>  send   = "(Optional) Grants send access to this this Authorization Rule. Defaults to `false`."<br/>  manage = "(Optional) Grants manage access to this this Authorization Rule. When this property is `true` - both `listen` and `send` must be too. Defaults to `false`."<br/>}) | <pre>map(object({<br/>    listen = optional(bool)<br/>    send   = optional(bool)<br/>    manage = optional(bool)<br/>  }))</pre> | `{}` | no |
| <a name="input_capacity"></a> [capacity](#input_capacity) | (Optional) Specifies the capacity. When sku is `Premium`, capacity can be `1`, `2`, `4`, `8` or `16`. | `number` | `1` | no |
| <a name="input_cmk_key_name"></a> [cmk_key_name](#input_cmk_key_name) | (optional) Key name to be used (max 127 chars) | `string` | `null` | no |
| <a name="input_cmk_rotation_policy"></a> [cmk_rotation_policy](#input_cmk_rotation_policy) | (Optional) A rotation policy block as defined below<br/>object({<br/>  notify_before_expiry = "(Optional) Expire a Key Vault Key after given duration as an ISO 8601 duration."<br/>  time_before_expiry   = "(Optional) Rotate automatically at a duration before expiry as an ISO 8601 duration."<br/>  time_after_creation  = "(Optional) Rotate automatically at a duration before expiry as an ISO 8601 duration."<br/>  expire_after         = "(Optional) Expire a Key Vault Key after given duration as an ISO 8601 duration."<br/>}) | <pre>object({<br/>    notify_before_expiry = string<br/>    time_before_expiry   = string<br/>    time_after_creation  = optional(string, null)<br/>    expire_after         = string<br/>  })</pre> | <pre>{<br/>  "expire_after": "P365D",<br/>  "notify_before_expiry": "P358D",<br/>  "time_after_creation": null,<br/>  "time_before_expiry": "P7D"<br/>}</pre> | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_create_role_assignment"></a> [create_role_assignment](#input_create_role_assignment) | Whether to create the Key Vault Crypto Service Encryption User role assignment. Set to false if the role assignment already exists. | `bool` | `true` | no |
| <a name="input_customer_managed_key"></a> [customer_managed_key](#input_customer_managed_key) | (Required) An customer_managed_key block as defined below<br/>object({<br/>  key_vault_id                      = "(Required) The resource ID of the Key Vault where the Key Vault Key resides."<br/>  infrastructure_encryption_enabled = "(Optional) Used to specify whether enable Infrastructure Encryption (Double Encryption). Changing this forces a new resource to be created."<br/>  expiration_date                   = "(Required) Expiration UTC datetime (Y-m-d'T'H:M:S'Z')."<br/>  identity_id                       = "(Required) The resource ID of the User Assigned Identity that has access to the key."<br/>  identity_principal_id             = "(Required) The principal ID of the User Assigned Identity that has access to the key."<br/>}) | <pre>object({<br/>    key_vault_id                      = string<br/>    infrastructure_encryption_enabled = optional(bool, null)<br/>    expiration_date                   = string<br/>    identity_id                       = string<br/>    identity_principal_id             = string<br/>  })</pre> | n/a | yes |
| <a name="input_disaster_recovery_config"></a> [disaster_recovery_config](#input_disaster_recovery_config) | (Optional) A disaster recovery configuration block as defined below. These value are required only when you need to create a secondary Service Bus Namespace for the Disaster Recovery.<br/>object({<br/>  secondary_region = "(Required) The name of the Azure region where the secondary service bus namespace will be created. Please choose among the regional pairs only.<br/>  identity = object({<br/>    type         = "(Optional) Specifies the type of Managed Service Identity that should be configured on this Service Bus Namespace. Possible values are `SystemAssigned` or `UserAssigned`. Defaults to `SystemAssigned`."<br/>    identity_ids = "(Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Service Bus Namespace."<br/>  })<br/>  customer_managed_key = object({<br/>    infrastructure_encryption_enabled = "(Optional) Used to specify whether enable Infrastructure Encryption (Double Encryption). Changing this forces a new resource to be created."<br/>    identity_id                       = "(Required) The resource ID of the User Assigned Identity that has access to the key."<br/>    identity_principal_id             = "(Required) The principal ID of the User Assigned Identity that has access to the key."<br/>  })<br/>}) | <pre>object({<br/>    secondary_region              = string<br/>    secondary_resource_group_name = string<br/>    identity = object({<br/>      type         = optional(string, "SystemAssigned")<br/>      identity_ids = optional(list(string), null)<br/>    })<br/>    customer_managed_key = object({<br/>      infrastructure_encryption_enabled = optional(bool, null)<br/>      identity_id                       = string<br/>      identity_principal_id             = string<br/>    })<br/>  })</pre> | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_identity"></a> [identity](#input_identity) | (Optional) An identity block as defined below<br/>object({<br/>  type         = "(Required) Specifies the type of Managed Service Identity that should be configured on this Linux Virtual Machine. Possible values are `SystemAssigned`, `UserAssigned`, `SystemAssigned, UserAssigned` (to enable both)."<br/>  identity_ids = "(Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Linux Virtual Machine. This is required when `type` is set to `UserAssigned` or `SystemAssigned, UserAssigned`."<br/>}) | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(set(string))<br/>  })</pre> | <pre>{<br/>  "identity_ids": null,<br/>  "type": "SystemAssigned"<br/>}</pre> | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_key_vault_tags"></a> [key_vault_tags](#input_key_vault_tags) | (Optional) Key Vault related tags to be set on key vault child resources. | `map(any)` | `{}` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_minimum_tls_version"></a> [minimum_tls_version](#input_minimum_tls_version) | (Optional) The minimum supported TLS version for this Service Bus Namespace. Valid values are: 1.0, 1.1 and 1.2. Defaults to 1.2. | `string` | `"1.2"` | no |
| <a name="input_network_rule_set"></a> [network_rule_set](#input_network_rule_set) | (Optional) This creates a `azurerm_servicebus_namespace_network_rule_set`:<br/>object({<br/>  default_action           = "(Optional) Specifies the default action for the Network Rule Set. Possible values are `Allow` and `Deny`. Defaults to `Deny`."<br/>  trusted_services_allowed = "(Optional) Are Azure Services that are known and trusted for this resource type are allowed to bypass firewall configuration?"<br/>  ip_rules                 = "(Optional) Set of one or more IP Addresses, or CIDR Blocks which should be able to access the ServiceBus Namespace."<br/>  network_rules            = list(object({<br/>    subnet_id                            = "(Required) The Subnet ID which should be able to access this ServiceBus Namespace."<br/>    ignore_missing_vnet_service_endpoint = "(Optional) Should the ServiceBus Namespace Network Rule Set ignore missing Virtual Network Service Endpoint option in the Subnet? Defaults to `false`."<br/>  }))<br/>}) | <pre>object({<br/>    default_action           = optional(string, "Deny")<br/>    trusted_services_allowed = optional(bool)<br/>    ip_rules                 = optional(set(string))<br/>    network_rules = optional(list(object({<br/>      subnet_id                            = string<br/>      ignore_missing_vnet_service_endpoint = optional(bool, false)<br/>    })), null)<br/>  })</pre> | `null` | no |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_premium_messaging_partitions"></a> [premium_messaging_partitions](#input_premium_messaging_partitions) | (Optional) Specifies the number messaging partitions. Default value is 1. Possible values include 1, 2, and 4. | `number` | `1` | no |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_drid"></a> [drid](#output_drid) | The ID of the Secondary Service Bus Namespace created. |
| <a name="output_drname"></a> [drname](#output_drname) | The Name of the Secondary Service Bus Namespace created. |
| <a name="output_drresource"></a> [drresource](#output_drresource) | The Secondary Service Bus Namespace resource created. |
| <a name="output_id"></a> [id](#output_id) | The ID of the Service Bus Namespace created. |
| <a name="output_name"></a> [name](#output_name) | The Name of the Service Bus Namespace created. |
| <a name="output_resource"></a> [resource](#output_resource) | The Service Bus Namespace resource created. |
| <a name="output_service_bus_auth_rule"></a> [service_bus_auth_rule](#output_service_bus_auth_rule) | The Service Bus Namespace authorization rule created. |
<!-- END_TF_DOCS -->
