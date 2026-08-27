---
version: 1.0.1
available_versions:
  - 1.0.1
  - 1.0.0
  - 0.1.2
  - 0.1.1
  - 0.1.0
---

<!-- BEGIN_TF_DOCS -->
# Synapse Workspace Role Assignment module


## Overview

This terraform module creates a Synapse Workspace Role Assignment and associated resources.

## Prerequisites

- A  Synapse Workspace with required configurations and [dependencies](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-synapseworkspace/-/blob/main/README.md) deployed to host the Synapse workspace.
- A `Private endpoint` with a Target subresource_name of `Dev` to Synapse Workspace.

## Guidance

#### Usage

- This module deploys the Azure Synapse Workspace Role Assignmen associated with `Synapse Workspace`.

#### Security Considerations

## Security Controls

- Security control of this product is coverd under parent module `azure-prdsvc-terraform-synapseworkspace`.

## Changelog

- [azure-prdsvc-terraform-synapseroleassignment](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/synapse-analytics/security/how-to-manage-synapse-rbac-role-assignments)

- [Connect Synapse from a restricted network](https://learn.microsoft.com/en-us/azure/synapse-analytics/security/how-to-connect-to-workspace-from-restricted-network#step-4-create-private-endpoints-for-your-workspace-resource)

### Terraform Docs

- [azure-prdsvc-terraform-synapseroleassignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/synapse_role_assignment)

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
| [azurerm_synapse_role_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/synapse_role_assignment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_principal_id"></a> [principal_id](#input_principal_id) | (Required) The Role Name of the Synapse Built-In Role. Possible values are Apache Spark Administrator, Synapse Administrator, Synapse Artifact Publisher, Synapse Artifact User, Synapse Compute Operator, Synapse Contributor, Synapse Credential User, Synapse Linked Data Manager, Synapse Monitoring Operator, Synapse SQL Administrator and Synapse User. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_principal_type"></a> [principal_type](#input_principal_type) | (Required) The Role Name of the Synapse Built-In Role. Possible values are Apache Spark Administrator, Synapse Administrator, Synapse Artifact Publisher, Synapse Artifact User, Synapse Compute Operator, Synapse Contributor, Synapse Credential User, Synapse Linked Data Manager, Synapse Monitoring Operator, Synapse SQL Administrator and Synapse User. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_role_name"></a> [role_name](#input_role_name) | (Required) The Role Name of the Synapse Built-In Role. Possible values are Apache Spark Administrator, Synapse Administrator, Synapse Artifact Publisher, Synapse Artifact User, Synapse Compute Operator, Synapse Contributor, Synapse Credential User, Synapse Linked Data Manager, Synapse Monitoring Operator, Synapse SQL Administrator and Synapse User. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_synapse_spark_pool_id"></a> [synapse_spark_pool_id](#input_synapse_spark_pool_id) | (Optional) The Synapse Spark Pool which the Synapse Role Assignment applies to. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_synapse_workspace_id"></a> [synapse_workspace_id](#input_synapse_workspace_id) | (Optional) The Synapse Workspace which the Synapse Role Assignment applies to. Changing this forces a new resource to be created. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The Resource ID of the Azure Synapse Workspace Role Assignment. |
| <a name="output_resource"></a> [resource](#output_resource) | The Resource of the Azure Synapse Workspace Role Assignment |
<!-- END_TF_DOCS -->
