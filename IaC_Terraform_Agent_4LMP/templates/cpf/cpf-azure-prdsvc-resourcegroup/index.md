---
version: 0.3.3
available_versions:
  - 0.3.3
  - 0.3.2
  - 0.3.1
  - 0.3.0
  - 0.2.0
---

<!-- BEGIN_TF_DOCS -->
# Azure Resouce Group module


## Overview

This terraform module creates an Azure Resource Group.

## Prerequisites

A resource group is usually not depending on the existence of any Azure resource.

## Guidance

#### Usage

A resource group is a container that holds related resources for an Azure solution. The resource group can include all the resources for the solution, or only those resources that you want to manage as a group.

#### Security Considerations

## Security Controls

- Not applicable for Azure Resource Group.

## SMCF Controls

| S. No.  | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|---------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-FIN-02 Cost Reporting](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/805/SMCF-FIN-02-Cost-Reporting) | SMCF-FIN-02-01: The ability to provide show-back and charge-back costs and track consumption to the key stakeholders. | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard via manual attestion policy. |
| 2. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) |SMCF-SEC-05-02: Assign roles to users at different scopes, such as resource group, subscription, or instance level.<br><br>SMCF-SEC-05-03: Review access periodically to ensure compliance with security standards. | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package. |
| 3. | [SMCF-GOV-01 Landing Zone](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1410/SMCF-GOV-01-Landing-Zone) |SMCF-GOV-01-01: Cloud Landing Zone is defined using Infrastructure-as-Code and deployed using automation.<br><br>SMCF-GOV-01-04: Centralized policies and guardrails are applied to the landing zone. | IaC<br><br>Documentation | True | This control will be implemented using terraform modules. |
| 4. | [SMCF-GOV-04 CMDB Integration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1411/SMCF-GOV-04-CMDB-Integration) |SMCF-GOV-04-03: Cloud CI governance - The process of defining and enforcing the policies and standards for the cloud CIs, such as naming conventions, tagging rules, and compliance requirements. | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard via manual attestion policy. |
| 5. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) |SMCF-GOV-02-01: Naming conventions are consistently applied to all resources within the resource group.<br><br>SMCF-GOV-02-02: Azure resource names are assessed and non-compliant resources remediated.<br><br>SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types.<br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc.<br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC<br><br>Documentation | True | This control will be implemented using resource naming module.<br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames) |
| 6. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02:Must apply tags to all deployed resources, where applicable.<br><br>SMCF-GOV-03-03: Tags must be audited and non-compliant resources remediated | IaC<br><br>Policy | True | This control will be implemented using `tags` parameter.<br><br>This control is achieved by custom policy as described in the [clear listing page](https://dev.azure.com/LSEGroup/Foundation/_git/azu-plat-policy) from where it inherits all the mandatory tags. |

## Changelog

- [azure-prdsvc-terraform-resourcegroup](CHANGELOG.md)

## References

### Microsoft Docs

- [Azure Resource Group](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/manage-resource-groups-portal#what-is-a-resource-group)

### Terraform Docs

- [azurerm_resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group)

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
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 71 chars). | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The ID of the created Resource Group. |
| <a name="output_name"></a> [name](#output_name) | The name of the created Resource Group. |
| <a name="output_resource"></a> [resource](#output_resource) | The Resource Group resource. |
<!-- END_TF_DOCS -->
