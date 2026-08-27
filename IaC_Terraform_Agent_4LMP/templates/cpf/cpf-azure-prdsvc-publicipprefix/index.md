---
version: 1.0.2
available_versions:
  - 1.0.2
  - 1.0.1
  - 1.0.0
  - 0.3.1
  - 0.3.0
---

<!-- BEGIN_TF_DOCS -->
# azu-product-tf-publicipprefix

## Overview

- This terraform module creates a public IP address prefix in Azure.

## Prerequisites

- A `Resource group`.

## Guidance

#### Usage

- Following are the service limits, per subscriptions and product:

  - [Azure limits per subscription](https://docs.microsoft.com/en-us/azure/azure-subscription-service-limits)
  - [azu-product-tf-resourcegroup](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/azure-subscription-service-limits#resource-group-limits)

#### Security Considerations

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-PIPP-SC_010 | Must use Microsoft owned public IP addresses | Must only use Microsoft owned public IP addresses and not custom (What) via Deployment settings (How) To provide ammonisation of LSEG assets exposed to the internet to hinder possible malicious activity against LSEG (Why) | False | False | This is a platform level control which will be implemented at ALZ vending. |
| 2. | AZU-PIPP-CP_010 | Public IP prefixes must have Routing Preference set to Microsoft network | Public IP prefixes must have Routing Preference set to Microsoft network (What) within Deployment settings (How) To leverage Microsoft’s managed global network to improve network availability (Why) | False | False | This is a platform level control which will be implemented at ALZ vending. |

## Changelog

- [azure-prdsvc-terraform-publicipprefix](/CHANGELOG.md)

## References

### Microsoft Docs

- [Public IP Address Prefix](https://learn.microsoft.com/en-us/azure/virtual-network/ip-services/public-ip-address-prefix)

### Terraform Docs

- [azurerm_public_ip_prefix](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip_prefix)

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
| [azurerm_public_ip_prefix.pip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip_prefix) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_availability_zones"></a> [availability_zones](#input_availability_zones) | (Optional) The Availability Zone in which this Public IP Prefix should be located. | `list(string)` | `null` | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 71 chars). | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_ip_version"></a> [ip_version](#input_ip_version) | (Optional) The IP Version to use, IPv6 or IPv4. | `string` | `"IPv4"` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_prefix_length"></a> [prefix_length](#input_prefix_length) | (Optional) The number of bits of the prefix. The value can be set between 0 (4,294,967,296 addresses) and 31 (2 addresses). | `number` | `31` | no |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input_sku) | (Optional) The SKU of the Public IP Prefix. Accepted values are - Standard. | `string` | `"Standard"` | no |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | ID of the public IP prefix. |
| <a name="output_name"></a> [name](#output_name) | Name of the public IP prefix. |
| <a name="output_public_ip_prefix"></a> [public_ip_prefix](#output_public_ip_prefix) | IP address prefix value that was allocated. |
| <a name="output_resource"></a> [resource](#output_resource) | The Public Ip Prefix resource. |
<!-- END_TF_DOCS -->
