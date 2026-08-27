---
version: 1.0.2
available_versions:
  - 1.0.2
  - 1.0.1
  - 1.0.0
  - 0.1.1
  - 0.1.0
---

<!-- BEGIN_TF_DOCS -->
# Linux Web App Module


## Overview

This terraform module creates a App service binding and its associated resources.

## Prerequisites

- An existing `Resource Group`.
- A `Virtual Network`, `Subnet` for VNET integration of app service binding.
- A `Service Plan` to host linux webapp and a `Key Vault`.
- A `App Service Environment` to host service plan.
- A `Certificate`, `Hostname` to bind the application.

## Guidance

#### Usage

- This module is creating the App service certificate, hostname binding and ssl certificate binding.
- One virtual_network_id must be specified.
- App Service plan must be in the same region.
- If `var.thumbprint` is specified then `var.ssl_state` also should be specified.
- The User Assigned Identity ID used for accessing KeyVault secrets. The identity must be assigned to the application in the identity block.

#### Security Considerations

- `Azure doesn't allow to create a Private endpoint on a delegated subnet`, hence, if there is a need to access or add Keyvault secrets then please use a non-delegated subnet to create a Private Endpoint.

- If using `key_vault_secret_id`, the WebApp Service Resource Principal ID is given the `Key Vault secret user` role as it must have 'Secret -> get' permissions on the Key Vault containing the certificate. ref: https://registry.terraform.io/providers/hashicorp/azurerm/3.117.1/docs/resources/app_service_certificate

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-WEBA-IA_010 | Entra ID authentication only must be used | Entra ID authentication only must be used for Web App (including app slots) (What) within Authentication (How) in order to use modern robust and less prone to compromise authentication methods embedded within Entra ID (Why) | False | False | This control cannot be set using techincal configuration. The Product restricts `auth_settings` and `auth_settings_v2` to only use Entra ID based Identity. Also, App/Deployment slots are not getting created with this module.|
| 2. | AZU-WEBA-IA_020 | Credentials for other resources/systems must be stored in Azure Key Vault when Managed Identities cannot be used |  Credentials for other resources/systems must be stored in Azure Key Vault (What) within Service Connector (How) in order to ensure the security of credentials (Why) | False | False | This control cannot be implemented by technical configuration. |
| 3. | AZU-WEBA-IA_030 | Web App (including app slots) must have basic authentication methods disabled for FTP/SCM deployments | Web App (including app slots) must have basic authentication methods disabled for FTP/SCM deployments (What) within Configuration, General settings (How) in order to use modern robust and less prone to compromise authentication methods embedded within Entra ID (Why) | True | True | This control has been enforced using `ftp_publish_basic_authentication_enabled = false` and `webdeploy_publish_basic_authentication_enabled = false`. App/Deployment slots are not getting created with this module. |
| 4. | AZU-WEBA-IA_040 | Entra ID identity provider must enforce restricted access | Entra ID identity provider must enforce restricted access to require authentication for Web App (including app slots) (What) within Authentication settings, identity provider, restricted access (How) in order to only allow authenticated requests (Why) | True | False | This control has been implemented by using `require_authentication = true` and `unauthenticated_action = "RedirectToLoginPage" as a default value` under `auth_settings_v2` block.The Entra ID authentication is supported in code, but there is no PowerShell command to check authentication parameter values in Pester post-deployment test. |
| 5. | AZU-WEBA-IA_050 | Entra ID identity provider must enforce workforce tenant type | Entra ID identity provider must enforce workforce tenant type for Web App (including app slots) (What) within Authentication settings, identity provider, tenant type (How) in order to use modern robust and less prone to compromise authentication methods embedded within Entra ID accounts and to prevent local and social accounts being used (Why) | False | False | This control cannot be implemented by technical configuration. |
| 6. | AZU-WEBA-IA_060 | Entra ID identity provider must enforce app registrations from the LSEG tenant | Entra ID identity provider must enforce app registration type as an existing app registration in this directory for Web App (including app slots) (What) within Authentication settings, identity provider, app registration type (How) in order to ensure LSEG approved apps are used only (Why) | False | False | This control cannot be implemented by technical configuration.  |
| 7. | AZU-WEBA-AC_010 | Disable Public Network Access | Web App (including app slots) must enforce a network guardrail (What) within Network settings (How) in order to prevent unauthorised access and data exposure to the internet (Why) | True | True | This control has been implemented by setting `public_network_access_enabled = false`. App/Deployment slots are not getting created with this module. |
| 8. | AZU-WEBA-AU_010 | Send all diagnostic log categories to a central SOC Log Analytics workspace | Web App (including app slots) must send all diagnostic logs to a central SOC Log Analytics workspace (What) within Diagnostic settings (How) in order to support a security investigation after a security incident (Why) | False | False | This control will be implemented by a `DINE` policy. |
| 9. | AZU-WEBA-AU_020 | Send all diagnostic log categories to a central SOC Storage Account | Web App (including app slots) must send all diagnostic logs to a central SOC Storage Account (What) within Diagnostic settings (How) In order to provide an immutable copy to adhere to compliance requirements (Why) | False | False | This control will be implemented by a `DINE` policy. |
| 10. | AZU-WEBA-AU_030 | Sending diagnostic logs to a partner solution requires CyberSecurity risk assessment and approval | Sending diagnostic logs to a partner solution requires CyberSecurity risk assessment and approval (What) within Diagnostic settings (How) in order to prevent sensitive data leakage to third parties outside of LSEG control (Why) | False | False | This control will be implemented via policy. |
| 11. | AZU-WEBA-SC_010 | Network connections to the Web App (including app slots) control and data planes must use TLS encryption | Web App (including app slots) must enforce network flow encryption in transit using TLS (What) within Configuration, general settings (How) in order to use modern techniques to establish robust encrypted data channels over untrusted networks (Why) | True | True | This control has been implemented by using `https_only = true`. App/Deployment slots are not getting created with this module. |
| 12. | AZU-WEBA-SC_020 | Use a minimum of TLS version 1.2 for network connections to the Web App control and data planes | Web App (including app slots) must enforce a minimum TLS version of 1.2 (What) within Configuration, general settings (How) in order to use modern techniques to establish robust encrypted data channels over untrusted networks (Why) | True | True | This control has been implemented by setting the parameters `minimum_tls_version = "1.2"` and `scm_minimum_tls_version = "1.2"`. |
| 13. | AZU-WEBA-SC_030 | Web App (including app slots) must be protected by Web Application Firewall (WAF) on Azure Application Gateway | Web App (including app slots) must be protected by Web Application Firewall (WAF) on Azure Application Gateway (What) in the Code deployment parameters (How) to protect web applications against common vulnerabilities and exploits (Why) | False | False | This control will be implemented by LSEG Standards. Also, App/Deployment slots are not getting created with this module. |
| 14. | AZU-WEBA-SC_040 | MySQL In App must be disabled for Web App (including app slots) | MySQL In App must be disabled for Web App (including app slots) (What) within MySQL In App settings (How) in order to ensure only LSEG Security Architecture approved database resources are used (Why) | True | True | This control has been implemented by using `local_mysql_enabled = false`. App/Deployment slots are not getting created with this module. |
| 15. | AZU-WEBA-SC_050 | Azure App Deployment must not be able to corrupt the centrally managed private link private DNS zones when making a private endpoint for Web App (including app slots) | Web App (including app slots) must have an Azure DeployIfNotExists policy to update the centrally managed private link private DNS zones with its private A record (What) via Policy to management group mapping (How) to ensure there is no ability for the Azure App Deployment team to have authorisation over these zones that could allow them to corrupt this file and impact service availability (Why) | False | False | This control will be implemented by a `DINE` policy. Also, App/Deployment slots are not getting created with this module. |
| 16. | AZU-WEBA-SC_060 | Web App (including app slots) must use HTTPv2 | Web App (including app slots) must use HTTPv2 (What) within Configuration settings (How) in order to use modern techniques to establish robust encrypted data channels over untrusted networks (Why) | True | True | This control has been implemented by using the parameter `http2_enabled = true`. App/Deployment slots are not getting created with this module. |
| 17. | AZU-WEBA-SC_070 | Production Web App must preserve the original HTTP host name | Production Web App must preserve the original HTTP host name (What) within Custom domains (How) in order to prevent authentication failure and back-end URLs inadvertently being exposed (Why) | False | False | This control will be implemented by LSEG Standards. |
| 18. | AZU-WEBA-SC_080 | Virtual Network integration must be enabled | Virtual Network integration must be enabled for Web App (including app slots) (What) within Networking settings (How) in order to provide secure access to other Azure services and govern outbound requests with NSGs and UDRs (Why) | True | True | This control has been implemented by using `virtual_network_subnet_id` and passing the value. |
| 19. | AZU-WEBA-SC_090 | Outbound traffic must be sent through the Virtual Network using RouteAll | Web App (including app slots) must send outbound traffic through the Virtual Network using RouteAll (What) in the code deployment parameters (How) in order to subject traffic to NSG and Route governance, so that the default route is the Routable Virtual Network Firewall (Why) | True | True | This control has been implemented by setting the parameter `vnet_route_all_enabled = true`. |
| 20. | AZU-WEBA-SC_100 | Azure App Deployment must not be able to corrupt the centrally managed private link private DNS zones when making a private endpoint for Web App (including app slots) SCM portal | Web App (including app slots) SCM portal must have an Azure DeployIfNotExists policy to update the centrally managed private link private DNS zones with its private A record (What) via Policy to management group mapping (How) to ensure there is no ability for the Azure App Deployment team to have authorisation over these zones that could allow them to corrupt this file and impact service availability (Why) | False | False | This control will be implemented by a `DINE` policy. Also, App/Deployment slots are not getting created with this module. |
| 21. | AZU-WEBA-SC_110 | Production Web App must not use app slots | Production Web App must not use app slots (What) within Deployment slots (How) in order to ensure only production workloads run in production subscriptions (Why) | True | True | Currently, there are no App/Deployment slots getting created with this module. |
| 22. | AZU-WEBA-SC_120 | Remote debugging must be disabled for production Web App (including app slots) | Remote debugging must be disabled for production Web App (including app slots) (What) within Configuration, General settings (How) in order to prevent sensitive information (e.g. credentials or customer data) being recorded in debugging logs (Why) | True | True | This control has been implemented by using the parameter `remote_debugging_enabled = false`. App/Deployment slots are not getting created with this module. |
| 23. | AZU-WEBA-SC_130 | FTP State must be set to disabled or FTPS only for Web App (including app slots) | FTP State must be set to disabled or FTPS only for Web App (including app slots) (What) within Configuration, General settings (How) in order to use modern techniques to establish robust encrypted data channels over untrusted networks (Why) | True | True | This control has been implemented by restricing the value for `ftps_state` to `FtpsOnly` or `Disabled`. Default is `Disabled`. App/Deployment slots are not getting created with this module. |

## Changelog

- [azure-prdsvc-terraform-appservicebinding](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation for Domain](https://learn.microsoft.com/en-us/azure/app-service/manage-custom-dns-buy-domain)
- [Official Documentation for Certificates](https://learn.microsoft.com/en-us/azure/app-service/configure-ssl-app-service-certificate?tabs=portal)

### Terraform Docs

- [azurerm_app_service_certificate](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_certificate)
- [azurerm_app_service_custom_hostname_binding](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_custom_hostname_binding)
- [azurerm_app_service_certificate_binding](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_certificate_binding)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.5.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm) | >=4.33 |
| <a name="requirement_time"></a> [time](#requirement_time) | >=0.12.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) | >=4.33 |
| <a name="provider_time"></a> [time](#provider_time) | >=0.12.1 |

## Resources

| Name | Type |
|------|------|
| [azurerm_app_service_certificate.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_certificate) | resource |
| [azurerm_app_service_certificate_binding.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_certificate_binding) | resource |
| [azurerm_app_service_custom_hostname_binding.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_custom_hostname_binding) | resource |
| [time_sleep.wait_for_cert](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_app_service_certificate_name"></a> [app_service_certificate_name](#input_app_service_certificate_name) | (Required) The name of the App Service Certificate. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_app_service_name"></a> [app_service_name](#input_app_service_name) | (Required) The name of the App Service in which to add the Custom Hostname Binding. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_app_service_plan_id"></a> [app_service_plan_id](#input_app_service_plan_id) | (Optional) The ID of the associated App Service plan. Must be specified when the certificate is used inside an App Service Environment hosted App Service or with Basic and Premium App Service plans. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_certificate_id"></a> [certificate_id](#input_certificate_id) | (Optional) The ID of the certificate to bind to the custom domain. Changing this forces a new App Service Certificate Binding to be created. | `string` | `null` | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_host_names"></a> [host_names](#input_host_names) | hostname  = (Required) Specifies the Custom Hostname to use for the App Service, example www.example.com. Changing this forces a new resource to be created.<br/>ssl_state = (Required) The SSL state of the hostname. Possible values are `Disabled`, `SniEnabled`, and `IpBasedEnabled`. Changing this forces a new resource to be created.<br/>thumbprint = (Optional) The thumbprint of the SSL certificate to use for the hostname. If not specified, the thumbprint from the `azurerm_app_service_certificate` resource will | <pre>map(object({<br/>    hostname   = string<br/>    ssl_state  = string<br/>    thumbprint = optional(string, null)<br/>  }))</pre> | n/a | yes |
| <a name="input_hostname_binding_id"></a> [hostname_binding_id](#input_hostname_binding_id) | (Optional) The ID of the Custom Domain/Hostname Binding. Changing this forces a new App Service Certificate Binding to be created. | `string` | `null` | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_key_vault_id"></a> [key_vault_id](#input_key_vault_id) | (Optional) The ID of the Key Vault. Must be specified if the Key Vault of key_vault_secret_id is in a different subscription from the App Service Certificate. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_key_vault_secret_id"></a> [key_vault_secret_id](#input_key_vault_secret_id) | (Optional) The ID of the Key Vault secret. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_pfx_blob"></a> [pfx_blob](#input_pfx_blob) | (Optional) The base64-encoded contents of the certificate. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_pfx_password"></a> [pfx_password](#input_pfx_password) | (Optional) The password to access the certificate's private key. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_certificate_binding_id"></a> [app_certificate_binding_id](#output_app_certificate_binding_id) | Map of Resource IDs for each App Certificate Binding. |
| <a name="output_app_certificate_binding_resource"></a> [app_certificate_binding_resource](#output_app_certificate_binding_resource) | Map of App Certificate Binding resources. |
| <a name="output_app_service_certificate_id"></a> [app_service_certificate_id](#output_app_service_certificate_id) | The Resource ID of the App Service Certificate. |
| <a name="output_app_service_certificate_name"></a> [app_service_certificate_name](#output_app_service_certificate_name) | The Name of the App Service Certificate. |
| <a name="output_app_service_certificate_resource"></a> [app_service_certificate_resource](#output_app_service_certificate_resource) | The App Service Certificate resource. |
| <a name="output_hostname_binding_id"></a> [hostname_binding_id](#output_hostname_binding_id) | Map of Resource IDs for each App Service Custom Hostname Binding. |
| <a name="output_hostname_binding_resource"></a> [hostname_binding_resource](#output_hostname_binding_resource) | Map of App Service Custom Hostname Binding resources. |
<!-- END_TF_DOCS -->
