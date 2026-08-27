---
version: 1.0.1
available_versions:
  - 1.0.1
  - 1.0.0
  - 0.3.7
  - 0.3.6
  - 0.3.5
---

<!-- BEGIN_TF_DOCS -->
# Front Door Origin module

## Overview

This terraform module creates a Front Door Origin and associated resources.
An origin refers to the application deployment that Azure Front Door retrieves contents from when caching isn't enabled or when a cache gets missed. Azure Front Door supports origins hosted in Azure and applications hosted in your on-premises datacenter or with another cloud provider.

## Prerequisites

- Network Security Group and 2 Subnets need to be created prior to this module.
- A load balancer associated with the 1st subnet needs to be created prior to this module.
- A private link service associated with the 2nd subnet needs to be created prior to this module.
- A CDN Front Door Profile needs to be created prior to this module.
- A CDN Front Door Origin Group needs to be created prior to this module.

## Guidance

#### Usage

- This module only creates Azure Front Door Origin within an Origin Group
- This module needs following resources
    - Azure Resource Group
    - Azure CDN Front Door Profile
    - Azure CDN Front Door Origin Group
- Points to remember when creating Origin that uses its own Private Link Service with a Load Balancer
  - Private Link requires that the Front Door Profile this Origin is hosted within is using the SKU `Premium_AzureFrontDoor` and that the `certificate_name_check_enabled` field is set to `true`
  - Private Link Endpoint must be approved manually - for more information and region availability please see the [product documentation](https://docs.microsoft.com/azure/frontdoor/private-link)
  - Origin support for direct private endpoint connectivity via Terraform is limited to `Storage (Azure Blobs)`, `Storage (Static Web Sites)`, `App Services`, `internal load balancers`, and `Azure API Management`. `Application Gateway` is supported via Azure Portal, PowerShell, and CLI only, but is not currently supported by Terraform or AzApi and will be revisited once Microsoft provides Terraform support. The Azure Front Door Private Link feature is region agnostic but for the best latency, you should always pick an Azure region closest to your origin when choosing to enable Azure Front Door Private Link endpoint.
  - To associate a Load Balancer with a Front Door Origin via Private Link you must stand up your own `azurerm_private_link_service` - and ensure that a `depends_on` exists to ensure it's destroyed before the azurerm_private_link_service resource, due to the design of the Front Door Service.
  - The `private_link_target_id` property must specify the Resource ID of the Private Link Service when using Load Balancer as an Origin.

#### Security Considerations

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-AFD-SC_100 | Certificate subject name must be validated against the origin | Certificate subject name must be validated against the origin (What) within Origin groups, Add, Add an origin (How) in order to validate the authenticity of the origin host name (Why) | True | True | Implemented by the setting the value of `certificate_name_check_enabled` argument to `true`. |
| 2. | AZU-AFD-SC_110 | Connections from Front Door to Origin must use Private Link where it is supported |  Connections from Front Door to Origin must use Private Link where it is supported (What) within Origin groups, Add, Add an origin (How) so that all network traffic is over the private Microsoft network (Why) | True | False | Implemented by the setting of `Private link` block. The Private Link is enforced in code, but there is no powershell command to check origin type value in Pester post-deployment test. |
| 3. | AZU-AFD-SC_160 | Front Door origins must be LSEG owned resources/applications/services | Front Door origins must be LSEG owned resources/applications/services (What) in the Deployment settings (How) to reduce the risk of data exfiltration (Why) | False | False | This control would be implemented by LSEG Standard. |
| 4. | AZU-AFD-SC_170 | Front Door origins must validate the X-Azure-FDID host header where possible | Front Door origins must validate the X-Azure-FDID host header where possible (What) in the Deployment settings (How) to ensure incoming requests are only accepted from the intended LSEG Front Door deployment (Why) | False | False | This control would be implemented by LSEG Standard. |

## Changelog

- [azure-prdsvc-terraform-cdnfrontdoororigin](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/frontdoor/origin?pivots=front-door-standard-premium#origin)

### Terraform Docs

- [azurerm_cdn_frontdoor_origin](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cdn_frontdoor_origin)

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
| [azurerm_cdn_frontdoor_origin.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cdn_frontdoor_origin) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_cdn_frontdoor_origin_group_id"></a> [cdn_frontdoor_origin_group_id](#input_cdn_frontdoor_origin_group_id) | (Required) The ID of the Front Door Origin Group within which this Front Door Origin should exist. Changing this forces a new Front Door Origin to be created. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_enabled"></a> [enabled](#input_enabled) | (Optional) Should the origin be enabled? Possible values are true or false. Defaults to true. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_host_name"></a> [host_name](#input_host_name) | (Required) The IPv4 address, IPv6 address or Domain name of the Origin. | `string` | n/a | yes |
| <a name="input_http_port"></a> [http_port](#input_http_port) | (Optional) The value of the HTTP port. Must be between 1 and 65535. Defaults to 80. | `number` | `80` | no |
| <a name="input_https_port"></a> [https_port](#input_https_port) | (Optional) The value of the HTTPS port. Must be between 1 and 65535. Defaults to 443. | `number` | `443` | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_origin_host_header"></a> [origin_host_header](#input_origin_host_header) | (Optional) The host header value (an IPv4 address, IPv6 address or Domain name) which is sent to the origin with each request. If unspecified the hostname from the request will be used. | `string` | `null` | no |
| <a name="input_priority"></a> [priority](#input_priority) | (Optional) Priority of origin in given origin group for load balancing. Higher priorities will not be used for load balancing if any lower priority origin is healthy. Must be between 1 and 5 (inclusive). Defaults to 1. | `number` | `1` | no |
| <a name="input_private_link"></a> [private_link](#input_private_link) | object({<br/>  request_message        = "(Optional) Specifies the request message that will be submitted to the private_link_target_id when requesting the private link endpoint connection. Values must be between 1 and 140 characters in length. Defaults to Access request for CDN FrontDoor Private Link Origin."<br/>  target_type            = "(Optional) Specifies the type of target for this Private Link Endpoint. Possible values are blob, blob_secondary, web and sites."<br/>  location               = "(Required) Specifies the location where the Private Link resource should exist. Changing this forces a new resource to be created."<br/>  private_link_target_id = "(Required) The ID of the Azure Resource to connect to via the Private Link."<br/>}) | <pre>object({<br/>    request_message        = optional(string, "Access request for CDN FrontDoor Private Link Origin")<br/>    target_type            = optional(string)<br/>    location               = string<br/>    private_link_target_id = string<br/>  })</pre> | `null` | no |
| <a name="input_weight"></a> [weight](#input_weight) | (Optional) The weight of the origin in a given origin group for load balancing. Must be between 1 and 1000. Defaults to 500. | `number` | `500` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The ID of the created CDN frontdoor Origin. |
| <a name="output_name"></a> [name](#output_name) | The Name of the created CDN frontdoor Origin. |
| <a name="output_resource"></a> [resource](#output_resource) | The Cdn Frontdoor Origin resource. |
<!-- END_TF_DOCS -->

