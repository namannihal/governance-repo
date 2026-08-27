---
version: 1.0.2
available_versions:
  - 1.0.2
  - 1.0.1
  - 1.0.0
  - 0.4.3
  - 0.4.2
---

<!-- BEGIN_TF_DOCS -->
# Key Vault Certificate module


## Overview

This terraform module provides options to import or generate a Key Vault Certificate.

## Prerequisites

A `Key Vault` needs to be created first, if not exists, to hold the `Key Vault Certificate`.

## Guidance

#### Usage

- `Key_usage` is case-sensitive.
- When choosing to create and "EC" or "EC-HSM" keys, don't add `Key_usage` as "dataEncipherment", "keyEncipherment", "encipherOnly", "decipherOnly" as it's not supported and throws an error "Unsupported key operation(s): \"encrypt\", \"decrypt\". Supported values are \"sign\", \"verify\"."
- `RSA-HSM` and `EC-HSM` key types should have the "exportable" value as false.
- `EC and EC-HSM` keys when created doesn't add Subject, Issuer, Serial Number, and Subject Alternative Name.
- Elliptic Curve Name: P-256 cannot be used with key size (384) or (521).\r\n", hence, keep the values of `Curve` and `key_size` matching such as with "P-256", key\\_size should be 256.
#### Security Considerations

- When creating a `Key Vault Certificate`, at least one of certificate or certificate\_policy is required. Provide certificate to import an existing certificate, certificate\_policy to generate a new certificate.
- To convert a private key to pkcs8 format with openssl use: `openssl pkcs8 -topk8 -nocrypt -in private\_key.pem > private\_key\_pk8.pem`

## Security Controls

- There are no security controls specified for the Key Vault Certificate in Key Vault Security Control document. The basic pester test case has been added and tested.

## Changelog

- [azure-prdsvc-terraform-keyvaultcertificate](CHANGELOG.md)

## References

### Microsoft Docs

- [Azure Key Vault Certificate](https://learn.microsoft.com/en-us/azure/key-vault/certificates/)

### Terraform Docs

- [azurerm_key_vault_certificate](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_certificate)

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
| [azurerm_key_vault_certificate.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_certificate) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_action_type"></a> [action_type](#input_action_type) | (Optional) The Type of action to be performed when the lifetime trigger is triggered. Required when import_certificate is false. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_certificate_contents"></a> [certificate_contents](#input_certificate_contents) | (Optional) The base64 encoded contents of the certificate to be imported. (Required) in case of import_certificate as True. PEM certificates are already base64-encoded, so don't need to be encoded again | `string` | `""` | no |
| <a name="input_content_type"></a> [content_type](#input_content_type) | (Optional) The Content-Type of the Certificate, such as application/x-pkcs12 for a PFX or application/x-pem-file for a PEM. Required when import_certificate is false. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_curve"></a> [curve](#input_curve) | (Optional) Specifies the curve to use when creating an EC key. Possible values are P-256, P-256K, P-384, and P-521.This field will be required in a future release if key_type is EC or EC-HSM. Changing this forces a new resource to be created. | `string` | `"P-256"` | no |
| <a name="input_ec_key_required"></a> [ec_key_required](#input_ec_key_required) | (Optional) Do you want to create an `EC` key? Required when import_certificate is false. | `bool` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_import_certificate"></a> [import_certificate](#input_import_certificate) | (Required) Choose to import certificate or to generate one. | `bool` | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_issuer_parameters_name"></a> [issuer_parameters_name](#input_issuer_parameters_name) | (Optional) The name of the Certificate Issuer. Required when import_certificate is false. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_key_size"></a> [key_size](#input_key_size) | (Optional) The size of the key used in the certificate. This property is required when using RSA keys and import_certificate is false. Changing this forces a new resource to be created. | `number` | `null` | no |
| <a name="input_key_type"></a> [key_type](#input_key_type) | (Optional) Specifies the type of key. Required when import_certificate is false. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_key_usage"></a> [key_usage](#input_key_usage) | (Optional) A list of uses associated with this Key. Required when import_certificate is false. Possible values are cRLSign, dataEncipherment, decipherOnly, digitalSignature, encipherOnly, keyAgreement, keyCertSign, keyEncipherment and nonRepudiation. Changing this forces a new resource to be created. | `list(string)` | `null` | no |
| <a name="input_key_vault_id"></a> [key_vault_id](#input_key_vault_id) | (Required) The ID of the Key Vault where the Certificate should be created. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_password"></a> [password](#input_password) | (Optional) The password associated with the certificate. | `string` | `null` | no |
| <a name="input_path_of_certificate"></a> [path_of_certificate](#input_path_of_certificate) | (Optional) Provide the path of the existing certificate. (Required) in case of import_certificate as True. | `string` | `null` | no |
| <a name="input_reuse_key"></a> [reuse_key](#input_reuse_key) | (Optional) Is the key reusable? Required when import_certificate is false. Changing this forces a new resource to be created. | `bool` | `null` | no |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |
| <a name="input_trigger"></a> [trigger](#input_trigger) | object({<br/>  days_before_expiry  = "(Optional) The number of days before the Certificate expires that the action associated with this Trigger should run. Changing this forces a new resource to be created. Conflicts with lifetime_percentage."<br/>  lifetime_percentage = "(Optional) The percentage at which during the Certificates Lifetime the action associated with this Trigger should run. Changing this forces a new resource to be created. Conflicts with days_before_expiry."<br/>}) | <pre>object({<br/>    days_before_expiry  = number<br/>    lifetime_percentage = string<br/>  })</pre> | `null` | no |
| <a name="input_x509_certificate_properties"></a> [x509_certificate_properties](#input_x509_certificate_properties) | (Optional) Object Containing Variables for x509 certificate properties<br/>  object({<br/>    extended_key_usage = "(Optional) A list of Extended/Enhanced Key Usages. Changing this forces a new resource to be created."<br/>    subject            = "(Required) The Certificate's Subject. Changing this forces a new resource to be created."<br/>    subject_alternative_names = object({<br/>      dns_names = "(Optional) A list of alternative DNS names (FQDNs) identified by the Certificate. Changing this forces a new resource to be created."<br/>      emails    = "(Optional) A list of email addresses identified by this Certificate. Changing this forces a new resource to be created."<br/>      upns      = "(Optional) A list of User Principal Names identified by the Certificate. Changing this forces a new resource to be created."<br/>    })<br/>    validity_in_months = "(Required) The Certificates Validity Period in Months. Changing this forces a new resource to be created."<br/>  }) | <pre>object({<br/>    extended_key_usage = optional(list(string))<br/>    subject            = string<br/>    subject_alternative_names = object({<br/>      dns_names = optional(list(string))<br/>      emails    = optional(list(string))<br/>      upns      = optional(list(string))<br/>    })<br/>    validity_in_months = string<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The Key Vault Certificate ID. |
| <a name="output_name"></a> [name](#output_name) | The Key Vault Certificate Name. |
| <a name="output_resource"></a> [resource](#output_resource) | The Key Vault Certificate resource. |
<!-- END_TF_DOCS -->
