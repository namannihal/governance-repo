---
version: 1.0.3
available_versions:
  - 1.0.3
  - 1.0.2
  - 1.0.1
  - 1.0.0
  - 0.10.0
---

<!-- BEGIN_TF_DOCS -->
# Stream Analytics Job module


## Overview

This terraform module creates a stream analytics job and associated resources.

## Prerequisites

- An existing `Resource Group`, `Eventhub Namespace`, `Storage Account`, `Key Vault and associated Private Endpoint`.

## Guidance

#### Usage

###### AzureRM 3.x to 4.x Upgrade Notes for Stream Analytics Job

Product Impact -- Low

- The `data_locale` property now defaults to `en-US`

- Wiki link for [AzureRM 4.x Upgrade](https://gitlab.dx1.lseg.com/groups/app/app-51310/azure/prdsvc/terraform/-/wikis/Terraform-AzureRM-Provider-Upgrade:-Version-3.x-to-4.x/streamanalyticsjob) for details on the upgrade process.

For more details, refer to the official [AzureRM 4.x Upgrade Guide](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/4.0-upgrade-guide)

#### Others

- The current module supports input as EventHub and output as EventHub, MSSQL having cluster with managed private endpoint configured.

- Stream Analytics jobs
  - The type of the Stream Analytics Job. Possible values are `Cloud` and `Edge`. Defaults to `Cloud`.
  - `Edge` doesn't support `stream_analytics_cluster_id` and `streaming_units`.
  - `streaming_units` must be set when type is `Cloud`.

- Stream Analytics job schedule
  - Setting start_mode to `LastOutputEventTime` is only possible if the job had been previously started and produced output.

- Stream Analytics input eventhub
  - In '`serialization`' block `encoding` is required when type is set to `CSV` or `JSON`.
  - In '`serialization`' block `field_delimiter` is required when type is set to `CSV`.

- Stream Analytics output eventhub
  - In '`serialization`' block `encoding` is required when type is set to CSV or `JSON`.
  - In '`serialization`' block `field_delimiter` is required when type is set to `CSV`.
  - In '`serialization`' block `format` is required and can only be specified when type is set to `JSON`.

#### Security Considerations

- In order to enable `job storage settings` in `stream analytics job`, need to use`storage account` module with privatendpoint enable.
- `Stream analytics cluster` supports `managed private endpoint` with target resource as `eventhub` and `storage account` as part of this module.
- Please make sure that the `approval` for `managed private endpoint` has to be provide `manually` from portal.
- Post `Manual Approval` only, stream analytics job will run successfully and even input and output will be able to establish connection with the Stream Analytics Job.

#### Additional Information

- To `store` the `data snapshot` of `stream analytics job` in `storage account` it requires `private connectivity` betwee `storage account` and `stream analytics job` which is currently not available and it's in `preview`.
- To `send` the `data snapshot` of `stream analytics` to `storage account`, need `stream analytic cluster` with `managed private endpoint` enable which will allow stream anayltics job to send the data to storage account privately.
- After approving the managed endpoint from portal we need to add the same storage account in stream analytic job storage account.
- This module is having all the required attributes to create job storage account in stream analytics job however it's not visible on the portal as it requires storage account with private endpoint enable.
- Added pester test case `Stream Analytics must use a Storage Account for data relating to jobs` post using azapi resource block, as azurerm provider was having issues.
- Testing Notes
  - However the testing of storing data snapshot of stream analytics job in storage account is not possible without sending the data.
- This module currently supports the `azurerm version range of "~>3.40" to "<=3.97.1" versions` dated 29th April, 2024, due to limitation from Hashicorp. There are issues in Stream Analytics Cluster deployment with ">v3.97.1" azurerm versions and it has been reported to Hashicorp team.
- Added `job_storage_account_azapi` variable to accept values based on requirement and create `job_storage_account`. Please make sure to set value `enable_job_storage_account` as True/False based on requirement in order to create Job Storage Account or not, respectively.
- We have not added `job_storage_account` argument in `azurerm_stream_analytics_job` resource block as `authenticationMode` feature in `job_storage_account` argument accepts only `ConnectionString` and `not Msi`, hence to overcome this limitation, we have used used `azapi_resource_action` resource block in main.tf file.
- Due to the above change, `job_storage_account` will always change to `null` post first run as expected and the below code shows changes displayed as per tf plan stage.

```
      - job_storage_account {
          - account_name        = "a1a51310devstpvsajuks028" -> null
          - authentication_mode = "Msi" -> null
        }
```

- Added `Storage Blob Data Contributor` role assignment for Stream Analytics Job Managed Identity scoped over Storage Account and Container for Storage account authentication and hence configuration of job_storage_account.
- If `identity.type` is `"SystemAssigned"` then please make sure to add `Storage Blob Data Contributor` role to azurerm_stream_analytics_job.this.identity[0].principal_id seperately as it cannot be handled via code due to cyclic dependency. Hence, `identity.type` used in test file is `"UserAssigned"`.

**IMPORTANT NOTES**

- This module earlier supported the `azurerm version range of "~>3.40" to "<=3.97.1" versions` dated 29th April, 2024, due to limitation from Hashicorp. There were issues in Stream Analytics Cluster deployment with ">v3.97.1" azurerm versions and it was reported to Hashicorp team and has been fixed now, validated with testing with latest azurerm provider.
- `Stream Analytics Job` usually runs with triggering of `Stream Analytics Job Schedule` repo, however in our testing, we noticed `Stream Analytics Job` run requires managed endpoint approval prior to triggering of `Stream Analytics Job Schedule` repo as shared in Table below. Though, even this behaviour is not consistent and showing intermittent issues. Hence, please try both the approaches, we will make sure to update the readme file as soon as we receive the concrete information from Product PG Team.
- Please make sure to `STOP` the `Stream Analytics Job` using `Stream Analytics Job Schedule` repo if any input/output or any feature to be updated/added over existing job as changes/addition cannot be done while Stream Analytics Job is in running state.

- Usage Flow

| S. No.  | Description | Execution | Repo Reference |
|---------|-------------|-----------|----------------|
| 1. | Create Stream Analytics Cluster along with Eventhub Namespace with managed private endpoint enabled for Eventhub Namespace | Terraform | `Stream Analytics Cluster` Repo |
| 2. | Create Stream Analytics Job along with above created cluster having managed private endpoint | Terraform | Existing Repo |
| 3. | Use existing Eventhub Namespace to create Event Hubs along with Consumer Group to be used for Input and Output | Terraform | Existing Repo |
| 4. | Assign Event Hub Data roles on existing Event Hubs IAM for Stream Analytics Job Managed Identity | Terraform | Existing Repo |
| 5. | Configure Stream Analytics Job with input and output with above created Eventhubs | Terraform | Existing Repo |
| 6. | Approve the managed private endpoint for Eventhub Namespace | Manual | Manual Task |
| 7. | Start the Stream Analytics Job Schedule | Terraform | `Stream Analytics Job Schedule` Repo |

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-STRM-IA_010 | Use a Managed Identity for accessing Azure Resources | Stream Analytics must enforce the use of a Managed Identity to authenticate to Azure resources where this is supported (What) within Input/Output settings (How) in order to remove the need to store credentials (Why) | True| True | Control will be implemented by assigning the default value for `identity` type. |
| 2. | AZU-STRM-AU_010 | Send all diagnostic log categories to a central SOC Log Analytics workspace | Stream Analytics must send all diagnostic logs to a central SOC Log Analytics workspace (What) Auditing settings (How) in order to support a security investigation after a security incident (Why) | False | False | Control will be implemented using Azure Policy. |
| 3. | AZU-STRM-AU_030 | Sending diagnostic logs to a partner solution requires CyberSecurity risk assessment and approval | Sending diagnostic logs to a partner solution requires CyberSecurity risk assessment and approval (What) within Diagnostic settings (How) in order to prevent sensitive data leakage to third parties outside of LSEG control (Why) | False | False | Control will be implemented using Azure Policy. |
| 4. | AZU-STRM-SC_010 | Stream Analytics must use a Storage Account for data relating to jobs | Stream Analytics must use a Storage Account for data relating to jobs (What) in the Storage Account settings (How) in order to securely store and encrypt with a CMK data pertaining to the Stream Analytics job (Why) | True | False | Control will be implemented by setting `job_storage_account` block as mandatory. Please refer the testing notes to understand why the Pester test is not currently implemented. |
| 5. | AZU-STRM-SC_020 | Stream Analytics must not be used to move or copy data to a location outside the classification ceiling | Stream Analytics must not be used to move or copy data to a target that is not within the data classification ceiling (What) within the Functions/Inputs/Outputs settings (How) to ensure data is kept within locations that have been approved for such classification and to reduce the risk of data exfiltration (Why) | False | False | Control implemented by technical configuration setting: False |
| 6. | AZU-STRM-SC_030 | Stream Analytics Functions/Inputs/Outputs must belong to the same environment (e.g. prod <-> prod, dev <-> dev) | Stream Analytics Functions/Inputs/Outputs must belong to the same environment (e.g. prod <-> prod, dev <-> dev) (What) on the Linked services page (How) to reduce the risk of data exfiltration and unauthorised system access (Why) | False | False | Control implemented by technical configuration setting: False |
| 7. | AZU-STRM-SC_040 | Stream Analytics jobs must run on a dedicated cluster | Stream Analytics jobs must run on a dedicated cluster (What) within Deployment settings (How) in order to provide single tenant isolation and private networking capabilities (Why) | True | True | Control implemented by setting this attribute as `mandatory`. |

## SMCF Controls

| S. No.  | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|---------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types.<br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc.<br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC<br><br>Documentation | True | This control will be implemented using resource naming module.<br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames) |
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC<br><br>Policy | True | This control will be implemented using `tags` parameter.<br><br>This control is achieved by custom policy as described in the [clear listing page](https://dev.azure.com/LSEGroup/Foundation/_git/azu-plat-policy) from where it inherits all the mandatory tags. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties.<br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration. | Policies<br><br>Iac<br><br>Policies<br><br>Iac | True | This control will be implemented by having all the `Mandate` and most of the `Optional` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring) | SMCF-OPS-03-02: Define and automate resource operation and security log collection<br><br>SMCF-OPS-03-03: Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs) | Policy<br><br>Documentation<br><br>Documentation | True | This control will be implemented by `DINE` Policy.<br><br>[Monitor Azure Stream Analytics](https://learn.microsoft.com/en-us/azure/stream-analytics/monitor-azure-stream-analytics)<br><br>[Supported metrics for Microsoft.StreamAnalytics/streamingjobs](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-streamanalytics-streamingjobs-metrics)<br><br>[Cloud monitoring service level objectives](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/monitor/service-level-objectives) |
| 5. | [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC<br><br>Documentation | False | This control is not implemented but it is recommended to deploy identical jobs to both paired regions. You should then monitor these jobs to get notified when something unexpected happens. If one of these jobs ends up in a Failed state after a Stream Analytics service update, you can contact customer support to help identify the root cause. Stream Analytics guarantees jobs in paired regions are updated in separate batches. Each batch has one or more regions which may be updated concurrently. The Stream Analytics service ensures any new update passes rigorous internal rings to have the highest quality. <br><br>[Guarantee Stream Analytics job reliability during service updates](https://learn.microsoft.com/en-us/azure/stream-analytics/stream-analytics-job-reliability)<br><br>[Achieve geo-redundancy for Azure Stream Analytics jobs](https://learn.microsoft.com/en-us/azure/stream-analytics/geo-redundancy) |
| 6. | [SMCF-OPS-07: Resource Protection](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-07-01: Prevent accidental or malicious deletion of production resources<br><br>SMCF-OPS-07-02: Prevent accidental misconfiguration of key production resources | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard based on application team requirement. <br><br>[Lock your resources to protect your infrastructure](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json) |
| 7. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package and has a JIT implementation in place.<br><br>[Azure built-in roles](https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles)<br><br>[Managed identities for Azure Stream Analytics](https://learn.microsoft.com/en-us/azure/stream-analytics/stream-analytics-managed-identities-overview) |

## Changelog

- [azure-prdsvc-terraform-streamanalyticsjob](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/stream-analytics/stream-analytics-quick-create-portal)

### Terraform Docs

- [azure-prdsvc-terraform-streamanalyticsjob](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/stream_analytics_job)
- [azure-prdsvc-terraform-streamanalyticsschduler](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/stream_analytics_job_schedule)
- [azure-prdsvc-terraform-streamanalyticsstreaminputeventhubv2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/stream_analytics_stream_input_eventhub_v2)
- [azure-prdsvc-terraform-streamanalyticsoutputeventhub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/stream_analytics_output_eventhub)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.5.0 |
| <a name="requirement_azapi"></a> [azapi](#requirement_azapi) | >= 2.2.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm) | >=4.33 |
| <a name="requirement_time"></a> [time](#requirement_time) | >= 0.12.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azapi"></a> [azapi](#provider_azapi) | >= 2.2.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) | >=4.33 |
| <a name="provider_time"></a> [time](#provider_time) | >= 0.12.0 |

## Resources

| Name | Type |
|------|------|
| [azapi_resource_action.stream_analytics_job_msi](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/resource_action) | resource |
| [azurerm_eventhub_consumer_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_consumer_group) | resource |
| [azurerm_role_assignment.input](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.output](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.stream_analytics_job_msi](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.stream_analytics_job_msi_con](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_stream_analytics_function_javascript_udf.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/stream_analytics_function_javascript_udf) | resource |
| [azurerm_stream_analytics_job.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/stream_analytics_job) | resource |
| [azurerm_stream_analytics_output_eventhub.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/stream_analytics_output_eventhub) | resource |
| [azurerm_stream_analytics_output_mssql.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/stream_analytics_output_mssql) | resource |
| [azurerm_stream_analytics_stream_input_eventhub_v2.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/stream_analytics_stream_input_eventhub_v2) | resource |
| [time_sleep.wait_seconds_role_assignment](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_compatibility_level"></a> [compatibility_level](#input_compatibility_level) | (Optional) Specifies the compatibility level for this job - which controls certain runtime behaviours of the streaming job. Possible values are 1.0, 1.1 and 1.2 | `string` | `"1.2"` | no |
| <a name="input_consumer_group"></a> [consumer_group](#input_consumer_group) | (Optional) The Consumer group consists of below variables:<br/>name                    = "(Required) The name of the Stream Input EventHub. Changing this forces a new resource to be created."<br/>eventhub_namespace_name = "(Required) Specifies the name of the grandparent EventHub Namespace. Changing this forces a new resource to be created."<br/>eventhub_name           = "(Required) Specifies the name of the EventHub. Changing this forces a new resource to be created."<br/>resource_group_name     = "(Required) The name of the resource group in which the EventHub Consumer Group's grandparent Namespace exists. Changing this forces a new resource to be created."<br/>user_metadata           = "(Optional) Specifies the user metadata." | <pre>object({<br/>    name                    = string<br/>    eventhub_namespace_name = string<br/>    eventhub_name           = string<br/>    resource_group_name     = string<br/>    user_metadata           = optional(string, null)<br/>  })</pre> | `null` | no |
| <a name="input_content_storage_policy"></a> [content_storage_policy](#input_content_storage_policy) | (Optional) The policy for storing Stream Analytics content. Possible values are JobStorageAccount, SystemAccount | `string` | `"SystemAccount"` | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_data_locale"></a> [data_locale](#input_data_locale) | (Optional) Specifies the Data Locale of the Job, which should be a supported .NET Culture. | `string` | `null` | no |
| <a name="input_encoding"></a> [encoding](#input_encoding) | (Optional) The encoding of the incoming data in the case of input and the encoding of outgoing data in the case of output. It currently can only be set to UTF8. | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_events_late_arrival_max_delay_in_seconds"></a> [events_late_arrival_max_delay_in_seconds](#input_events_late_arrival_max_delay_in_seconds) | (Optional) Specifies the maximum tolerable delay in seconds where events arriving late could be included. Supported range is -1 (indefinite) to 1814399 (20d 23h 59m 59s). | `number` | `0` | no |
| <a name="input_events_out_of_order_max_delay_in_seconds"></a> [events_out_of_order_max_delay_in_seconds](#input_events_out_of_order_max_delay_in_seconds) | (Optional) Specifies the maximum tolerable delay in seconds where out-of-order events can be adjusted to be back in order. Supported range is 0 to 599 (9m 59s). | `number` | `5` | no |
| <a name="input_events_out_of_order_policy"></a> [events_out_of_order_policy](#input_events_out_of_order_policy) | (Optional) Specifies the policy which should be applied to events which arrive out of order in the input event stream. Possible values are Adjust and Drop | `string` | `"Adjust"` | no |
| <a name="input_field_delimiter"></a> [field_delimiter](#input_field_delimiter) | (Optional) The delimiter that will be used to separate comma-separated value (CSV) records. Possible values are (space), , (comma), (tab), \| (pipe) and ; | `string` | `null` | no |
| <a name="input_identity"></a> [identity](#input_identity) | (Optional) An identity block supports the following:<br/>object({<br/>  type         = "(Required) Specifies the type of Managed Service Identity that should be configured on this Stream Analytics Job. Possible values are SystemAssigned and UserAssigned."<br/>  identity_ids = "(Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Cognitive Account."<br/>}) | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string), null)<br/>  })</pre> | <pre>{<br/>  "identity_ids": null,<br/>  "type": "SystemAssigned"<br/>}</pre> | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_job_storage_account_azapi"></a> [job_storage_account_azapi](#input_job_storage_account_azapi) | (Optional) Object containing variable job_storage_account of Stream Analytics job<br/>object({<br/>  enable_job_storage_account = "(Optional) Select whether to create Job Storage Account or not."<br/>  authentication_mode        = "(Optional) The authentication mode of the storage account. The supported values are `ConnectionString`, `Msi`."<br/>  account_name               = "(Optional) The name of the Azure storage account."<br/>  account_key                = "(Optional) The account key for the Azure storage account."<br/>  account_id                 = "(Optional) The storage account ID to be attached to Stream Analytics Job."<br/>  container_id               = "(Optional) The ID the container inside storage account."<br/>}) | <pre>object({<br/>    enable_job_storage_account = optional(bool, true)<br/>    authentication_mode        = optional(string, "Msi")<br/>    account_name               = optional(string)<br/>    account_key                = optional(string)<br/>    account_id                 = optional(string)<br/>    container_id               = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_job_type"></a> [job_type](#input_job_type) | (Optional) The type of the Stream Analytics Job. Possible values are Cloud and Edge | `string` | `"Cloud"` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_output_error_policy"></a> [output_error_policy](#input_output_error_policy) | (Optional) Specifies the policy which should be applied to events which arrive at the output and cannot be written to the external storage due to being malformed (such as missing column values, column values of wrong type or size). Possible values are Drop and Stop | `string` | `"Drop"` | no |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku_name](#input_sku_name) | (Optional) The Sku_name to use for stream_analytics_job. Possible values are `Standard` and `StandardV2` | `string` | `"Standard"` | no |
| <a name="input_stream_analytics_cluster_id"></a> [stream_analytics_cluster_id](#input_stream_analytics_cluster_id) | (Required) The id of the Stream Analytics cluster. | `string` | n/a | yes |
| <a name="input_stream_function_javascript_udf"></a> [stream_function_javascript_udf](#input_stream_function_javascript_udf) | (Optional) The Stream function Javascript Udf consists of below variables:<br/>  input = object({<br/>    type                    = "(Required) The Data Type for the Input Argument of this JavaScript Function. Possible values include array, any, bigint, datetime, float, nvarchar(max) and record."<br/>    configuration_parameter = "(Optional) Is this input parameter a configuration parameter? Defaults to false."<br/>  })<br/>  output = object({<br/>    type = "(Required) The Data Type output from this JavaScript Function. Possible values include array, any, bigint, datetime, float, nvarchar(max) and record."<br/>  })<br/>  script = "(Required) The JavaScript of this UDF Function."<br/>}) | <pre>map(object({<br/>    input = object({<br/>      type                    = string<br/>      configuration_parameter = optional(string)<br/>    })<br/>    output = object({<br/>      type = string<br/>    })<br/>    script = string<br/>  }))</pre> | `{}` | no |
| <a name="input_stream_input_eventhub"></a> [stream_input_eventhub](#input_stream_input_eventhub) | (Optional) <br/>object({<br/>  eventhub_name                = "(Required) The name of the Event Hub."<br/>  eventhub_resource_group_name = "(Required) The name of the Event Hub Resource Group."<br/>  servicebus_namespace         = "(Required) The namespace that is associated with the desired Event Hub, Service Bus Queue, Service Bus Topic, etc."<br/>  shared_access_policy_key     = "(Optional) The shared access policy key for the specified shared access policy."<br/>  shared_access_policy_name    = "(Optional) The shared access policy name for the Event Hub, Service Bus Queue, Service Bus Topic, etc."<br/>  partition_key                = "(Optional) The property the input Event Hub has been partitioned by."<br/>  authentication_mode          = "(Optional) The authentication mode for the Stream Output."<br/>  input_eventhub_id            = "(Required) The ID of the Eventhub under Eventhubnamespace."<br/>}) | <pre>map(object({<br/>    eventhub_name                = string<br/>    eventhub_resource_group_name = string<br/>    servicebus_namespace         = string<br/>    shared_access_policy_key     = optional(string)<br/>    shared_access_policy_name    = optional(string)<br/>    partition_key                = optional(string)<br/>    authentication_mode          = optional(string)<br/>    input_eventhub_id            = string<br/>  }))</pre> | `{}` | no |
| <a name="input_stream_output_eventhub"></a> [stream_output_eventhub](#input_stream_output_eventhub) | (Optional) <br/>object({<br/>  output_eventhub_name                = "(Required) The name of the Event Hub."<br/>  output_eventhub_resource_group_name = "(Required) The name of the Event Hub Resource Group."<br/>  output_servicebus_namespace         = "(Required) The namespace that is associated with the desired Event Hub, Service Bus Queue, Service Bus Topic, etc."<br/>  output_shared_access_policy_key     = "(Optional) The shared access policy key for the specified shared access policy."<br/>  output_shared_access_policy_name    = "(Optional) The shared access policy name for the Event Hub, Service Bus Queue, Service Bus Topic, etc."<br/>  output_partition_key                = "(Optional) The property the input Event Hub has been partitioned by."<br/>  output_authentication_mode          = "(Optional) The authentication mode for the Stream Output. Possible values are Msi and ConnectionString. Defaults to ConnectionString.<br/>  output_property_columns             = "(Optional) A list of property columns to add to the Event Hub output."<br/>  output_eventhub_id                  = "(Required) The ID of the Eventhub under Eventhubnamespace."<br/>  serialization                       = object({<br/>    output_type            = "(Required) The serialization format used for outgoing data streams. Possible values are Avro, Csv, Json and Parquet."<br/>    output_encoding        = "(Optional) The encoding of the incoming data in the case of input and the encoding of outgoing data in the case of output. It currently can only be set to UTF8."<br/>    output_field_delimiter = "(Optional) The delimiter that will be used to separate comma-separated value (CSV) records. Possible values are (space), , (comma), (tab), \| (pipe) and ;."<br/>    output_format          = "(Optional) Specifies the format of the JSON the output will be written in. Possible values are Array and LineSeparated."<br/>}) | <pre>map(object({<br/>    output_eventhub_name                = string<br/>    output_eventhub_resource_group_name = string<br/>    output_servicebus_namespace         = string<br/>    output_shared_access_policy_key     = optional(string)<br/>    output_shared_access_policy_name    = optional(string)<br/>    output_partition_key                = optional(string)<br/>    output_authentication_mode          = optional(string, "ConnectionString")<br/>    output_property_columns             = optional(list(string))<br/>    output_eventhub_id                  = string<br/>    output_serialization = object({<br/>      output_type            = string<br/>      output_encoding        = optional(string, "UTF8")<br/>      output_field_delimiter = optional(string)<br/>      output_format          = optional(string)<br/>    })<br/>  }))</pre> | `{}` | no |
| <a name="input_stream_output_mssql"></a> [stream_output_mssql](#input_stream_output_mssql) | (Optional) <br/> object({<br/>  output_server              = "(Required) The SQL server url (fully_qualified_domain_name). Changing this forces a new resource to be created."<br/>  output_user                = "(Optional) Username used to login to the Microsoft SQL Server. Changing this forces a new resource to be created. Required if authentication_mode is ConnectionString."<br/>  output_database            = "(Required) The MS SQL database name where the reference table exists. Changing this forces a new resource to be created."<br/>  output_password            = "(Optional) Password used together with username, to login to the Microsoft SQL Server. Required if authentication_mode is ConnectionString."<br/>  output_table               = "(Required) Table (name) in the database that the output points to. Changing this forces a new resource to be created."<br/>  output_max_batch_count     = "(Optional) The max batch count to write to the SQL Database. Defaults to 10000. Possible values are between 1 and 1073741824."<br/>  output_max_writer_count    = "(Optional) The max writer count for the SQL Database. Defaults to 1. Possible values are 0 which bases the writer count on the query partition and 1 which corresponds to a single writer."<br/>  output_authentication_mode = "(Optional) The authentication mode for the Stream Output. Possible values are Msi and ConnectionString. Defaults to ConnectionString."<br/>}) | <pre>map(object({<br/>    output_server              = string<br/>    output_user                = optional(string)<br/>    output_database            = string<br/>    output_password            = optional(string)<br/>    output_table               = string<br/>    output_max_batch_count     = optional(number, 10000)<br/>    output_max_writer_count    = optional(number, 1)<br/>    output_authentication_mode = optional(string, "ConnectionString")<br/>  }))</pre> | `{}` | no |
| <a name="input_streaming_units"></a> [streaming_units](#input_streaming_units) | (Optional) Specifies the number of streaming units that the streaming job uses. Supported values are 1, 3, 6 and multiples of 6 up to 120 | `number` | `3` | no |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |
| <a name="input_transformation_query"></a> [transformation_query](#input_transformation_query) | (Required) Specifies the query that will be run in the streaming job, written in Stream Analytics Query Language (SAQL). | `string` | n/a | yes |
| <a name="input_type"></a> [type](#input_type) | (Required) The serialization format used for incoming data streams. Possible values are Avro, CSV and Json. | `string` | n/a | yes |
| <a name="input_uai_principal_id"></a> [uai_principal_id](#input_uai_principal_id) | (Optional) Principal id of the User Assigned Identity. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_consumer_group_id"></a> [consumer_group_id](#output_consumer_group_id) | The ID of the EventHub Consumer Group. |
| <a name="output_id"></a> [id](#output_id) | The  Resource ID of the stream analytics job. |
| <a name="output_input_eventhub_v2_resource"></a> [input_eventhub_v2_resource](#output_input_eventhub_v2_resource) | The Input EventHub resource. |
| <a name="output_job_storage_account_azapi_resource_action"></a> [job_storage_account_azapi_resource_action](#output_job_storage_account_azapi_resource_action) | The Job Storage Account resource. |
| <a name="output_name"></a> [name](#output_name) | The Name of the stream analytics job. |
| <a name="output_output_eventhub_resource"></a> [output_eventhub_resource](#output_output_eventhub_resource) | The Output EventHub resource. |
| <a name="output_output_mssql_resource"></a> [output_mssql_resource](#output_output_mssql_resource) | The Output MSSQL resource. |
| <a name="output_resource"></a> [resource](#output_resource) | The stream analytics job resource. |
| <a name="output_stream_function_javascript_udf_resource"></a> [stream_function_javascript_udf_resource](#output_stream_function_javascript_udf_resource) | The Stream function Javascript Udf resource. |
<!-- END_TF_DOCS -->
