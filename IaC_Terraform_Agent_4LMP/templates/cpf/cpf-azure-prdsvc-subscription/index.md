---
version: 0.2.2
available_versions:
  - 0.2.2
  - 0.2.1
  - 0.2.0
  - 0.1.0
---

<!-- BEGIN_TF_DOCS -->
# Subscription module


## Overview

This terraform module creates an Azure Subscription in an Azure Tenant.

## Prerequisites

- An Azure tenant where to target the deployment.

## Guidance

#### Usage

- The Azure tenant to create the subscription in is deducted from the combination of the provided:
  - Billing Account name,
  - Enrollment Account name.
- The subscription is created and not associated to a Management Group by this module. It is created at the Management group's root level. To associate the Subscription to a Management Group, use the LSEG Management Group module.
- The subscription name is generated following this convention:
  >[`azu`][(optional)-`dev`]-[`stage`]-[`context`][(optional)-`instance`]

#### Security Considerations

#### Additional information

Due to lacking permissions in the testing environment, this product is not continuously validated and the terraform apply step is skipped by the validation pipeline.

## Security Controls

Controls are Not Applicable to this Cloud Product. Related evidence will be captured in the Azure Landing Zone (ALZ) vending design.

## SMCF Controls

Controls are Not Applicable to this Cloud Product. Related evidence will be captured in the Azure Landing Zone (ALZ) vending design.

## Changelog

- [azure-prdsvc-terraform-subscription](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/cost-management-billing/manage/create-customer-subscription)

- [Create Azure subscription programmatically](https://learn.microsoft.com/en-us/azure/cost-management-billing/manage/programmatically-create-subscription)

### Terraform Docs

- [azurerm_subscription](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subscription)

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
| [azurerm_subscription.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subscription) | resource |
| [azurerm_billing_enrollment_account_scope.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/billing_enrollment_account_scope) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alias"></a> [alias](#input_alias) | (Optional) Alias name for the subscription. | `string` | `null` | no |
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_billing_account_name"></a> [billing_account_name](#input_billing_account_name) | (Required) The Azure Billing Scope ID. Can be a Microsoft Customer Account Billing Scope ID, a Microsoft Partner Account Billing Scope ID or an Enrollment Billing Scope ID. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 71 chars). | `string` | `null` | no |
| <a name="input_enrollment_account_name"></a> [enrollment_account_name](#input_enrollment_account_name) | (Required) Enrollment account name. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |
| <a name="input_workload"></a> [workload](#input_workload) | (Optional) Subscription type.  More information: [Enterprise Dev/Test subscription](https://azure.microsoft.com/en-us/offers/ms-azr-0148p/).<br></br>&#8226; Value of `workload` must be one of: `[Production,DevTest]`. | `string` | `"DevTest"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alias"></a> [alias](#output_alias) | Alias name for the subscription. |
| <a name="output_billing_scope_id"></a> [billing_scope_id](#output_billing_scope_id) | The Azure billing scope ID. |
| <a name="output_id"></a> [id](#output_id) | The resource ID of the Alias. |
| <a name="output_resource"></a> [resource](#output_resource) | The Subscription resource. |
| <a name="output_subscription_id"></a> [subscription_id](#output_subscription_id) | The ID of the Subscription. |
| <a name="output_subscription_name"></a> [subscription_name](#output_subscription_name) | The Name of the Subscription. This is the Display Name in the portal. |
| <a name="output_tenant_id"></a> [tenant_id](#output_tenant_id) | The ID of the Tenant to which the subscription belongs. |
| <a name="output_workload"></a> [workload](#output_workload) | The workload type of the Subscription. |
<!-- END_TF_DOCS -->
