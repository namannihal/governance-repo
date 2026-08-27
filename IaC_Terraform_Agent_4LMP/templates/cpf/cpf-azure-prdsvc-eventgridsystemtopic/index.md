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
# Event Grid System Topic module

## Overview

This terraform module creates a Event Grid System Topic and associated resources.

## Prerequisites

- `Resource Group` module as needed if not existing.

## Guidance

#### Usage

- A system topic in Event Grid represents one or more events published by Azure services such as Azure Storage and Azure Event Hubs.
- The topic type is validated by Azure and there may be additional topic types beyond the following: `Microsoft.AppConfiguration.ConfigurationStores, Microsoft.Communication.CommunicationServices, Microsoft.ContainerRegistry.Registries, Microsoft.Devices.IoTHubs, Microsoft.EventGrid.Domains, Microsoft.EventGrid.Topics, Microsoft.Eventhub.Namespaces, Microsoft.KeyVault.vaults, Microsoft.MachineLearningServices.Workspaces, Microsoft.Maps.Accounts, Microsoft.Media.MediaServices, Microsoft.Resources.ResourceGroups, Microsoft.Resources.Subscriptions, Microsoft.ServiceBus.Namespaces, Microsoft.SignalRService.SignalR, Microsoft.Storage.StorageAccounts, Microsoft.Web.ServerFarms and Microsoft.Web.Sites.`
- Some topic_types (e.g. Microsoft.Resources.Subscriptions) requires location to be set to Global instead of a real location like Uk South.
- We can use Azure CLI to get a full list of the available topic types: `az eventgrid topic-type list --output json | grep -w id`

#### Security Considerations

#### Additional Information

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-EGST-IA_010 | Use a Managed Identity for accessing Azure Resources | Event Grid System Topics must enforce the use of a Managed Identity to authenticate to Azure resources where this is supported (What) within targets IAM settings (How) in order to remove the need to store credentials (Why) | True | True | Enforced using the `identity` block. |
| 2. | AZU-EGST-AU_010 | Send all diagnostic log categories to a central SOC Log Analytics workspace | Event Grid System Topics must send all diagnostic logs to a central SOC Log Analytics workspace (What) within namespace Diagnostic settings (How) in order to support a security investigation after a security incident (Why) | False | False | To be implemented via policy. |
| 3. | AZU-EGST-AU_020 | Send all diagnostic log categories to a central SOC Storage Account | Event Grid System Topics must send all diagnostic logs to a central SOC Storage Account (What) within namespace Diagnostic settings (How) In order to provide an immutable copy to adhere to compliance requirements (Why) | False | False | To be implemented via policy. |
| 4. | AZU-EGST-AU_030 | Sending diagnostic logs to a partner solution requires CyberSecurity risk assessment and approval | SSending diagnostic logs to a partner solution requires CyberSecurity risk assessment and approval (What) within Diagnostic settings (How) in order to prevent sensitive data leakage to third parties outside of LSEG control (Why) | False | False | To be enforced using the approval process required for CyberSecurity risk assessment. |
| 5. | AZU-EGST-SC_010 | Event Grid System Topic Event Subscriptions must only connect to Event Grid System Topics that belong to the LSEG tenant | Event Grid System Topic Event Subscriptions must only connect to Event Grid System Topics that belong to the LSEG tenant (What) within the Event subscription settings (How) to reduce the risk of data exfiltration and unauthorised system access (Why) | False | False | Control cannot be implemented by technical configuration. |
| 6. | AZU-EGST-SC_020 | Event Grid System Topic Event Subscriptions must only connect to Event Grid System Topics that belong to the same environment | Event Grid System Topic Event Subscriptions must only connect to Event Grid System Topics that belong to the same environment (e.g. prod <-> prod, dev <-> dev) (What) within the Subscription settings (How) to reduce the risk of data exfiltration and unauthorised system access (Why) | False | False | Control cannot be implemented by technical configuration. |
| 7. | AZU-EGST-SC_030 | Headers containing secrets must have the secret flag enabled | Headers containing secrets must have the secret flag enabled (What) in Delivery properties (How) to prevent secrets being visible in the Azure portal (Why) | False | False | Control cannot be implemented by technical configuration. |

## SMCF Controls

| S. No.  | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|---------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SSMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types.<br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc.<br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC<br><br>Documentation | True | This control will be implemented using resource naming module.<br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames) |
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC<br><br>Policy | True | This control will be implemented using `tags` parameter.<br><br>This control will be implemented using Policy which inherits all the mandatory tags. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties.<br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration. | Policies<br><br>Iac<br><br>Policies<br><br>Iac | True | This control will be implemented by having all the `Mandate` and most of the `Optional ` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring) | SMCF-OPS-03-02: Define and automate resource operation and security log collection<br><br>SMCF-OPS-03-03: Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs) | Policy<br><br>Documentation<br><br>Documentation | True | This control will be implemented by `DINE` Policy.<br><br>[Monitor Azure App Service Plan](https://learn.microsoft.com/en-us/azure/app-service/web-sites-monitor#understand-metrics)<br><br>[Stream diagnostic logs](https://learn.microsoft.com/en-us/azure/app-service/troubleshoot-diagnostic-logs#overview)<br><br><br><br>[Cloud monitoring service level objectives](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/monitor/service-level-objectives)<br><br>[Supported Metrics for App Service Plan](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-web-serverfarms-metrics)
| 5. | [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC<br><br>Documentation | False | Event Grid resource definitions for topics, system topics, domains, and event subscriptions and event data are automatically replicated across three availability zones (when available) in the region. When there's a failure in one of the availability zones, Event Grid resources automatically failover to another availability zone without any human intervention. Currently, it isn't possible for you to control (enable or disable) this feature. When an existing region starts supporting availability zones, existing Event Grid resources would be automatically failed over to take advantage of this feature. No customer action is required.<br><br>[In-region recovery using availability zones and geo-disaster recovery across regions (Azure Event Grid)](https://learn.microsoft.com/en-us/azure/event-grid/availability-zones-disaster-recovery)
| 6. | [SMCF-OPS-07: Resource Protection](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-07-01: Prevent accidental or malicious deletion of production resources<br><br>SMCF-OPS-07-02: Prevent accidental misconfiguration of key production resources | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard based on application team requirement. <br><br>[Lock your resources to protect your infrastructure](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json) |
| 7. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package and has a JIT implementation in place.<br><br>[Azure built-in roles](https://docs.microsoft.com/en-us/azure/role-based-access-control/built-in-roles)<br><br>[Authenticate event delivery to event handlers (Azure Event Grid)](https://learn.microsoft.com/en-us/azure/event-grid/security-authentication)

## Changelog

- [azure-prdsvc-terraform-eventgridsystemtopic](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/event-grid/system-topics)

### Terraform Docs

- [azurerm_eventgrid_system_topic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventgrid_system_topic)

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
| [azurerm_eventgrid_system_topic.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventgrid_system_topic) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_identity"></a> [identity](#input_identity) | (Optional) An identity block supports the following:<br/>object({<br/>  type         = "(Required) Specifies the type of Managed Service Identity that should be configured on this Event Grid System Topic."<br/>  identity_ids = "(Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Event Grid System Topic."<br/>}) | <pre>object({<br/>    type         = string<br/>    identity_ids = list(string)<br/>  })</pre> | <pre>{<br/>  "identity_ids": null,<br/>  "type": "UserAssigned"<br/>}</pre> | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_system_topic_var"></a> [system_topic_var](#input_system_topic_var) | (Optional) A system_topic_var block supports the following:<br/>source_arm_resource_id = "(Required) The ID of the Event Grid System Topic ARM Source. Changing this forces a new Event Grid System Topic to be created."<br/>topic_type             = "(Required) The Topic Type of the Event Grid System Topic. The topic type is validated by Azure and there may be additional topic types beyond the following: Microsoft.AppConfiguration.ConfigurationStores, Microsoft.Communication.CommunicationServices, Microsoft.ContainerRegistry.Registries, Microsoft.Devices.IoTHubs, Microsoft.EventGrid.Domains, Microsoft.EventGrid.Topics, Microsoft.Eventhub.Namespaces, Microsoft.KeyVault.vaults, Microsoft.MachineLearningServices.Workspaces, Microsoft.Maps.Accounts, Microsoft.Media.MediaServices, Microsoft.Resources.ResourceGroups, Microsoft.Resources.Subscriptions, Microsoft.ServiceBus.Namespaces, Microsoft.SignalRService.SignalR, Microsoft.Storage.StorageAccounts, Microsoft.Web.ServerFarms and Microsoft.Web.Sites. Changing this forces a new Event Grid System Topic to be created." | <pre>object({<br/>    source_arm_resource_id = string<br/>    topic_type             = string<br/>  })</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The ID of the Event Grid System Topic. |
| <a name="output_identity_details"></a> [identity_details](#output_identity_details) | The Identity Details of Event Grid System Topic associated with the Managed Service Identity |
| <a name="output_metric_arm_resource_id"></a> [metric_arm_resource_id](#output_metric_arm_resource_id) | The Metric ARM Resource ID of the Event Grid System Topic. |
| <a name="output_name"></a> [name](#output_name) | The name of the Event Grid System Topic. |
| <a name="output_resource"></a> [resource](#output_resource) | The Event Grid System Topic resource. |
<!-- END_TF_DOCS -->
