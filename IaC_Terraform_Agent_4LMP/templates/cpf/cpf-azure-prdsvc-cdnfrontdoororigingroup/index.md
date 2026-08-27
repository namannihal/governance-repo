---
version: 1.0.1
available_versions:
  - 1.0.1
  - 1.0.0
  - 0.3.3
  - 0.3.2
  - 0.3.1
---

<!-- BEGIN_TF_DOCS -->
# Front Door Origin Group module

## Overview

This terraform module creates a Front Door Origin Group and associated resources.

## Prerequisites

- Azure CDN Front Door Profile needs to be created prior to this module.

## Guidance

#### Usage
- An origin group in Azure Front Door refers to a set of origins that receives similar traffic for their application. You can define the origin group as a logical grouping of your application instances across the world that receives the same traffic and responds with an expected behavior.
- This module only creates Azure Front Door Origin Group within an Azure Front Door Profile.
- Front Door Origins will be deployed using a separate module.

#### Security Considerations

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-AFD-SC_080  | Network connections to the Front Door control and data planes must use TLS encryption | Front Door must enforce network flow encryption in transit using TLS (What) within Origin groups, configure route (How) in order to use techniques to establish an encrypted data channel over untrusted networks (Why) | False | False | This control would be implemented by LSEG Standard. |

## Changelog

- [azure-prdsvc-terraform-cdnfrontdoororigingroup](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/frontdoor/origin?pivots=front-door-standard-premium#origin-group)

### Terraform Docs

- [azurerm_cdn_frontdoor_origin_group](https://registry.terraform.io/providers/hashicorp/azurerm/3.70.0/docs/resources/cdn_frontdoor_origin_group)

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
| [azurerm_cdn_frontdoor_origin_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cdn_frontdoor_origin_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_cdn_frontdoor_profile_id"></a> [cdn_frontdoor_profile_id](#input_cdn_frontdoor_profile_id) | (Required) The ID of the Front Door Profile within which this Front Door Origin Group should exist. Changing this forces a new Front Door Origin Group to be created. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_health_probe"></a> [health_probe](#input_health_probe) | object({<br/>  protocol            = "(Required) Specifies the protocol to use for health probe. Possible values are Http and Https."<br/>  interval_in_seconds = "(Required) Specifies the number of seconds between health probes. Possible values are between 5 and 31536000 seconds (inclusive)."<br/>  request_type        = "(Optional) Specifies the type of health probe request that is made. Possible values are GET and HEAD. Defaults to HEAD."<br/>  request_type        = "(Optional) Specifies the path relative to the origin that is used to determine the health of the origin. Defaults to /."<br/>}) | <pre>object({<br/>    protocol            = string<br/>    interval_in_seconds = number<br/>    request_type        = optional(string, "HEAD")<br/>    path                = optional(string, "/")<br/>  })</pre> | `null` | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_load_balancing"></a> [load_balancing](#input_load_balancing) | object({<br/>  additional_latency_in_milliseconds = "(Optional) Specifies the additional latency in milliseconds for probes to fall into the lowest latency bucket. Possible values are between 0 and 1000 milliseconds (inclusive). Defaults to 50."<br/>  sample_size                        = "(Optional) Specifies the number of samples to consider for load balancing decisions. Possible values are between 0 and 255 (inclusive). Defaults to 4."<br/>  successful_samples_required        = "(Optional) Specifies the number of samples within the sample period that must succeed. Possible values are between 0 and 255 (inclusive). Defaults to 3."<br/>}) | <pre>object({<br/>    additional_latency_in_milliseconds = optional(number, 50)<br/>    sample_size                        = optional(number, 4)<br/>    successful_samples_required        = optional(number, 3)<br/>  })</pre> | n/a | yes |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_restore_traffic_time_in_minutes"></a> [restore_traffic_time_in_minutes](#input_restore_traffic_time_in_minutes) | (Optional) Specifies the amount of time which should elapse before shifting traffic to another endpoint when a healthy endpoint becomes unhealthy or a new endpoint is added. Possible values are between 0 and 50 minutes (inclusive). Default is 10 minutes. | `number` | `10` | no |
| <a name="input_session_affinity_enabled"></a> [session_affinity_enabled](#input_session_affinity_enabled) | (Optional) Specifies whether session affinity should be enabled on this host. Defaults to true. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The ID of the created Origin Group. |
| <a name="output_name"></a> [name](#output_name) | The Name of the created Origin Group. |
| <a name="output_resource"></a> [resource](#output_resource) | The Cdn Frontdoor Origin Group resource. |
<!-- END_TF_DOCS -->
