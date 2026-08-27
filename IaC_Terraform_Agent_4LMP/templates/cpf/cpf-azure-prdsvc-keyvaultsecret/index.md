---
version: 1.0.2
available_versions:
  - 1.0.2
  - 1.0.1
  - 1.0.0
  - 0.3.3
  - 0.3.2
---

<!-- BEGIN_TF_DOCS -->
# Key Vault Secret module

## Overview

This terraform module creates a Key Vault Secret and associated resources.

## Prerequisites

A `Key Vault` needs to be created first, if not exists, to hold the `Key Vault Secret`.

## Guidance

#### Usage

- Key Vault strips newlines. To preserve newlines in multi-line secrets try replacing them with `\n` or by base 64 encoding them with `replace(file("my_secret_file"), "/\n/", "\n")` or `base64encode(file("my_secret_file"))`, respectively.

#### Security Considerations

## Security Controls

- Key Vault Secret does not have any [security controls](https://gitlab.dx1.lseg.com/app/app-51285/cloud-security-controls/azure-clear-listing/-/blob/main/azure/services/Microsoft.KeyVault/vaults/v1.0.0/markdown/serviceControls.md) available currently. If any security controls are identified in this product new version will be added.

## Changelog

[azure_prdsvc_terraform_keyvaultsecret](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/key-vault/secrets/about-secrets)

### Terraform Docs

- [azurerm_key_vault_secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret)

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
| [azurerm_key_vault_secret.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_content_type"></a> [content_type](#input_content_type) | (Optional) Specifies the content type of the Key Vault Secret. | `string` | `null` | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_expiration_date"></a> [expiration_date](#input_expiration_date) | (Optional) Expiration UTC datetime (Y-m-d'T'H:M:S'Z'). | `string` | `null` | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_key_vault_id"></a> [key_vault_id](#input_key_vault_id) | (Required) The ID of the Key Vault where the Secret should be created. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input_name) | (optional) Key name to be used (max 127 chars) | `string` | `null` | no |
| <a name="input_not_before_date"></a> [not_before_date](#input_not_before_date) | (Optional) Key not usable before the provided UTC datetime (Y-m-d'T'H:M:S'Z'). | `string` | `null` | no |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |
| <a name="input_value"></a> [value](#input_value) | (Required) Specifies the value of the Key Vault Secret. Changing this will create a new version of the Key Vault Secret. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The Resource ID of the Key Vault Secret. |
| <a name="output_name"></a> [name](#output_name) | The Name of the Key Vault Secret. |
| <a name="output_resource"></a> [resource](#output_resource) | The Key Vault Secret resource. |
<!-- END_TF_DOCS -->
