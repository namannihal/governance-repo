---
version: 1.0.2
available_versions:
  - 1.0.2
  - 1.0.1
  - 1.0.0
  - 0.8.1
  - 0.8.0
---

<!-- BEGIN_TF_DOCS -->
# Front Door Profile module

## Overview

- This terraform module creates a Front Door Profile and associated resources.
- Azure Front Door is Microsoft’s modern cloud Content Delivery Network (CDN) that provides fast, reliable, and secure access between your users and your applications’ static and dynamic web content across the globe. Azure Front Door delivers your content using Microsoft’s global edge network with hundreds of global and local points of presence (PoPs) distributed around the world close to both your enterprise and consumer end users.
- This module creates System identity as optional feature through AzAPI. This is required to retrieve secrets from key vault when customer certificate is selected in custom domain module.

## Prerequisites

## Guidance

#### Usage

- This module only creates following resources in Azure
  - Azure Front Door Profile
  - Endpoint in Front Door Profile
- Other Front door configuration like Origin Groups, Origins, Routes etc will be done through separate modules.

##### Response Timeout Configuration

The `response_timeout_seconds` parameter allows you to configure the maximum response timeout for your Front Door Profile. This is useful for applications that may require longer processing times.

**Example with default timeout (120 seconds):**
```hcl
module "frontdoor" {
  source              = "path/to/module"
  org_id              = "a1a"
  app_id              = "51310"
  environment         = "dev"
  location            = "uksouth"
  resource_group_name = "rg-frontdoor"
  sku_name            = "Premium_AzureFrontDoor"
  # response_timeout_seconds defaults to 120 seconds
}
```

**Example with custom timeout:**
```hcl
module "frontdoor" {
  source                   = "path/to/module"
  org_id                   = "a1a"
  app_id                   = "51310"
  environment              = "dev"
  location                 = "uksouth"
  resource_group_name      = "rg-frontdoor"
  sku_name                 = "Premium_AzureFrontDoor"
  response_timeout_seconds = 180  # Set to 3 minutes for long-running operations
}
```

**Note:** The `response_timeout_seconds` value must be between 16 and 240 seconds (inclusive). The default value is 120 seconds, which provides backward compatibility for existing deployments.

##### Operation Timeouts

This module configures extended timeouts for create, update, and delete operations (120 minutes each) to accommodate the time required for global CDN Front Door deployment and cleanup. These timeouts ensure that:

- **Create operations** have sufficient time to deploy the Front Door Profile across all global edge locations
- **Update operations** can propagate changes globally without timing out
- **Delete operations** can complete the cleanup of all global resources

These extended timeouts are especially important for CDN Front Door due to its globally distributed nature and the time required to provision/deprovision resources across Microsoft's worldwide edge network.

#### Security Considerations

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-AFD-IA_010 | Use a Managed Identity for accessing Azure Resources  | Front Door must enforce the use of a Managed Identity to authenticate to Azure resources where this is supported (What) within Identity setting (How) in order to remove the need to store credentials (Why) | False | False | This Control would be implemented by LSEG Standard. |
| 2. | AZU-AFD-AU_010 | Send all diagnostic log (except Health Probe) categories to a central SOC Log Analytics workspace  | Front Door must send all diagnostic logs (except Health Probe) to a central SOC Log Analytics workspace (What) within Diagnostic settings (How) in order to support a security investigation after a security incident (Why) | False | False | Audit Logging can be enabled using a separate module at bundle/pattern level. |
| 3. | AZU-AFD-AU_020 | Send all diagnostic log (except Health Probe) categories to a central SOC Storage Account  | Front Door must send all diagnostic logs to a central SOC Storage Account (What) within Diagnostic settings (How) In order to provide an immutable copy to adhere to compliance requirements (Why) | False | False | Audit Logging can be enabled using a separate module at bundle/pattern level. |
| 4. | AZU-AFD-SC_150 | Front Door must not be used across environment type (e.g. APP1-PROD, APP1-DEV) except in non-production (e.g. APP1-DEV, APP1-STG, APP2-DEV) where there is no risk from separating them relevant to the application risk profile | Front Door must not be used across environment type (e.g. APP1-PROD, APP1-DEV) except in non-production (e.g. APP1-DEV, APP1-STG, APP2-DEV) where there is no risk from separating them relevant to the application risk profile (What) within code deployment parameters (How) in order to reduce misconfiguration that might expose non-production content as production (Why) | False | False | This Control would be implemented by LSEG Standard. |

## SMCF Controls

| S. No.  | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|---------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types.<br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc.<br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC<br><br>Documentation | True | This control will be implemented using resource naming module.<br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames) |
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC<br><br>Policy | True | This control will be implemented using `tags` parameter.<br><br>This control is achieved by custom policy as described in the [clear listing page](https://dev.azure.com/LSEGroup/Foundation/_git/azu-plat-policy) from where it inherits all the mandatory tags. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties.<br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration. | Policies<br><br>Iac<br><br>Policies<br><br>Iac | True | This control will be implemented by having all the `Mandate` and most of the `Optional ` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring) | SMCF-OPS-03-02: Define and automate resource operation and security log collection<br><br>SMCF-OPS-03-03: Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs) | Policy<br><br>Documentation<br><br>Documentation | True | This control will be implemented by `DINE` Policy.<br><br>[Monitor metrics and logs in Azure Front Door](https://learn.microsoft.com/en-us/azure/frontdoor/front-door-diagnostics?pivots=front-door-standard-premium)<br><br>[Cloud monitoring service level objectives](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/monitor/service-level-objectives)<br><br>[Supported metrics for Microsoft.Network/frontdoors](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-network-frontdoors-metrics) |
| 5. | [SMCF-OPS-07: Resource Protection](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-07-01: Prevent accidental or malicious deletion of production resources<br><br>SMCF-OPS-07-02: Prevent accidental misconfiguration of key production resources | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard based on application team requirement. <br><br>[Lock your resources to protect your infrastructure](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json) |
| 6. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package and has a JIT implementation in place.<br><br>[Azure built-in roles](https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles)<br><br> |

## Changelog

- [azure-prdsvc-terraform-cdnfrontdoorprofile](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/frontdoor/)

### Terraform Docs

- [azurerm_cdn_frontdoor_profile](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cdn_frontdoor_profile)
- [azurerm_cdn_frontdoor_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cdn_frontdoor_endpoint)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.5.0 |
| <a name="requirement_azapi"></a> [azapi](#requirement_azapi) | >= 1.9 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm) | >=4.33 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azapi"></a> [azapi](#provider_azapi) | >= 1.9 |
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) | >=4.33 |

## Resources

| Name | Type |
|------|------|
| [azapi_update_resource.frontdoor_system_identity](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/update_resource) | resource |
| [azurerm_cdn_frontdoor_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cdn_frontdoor_endpoint) | resource |
| [azurerm_cdn_frontdoor_profile.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cdn_frontdoor_profile) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_enable_endpoint"></a> [enable_endpoint](#input_enable_endpoint) | (Optional) Specifies if this Front Door Endpoint is enabled? Defaults to true. | `string` | `true` | no |
| <a name="input_enable_frontdoor_systemidentity"></a> [enable_frontdoor_systemidentity](#input_enable_frontdoor_systemidentity) | (Optional) Specifies if this Front Door System identity is enabled? Defaults to false. | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_response_timeout_seconds"></a> [response_timeout_seconds](#input_response_timeout_seconds) | (Optional) Specifies the maximum response timeout in seconds. Possible values are between 16 and 240 seconds (inclusive). Defaults to 120 seconds. | `number` | `120` | no |
| <a name="input_sku_name"></a> [sku_name](#input_sku_name) | (Required) Specifies the SKU for this Front Door Profile. Possible values include Standard_AzureFrontDoor and Premium_AzureFrontDoor. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input_timeouts) | (Optional) Timeouts for CDN Front Door Profile operations. Defaults: create=120m, update=120m, delete=120m. | <pre>object({<br/>    create = optional(string, "120m")<br/>    update = optional(string, "120m")<br/>    delete = optional(string, "120m")<br/>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cdn_fd_endpoint"></a> [cdn_fd_endpoint](#output_cdn_fd_endpoint) | The Cdn Frontdoor Endpoint resource. |
| <a name="output_endpoint_id"></a> [endpoint_id](#output_endpoint_id) | The ID of the created Front Door endpoint. |
| <a name="output_endpoint_name"></a> [endpoint_name](#output_endpoint_name) | The name of the created Front Door endpoint. |
| <a name="output_id"></a> [id](#output_id) | The ID of the created Front Door Profile. |
| <a name="output_name"></a> [name](#output_name) | The name of the created Front Door Profile. |
| <a name="output_resource"></a> [resource](#output_resource) | The Cdn Frontdoor Profile resource. |
| <a name="output_system_identity_principalId"></a> [system_identity_principalId](#output_system_identity_principalId) | The principal ID of the Front Door Profile system identity. |
| <a name="output_system_identity_tenantId"></a> [system_identity_tenantId](#output_system_identity_tenantId) | The tenant ID of the Front Door Profile system identity. |
<!-- END_TF_DOCS -->
