---
version: 2.1.2
available_versions:
  - 2.1.2
  - 2.1.1
  - 2.1.0
  - 2.0.0
  - 1.0.0
---

<!-- BEGIN_TF_DOCS -->
# Azure Web Static App


## Overview

- This terraform module creates an Azure Static Web App.
- Microsoft Azure's offering for deploying modern web applications.
- Ideal for: Applications that primarily use client-side processing, supports custom domains with free SSL certificates from Azure and integrated with Azure Monitor for application insights and analytics.
- Supported Frameworks/Libraries: React, Angular, Vue, Blazor, and others.

## Prerequisites

- `Resource Group` name is required.

## Guidance

#### Usage

- This Module Covers deployment of Azure Web Static App.
- At the time of building this module List of available regions for the resource type 'Microsoft.Web/staticSites' is westus2,centralus,eastus2,westeurope,eastasia.
- Once the supported regions are inflated for the subscriptions PE location can be the same as static web site resource location if needed i.e locals `location` and `pe_location` can be same.
- Static web apps cannot be used with private endpoints due to policy issues.

#### Security Considerations

- As per LSEG security controls the public access is disabled for static web app and must be restricted by a Private Endpoint

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-SWA-IA_010 | Entra ID authentication only must be used | Entra ID authentication only must be used for Static Web App (What) within Application configuration file  (How) in order to use modern robust and less prone to compromise authentication methods embedded within Entra ID (Why) | False | False | Doesn't support Entra ID, Application configuration passowrd supports only local username and password [Passowrd Protection](https://learn.microsoft.com/en-us/azure/static-web-apps/password-protection#enable-password-protection) |
| 2. | AZU-SWA-IA_020 | Static Web App must use a Managed Identity for accessing Azure Resources | EStatic Web App must enforce the use of a Managed Identity to authenticate to Azure resources where this is supported (What) within target service Identity settings (How) in order to remove the need to store credentials (Why) | True | True | Implemented using `identity_type` in `identity` variable. |
| 3. | AZU-SWA-AC_010 | Static Web App must disable Public Network Access | Static Web Apps must enforce a network guardrail (What) within Private endpoints (How) in order to prevent unauthorised access and data exposure to the internet (Why) | True | True | Implemented with az api resource POST action to dissable the public access as TF doesn't suppport this feature yet. Private endpoint configuration is out of scope for this module and the controls on those are applied by LSEG DINE policies |
| 4. | AZU-SWA-SC_010 | Azure App Deployment must not be able to corrupt the centrally managed private link private DNS zones when making a private endpoint for Static Web App |  Static Web App must have an Azure DeployIfNotExists policy to update the centrally managed private link private DNS zones with its private A record (What) via Policy to management group mapping (How) to ensure there is no ability for the Azure App Deployment team to have authorisation over these zones that could allow them to corrupt this file and impact service availability (Why) | False | False | This control will be implemented via DINE policy to update the dns zones and also withlseg RBAC structure to restrict appdeployment SPN access over the central dns zone. |

## SMCF Controls

| S. No.  | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|---------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types.<br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc.<br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC<br><br>Documentation | True | This control will be implemented using resource naming module.<br><br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames)|
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC<br><br>Policy | True | This control will be implemented using `tags` parameter.<br><br>This control is achieved by custom policy as described in the [clear listing page](https://dev.azure.com/LSEGroup/Foundation/_git/azu-plat-policy) from where it inherits all the mandatory tags. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties.<br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration. | Policies<br><br>Iac<br><br>Policies<br><br>Iac | True | This control will be implemented by having all the `Mandate` and most of the `Optional ` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring) | SMCF-OPS-03-02: Define and automate resource operation and security log collection<br><br>SMCF-OPS-03-03: Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs) | Policy<br><br>Documentation<br><br>Documentation | True | This control will be implemented by `DINE` Policy.<br><br>[Collect Diagnostics and send to Log Analytics]<br><br>[Monitor Azure Static Web App](https://docs.microsoft.com/en-us/azure/static-web-apps/monitor)<br><br>[Cloud monitoring service level objectives ](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/monitor/service-level-objectives)<br><br>[Supported Metrics for Static Web App](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-web-staticsites-metrics) |
| 5.| [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC<br><br>Documentation | False | [Enterprise-grade edge Azure Static Web App](https://learn.microsoft.com/en-us/azure/static-web-apps/enterprise-edge?tabs=azure-cli). Private Endpoint can't be used with enterprise-grade edge. So this contradicts the security control [Limitation](https://learn.microsoft.com/en-us/azure/static-web-apps/enterprise-edge?tabs=azure-portal#limitations) |
| 6. | [SMCF-OPS-07: Resource Protection](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-07-01: Prevent accidental or malicious deletion of production resources<br><br>SMCF-OPS-07-02: Prevent accidental misconfiguration of key production resources | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard based on application team requirement. <br><br>[Lock your resources to protect your infrastructure](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json) |
| 7. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package and has a JIT implementation in place.<br><br>[Manage access to Azure Machine Learning workspaces](https://learn.microsoft.com/en-us/azure/machine-learning/how-to-assign-roles?view=azureml-api-2&tabs=team-lead) |

## Changelog

- [azure-prdsvc-terraform-staticwebapp](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/static-web-apps/overview)

### Terraform Docs

- [azurerm_static_web_app_name](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/static_web_app)

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
| [azurerm_static_web_app.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/static_web_app) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_app_settings"></a> [app_settings](#input_app_settings) | (Optional) A map of app settings to be applied to the static site. | <pre>object({<br/>  })</pre> | `null` | no |
| <a name="input_basic_auth"></a> [basic_auth](#input_basic_auth) | (Optional) A Identity block as defined below.<br/>    password     = "(Required) The password for the basic authentication access."<br/>    environments = "(Required) The Environment types to use the Basic Auth for access." | <pre>object({<br/>    password     = string<br/>    environments = string<br/>  })</pre> | `null` | no |
| <a name="input_configuration_file_changes_enabled"></a> [configuration_file_changes_enabled](#input_configuration_file_changes_enabled) | (Optional) Should changes to the configuration file be permitted. | `bool` | `"true"` | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_identity"></a> [identity](#input_identity) | (Optional) An identity block as defined below<br/>object({<br/>  type         = "(Required) Specifies the type of Managed Service Identity that should be configured on this Static Web App. Possible values are `SystemAssigned`, `UserAssigned`, `SystemAssigned, UserAssigned` (to enable both)."<br/>  identity_ids = "(Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this App Configuration. This is required when `type` is set to `UserAssigned` or `SystemAssigned, UserAssigned`."<br/>}) | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string))<br/>  })</pre> | <pre>{<br/>  "identity_ids": null,<br/>  "type": "SystemAssigned"<br/>}</pre> | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input_name) | (Optional) The name of the Azure Static Web App. If not provided, the name will be auto-generated using the resource naming module based on org_id, app_id, location, environment, context, and instance. | `string` | `null` | no |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_preview_environments_enabled"></a> [preview_environments_enabled](#input_preview_environments_enabled) | (Optional) Are Preview (Staging) environments enabled. | `bool` | `"true"` | no |
| <a name="input_public_network_access_enabled"></a> [public_network_access_enabled](#input_public_network_access_enabled) | (Optional) Should public network access be enabled for the Static Web App. | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_sku_size"></a> [sku_size](#input_sku_size) | (Optional) The pricing size of the Azure Static Web App. | `string` | `"Standard"` | no |
| <a name="input_sku_tier"></a> [sku_tier](#input_sku_tier) | (Optional) The pricing tier of the Azure Static Web App. | `string` | `"Standard"` | no |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The ID of the Static Web App. |
| <a name="output_name"></a> [name](#output_name) | The Name of the Static Web App. |
| <a name="output_resource"></a> [resource](#output_resource) | The Static Web App resource. |
<!-- END_TF_DOCS -->
