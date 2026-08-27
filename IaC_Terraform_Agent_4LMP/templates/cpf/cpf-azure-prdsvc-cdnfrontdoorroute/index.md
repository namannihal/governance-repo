---
version: 1.0.1
available_versions:
  - 1.0.1
  - 1.0.0
  - 0.2.4
  - 0.2.3
  - 0.2.2
---

<!-- BEGIN_TF_DOCS -->
# Front Door Route module

## Overview

This terraform module creates a Front Door Origin and associated resources.
Azure Front Door traffic routing takes place over multiple stages. First, traffic is routed from the client to the Front Door. Then, Front Door uses your configuration to determine the origin to send the traffic to. The Front Door web application firewall, routing rules, rules engine, and caching configuration can all affect the routing process.

## Prerequisites
- Azure CDN Front Door Profile needs to be created prior to this module.
- Azure CDN Front Door Origin group needs to be created prior to this module.
- Azure CDN Front Door Origin needs to be created prior to this module.

## Guidance

#### Usage

#### Security Considerations

- TLS and SSL policy in greenfield denies CDN Front Door Route deployment. Custom domain is the only resource type amongst other Front Door modules that uses TLS/SSL. Hence custom domain is used as a dependent module for end to end testing.

#### Additional Information

- However, custom domain module can't be tested with Greenfield changes, as it only support the certificate signed by well known CA. This is because of this policy `Custom-Front Door domains must use a TLS certificate that is persisted in an HSM backed Key Vault-1.0.0` can use only `CustomerCertificate`.
- Due to this limitation, we are able to progress till terraform plan stage and full functionality of the product couldn't be tested in Greenfield.

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-AFD-SC_130  | Front Door caching must be a configured as a separate Route and must must not cache any data that is classified as Restricted or Highly Restricted | Front Door caching must be a configured as a separate Route and must must not cache any data that is classified as Restricted or Highly Restricted (What) within Front Door Manager, Add a route (How) in order to prevent the leakage of personal information (Why) | False  | False  | This Control would be implemented via LSEG Standard. |

## Changelog

- [azure-prdsvc-terraform-cdnfrontdoorroute](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/frontdoor/front-door-routing-architecture?pivots=front-door-standard-premium)

### Terraform Docs

- [azurerm_cdn_frontdoor_route](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cdn_frontdoor_route)

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
| [azurerm_cdn_frontdoor_route.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cdn_frontdoor_route) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_cache"></a> [cache](#input_cache) | object({<br/>  query_string_caching_behavior = "(Optional) Defines how the Front Door Route will cache requests that include query strings. Possible values include IgnoreQueryString, IgnoreSpecifiedQueryStrings, IncludeSpecifiedQueryStrings or UseQueryString. Defaults it IgnoreQueryString."<br/>  query_strings                 = "(Optional) Query strings to include or ignore."<br/>  compression_enabled           = "(Optional) Is content compression enabled? Possible values are true or false. Defaults to false."<br/>  compression_enabled           = "(Optional) A list of one or more Content types (formerly known as MIME types) to compress. Possible values include application/eot, application/font, application/font-sfnt, application/javascript, application/json, application/opentype, application/otf, application/pkcs7-mime, application/truetype, application/ttf, application/vnd.ms-fontobject, application/xhtml+xml, application/xml, application/xml+rss, application/x-font-opentype, application/x-font-truetype, application/x-font-ttf, application/x-httpd-cgi, application/x-mpegurl, application/x-opentype, application/x-otf, application/x-perl, application/x-ttf, application/x-javascript, font/eot, font/ttf, font/otf, font/opentype, image/svg+xml, text/css, text/csv, text/html, text/javascript, text/js, text/plain, text/richtext, text/tab-separated-values, text/xml, text/x-script, text/x-component or text/x-java-source."<br/>}) | <pre>object({<br/>    query_string_caching_behavior = optional(string, "IgnoreQueryString")<br/>    query_strings                 = optional(list(string))<br/>    compression_enabled           = optional(bool, false)<br/>    content_types_to_compress     = optional(list(string))<br/>  })</pre> | `null` | no |
| <a name="input_cdn_frontdoor_custom_domain_ids"></a> [cdn_frontdoor_custom_domain_ids](#input_cdn_frontdoor_custom_domain_ids) | (Optional) The IDs of the Front Door Custom Domains which are associated with this Front Door Route. | `list(string)` | `[]` | no |
| <a name="input_cdn_frontdoor_endpoint_id"></a> [cdn_frontdoor_endpoint_id](#input_cdn_frontdoor_endpoint_id) | (Required) The resource ID of the Front Door Endpoint where this Front Door Route should exist. Changing this forces a new Front Door Route to be created. | `string` | n/a | yes |
| <a name="input_cdn_frontdoor_origin_group_id"></a> [cdn_frontdoor_origin_group_id](#input_cdn_frontdoor_origin_group_id) | (Required) The resource ID of the Front Door Origin Group where this Front Door Route should be created. | `string` | n/a | yes |
| <a name="input_cdn_frontdoor_origin_ids"></a> [cdn_frontdoor_origin_ids](#input_cdn_frontdoor_origin_ids) | (Required) One or more Front Door Origin resource IDs that this Front Door Route will link to. | `list(string)` | n/a | yes |
| <a name="input_cdn_frontdoor_origin_path"></a> [cdn_frontdoor_origin_path](#input_cdn_frontdoor_origin_path) | (Optional) A directory path on the Front Door Origin that can be used to retrieve content (e.g. contoso.cloudapp.net/originpath). | `string` | `null` | no |
| <a name="input_cdn_frontdoor_rule_set_ids"></a> [cdn_frontdoor_rule_set_ids](#input_cdn_frontdoor_rule_set_ids) | (Optional) A list of the Front Door Rule Set IDs which should be assigned to this Front Door Route. | `list(string)` | `[]` | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_enabled"></a> [enabled](#input_enabled) | (Optional) Is this Front Door Route enabled? Possible values are true or false. Defaults to true. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_forwarding_protocol"></a> [forwarding_protocol](#input_forwarding_protocol) | (Optional) The Protocol that will be use when forwarding traffic to backends. Possible values are HttpOnly, HttpsOnly or MatchRequest. | `string` | `"HttpsOnly"` | no |
| <a name="input_https_redirect_enabled"></a> [https_redirect_enabled](#input_https_redirect_enabled) | (Optional) Automatically redirect HTTP traffic to HTTPS traffic? Possible values are true or false. Defaults to true. | `bool` | `true` | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_link_to_default_domain"></a> [link_to_default_domain](#input_link_to_default_domain) | (Optional) Should this Front Door Route be linked to the default endpoint? Possible values include true or false. Defaults to true. | `bool` | `true` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_patterns_to_match"></a> [patterns_to_match](#input_patterns_to_match) | (Required) The route patterns of the rule. | `list(string)` | n/a | yes |
| <a name="input_supported_protocols"></a> [supported_protocols](#input_supported_protocols) | (Optional) One or more Protocols supported by this Front Door Route. Possible values are Http or Https. | `list(string)` | <pre>[<br/>  "Http",<br/>  "Https"<br/>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The ID of the created CDN Front Door Route. |
| <a name="output_name"></a> [name](#output_name) | The name of the created CDN Front Door Route. |
| <a name="output_resource"></a> [resource](#output_resource) | The Cdn Frontdoor Route resource. |
<!-- END_TF_DOCS -->
