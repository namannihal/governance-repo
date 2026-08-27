---
version: 1.0.2
available_versions:
  - 1.0.2
  - 1.0.1
  - 1.0.0
  - 0.3.2
  - 0.3.1
---

<!-- BEGIN_TF_DOCS -->
# Event Hub module

## Overview

This terraform module creates an event hub and associated resources.

## Prerequisites

- `Resource Group` and `Virtual Network`  (to be called if not existing).
-`Subnet` to be used by the Private endpoints.
- `Network Security Group` to be associated with the Subnet.
- `Route Table` to be associated with the Subnet.
- `Keyvault` id for private connection resource id.
- `Privateendpoint` module to create a private connection to the Keyvault and Eventhubnamespace.
- `Eventnamespace` module for creation of Event Hub.
- Optional modules and resources:
  - `time_sleep` resource block to wait for the Privatendpoint connection with Keyvault and Eventhub Namespace.

## Guidance

#### Usage

- This module creates and manage an Event Hub in an exiting Event Hub namespace.
- The module also supports the creation of Event Hub Authorization rules and Consumer Groups. You can create multiple Authorization Rules and Consumer Groups in a Event Hub using this module.

#### Security Considerations

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. |  |  |  |  |  |  |

- This Event Hub Module does not have any [security controls](https://gitlab.dx1.lseg.com/app/app-51285/cloud-security-controls/azure-clear-listing/-/blob/main/azure/services/Microsoft.Eventhubs/v1.0.0/markdown/serviceControls.md) that can be implemented. All controls have been implemented and documented in [Event Hub Namespace](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-eventhubnamespace/-/tree/main). If any new security controls are identified in this product a new version will be added.

## SMCF Controls

| S. No.  | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|---------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types.<br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc.<br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC<br><br>Documentation | True | This control will be implemented using resource naming module.<br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames) |
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC<br><br>Policy | True | This control will be implemented using `tags` parameter.<br><br>This control is achieved by custom policy as described in the [clear listing page](https://dev.azure.com/LSEGroup/Foundation/_git/azu-plat-policy) from where it inherits all the mandatory tags. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties.<br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration. | Policies<br><br>Iac<br><br>Policies<br><br>Iac | True | This control will be implemented by having all the `Mandate` and most of the `Optional ` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring) | SMCF-OPS-03-02: Define and automate resource operation and security log collection<br><br>SMCF-OPS-03-03: Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs) | Policy<br><br>Documentation<br><br>Documentation | True | This control will be implemented by `DINE` Policy.<br><br>[Monitor your Event Hubs](https://learn.microsoft.com/en-us/azure/event-hubs/monitor-event-hubs?tabs=AzureDiagnostics%2CAzureDiagnosticsforRuntimeAudit%2CAzureDiagnosticsforAppMetrics)<br><br>[Cloud monitoring service level objectives ](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/monitor/service-level-objectives)<br><br>[Supported Metrics for Azure Event Hubs](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-eventhub-namespaces-metrics) |
| 5.| [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC<br><br>Documentation | True | The Event Hubs Geo-disaster recovery feature is designed to make it easier to recover from a disaster of this magnitude and abandon a failed Azure region.<br><br>[Disaster recovery and high availability for Event Hubs](https://learn.microsoft.com/en-us/azure/event-hubs/event-hubs-geo-dr?tabs=portal) |
| 6. | [SMCF-OPS-07: Resource Protection](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-07-01: Prevent accidental or malicious deletion of production resources<br><br>SMCF-OPS-07-02: Prevent accidental misconfiguration of key production resources | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard based on application team requirement. <br><br>[Lock your resources to protect your infrastructure](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json) |
| 7. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package and has a JIT implementation in place.<br><br>[Authorize access to Event Hubs resources using Microsoft Entra ID](https://learn.microsoft.com/en-us/azure/event-hubs/authorize-access-azure-active-directory) |

## Changelog

- [azure-prdsvc-terraform-eventhub](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/event-hubs/event-hubs-about)

### Terraform Docs

- [azurerm_eventhub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub)

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
| [azurerm_eventhub.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub) | resource |
| [azurerm_eventhub_authorization_rule.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_authorization_rule) | resource |
| [azurerm_eventhub_consumer_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_consumer_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_authorization_rules"></a> [authorization_rules](#input_authorization_rules) | (Optional) An Event Hub Namespace Authorization Rules configuation as defined below..<br/>object({<br/>  name   = "(Required) Specifies the name of the Authorization Rule."<br/>  listen = "(Optional) Grants listen access to this this Authorization Rule."<br/>  send   = "(Optional) Grants send access to this this Authorization Rule."<br/>  manage = "(Optional) Grants manage access to this this Authorization Rule. When this property is true - both listen and send must be too."<br/>}) | <pre>map(object({<br/>    name   = string<br/>    listen = optional(bool, false)<br/>    send   = optional(bool, false)<br/>    manage = optional(bool, false)<br/>  }))</pre> | `null` | no |
| <a name="input_capture_description"></a> [capture_description](#input_capture_description) | (Optional) A capture_description block as defined below.<br/>object({<br/>  enabled             = "(Required) Specifies if the Capture Description is Enabled."<br/>  encoding            = "(Required) Specifies the Encoding used for the Capture Description. Possible values are `Avro` and `AvroDeflate`."<br/>  interval_in_seconds = "(Optional) Specifies the time interval in seconds at which the capture will happen. Values can be between 60 and 900 seconds."<br/>  size_limit_in_bytes = "(Optional) Specifies the amount of data built up in your EventHub before a Capture Operation occurs. Value should be between 10485760 and 524288000 bytes."<br/>  skip_empty_archives = "(Optional) Specifies if empty files should not be emitted if no events occur during the Capture time window."<br/>  destination = (Required) A destination block as defined below.<br/>  object({<br/>    name                = "(Required) The Name of the Destination where the capture should take place. At this time the only supported value is `EventHubArchive.AzureBlockBlob`."<br/>    archive_name_format = "(Required) The Blob naming convention for archiving. e.g. {Namespace}/{EventHub}/{PartitionId}/{Year}/{Month}/{Day}/{Hour}/{Minute}/{Second}."<br/>    blob_container_name = "(Required) The name of the Container within the Blob Storage Account where messages should be archived."<br/>    storage_account_id  = "(Required) The ID of the Blob Storage Account where messages should be archived."<br/>  })<br/>}) | <pre>object({<br/>    enabled             = bool<br/>    encoding            = string<br/>    interval_in_seconds = optional(number, 300)<br/>    size_limit_in_bytes = optional(number, 314572800)<br/>    skip_empty_archives = optional(bool, false)<br/>    destination = object({<br/>      name                = string<br/>      archive_name_format = string<br/>      blob_container_name = string<br/>      storage_account_id  = string<br/>    })<br/>  })</pre> | `null` | no |
| <a name="input_consumer_groups"></a> [consumer_groups](#input_consumer_groups) | (Optional) An Event Hub Consumer Group objects as defined below..<br/>object({<br/>  name          = "(Required) Specifies the name of the EventHub Consumer Group resource."<br/>  user_metadata = "(Optional) Specifies the user metadata."<br/>}) | <pre>map(object({<br/>    name          = string<br/>    user_metadata = optional(string, null)<br/>  }))</pre> | `null` | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_eventhub_name"></a> [eventhub_name](#input_eventhub_name) | (Optional) Specifies the custom name of the EventHub. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_eventhub_namespace_name"></a> [eventhub_namespace_name](#input_eventhub_namespace_name) | (Required) Specifies the name of the EventHub Namespace. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_message_retention"></a> [message_retention](#input_message_retention) | (Required) Specifies the number of days to retain the events for this Event Hub. | `number` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_partition_count"></a> [partition_count](#input_partition_count) | (Required) Specifies the current number of shards on the Event Hub. Changing this will force-recreate the resource. | `number` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_status"></a> [status](#input_status) | (Optional) Specifies the status of the Event Hub resource. Possible values are `Active`, `Disabled` and `SendDisabled`. | `string` | `"Active"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_consumer_group_ids"></a> [consumer_group_ids](#output_consumer_group_ids) | The IDs of the Event Hub consumer groups. |
| <a name="output_consumer_group_names"></a> [consumer_group_names](#output_consumer_group_names) | The names of the Event Hub consumer groups. |
| <a name="output_id"></a> [id](#output_id) | The ID of the created Event Hub. |
| <a name="output_name"></a> [name](#output_name) | The name of the created Event Hub. |
| <a name="output_resource"></a> [resource](#output_resource) | The Event Hub resource. |
<!-- END_TF_DOCS -->
