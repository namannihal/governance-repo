---
version: 1.0.1
available_versions:
  - 1.0.1
  - 1.0.0
  - 0.2.5
  - 0.2.4
  - 0.2.3
---

<!-- BEGIN_TF_DOCS -->
# Role Assignment Module

## Overview

This terraform module assigns Roles onto Azure Resource (scope) for an Object. Azure Role-Based access Control (Azure RBAC) is the authorization system used to manage access to Azure resources.

To grant access, **roles** are assigned to **users, groups, service principals** at a particular **scope**.

## Prerequisites

- A `Management Group`, `Subscription`, `Resource Group` or `Resource` to set scope for role assignment.
- `object_id` of the `Service Principal/User/Group` to which the role is assigned.
- The **Service Principal/User/Group** needs to have **equivalent** or **more than** `User Access Administrator` role to assign the roles using this module.

## Guidance

#### Usage

- This module does not utilize LSEG naming module as no resource is being created with this module, only `built-in role` is being assigned using this module.
- This module assigns built-in `role` to `User/Service Principal/Group` for different `Azure Resource`. Please look in [documentation](https://docs.microsoft.com/en-us/azure/role-based-access-control/built-in-roles) for the available `built-in roles`.
- **Only one** value between `role_definition_id` & `role_definition_name` must be provided. If `both` or 'none' are provided, it'll return an error.

#### Security Considerations

## Security Controls

Role Assignment Product does not have any security controls available and likely will be not be available in future as well. If any security controls are identified in this product new version will be added.

## SMCF Controls

| S. No.  | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|---------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-02:  Assign roles to users at different scopes, such as resource group, subscription, or instance level.<br><br>SMCF-SEC-05-03:Review access periodically to ensure compliance with security standards. | Azure RBAC IaC<br><br>Automated access reviews | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package and has a JIT implementation in place.|
| 2. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types.<br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC<br><br>Documentation | True | This control will be implemented using resource naming module.<br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames) |

## Changelog

- [azure-prdsvc-terraform-roleassignment](CHANGELOG.md)

## References

### Microsoft Docs

- [Azure built-in roles] https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles
- [Azure RBAC] https://learn.microsoft.com/en-us/azure/role-based-access-control/overview

### Terraform Docs

- [azurerm_role_assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment)

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
| [azurerm_role_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_condition"></a> [condition](#input_condition) | (Optional) Provide the condition that limits the resources that the role can be assigned to. | `string` | `null` | no |
| <a name="input_condition_version"></a> [condition_version](#input_condition_version) | (Optional) The version of the condition. Possible values are `1.0` or `2.0`. | `string` | `null` | no |
| <a name="input_delegated_managed_identity_resource_id"></a> [delegated_managed_identity_resource_id](#input_delegated_managed_identity_resource_id) | (Optional) Provide the delegated `Azure Resource Id` which contains a `Managed Identity`. This field is used in cross tenant scenario. The `principal_id` in this scenario must be the `object_id` of the `Managed Identity` | `string` | `null` | no |
| <a name="input_description"></a> [description](#input_description) | (Optional) A description for this Role Assignment. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input_name) | (Optional) A unique UUID/GUID for this Role Assignment - one will be generated if not specified. | `string` | `null` | no |
| <a name="input_principal_id"></a> [principal_id](#input_principal_id) | (Required) Provide the `Object ID` of the `Principal` `(User, Group or Service Principal)` to assign the Role to. The Principal ID is also known as the `Object ID` (for `App registrations`, it is the **`Object ID` of the underlying Managed/Enterprise Application**). | `string` | n/a | yes |
| <a name="input_role_definition_id"></a> [role_definition_id](#input_role_definition_id) | (Required*) Provide the "ID" of a built-in Role. See [list of built-in Roles](https://docs.microsoft.com/en-us/azure/role-based-access-control/built-in-roles). Only one of `role_definition_name` or `role_definition_id` is required: if both are provided, it will return an error (valid input is: Id XOR Name). | `string` | `null` | no |
| <a name="input_role_definition_name"></a> [role_definition_name](#input_role_definition_name) | (Required*) Provide the "Name" of a built-in Role. See [list of built-in Roles](https://docs.microsoft.com/en-us/azure/role-based-access-control/built-in-roles). Only one of `role_definition_name` or `role_definition_id` is required: if both are provided, it will return an error (valid input is: Id XOR Name). | `string` | `null` | no |
| <a name="input_scope"></a> [scope](#input_scope) | (Required) Provide the `Resource ID` of the `Resource` in which built-in Role needs to be assigned. | `string` | n/a | yes |
| <a name="input_skip_service_principal_aad_check"></a> [skip_service_principal_aad_check](#input_skip_service_principal_aad_check) | (Optional) If the `principal_id` is a newly provisioned `Service Principal` set this value to `true` to skip the `Azure Active Directory` check: it may fail due to replication lag. This argument is only valid if the `principal_id` is of type `Service Principal`. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The Role Assignment ID. |
| <a name="output_principal_id"></a> [principal_id](#output_principal_id) | The object ID of the role assigned |
| <a name="output_principal_type"></a> [principal_type](#output_principal_type) | The `principal_id`'s type: e.g. `User`, `Group`, `Service Principal`, `Application`, `etc`. |
| <a name="output_resource"></a> [resource](#output_resource) | The Role Assignment resource. |
| <a name="output_scope"></a> [scope](#output_scope) | List the scope on which rbac is applied |
<!-- END_TF_DOCS -->
