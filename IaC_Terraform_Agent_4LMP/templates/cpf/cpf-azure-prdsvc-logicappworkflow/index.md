---
version: 1.0.2
available_versions:
  - 1.0.2
  - 1.0.1
  - 1.0.0
  - 0.2.4
  - 0.2.3
---

<!-- BEGIN_TF_DOCS -->
# Azure Logic App Workflow Module

## Overview

 - This terraform module creates a Azure Logic App Workflow.
 - Azure Logic Apps is a cloud platform used to automated workflows with little to no code.
 - Azure Logic Apps simplifies the way to connect legacy, modern, and cutting-edge systems across cloud, on premises, and hybrid environments and provides low-code-no-code tools, to develop highly scalable integration solutions for enterprise and business-to-business (B2B) scenarios.

## Prerequisites

- `Resource Group` name is required.

## Guidance

#### Usage

- The default values provided in the variable for  `allowed_caller_ip_address_range` are just dummy values for the testing purpose. Please use the correct values when using this code.

#### Security Considerations

## Security Controls

- Logic App Workflow does not have any [security controls] (https://gitlab.dx1.lseg.com/app/app-51285/cloud-security-controls/azure-clear-listing/-/tree/main/azure/services) available currently.

## SMCF Controls

| S. No.  | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|---------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types.<br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc.<br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC<br><br>Documentation | True | This control is implemented by generating names using the resource naming module.<br><br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames)<br><br>[Resource name rules](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/resource-name-rules#microsoftlogic) |
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC<br><br>Policy | True | This control will be implemented using `tags` parameter.<br><br>This control is achieved by custom policy as described in the [clear listing page](https://dev.azure.com/LSEGroup/Foundation/_git/azu-plat-policy) from where it inherits all the mandatory tags. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties.<br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration. | Policies<br><br>Iac<br><br>Policies<br><br>Iac | True | This control will be implemented by having all the `Mandatory` and most of the `Optional` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring) | SMCF-OPS-03-02: Define and automate resource operation and security log collection<br><br>SMCF-OPS-03-03: Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs) | Policy<br><br>Documentation<br><br>Documentation | True | This control will be implemented by `DINE` Policy.<br><br>[Monitor Azure Logic Apps](https://learn.microsoft.com/en-us/azure/logic-apps/monitor-logic-apps?tabs=consumption)<br><br>[Cloud monitoring service level objectives](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/monitor/service-level-objectives)<br><br>[Supported Metrics for Azure Logic Apps](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-logic-workflows-metrics) |
| 5. | [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC<br><br>Documentation | True | For high availability, geo-redundant storage (GRS) is enabled and For redundancy purposes, data is replicated in the paired region.<br><br>[High Availability For Logic App Workflow](https://learn.microsoft.com/en-us/azure/logic-apps/logic-apps-overview#create-and-deploy-to-different-environments) |
| 6. | [SMCF-OPS-07: Resource Protection](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-07-01: Prevent accidental or malicious deletion of production resources<br><br>SMCF-OPS-07-02: Prevent accidental misconfiguration of key production resources | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard based on application teams' requirements.<br><br>[Lock your resources to protect your infrastructure](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json) |
| 7. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package and has a JIT implementation in place.<br><br>[Azure Secure Access in Azure Logic Apps](https://learn.microsoft.com/en-us/azure/logic-apps/logic-apps-securing-a-logic-app?tabs=azure-portal#multi-user-authorization%5D(https://learn.microsoft.com/en-us/azure/logic-apps/authenticate-with-managed-identity?tabs=consumption)) |

## Changelog

- [azure-prdsvc-terraform-logicappworkflow](CHANGELOG.md)

## References

### Microsoft Docs

-[Official Documentation](https://learn.microsoft.com/en-us/azure/logic-apps/logic-apps-overview)

### Terraform Docs

-[azurerm_logic_app_workflow](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/logic_app_workflow)

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
| [azurerm_logic_app_workflow.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/logic_app_workflow) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_control"></a> [access_control](#input_access_control) | (Optional) A access_control block as defined below.<br/>    action = "(Optional) One or more management blocks as documented below."<br/>      allowed_caller_ip_address_range = "(Required) A list of the allowed caller IP address ranges."<br/>    content = "(Optional) One or more management blocks as documented below."<br/>      allowed_caller_ip_address_range = "(Required) A list of the allowed caller IP address ranges."<br/>    trigger = "(Optional) One or more management blocks as documented below."<br/>      allowed_caller_ip_address_range = "(Required) A list of the allowed caller IP address ranges."<br/>      open_authentication_policy = "(Optional) A open_authentication_policy block as defined below."<br/>        name = "(Required) The OAuth policy name for the Logic App Workflow."<br/>        claim = "(Required) A claim block as defined below."<br/>          name  = "(Required) The name of the OAuth policy claim for the Logic App Workflow."<br/>          value = "(Required) The value of the OAuth policy claim for the Logic App Workflow."<br/>    workflow_management = "(Optional) One or more management blocks as documented below."<br/>      allowed_caller_ip_address_range = "(Required) A list of the allowed caller IP address ranges." | <pre>object({<br/>    action = optional(object({<br/>      allowed_caller_ip_address_range = list(string)<br/>    }))<br/>    content = optional(object({<br/>      allowed_caller_ip_address_range = list(string)<br/>    }))<br/>    trigger = optional(object({<br/>      allowed_caller_ip_address_range = list(string)<br/>      open_authentication_policy = object({<br/>        name = string<br/>        claim = object({<br/>          name  = string<br/>          value = string<br/>        })<br/>      })<br/>    }))<br/>    workflow_management = optional(object({<br/>      allowed_caller_ip_address_range = list(string)<br/>    }))<br/>  })</pre> | <pre>{<br/>  "action": {<br/>    "allowed_caller_ip_address_range": null<br/>  },<br/>  "content": {<br/>    "allowed_caller_ip_address_range": null<br/>  },<br/>  "trigger": {<br/>    "allowed_caller_ip_address_range": null,<br/>    "open_authentication_policy": {<br/>      "claim": {<br/>        "name": null,<br/>        "value": null<br/>      },<br/>      "name": null<br/>    }<br/>  },<br/>  "workflow_management": {<br/>    "allowed_caller_ip_address_range": null<br/>  }<br/>}</pre> | no |
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_enabled"></a> [enabled](#input_enabled) | (Optional) Is the Logic App Workflow enabled. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_identity"></a> [identity](#input_identity) | (Optional) A Identity block as defined below.<br/>    type  = "(Required) Specifies the type of Managed Service Identity that should be configured on this Logic App Workflow."<br/>    identity_ids = "(Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Logic App Workflow." | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string))<br/>  })</pre> | <pre>{<br/>  "identity_ids": null,<br/>  "type": "SystemAssigned"<br/>}</pre> | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_integration_service_environment_id"></a> [integration_service_environment_id](#input_integration_service_environment_id) | (Optional) The ID of the Integration Service Environment to which this Logic App Workflow belongs. | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_logic_app_integration_account_id"></a> [logic_app_integration_account_id](#input_logic_app_integration_account_id) | (Optional) The ID of the integration account linked by this Logic App Workflow. | `string` | `null` | no |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_parameters"></a> [parameters](#input_parameters) | (Optional) A map of Key-Value pairs. | `map(string)` | `null` | no |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |
| <a name="input_workflow_parameters"></a> [workflow_parameters](#input_workflow_parameters) | (Optional) Specifies a map of Key-Value pairs of the Parameter Definitions to use for this Logic App Workflow. | `map(string)` | `null` | no |
| <a name="input_workflow_schema"></a> [workflow_schema](#input_workflow_schema) | (Optional) Specifies the Schema to use for this Logic App Workflow. | `string` | `null` | no |
| <a name="input_workflow_version"></a> [workflow_version](#input_workflow_version) | (Optional) Specifies the version of the Schema used for this Logic App Workflow. | `string` | `"1.0.0.0"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The Resource ID of the Azure Logic App Workflow. |
| <a name="output_name"></a> [name](#output_name) | The Name of the Azure Logic App Workflow. |
| <a name="output_resource"></a> [resource](#output_resource) | The Resource of the Azure Logic App Workflow. |
<!-- END_TF_DOCS -->
