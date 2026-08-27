---
version: 2.0.2
available_versions:
  - 2.0.2
  - 2.0.1
  - 2.0.0
  - 1.0.1
  - 1.0.0
---

<!-- BEGIN_TF_DOCS -->
# Microsoft Fabric module


## Overview

This terraform module creates a Microsoft Fabric and associated resources.

## Prerequisites

Please find the below pre-requisites to deploy fabric cappacity.

- Role Assignment to `SPN` for Fabric Capacity
    <br>Step 1: Fabric Capacity should have the following permission `Microsoft.Fabric/capacities/write` needs to be assigned at Subscription level for your existing SPN
    <br><br>Step 2: We have the custom role `Custom-Fabric-Capacity-Admin-1.0.0` created in all Environment which has the following actions:<br>
    [Image: CustomRoleAction]
    <br><br>Step 3: Raise an `SRE ticket` to add your `SPN` to the `Custom-Fabric-Capacity-Admin-1.0.0` role in the respective environment
    <br><br>Step 4: Validate if your `SPN` has the `Custom-Fabric-Capacity-Admin-1.0.0` role assigned:<br>
    [Image: RoleAssignmentoverSPN]

## Guidance

#### Usage

- SPN must have the relevant permissions to deploy the fabric capacity in LSEG. A custom role, [A1A-DEV] Custom-Fabric-Capacity-Admin-1.0.0, has already been created for this purpose. This role should be assigned to the app deployment SPN prior to deployment.
- Use the `tags` variable to define additional tags related to the product (core). Note that the product already has a default of 13 tags, so if you are adding multiple additional tags (key-value pairs), ensure the total count does not exceed the limit supported by Azure resources. [Azure Resources Tag Limitation](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/tag-support)

#### Security Considerations

- Fabric Capacity should have the following permission `Microsoft.Fabric/capacities/write`

#### Additional Information

- Fabric Administrator is a Entra role which is used to manage and assign the fabric capacity resources in workspace.<br>
[Image: Fabric Administrator]

> **Note:** The name format for Microsoft Fabric capacity clusters does not support hyphens (`-`). Please ensure that resource names generated or provided do not contain hyphens to comply with Azure naming restrictions for Fabric clusters.

## Security Controls

- Fabric Capacity doesn't have any security controls to implement.

## SMCF Controls

| S. No.  | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|---------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types.<br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc.<br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC<br><br>Documentation | True | This control will be implemented using resource naming module.<br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames) |
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC<br><br>Policy | True | This control will be implemented using `tags` parameter.<br><br>This control is achieved by custom policy as described in the [clear listing page](https://dev.azure.com/LSEGroup/Foundation/_git/azu-plat-policy) from where it inherits all the mandatory tags. |
| 3. | [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC<br><br>Documentation | False | This controls is to be implemented by Fabric admin portal not through TF, To change the region for existing content in Microsoft Fabric, either create a new capacity and move workspaces there, or temporarily use a shared capacity with some downtime.<br><br>[Configure Multi-Geo support for Fabric](https://learn.microsoft.com/en-us/fabric/admin/service-admin-premium-multi-geo) |
| 4. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package and has a JIT implementation in place.<br><br>[Azure built-in roles](https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles)<br><br>After the product deployment is completed, this step must be performed manually, as a Service Principal serves as an authentication method allowing a Microsoft Entra application to access Microsoft Fabric content and APIs.<br><br>[Enable service principal authentication for read-only admin APIs](https://learn.microsoft.com/en-us/fabric/admin/metadata-scanning-enable-read-only-apis) |

## Changelog

- [azure-prdsvc-terraform-fabriccapacity](CHANGELOG.md)

## References

### Microsoft Docs

- [Capacity admin roles](https://learn.microsoft.com/en-us/fabric/admin/microsoft-fabric-admin#power-platform-and-fabric-admin-roles)
- [Scale your capacity](https://learn.microsoft.com/en-us/fabric/enterprise/scale-capacity)
- [Fabric capacity](https://github.com/Azure/azure-data-labs-modules/tree/main/terraform/fabric/fabric-capacity)

### Terraform Docs

- No `azurerm` provider available for creating/adding the Fabric Capacity, hence, the deployment is done using `azapi` provider for the main product.

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

## Resources

| Name | Type |
|------|------|
| [azapi_resource.fabriccapacity](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_administration_members"></a> [administration_members](#input_administration_members) | (Required) A list of member object IDs or email addresses that will be administrators for the Fabric capacity | `list(string)` | n/a | yes |
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_resource_group_id"></a> [resource_group_id](#input_resource_group_id) | (Required) The ID of the azure resource group in which this resource is created. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input_sku) | (Required) The SKU settings for the Microsoft Fabric.<br/>  The object contains the following properties:<br/>    name     = "(Required) The name of the SKU. Possible values are F2, F4, F8, F16, F32, F64, F128, F256, F512, F1024, F2048."<br/>    tier     = "(Optional) The tier of the SKU." | <pre>object({<br/>    name = string<br/>    tier = optional(string)<br/>  })</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The Resource ID of the Fabric Capacity. |
| <a name="output_name"></a> [name](#output_name) | The Name of the Fabric Capacity. |
| <a name="output_resource"></a> [resource](#output_resource) | The Fabric Capacity resource. |
<!-- END_TF_DOCS -->
