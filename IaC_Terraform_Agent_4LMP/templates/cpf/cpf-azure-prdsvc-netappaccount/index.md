---
version: 0.2.2
available_versions:
  - 0.2.2
  - 0.2.1
  - 0.2.0
  - 0.1.0
---

<!-- BEGIN_TF_DOCS -->
# NetApp Account module


## Overview

# This product has been Decommisioned. Will be no longer supported.

This terraform module creates a NetApp Account and associated resources.

## Prerequisites

This module requires the following pre-existing dependent Azure resources:
  - `Resource Group`, `Virtual Network` (both modules to be called if not existing, if allowed by the deployment permissions).
  - `Subnet` to be used by the Key Vault Private endpoint.
  - `Network Security Group` to be associated with the Subnet.
  - `Route Table` to be associated with the Subnet.
  - `Key Vault` for resource Customer Managed Key encryption.
  - `Private Endpoint` to create a private connection to the Key Vault.
  - `User Assigned Identity` leveraged for both identity and Customer Managed Key encryption.

## Guidance

#### Usage
- This module creates a NetApp account encrypted with CMK. Capacity Pools and Volumes are part of a different module repository.
- Use `key_vault_tags` variable to define additional Key Vault Key/Secret related tags in your product. Note that azure policies are enforcing a number N of tags for all products by default. Also note that Key Vault child resources support only 15 tags as the maximum limit. Therefore, please ensure the total count of tags enforced by policy and tags applied via variable does not exceed the limit. For example, if 10 tags are enforced via Azure policy, a maximum of 5 tags can be set via the `key_vault_tags` variable. Reference link - [Key tags](https://learn.microsoft.com/en-us/azure/key-vault/keys/about-keys-details#key-tags).
- Use the `tags` variable to define additional tags related to the product (core). Note that azure policies are enforcing a number N of tags for all products by default and that additional 3 tags are set on the main product via main terraform template.
If you are assigning additional tags (key-value pairs) via the `tags` variable, please ensure the total count does not exceed the limit supported by Azure resources. Reference link - [Azure Resources Tag Limitation](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/tag-support)

#### Security Considerations

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-NETAPP-IA_010 | Microsoft Entra Domain Services authentication only must be used | Microsoft Entra Domain Services authentication only must be used for Azure NetApp Files (What) within Active Directory Connections settings (How) to provide cloud based authentication contained within the LSEG tenant (Why) | False | False | AD connection for NetApp is proivsioned using variable `"active_directory"` but this couldn't be enforced due to technical limitation in implementing and testing the AD connection|
| 2. | AZU-NETAPP-SC_010 | Azure NetApp Files must use a dedicated CMK for Azure NetApp Files Transparent Data Encryption that is persisted in an HSM backed Key Vault | Use a dedicated Azure NetApp Files LSEG managed encryption at rest key persisted in an HSM backed Key Vault (What) within Encryption settings (How) in order should Microsoft's key management platform become compromised LSEG can revoke access to exfiltrated encrypted data (Why) | True | True | This is implemented using `resource "azurerm_netapp_account_encryption"` block |
| 3. | AZU-NETAPP-SC_070 | Azure NetApp Files Active Directory Connections must use AES encryption | Azure NetApp Files Active Directory Connections must use AES encryption (What) within Active Directory connections settings (How) to use modern techniques to establish robust encrypted data channels (Why) | False | False | AD connection for NetApp is not within the scope of this module due to technical limitation to implement and test AD connection |
| 4. | AZU-NETAPP-SC_080 | Azure NetApp Files must only use approved add-ons | Azure NetApp Files must only use approved add-ons (What) within Addons settings (How) to prevent unauthorised access to protected services (Why) | False | False | can't implement this control through terraform configuration and application team should get cyber approval to use addons |

## SMCF Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types.<br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc.<br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC<br><br>Documentation | True | This control will be implemented using resource naming module.<br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames) |
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC<br><br>Policy | True | This control will be implemented using `tags` parameter.<br><br>This control is achieved by custom policy as described in the [clear listing page](https://dev.azure.com/LSEGroup/Foundation/_git/azu-plat-policy) from where it inherits all the mandatory tags. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties.<br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration. | Policies<br><br>Iac<br><br>Policies<br><br>Iac | True | This control will be implemented by having all the `Mandate` and most of the `Optional ` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring) | SMCF-OPS-03-02: Define and automate resource operation and security log collection<br><br>SMCF-OPS-03-03: Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs) | Policy<br><br>Documentation<br><br>Documentation | True | This control will be implemented by `DINE` Policy.<br><br>[Ways to monitor Azure NetApp Files](https://learn.microsoft.com/en-us/azure/azure-netapp-files/monitor-azure-netapp-files)<br><br>[Supported Metrics for Azure NetApp Files](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-netapp-netappaccounts-capacitypools-metrics)<br><br>[Metrics for Azure NetApp Files](https://learn.microsoft.com/en-us/azure/azure-netapp-files/azure-netapp-files-metrics) |
| 5. | [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC<br><br>Documentation | True | [Use availability zones for application high availability with Azure NetApp Files](https://learn.microsoft.com/en-us/azure/azure-netapp-files/use-availability-zones) |
| 6. | [SMCF-OPS-07: Resource Protection](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-07-01: Prevent accidental or malicious deletion of production resources<br><br>SMCF-OPS-07-02: Prevent accidental misconfiguration of key production resources | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard based on application team requirement. <br><br>[Lock your resources to protect your infrastructure](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json) |
| 7. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals | IaC<br><br>Documentation | True | [Built-in roles for management operations](https://docs.microsoft.com/en-us/azure/azure-netapp-files/azure-netapp-files-best-practices-security#built-in-roles-for-management-operations)<br><br>[Create and manage Active Directory connections for Azure NetApp Files](https://learn.microsoft.com/en-us/azure/azure-netapp-files/create-active-directory-connections)<br><br> Implemented using `"active_directory"` property|

## Changelog

- [azure-prdsvc-terraform-netappaccount](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/azure-netapp-files/azure-netapp-files-introduction)

### Terraform Docs

- [azurerm_netapp_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/netapp_account)
- [azurerm_netapp_account_encryption](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/netapp_account_encryption)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.5.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm) | >= 3.51 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) | >= 3.51 |

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault_key.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key) | resource |
| [azurerm_netapp_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/netapp_account) | resource |
| [azurerm_netapp_account_encryption.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/netapp_account_encryption) | resource |
| [azurerm_role_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_active_directory"></a> [active_directory](#input_active_directory) | (Optional) A active_directory block as defined below.<br/>object({<br/>  username            = "(Required) The Username of Active Directory Domain Administrator."<br/>  password            = "(Required) The password associated with the username."<br/>  domain              = "(Required) The name of the Active Directory domain."<br/>  dns_servers         = "(Required) A list of DNS server IP addresses for the Active Directory domain. Only allows IPv4 address"<br/>  smb_server_name     = "(Required) The NetBIOS name which should be used for the NetApp SMB Server, which will be registered as a computer account in the AD and used to mount volumes."<br/>  organizational_unit = "(Optional) The Organizational Unit (OU) within Active Directory where machines will be created. If blank, defaults to CN=Computers."<br/>}) | <pre>object({<br/>    username            = string<br/>    password            = string<br/>    domain              = string<br/>    dns_servers         = list(string)<br/>    smb_server_name     = string<br/>    organizational_unit = optional(string, "CN=Computers")<br/>  })</pre> | `null` | no |
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_cmk_rotation_policy"></a> [cmk_rotation_policy](#input_cmk_rotation_policy) | (Optional) A rotation policy block as defined below<br/>object({<br/>  notify_before_expiry = "(Optional) Expire a Key Vault Key after given duration as an ISO 8601 duration."<br/>  time_before_expiry   = "(Optional) Rotate automatically at a duration before expiry as an ISO 8601 duration."<br/>  time_after_creation  = "(Optional) Rotate automatically at a duration before expiry as an ISO 8601 duration."<br/>  expire_after         = "(Optional) Expire a Key Vault Key after given duration as an ISO 8601 duration."<br/>}) | <pre>object({<br/>    notify_before_expiry = string<br/>    time_before_expiry   = string<br/>    time_after_creation  = optional(string, null)<br/>    expire_after         = string<br/>  })</pre> | <pre>{<br/>  "expire_after": "P365D",<br/>  "notify_before_expiry": "P358D",<br/>  "time_after_creation": null,<br/>  "time_before_expiry": "P7D"<br/>}</pre> | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_customer_managed_key"></a> [customer_managed_key](#input_customer_managed_key) | (Optional) A customer_managed_key block as defined below<br/>object({<br/>  key_vault_id          = "(Required) The resource ID of the Key Vault where the Key Vault Key resides."<br/>  expiration_date       = "(Required) Expiration UTC datetime (Y-m-d'T'H:M:S'Z')."<br/>  identity_id           = "(Required) The resource ID of the User Assigned Identity that has access to the key."<br/>  identity_principal_id = "(Required) The principal ID of the User Assigned Identity that has access to the key."<br/>}) | <pre>object({<br/>    key_vault_id          = string<br/>    expiration_date       = string<br/>    identity_id           = string<br/>    identity_principal_id = string<br/>  })</pre> | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_identity"></a> [identity](#input_identity) | (Optional) The identity block where it is used when customer managed keys based encryption will be enabled as defined below.<br/>object({<br/>  type         = "(Required) The identity type, which can be SystemAssigned or UserAssigned. Only one type at a time is supported by Azure NetApp Files."<br/>  identity_ids = "(Optional) The identity id of the user assigned identity to use when type is UserAssigned."<br/>}) | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string))<br/>  })</pre> | `null` | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_key_vault_tags"></a> [key_vault_tags](#input_key_vault_tags) | (Optional) Key Vault related tags to be set on key vault child resources. | `map(any)` | `{}` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The Resource ID of the NetApp Account. |
| <a name="output_name"></a> [name](#output_name) | The Name of the NetApp Account. |
| <a name="output_resource"></a> [resource](#output_resource) | The NetApp Account resource. |
<!-- END_TF_DOCS -->
