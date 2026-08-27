---
version: 1.1.0
available_versions:
  - 1.1.0
  - 1.0.2
  - 1.0.1
  - 1.0.0
  - 0.6.4
---

<!-- BEGIN_TF_DOCS -->
<!-- BEGIN_TF_DOCS -->
# App Service Plan module

## Overview

This terraform module creates an Azure App Service Plan and associated resources.

## Prerequisites

- `Resource Group` module to be called if not existing.

## Guidance

#### Usage

- Isolated SKUs (I1, I2, I3, I1v2, I2v2, and I3v2) can only be used with App Service Environments. I1v2, I2v2, I3v2  for azurerm\_app\_service\_environment\_v3.
- Elastic and Consumption SKUs (Y1, EP1, EP2, and EP3) are for use with Function Apps.
- Flexible Consumption SKU (FC1) are for use of flexible function.
- `maximum_elastic_worker_count` can only be specified with Elastic Premium Skus.
- If `zone_balancing_enabled` setting is set to true and the worker\_count value is specified, it should be set to a multiple of the number of availability zones in the region. Please see the Azure documentation for the number of [Availability Zones](https://www.azurespeed.com/Information/AzureAvailabilityZones) in your region.
- If `worker_count` is provided, it should be atleast 1.
- Location for App Service Environment and App Service Plan must be same.

#### Security Considerations

#### Additional Information

- Due to increased demand, Azure is restricting capacity to first party services such as Azure App Service. As a result Azure App Service is rolling out offer restrictions in most regions for Microsoft Internal subscriptions. Please visit the link mentioned below in the `Microsoft Docs` section to get all of the current quota and offer restrictions.
-  When creating an new App Service Plan in an existing Resource Group, certain conditions with existing apps can trigger these errors:

    - The pricing tier is not allowed in this resource group
    - <SKU_NAME> workers are not available in resource group <RESOURCE_GROUP_NAME>

    This can happen due to incompatibilities with pricing tiers, regions, operating systems, Availability Zones, existing Function apps, or existing web apps. If this error occurs, create your App Service Plan in a new Resource Group.
  [Create an App Service Plan](https://learn.microsoft.com/en-us/azure/app-service/app-service-plan-manage#create-an-app-service-plan)
## Security Controls

Currently, as per LSEG Approved App service plan Security Requirements, there are no security controls for this product

## SMCF Controls

| S. No.  | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|---------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SSMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types.<br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc.<br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC<br><br>Documentation | True | This control will be implemented using resource naming module.<br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames) |
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC<br><br>Policy | True | This control will be implemented using `tags` parameter.<br><br>This control will be implemented using Policy which inherits all the mandatory tags. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties.<br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration. | Policies<br><br>Iac<br><br>Policies<br><br>Iac | True | This control will be implemented by having all the `Mandate` and most of the `Optional ` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring) | SMCF-OPS-03-02: Define and automate resource operation and security log collection<br><br>SMCF-OPS-03-03: Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs) | Policy<br><br>Documentation<br><br>Documentation | True | This control will be implemented by `DINE` Policy.<br><br>[Monitor Azure App Service Plan](https://learn.microsoft.com/en-us/azure/app-service/web-sites-monitor#understand-metrics)<br><br>[Stream diagnostic logs](https://learn.microsoft.com/en-us/azure/app-service/troubleshoot-diagnostic-logs#overview)<br><br><br><br>[Cloud monitoring service level objectives](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/monitor/service-level-objectives)<br><br>[Supported Metrics for App Service Plan](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-web-serverfarms-metrics)
| 5. | [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC<br><br>Documentation | True | This control will be implemented by following parameters: `zone_balancing_enabled` to evenly distributed across Availability Zones.<br><br>[Disaster recovery and high availability for Azure Service Plans](https://learn.microsoft.com/en-us/azure/reliability/reliability-app-service)
| 6. | [SMCF-OPS-07: Resource Protection](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-07-01: Prevent accidental or malicious deletion of production resources<br><br>SMCF-OPS-07-02: Prevent accidental misconfiguration of key production resources | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard based on application team requirement. <br><br>[Lock your resources to protect your infrastructure](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json) |
| 7. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package and has a JIT implementation in place.<br><br>[Azure built-in roles](https://docs.microsoft.com/en-us/azure/role-based-access-control/built-in-roles)<br><br>[Manage access to Azure resources using RBAC and the Azure portal](https://docs.microsoft.com/en-us/azure/role-based-access-control/role-assignments-portal)

## Changelog

- [azure-prdsvc-terraform-appserviceplan](CHANGELOG.md)

## References

### Microsoft Docs

- [App Service Plan](https://learn.microsoft.com/en-us/azure/app-service/overview-hosting-plans)
- [Quota and Offer restrictions for App Service users](https://msazure.visualstudio.com/AzureWiki/_wiki/wikis/AzureWiki.wiki/50298/Quota-and-Offer-restrictions-for-App-Service-users)

### Terraform Docs

- [azurerm\_app\_service\_plan](https://registry.terraform.io/providers/hashicorp/azurerm/3.73.0/docs/resources/service_plan).

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
| [azurerm_service_plan.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_app_service_environment_id"></a> [app_service_environment_id](#input_app_service_environment_id) | (Optional) The ID of the App Service Environment to create this Service Plan in. | `string` | `null` | no |
| <a name="input_ase_sku_name"></a> [ase_sku_name](#input_ase_sku_name) | (Optional) The SKU for the plan for App Service Environments. Possible values include I1v2, I2v2, I3v2, I4v2, I5v2, I6v2. | `string` | `"I1v2"` | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_maximum_elastic_worker_count"></a> [maximum_elastic_worker_count](#input_maximum_elastic_worker_count) | (Optional) The maximum number of workers to use in an Elastic SKU Plan or Premium Plan that have premium_plan_auto_scale_enabled set to true. Cannot be set unless using an Elastic or Premium SKU. | `number` | `2` | no |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_os_type"></a> [os_type](#input_os_type) | (Required) The O/S type for the App Services to be hosted in this plan. Possible values include Windows, Linux, and WindowsContainer. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_per_site_scaling_enabled"></a> [per_site_scaling_enabled](#input_per_site_scaling_enabled) | (Optional) Should Per Site Scaling be enabled. Defaults to false. | `bool` | `false` | no |
| <a name="input_required_for_ase"></a> [required_for_ase](#input_required_for_ase) | (Required) ASP required for App Service Environment V3? | `bool` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) The name of the Resource Group where the AppService should exist. Changing this forces a new AppService to be created. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku_name](#input_sku_name) | (Required) The SKU for the plan. Possible values include B1, B2, B3, D1, F1, I1, I2, I3, I1v2, I1mv2, I2v2, I2mv2, I3v2, I3mv2, I4v2, I4mv2, I5v2, I5mv2, I6v2, P1v2, P2v2, P3v2, P0v3, P1v3, P2v3, P3v3, P1mv3, P2mv3, P3mv3, P4mv3, P5mv3, P0v4, P1v4, P2v4, P3v4, P1mv4, P2mv4, P3mv4, P4mv4, P5mv4, S1, S2, S3, SHARED, EP1, EP2, EP3, FC1, WS1, WS2, WS3, and Y1. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |
| <a name="input_worker_count"></a> [worker_count](#input_worker_count) | (Optional) The number of Workers (instances) to be allocated. | `number` | `2` | no |
| <a name="input_zone_balancing_enabled"></a> [zone_balancing_enabled](#input_zone_balancing_enabled) | (Optional) Should the Service Plan balance across Availability Zones in the region. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The ID of the App Service Plan component. |
| <a name="output_kind"></a> [kind](#output_kind) | A string representing the Kind of Service Plan. |
| <a name="output_name"></a> [name](#output_name) | The name of the App Service Plan component. |
| <a name="output_resource"></a> [resource](#output_resource) | The App Service Plan resource. |
<!-- END_TF_DOCS -->
