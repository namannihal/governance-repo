---
version: 1.0.2
available_versions:
  - 1.0.2
  - 1.0.1
  - 1.0.0
  - 0.2.2
  - 0.2.1
---

<!-- BEGIN_TF_DOCS -->
# Azure Communication Service module


## Overview

- Azure Communication Services offers multichannel communication APIs for adding voice, video, chat, text messaging/SMS, email, and more to all your applications.

## Prerequisites

- An Exisiting `resource_group`

## Guidance

#### Usage

- Azure communication service enable you to add voice and video calling to your browser or native apps using the Calling SDK.

#### Security Considerations

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-COMS-AU_010 | Send all diagnostic log categories to a central SOC Log Analytics workspace  | Communication Services must send all diagnostic logs to a central SOC Log Analytics workspace (What) within Diagnostic setting (How) in order to support a security investigation after a security incident (Why) | False | False | This Security Control will be implemented using Azure Policy |
| 2. | AZU-COMS-AU_020 | Send all diagnostic log categories to a central SOC Storage Account | Communication Services must send all diagnostic logs to a central SOC Storage Account (What) within Diagnostic setting (How) In order to provide an immutable copy to adhere to compliance requirements (Why) | False | False | This Security Control will be implemented using Azure Policy.|
| 3. | AZU-COMS-IA_020 |  Entra ID authentication only must be used | Entra ID authentication only must be used (What) within Communication Services SDK (How) in order to use modern robust and less prone to compromise authentication methods embedded within Azure Active Directory (Why) | False | False| Control implemented by technical configuration setting: False. |

## SMCF Controls

| S. No.  | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|---------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types.<br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc.<br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC<br><br>Documentation | True | This control is implemented by generating names using the resource naming module.<br><br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames) |
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC<br><br>Policy | True | This control will be implemented using `tags` parameter.<br><br>This control is achieved by custom policy as described in the [clear listing page](https://dev.azure.com/LSEGroup/Foundation/_git/azu-plat-policy) from where it inherits all the mandatory tags. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties.<br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration. | Policies<br><br>Iac<br><br>Policies<br><br>Iac | True | This control will be implemented by having all the `Mandatory` and most of the `Optional` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring) | SMCF-OPS-03-02: Define and automate resource operation and security log collection<br><br>SMCF-OPS-03-03: Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs) | Policy<br><br>Documentation<br><br>Documentation | True | This control will be implemented by `DINE` Policy.<br><br>[Monitor Azure Communication Service](https://learn.microsoft.com/en-us/azure/communication-services/concepts/analytics/enable-logging)<br><br>[Cloud monitoring service level objectives](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/monitor/service-level-objectives)<br><br>[Supported Metrics for Azure Communication Service](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-communication-communicationservices-metrics) |
| 5. | [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC<br><br>Documentation | True | Azure Communication Services has integrated built-in failover mechanisms to ensure a high level of availability and redundancy for uninterrupted communication experiences. using the `data_location` variable all chat messages, and resource data stored by Communication Services at rest are retained in that geography, in a data center selected internally by Communication Services, endpoints are necessary to provide a high-performance, low-latency experience to end-users no matter their location<br><br>[High Availability For Azure Communication Service](https://learn.microsoft.com/en-us/azure/communication-services/concepts/privacy) |
| 6. | [SMCF-OPS-07: Resource Protection](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-07-01: Prevent accidental or malicious deletion of production resources<br><br>SMCF-OPS-07-02: Prevent accidental misconfiguration of key production resources | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard based on application teams' requirements.<br><br>[Lock your resources to protect your infrastructure](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json) |
| 7. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals | IaC<br><br>Documentation | False | The Azure platform provides role-based access (Azure RBAC) to control access to the resources. Azure RBAC security principal represents a user, group, service principal, or managed identity that is requesting access to Azure resources.<br><br>[Azure built-in roles](https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles)<br><br>[Azure Communication-Service-Authentication](https://learn.microsoft.com/en-us/azure/communication-services/concepts/identity-model) |

## Changelog

- [azure-prdsvc-terraform-communicationservice](../CHANGELOG.md)

## References

### Microsoft Docs

- [Azure communicationservice](https://learn.microsoft.com/en-us/azure/communication-services/overview)

### Terraform Docs

- [azurerm_communication_service](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/communication_service)

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
| [azurerm_communication_service.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/communication_service) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-123456', for the purpose of naming resources only 6 number will be used. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_data_location"></a> [data_location](#input_data_location) | The location where the Communication service stores its data at rest. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The Resource ID of the Azure Communication service. |
| <a name="output_name"></a> [name](#output_name) | The Name of the Azure Communication service. |
| <a name="output_primary_connection_string"></a> [primary_connection_string](#output_primary_connection_string) | The primary connection string of the Communication Service. |
| <a name="output_primary_key"></a> [primary_key](#output_primary_key) | The primary key of the Communication Service. |
| <a name="output_resource"></a> [resource](#output_resource) | The Azure Communication service resource. |
| <a name="output_secondary_connection_string"></a> [secondary_connection_string](#output_secondary_connection_string) | The Secondary connection string of the Communication Service. |
| <a name="output_secondary_key"></a> [secondary_key](#output_secondary_key) | The primary key of the Communication Service. |
<!-- END_TF_DOCS -->
