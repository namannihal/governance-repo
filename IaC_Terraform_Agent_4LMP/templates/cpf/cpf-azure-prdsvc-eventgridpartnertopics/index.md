---
version: 0.1.3
available_versions:
  - 0.1.3
  - 0.1.2
  - 0.1.1
  - 0.1.0
---

<!-- BEGIN_TF_DOCS -->
# Event Grid Partner Topic module

## Overview

This terraform module creates a Event Grid Partner Configuration and its associate resources which is used to manage Event Grid Partner Topics

## Prerequisites
- `Resource Group` is required.
- Cyber exemption required on security control AZU-EGPT-SC_030 - Event Grid Partner Configuration must not be created without CyberSecurity approval

## Guidance

#### Usage
- This module supports the creation of Event Grid Partner Configuration using `azapi_resource`. Event Grid Partner Topic is not recommended to be created using terraform as Microsoft Graph API creates partner topic automatically. When user creates a Microsoft Graph API subscription to enable Graph API events to flow into a partner topic. The partner topic is automatically created in the resource group of the subscription which uses the event grid partner configuration created by module.
- Only Microsoft Graph API is authorized as a partner to create partner topics and partner destinations that allow the flow of events from the partner and to the partner (if supported), respectively
- Default expiration time for partners authorizations to create partner topics is 1 day as per Policy
- Sequence of steps
    - Get a Cyber exemption of security control AZU-EGPT-SC_030 to allow usage of Event Grid Partner Topic at subscription or RG level
    - Authorize partner to create a partner topic in a resource group within a day post provisioning. Authorizations are stored in partner configurations. The current module is used to create Event Grid Partner Configuration. Only Microsoft Graph API can be authorized as a partner. It is recommended to Set Variable authorizationExpirationTimeInUtc to Null for ARM to decide the exact time as ARM will not accept < 1 day or > 1 day due to policy. Rerunning the module will increment authorizationExpirationTimeInUtc by 1 day for the partner from the time terraform reran everytime.
    - Request partner to forward events from its service to your partner topic. Partner provisions a partner topic in the specified resource group of Azure subscription. To be done by user
    - Activate Partner Topic by raising SRE ticket
    - Subscribe to events by creating one or more event subscriptions for the partner topic. Use CPF module azure-prdsvc-terraform-eventgrideventsubscription
- There can be only one Event Grid PartnerConfiguration per resource group with name as default and location as Global and cannot be changed.

#### Security Considerations

#### Additional Information

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-EGPT-IA_010  |  Event Grid Partner Topic must use a Managed Identity for accessing Azure Resources | Event Grid Partner Topic must enforce the use of a Managed Identity to authenticate to Azure resources where this is supported (What) within target service access control settings (How) in order to remove the need to store credentials (Why)  | False  | False | Control cannot be set using technical configuration. Product only creates a partner configuration and partner topic will be implemented using LSEG standard  |
| 2. | AZU-EGPT-IA_020  |  Event Grid Partner Configuration must have a maximum partner authorisation of 1 day | Event Grid Partner Configuration must have a maximum partner authorisation of 1 day (What) within code deployment parameters (How) in order to create the minimum Just-in-time window for Partner Topic creation (Why)  | True  | True | Implemented by setting optional variable defaultMaximumExpirationTimeInDays with default as 1 |
| 3. | AZU-EGPT-IA_040  |  Event Grid Partner Configuration must only allow Microsoft Graph API partners authorisations | Event Grid Partner Configuration must only allow Microsoft Graph API partners authorisations (What) within Partner Authorizations (How) in order to restrict resource creation from LSEG approved partners (Why)  | True  | True | Implemented by setting optional list of object variable authorized_partners by giving variable partnerName as MicrosoftGraphAPI  |
| 4. | AZU-EGPT-SC_010  |  Event Grid Partner Topic Event Subscriptions must only connect to event handlers that belong to the LSEG tenant | Event Grid Partner Topics Event Subscriptions must only connect to event handlers that belong to the LSEG tenant (What) within Event Subscription settings (How) to reduce the risk of data exfiltration and unauthorised system access (Why)  | False  | False | Control cannot be set using technical configuration and will be implemented using LSEG standard  |
| 5. | AZU-EGPT-SC_020  |  Event Grid Partner Topic Event Subscriptions must only connect to event handlers that belong to the same environment | Event Grid Partner Topic Event Subscriptions must only connect to event handlers that belong to the same environment (e.g. prod <-> prod, dev <-> dev) (What) within Event Subscription settings (How) to reduce the risk of data exfiltration and unauthorised system access (Why)  | False  | False | Control cannot be set using technical configuration and will be implemented using LSEG standard  |
| 6. | AZU-EGPT-SC_030  |   Event Grid Partner Configuration must not be created without CyberSecurity approval | Event Grid Partner Configuration must not be created without CyberSecurity approval (What) within code deployment parameters (How) to prevent unapproved Partner Topics being created without appropriate risk assessment (Why)  | False  | False | Control will be implemented by policy  |

## Changelog

## References

### Microsoft Docs

### Terraform Docs

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.5.0 |
| <a name="requirement_azapi"></a> [azapi](#requirement_azapi) | >=1.9 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azapi"></a> [azapi](#provider_azapi) | >=1.9 |

## Resources

| Name | Type |
|------|------|
| [azapi_resource.eventgridpartnerconfiguration](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_authorized_partners"></a> [authorized_partners](#input_authorized_partners) | (Optional) The list of objects of authorized partners for the Event Grid Partner Configuration.Each partner must have a name, registration immutable ID, and authorization expiration time in UTC.<br/>partnerName                       = (Required) The name of the partner. Possible values are "MicrosoftGraphAPI", "Auth0", "SAP", "TribalGroup" or any other partner name.<br/>partnerRegistrationImmutableId    = (Required) The immutable ID of the partner registration. Possible values are "c02e0126-707c-436d-b6a1-175d2748fb58", "804a11ca-ce9b-4158-8e94-3c8dc7a072ec", "68e84d61-202a-4d5e-b028-f1afea4b41a6", "d5f29171-89f7-4280-b685-0db1d4c38b8d" or any other partner registration immutable ID.<br/>authorizationExpirationTimeInUtc  = (Optional) The expiration time of the partner's authorization in RFC 3339 format in UTC time zone, for example: "2025-12-31T23:59:59Z". Leave it to null for Azure to calculate the default expiration time based on the current time plus the default maximum expiration time in days. | <pre>list(object({<br/>    partnerName                      = string<br/>    partnerRegistrationImmutableId   = string<br/>    authorizationExpirationTimeInUtc = optional(string, null) # Optional, but if provided must be in RFC 3339 format<br/>  }))</pre> | <pre>[<br/>  {<br/>    "partnerName": "MicrosoftGraphAPI",<br/>    "partnerRegistrationImmutableId": "c02e0126-707c-436d-b6a1-175d2748fb58"<br/>  }<br/>]</pre> | no |
| <a name="input_defaultMaximumExpirationTimeInDays"></a> [defaultMaximumExpirationTimeInDays](#input_defaultMaximumExpirationTimeInDays) | (Optional) The default maximum expiration time in days for the Event Grid Partner Configuration. | `number` | `1` | no |
| <a name="input_resource_group_id"></a> [resource_group_id](#input_resource_group_id) | (Required) The resource ID of the Resource Group in which to create the resource. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_eventgrid_partnerconfiguration"></a> [eventgrid_partnerconfiguration](#output_eventgrid_partnerconfiguration) | The Event Grid Partner Configuration resource. |
| <a name="output_eventgrid_partnerconfiguration_id"></a> [eventgrid_partnerconfiguration_id](#output_eventgrid_partnerconfiguration_id) | The Resource ID of the Event Grid Partner Configuration. |
| <a name="output_eventgrid_partnerconfiguration_name"></a> [eventgrid_partnerconfiguration_name](#output_eventgrid_partnerconfiguration_name) | The Name of the Event Grid Partner Configuration. |
<!-- END_TF_DOCS -->
