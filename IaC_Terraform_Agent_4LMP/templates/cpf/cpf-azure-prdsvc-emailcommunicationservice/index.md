---
version: 1.0.2
available_versions:
  - 1.0.2
  - 1.0.1
  - 1.0.0
  - 0.2.3
  - 0.2.2
---

<!-- BEGIN_TF_DOCS -->
# Azure Email Communication Service

## Overview

This terraform module creates a Azure email communication service.

## Prerequisites

- `Resource Group` name is required.

## Guidance

#### Usage

- This Module Covers deployment of Azure Email Communication Service.

#### Security Considerations

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. |  AZU-ECS-SC_010 | Email Communication Services must use an approved LSEG domain name | Email Communication Services must use an approved LSEG domain name (What) within Provision domains (How) in order to ensure brand integrity of LSEG emails (Why) | False | False | Control implemented by technical configuration setting: False |
| 2. |  AZU-ECS-SC_020 |  Email Communication Services must configure SPF |  Email Communication Services must have a custom SPF record configured and verified in DNS as a TXT type to authorise sending emails from an LSEG.com sub-domain (What) within Provisioning custom domains in DNS (How) in order to help prevent against email spoofing and protect domain reputation (Why) | False | False | Control implemented by technical configuration setting: False |
| 3. |  AZU-ECS-SC_030 | Email Communication Services must configure DKIM |  Email Communication Services must have a custom DKIM record configured and verified in DNS as a CNAME type to authorise sending emails from an LSEG.com sub-domain (What) within Provisioning custom domains in DNS (How) in order to help prevent against email spoofing and protect domain reputation (Why) | False | False | Control implemented by technical configuration setting: False |
| 4. |  AZU-ECS-SC_040 | Email Communication Services must configure DMARC | Email Communication Services must have a custom DMARC record configured and verified in DNS as a TXT type to protect LSEG.com sub-domain in terms of email being rejected (What) within Provisioning custom domains in DNS (How) in order to help prevent against email spoofing and protect domain reputation (Why) | False | False | Control implemented by technical configuration setting: False |

## SMCF Controls

| S. No.  | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|---------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types.<br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc.<br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC<br><br>Documentation | True | This control is implemented by generating names using the resource naming module.<br><br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames) |
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC<br><br>Policy | True | This control will be implemented using `tags` parameter.<br><br>This control is achieved by custom policy as described in the [clear listing page](https://dev.azure.com/LSEGroup/Foundation/_git/azu-plat-policy) from where it inherits all the mandatory tags. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties.<br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration. | Policies<br><br>Iac<br><br>Policies<br><br>Iac | True | This control will be implemented by having all the `Mandatory` and most of the `Optional` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC<br><br>Documentation | True | Azure Communication Services has integrated built-in failover mechanisms to ensure a high level of availability and redundancy for uninterrupted communication experiences. using the `data_location` variable all chat messages, and resource data stored by Communication Services at rest are retained in that geography, in a data center selected internally by Communication Services, endpoints are necessary to provide a high-performance, low-latency experience to end-users no matter their location<br><br>[High Availability For Azure Communication Service](https://learn.microsoft.com/en-us/azure/communication-services/concepts/privacy) |
| 5. | [SMCF-OPS-07: Resource Protection](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-07-01: Prevent accidental or malicious deletion of production resources<br><br>SMCF-OPS-07-02: Prevent accidental misconfiguration of key production resources | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard based on application teams' requirements.<br><br>[Lock your resources to protect your infrastructure](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json) |
| 6. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals | IaC<br><br>Documentation | False | The Azure platform provides role-based access (Azure RBAC) to control access to the resources. Azure RBAC security principal represents a user, group, service principal, or managed identity that is requesting access to Azure resources.<br><br>[Azure built-in roles](https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles)<br><br>[Azure Email Communication-Service-Authentication](https://learn.microsoft.com/en-us/azure/communication-services/concepts/identity-model) |

## Changelog

- [azure-prdsvc-terraform-emailcommunicationservice](../CHANGELOG.md)

## References

### Microsoft Docs

- [Official documentation](https://learn.microsoft.com/en-us/azure/communication-services/concepts/email/email-overview)

### Terraform Docs

- [azurerm_email_communication_service](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/email_communication_service)

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
| [azurerm_email_communication_service.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/email_communication_service) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_data_location"></a> [data_location](#input_data_location) | The location where the email communication service stores its data at rest. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The Resource ID of the Azure email communication service. |
| <a name="output_name"></a> [name](#output_name) | The Name of the Azure email communication service. |
| <a name="output_resource"></a> [resource](#output_resource) | The Azure email communication service resource. |
<!-- END_TF_DOCS -->
