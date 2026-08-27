---
version: 1.0.3
available_versions:
  - 1.0.3
  - 1.0.2
  - 1.0.1
  - 1.0.0
  - 0.2.1
---

<!-- BEGIN_TF_DOCS -->
# Azure Logic App Standard module


## Overview

This terraform module creates a Logic App standard and associated resources.

## Prerequisites

This module requires the following pre-existing dependent Azure resources:

- `Resource Group`, `Virtual Network` (both modules to be called if not existing, if allowed by the deployment permissions).
- Two `Subnets` One to be used by the Key Vault & Storage account Private endpoint & One to be used by the Logic App Standard.
- `Network Security Group` to be associated with the Subnet.
- `Route Table` to be associated with the Subnet.
- `User Assigned Identity` leveraged for Identity.
- dependent resource for Logic App Standard.
  - `storage_account`
  - `key_vault`encryption.
- Private endpoint for the below resource,
  - `key_vault`
  - `storage_account`

## Guidance

#### Usage

AzureRM 4.x Upgrade Notes for Logic App Standard

Impact analysis -- HIGH

Users migrating from azurerm 3.x to 4.x need to perform the following changes:
  - **Logic App Runtime**: Default runtime version changed from `~3` to `~4`. Existing deployments may need runtime version explicitly set if `~3` is required
  - **Network Access Property**: The deprecated `public_network_access_enabled` boolean property has been replaced with `public_network_access` string property accepting 'Enabled' or 'Disabled' values
  - **New Variable**: Added configurable `public_network_access` variable with enhanced security (defaults to 'Disabled')
  - **Basic Authentication Control**: Native Terraform attributes now available for FTP/SCM basic authentication control:
    - `ftp_publish_basic_authentication_enabled` - Controls FTP basic authentication (replaces azapi_update_resource for FTP)
    - `scm_publish_basic_authentication_enabled` - Controls SCM basic authentication (replaces azapi_update_resource for SCM)

### Removed:
- `resource "azapi_update_resource" "ftp"` - No longer needed, replaced by native `ftp_publish_basic_authentication_enabled` attribute
- `resource "azapi_update_resource" "scm"` - No longer needed, replaced by native `scm_publish_basic_authentication_enabled` attribute

These features are now natively supported in AzureRM v4.x and no longer require AzAPI overrides.

Wiki link for [AzureRM 4.x Upgrade](https://gitlab.dx1.lseg.com/groups/app/app-51310/azure/prdsvc/terraform/-/wikis/Terraform-AzureRM-Provider-Upgrade:-Version-3.x-to-4.x/Logic-App-Standard) for details on the upgrade process.

For more details, refer to the official [AzureRM 4.x Upgrade Guide](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/4.0-upgrade-guide#azurerm_logic_app_standard)

- This modules creates a Logic App Standard.

#### Security Considerations

#### Additional Information

- In the Logic app settings block add the WEBSITE_CONTENTOVERVNET and set the value to 1. It enables Logic App resource to access the website content over VNET traffic i.e. on SE or PE’s.

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-LA-IA_010 | Entra ID must be used for Azure Logic App Connector authentication where supported | Entra ID must be used for Azure Logic App Connector authentication where supported (What) within Designer trigger or action and Service connector authentication settings (How) in order to remove the need to store credentials (Why) | False | False | Control cannot be set using techincal configuration. |
| 2. | AZU-LA-IA_020 | Azure Logic App connector user type authentication must use an Entra ID service account | Azure Logic App connector user type authentication must use an Entra ID service account (What) within Designer trigger or action and Service Connector authentication settings (How) to ensure no service interruption should the user rotate their password or leave LSEG (Why) | False | False | Control cannot be set using techincal configuration. |
| 3. | AZU-LA-IA_030 | Azure Logic Apps must have basic authentication methods disabled for FTP/SCM |  Azure Logic Apps must have basic authentication methods disabled for FTP/SCM deployments (What) within Configuration, general settings (How) in order to use modern robust and less prone to compromise authentication methods embedded within Entra ID (Why) | True | True | Implemented using native AzureRM 4.x attributes: `ftp_publish_basic_authentication_enabled = false` and `scm_publish_basic_authentication_enabled = false`. |
| 4. | AZU-LA-AC_010 | Disable Public Network Access | Azure Logic App must enforce a network guardrail (What) within Networking settings (How) in order to prevent unauthorised access and data exposure to the internet (Why) | True | True |Implemented by `public_network_access_enabled = false` |
| 5. | AZU-LA-AU_010 | Sending diagnostic logs to a partner solution requires CyberSecurity Risk Assessment and approval | Sending diagnostic logs to a partner solution requires CyberSecurity Risk Assessment and approval (What) within Diagnostic settings (How) in order to prevent sensitive data leakage to third parties outside of LSEG control (Why) | False | False |This control will be implemented via policy. |
| 6. | AZU-LA-SC_010 | Virtual Network integration must be enabled | Virtual Network integration must be enabled for Azure Logic Apps (What) within Network settings (How) in order to provide secure access to other Azure services and govern outbound requests with NSGs and UDRs (Why) | True | True | Implemented by making virtual_network_subnet_id as a required parameter |
| 7. | AZU-LA-SC_020 | Azure Logic Apps must not be able to corrupt the centrally managed private link private DNS zones when making a private endpoint for Azure Logic Apps mywebapp | Azure Logic Apps must have an Azure DeployIfNotExists policy to update the centrally managed private link private DNS zones with its private A record (What) via Policy to management group mapping (How) to ensure there is no ability for the Azure App Deployment team to have authorisation over these zones that could allow them to corrupt this file and impact service availability (Why) | False | False | This control will be implemented via policy. |
| 8. | AZU-LA-SC_030 |  Azure Logic Apps must obfuscate sensitive data when used for Triggers or Action | Azure Logic Apps must obfuscate sensitive data when used for Triggers or Action (What) via Designer trigger or action settings (How) to ensure sensitive data is not exposed for possible exfiltration within the workflow (Why) | False | False | Control cannot be set using techincal configuration. |
| 9. | AZU-LA-SC_040 | Store credential in a Key Vault when Managed Identity is not supported as an authentication mechanism | Store credential in a Key Vault when Managed Identity is not supported as an authentication mechanism (What) via Designer Key Vault connector (How) in order to securely store credentials (Why) | False | False | Control cannot be set using techincal configuration. |
| 10. | AZU-LA-SC_080 | Azure Logic Apps Network connections to the control and data planes must use TLS encryption | Azure Logic Apps Network connections to the control and data planes must use TLS encryption (What) within Configuration, general, https settings (How) in order to use modern techniques to establish robust encrypted data channels over untrusted networks (Why) | True | True | Implemented using `https_only = true`|
| 11. | AZU-LA-SC_090 | Use a minimum of TLS version 1.2 for network connections to the Azure Logic Apps control and data planes |  Azure Logic Apps must enforce a minimum TLS version of 1.2 (What) within Configuration, general settings (How) in order to use modern techniques to establish robust encrypted data channels over untrusted networks (Why) | True | True | Implemented using `min_tls_version = "1.2"` and `scm_min_tls_version = "1.2"` |
| 12. | AZU-LA-SC_100 | Azure Logic Apps must use HTTPv2 | Azure Logic Apps must use HTTPv2 (What) within Configuration, general settings (How) in order to use modern techniques to establish robust encrypted data channels over untrusted networks (Why) | True | True | Implemented using `http2_enabled = true` |
| 13. | AZU-LA-SC_110 | Azure Logic Apps must send all outbound traffic via VNet integration | Azure Logic Apps must send all outbound traffic via VNet integration (What) within Networking, outbound traffic configuration, VNet/subnet, application routing, outbound internet traffic set to enabled setting (How) in order to subject traffic to NSG and Route governance, so that the default route is the Routable VNet Firewall (Why) | True | True | Implemented using `vnet_route_all_enabled = true` |
| 14. | AZU-LA-SC_120 | FTP State must be set to disabled or FTPS only for Azure Logic Apps | FTP State must be set to disabled or FTPS only for Azure Logic Apps (What) within Configuration, general settings (How) in order to prevent unauthorised access and data exposure to the internet (Why) | True | True | Implemented by restricing the value for `ftps_state` to `FtpsOnly` or `Disabled`. Default is `Disabled` |
| 15. | AZU-LA-SC_130 | Remote debugging must be disabled for production Azure Logic Apps | Remote debugging must be disabled for production Azure Logic Apps (What) within Configuration, general settings (How) in order to prevent unauthorised access and data exposure to the internet (Why) | False | False | Control cannot be set using techincal configuration. Logic App Remote debugging state default to disabled. |
| 16. |  AZU-LA-SC_140 | Azure Logic Apps must not use Hybrid connections | Azure Logic Apps must not use Hybrid connections (What) within Networking, outbound traffic configuration, hybrid connections setting (How) in order to prevent LSEG data being sent over untrusted networks (Why) | False | False | This control is related to Relay Name spaces and not applicable for Logic app standard resource `azurerm_logic_app_standard`.  |
| 17. | AZU-LA-SC_150 | Azure Logic Apps must not be able to corrupt the centrally managed private link private DNS zones when making a private endpoint for Azure Logic Apps mywebapp.scm | Azure Logic Apps must have an Azure DeployIfNotExists policy to update the centrally managed private link private DNS zones with its private A record (What) via Policy to management group mapping (How) to ensure there is no ability for the Azure App Deployment team to have authorisation over these zones that could allow them to corrupt this file and impact service availability (Why) | False | False | This control will be implemented via policy. |

## SMCF Controls

| S. No.  | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|---------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types.<br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc.<br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC<br><br>Documentation | False | This control will be implemented using resource naming module.<br><br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames)|
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC<br><br>Policy | True | This control will be implemented using `tags` parameter.<br><br>This control is achieved by custom policy as described in the [clear listing page](https://dev.azure.com/LSEGroup/Foundation/_git/azu-plat-policy) from where it inherits all the mandatory tags. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties.<br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration. | Policies<br><br>Iac<br><br>Policies<br><br>Iac | True | This control will be implemented by having all the `Mandate` and most of the `Optional ` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring) | SMCF-OPS-03-02: Define and automate resource operation and security log collection<br><br>SMCF-OPS-03-03: Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs) | Policy<br><br>Documentation<br><br>Documentation | True | This control will be implemented by `DINE` Policy.<br><br>[Collect Diagnostics and send to Log Analytics]<br><br>[Monitoring and reporting solutions for Azure Logic Apps ](https://docs.microsoft.com/en-us/azure/logic-apps/monitor-logic-apps)<br><br>[Cloud monitoring service level objectives ](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/monitor/service-level-objectives)<br><br>[Supported Metrics for Logic Apps ](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-logic-workflows-metrics) |
| 5.| [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC<br><br>Documentation | True | Azure Logic Apps relies on Azure Storage to store and automatically encrypt data at rest. This encryption protects your data and helps you meet your organizational security and compliance commitments. By default, Azure Storage uses Microsoft-managed keys to encrypt your data. For more information, review Azure Storage encryption for data at rest..<br><br>[Reliability in Azure Logic Apps ](https://learn.microsoft.com/en-us/azure/logic-apps/set-up-zone-redundancy-availability-zones?tabs=standard) |
| 6. | [SMCF-OPS-07: Resource Protection](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-07-01: Prevent accidental or malicious deletion of production resources<br><br>SMCF-OPS-07-02: Prevent accidental misconfiguration of key production resources | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard based on application team requirement. <br><br>[Lock your resources to protect your infrastructure](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json) |
| 7. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals. | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package and has a JIT implementation in place.<br><br>[Authenticate access and connections to Azure resources with managed identities in Azure Logic Apps ](https://docs.microsoft.com/en-us/azure/logic-apps/logic-apps-securing-a-logic-app#multi-user-authorization%5D(https://learn.microsoft.com/en-us/azure/logic-apps/authenticate-with-managed-identity?tabs=consumption) |

## Changelog

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/logic-apps/logic-apps-overview)

### Terraform Docs

- [azurerm_logic_app_standard](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/logic_app_standard)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.5.0 |
| <a name="requirement_azapi"></a> [azapi](#requirement_azapi) | >=1.9 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm) | >=4.33 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) | >=4.33 |

## Resources

| Name | Type |
|------|------|
| [azurerm_logic_app_standard.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/logic_app_standard) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_service_plan_id"></a> [app_service_plan_id](#input_app_service_plan_id) | (Required) The ID of the App Service Plan within which to create this Logic App. | `string` | n/a | yes |
| <a name="input_app_settings"></a> [app_settings](#input_app_settings) | (Optional) A map of key-value pairs for App Settings and custom values. | `map(any)` | `{}` | no |
| <a name="input_bundle_version"></a> [bundle_version](#input_bundle_version) | (Optional) If use_extension_bundle then controls the allowed range for bundle versions. Defaults to [1.*, 2.0.0). | `string` | `"2.0.0"` | no |
| <a name="input_client_affinity_enabled"></a> [client_affinity_enabled](#input_client_affinity_enabled) | (Optional) Should the Logic App send session affinity cookies, which route client requests in the same session to the same instance? | `bool` | `null` | no |
| <a name="input_client_certificate_mode"></a> [client_certificate_mode](#input_client_certificate_mode) | (Optional) The mode of the Logic App's client certificates requirement for incoming requests. Possible values are Required and Optional. | `string` | `null` | no |
| <a name="input_connection_strings"></a> [connection_strings](#input_connection_strings) | (Optional) A list of `connection_strings` objects for the Logic App with following arguments:<br/>  name  = "(Required) The name of the connection string."<br/>  type  = "(Required) The type of the Connection String. Possible values are APIHub, Custom, DocDb, EventHub, MySQL, NotificationHub, PostgreSQL, RedisCache, ServiceBus, SQLAzure and SQLServer."<br/>  value = "(Required) The value of the connection string." | <pre>list(<br/>    object({<br/>      name  = string<br/>      type  = string<br/>      value = string<br/>    })<br/>  )</pre> | `[]` | no |
| <a name="input_enabled"></a> [enabled](#input_enabled) | (Optional) Is the Logic App enabled? Defaults to true. | `bool` | `true` | no |
| <a name="input_identity"></a> [identity](#input_identity) | (Optional) An identity block as defined below<br/>object({<br/>  type         = "(Required) Specifies the type of Managed Service Identity that should be configured on thisLogic App. Possible values are `SystemAssigned`, `UserAssigned`, `SystemAssigned, UserAssigned` (to enable both)."<br/>  identity_ids = "(Optional) A list of User Assigned Managed Identity IDs to be assigned to this Logic App. This is required when `type` is set to `UserAssigned` or `SystemAssigned, UserAssigned`."<br/>}) | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(set(string))<br/>  })</pre> | <pre>{<br/>  "identity_ids": null,<br/>  "type": "SystemAssigned"<br/>}</pre> | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_logic_app_name"></a> [logic_app_name](#input_logic_app_name) | (Required) Specifies the name of the Logic App Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_public_network_access"></a> [public_network_access](#input_public_network_access) | (Optional) Specifies whether public network access is allowed for this Logic App. Possible values are 'Enabled' and 'Disabled'. Defaults to 'Enabled'. | `string` | `"Disabled"` | no |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_run_time_version"></a> [run_time_version](#input_run_time_version) | (Optional) The runtime version associated with the Logic App. Defaults to ~4. | `string` | `"~4"` | no |
| <a name="input_site_config"></a> [site_config](#input_site_config) | (Required) The `site_config` block supports the following:<br/>  always_on                              = "(Optional) Should the Logic App be loaded at all times? Defaults to false."<br/>  app_scale_limit                        = "(Optional) The number of workers this Logic App can scale out to. Only applicable to apps on the Consumption and Premium plan."<br/>  cors = "(Optional) A cors as defined below.<br/>  cors = "(object({<br/>    allowed_origins         = "(Required) A list of origins which should be able to make cross-origin calls. * can be used to allow all calls."<br/>    support_credentials     = "(Optional) Are credentials supported"<br/>  }))" <br/>  dotnet_framework_version               = "(Optional) The version of the .NET framework's CLR used in this Logic App Possible values are v4.0 (including .NET Core 2.1 and 3.1), v5.0, v6.0 and v8.0. For more information on which .NET Framework version to use based on the runtime version you're targeting - please see this table. Defaults to v4.0."<br/>  elastic_instance_minimum               = "(Optional) The number of minimum instances for this Logic App Only affects apps on the Premium plan."<br/>  ftps_state                             = "(Optional) State of FTP / FTPS service for this Logic App Possible values include: AllAllowed, FtpsOnly and Disabled. Defaults to AllAllowed."<br/>  health_check_path                      = "(Optional) Path which will be checked for this Logic App health."<br/>  http2_enabled                          = "(Optional) Specifies whether or not the HTTP2 protocol should be enabled. Defaults to false."<br/>  scm_use_main_ip_restriction            = "(Optional) Should the Logic App ip_restriction configuration be used for the SCM too. Defaults to false."<br/>  scm_type                               = "(Optional) The type of Source Control used by the Logic App in use by the Windows Function App. Defaults to None. Possible values are: BitbucketGit, BitbucketHg, CodePlexGit, CodePlexHg, Dropbox, ExternalGit, ExternalHg, GitHub, LocalGit, None, OneDrive, Tfs, VSO, and VSTSRM."<br/>  linux_fx_version                       = "(Optional) Linux App Framework and version for the AppService, e.g. DOCKER\|(golang:latest). Setting this value will also set the kind of application deployed to functionapp,linux,container,workflowapp."<br/>  pre_warmed_instance_count              = "(Optional) The number of pre-warmed instances for this Logic App Only affects apps on the Premium plan."<br/>  runtime_scale_monitoring_enabled       = "(Optional) Should Runtime Scale Monitoring be enabled?. Only applicable to apps on the Premium plan. Defaults to false."<br/>  use_32_bit_worker_process              = "(Optional) Should the Logic App run in 32 bit mode, rather than 64 bit mode? Defaults to true."<br/>  websockets_enabled                     = "(Optional) Should WebSockets be enabled?"<br/>  ip_restrictions = "(Optional) A list of `ip_restriction` objects for the Logic App.<br/>    ip_restriction = "object({<br/>      headers = "(Optional) object({<br/>        x_azure_fdid      = "(Optional) A list of allowed Azure FrontDoor IDs in UUID notation with a maximum of 8."<br/>        x_fd_health_probe = "(Optional) A list to allow the Azure FrontDoor health probe header. Only allowed value is "1"."<br/>        x_forwarded_for   = "(Optional) A list of allowed 'X-Forwarded-For' IPs in CIDR notation with a maximum of 8."<br/>        x_forwarded_host  = "(Optional) A list of allowed 'X-Forwarded-Host' domains with a maximum of 8."<br/>      }))"<br/>      ip_address                = "(Optional) The IP Address used for this IP Restriction in CIDR notation."<br/>      action                    = "(Optional) Does this restriction Allow or Deny access for this IP range. Defaults to Allow."<br/>      name                      = "(Optional) The name for this IP Restriction."<br/>      priority                  = "(Optional) The priority for this IP Restriction. Restrictions are enforced in priority order. By default, the priority is set to 65000 if not specified."<br/>      service_tag               = "(Optional) The Service Tag used for this IP Restriction."<br/>      virtual_network_subnet_id = "(Optional) The Virtual Network Subnet ID used for this IP Restriction."<br/>    }))"<br/>  scm_ip_restrictions = "(Optional) A list of `scm_ip_restriction` objects for the Logic App.<br/>    scm_ip_restriction = "object({<br/>      headers = "(Optional) object({<br/>        x_azure_fdid      = "(Optional) A list of allowed Azure FrontDoor IDs in UUID notation with a maximum of 8."<br/>        x_fd_health_probe = "(Optional) A list to allow the Azure FrontDoor health probe header. Only allowed value is "1"."<br/>        x_forwarded_for   = "(Optional) A list of allowed 'X-Forwarded-For' IPs in CIDR notation with a maximum of 8."<br/>        x_forwarded_host  = "(Optional) A list of allowed 'X-Forwarded-Host' domains with a maximum of 8."<br/>      }))"<br/>      ip_address                = "(Optional) The IP Address used for this IP Restriction in CIDR notation."<br/>      action                    = "(Optional) Does this restriction Allow or Deny access for this IP range. Defaults to Allow."<br/>      name                      = "(Optional) The name for this IP Restriction."<br/>      priority                  = "(Optional) The priority for this IP Restriction. Restrictions are enforced in priority order. By default, the priority is set to 65000 if not specified."<br/>      service_tag               = "(Optional) The Service Tag used for this IP Restriction."<br/>      virtual_network_subnet_id = "(Optional) The Virtual Network Subnet ID used for this IP Restriction."<br/>    }))" | <pre>object({<br/>    always_on                        = optional(bool, false)<br/>    app_scale_limit                  = optional(number)<br/>    dotnet_framework_version         = optional(string)<br/>    elastic_instance_minimum         = optional(number)<br/>    ftps_state                       = optional(string, "Disabled")<br/>    health_check_path                = optional(string)<br/>    http2_enabled                    = optional(bool, false)<br/>    scm_use_main_ip_restriction      = optional(bool, false)<br/>    scm_type                         = optional(string)<br/>    linux_fx_version                 = optional(string)<br/>    pre_warmed_instance_count        = optional(number)<br/>    runtime_scale_monitoring_enabled = optional(bool, false)<br/>    use_32_bit_worker_process        = optional(bool)<br/>    websockets_enabled               = optional(bool)<br/>    cors = optional(object({<br/>      allowed_origins     = optional(set(string))<br/>      support_credentials = optional(bool)<br/>    }))<br/>    ip_restrictions = optional(list(<br/>      object({<br/>        headers = optional(object({<br/>          x_azure_fdid      = optional(list(string))<br/>          x_fd_health_probe = optional(number)<br/>          x_forwarded_for   = optional(list(string))<br/>          x_forwarded_host  = optional(list(string))<br/>        }))<br/>        ip_address                = optional(list(string))<br/>        action                    = optional(string)<br/>        name                      = optional(string)<br/>        priority                  = optional(number, 65000)<br/>        service_tag               = optional(string)<br/>        virtual_network_subnet_id = optional(string)<br/>      })<br/>    ), [])<br/>    scm_ip_restrictions = optional(list(<br/>      object({<br/>        headers = optional(object({<br/>          x_azure_fdid      = optional(list(string))<br/>          x_fd_health_probe = optional(number)<br/>          x_forwarded_for   = optional(list(string))<br/>          x_forwarded_host  = optional(list(string))<br/>        }))<br/>        ip_address                = optional(list(string))<br/>        action                    = optional(string)<br/>        name                      = optional(string)<br/>        priority                  = optional(number, 65000)<br/>        service_tag               = optional(string)<br/>        virtual_network_subnet_id = optional(string)<br/>      })<br/>    ), [])<br/>  })</pre> | n/a | yes |
| <a name="input_storage_account_access_key"></a> [storage_account_access_key](#input_storage_account_access_key) | (Required) The access key which will be used to access the backend storage account for the Logic App | `string` | n/a | yes |
| <a name="input_storage_account_name"></a> [storage_account_name](#input_storage_account_name) | (Required) The backend storage account name which will be used by this Logic App (e.g. for Stateful workflows data). Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_storage_account_share_name"></a> [storage_account_share_name](#input_storage_account_share_name) | (Optional) The name of the share used by the logic app, if you want to use a custom name. This corresponds to the WEBSITE_CONTENTSHARE appsetting, which this resource will create for you. If you don't specify a name, then this resource will generate a dynamic name. This setting is useful if you want to provision a storage account and create a share using azurerm_storage_share. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |
| <a name="input_use_extension_bundle"></a> [use_extension_bundle](#input_use_extension_bundle) | (Optional) Should the logic app use the bundled extension package? If true, then application settings for AzureFunctionsJobHost__extensionBundle__id and AzureFunctionsJobHost__extensionBundle__version will be created. Defaults to true. | `bool` | `true` | no |
| <a name="input_virtual_network_subnet_id"></a> [virtual_network_subnet_id](#input_virtual_network_subnet_id) | (Optional) The subnet id which will be used by this resource for regional virtual network integration. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The ID of the created Logic App Standard. |
| <a name="output_name"></a> [name](#output_name) | The Name of the created Logic App Standard. |
| <a name="output_resource"></a> [resource](#output_resource) | The Logic App resource. |
<!-- END_TF_DOCS -->
