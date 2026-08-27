---
version: 1.0.1
available_versions:
  - 1.0.1
  - 1.0.0
  - 0.1.3
  - 0.1.2
  - 0.1.1
---

<!-- BEGIN_TF_DOCS -->
# Stream Analytics Job Schedule module


## Overview

This terraform module creates a Stream Analytics Job Schedule and associated resources.

## Prerequisites

- An existing `Stream Analytics Job` with `Stream Analytics Cluster` and associated Input and Output.

## Guidance

#### Usage

- This module expects `Stream Analytics Job` with `Stream Analytics Cluster` and associated Input and Output.
- This module needs to be triggered post manual managed private endpoint approval. Refer Usage Flow.
- Setting start_mode to `LastOutputEventTime` is only possible if the job had been previously started and produced output.

#### Security Considerations

#### Additional Information

- Usage Flow

| S. No.  | Description | Execution | Repo Reference |
|---------|-------------|-----------|----------------|
| 1. | Create Stream Analytics Cluster along with Eventhub Namespace with managed private endpoint enabled for Eventhub Namespace | Terraform | `Stream Analytics Cluster` Repo |
| 2. | Create Stream Analytics Job along with above created cluster having managed private endpoint | Terraform | `Stream Analytics Job` Repo |
| 3. | Use existing Eventhub Namespace to create Event Hubs along with Consumer Group to be used for Input and Output | Terraform | `Stream Analytics Job` Repo |
| 4. | Assign Event Hub Data roles on existing Event Hubs IAM for Stream Analytics Job Managed Identity | Terraform | `Stream Analytics Job` Repo |
| 5. | Configure Stream Analytics Job with input and output with above created Eventhubs | Terraform | `Stream Analytics Job` Repo |
| 6. | Approve the managed private endpoint for Eventhub Namespace | Manual | Manual Task |
| 7. | Start the Stream Analytics Job Schedule | Terraform | Existing Repo |

## Security Controls

- Security controls are implemented in Stream Analytics Job module. There is no specific security control available for Stream Analytics Job Schedule.

## Changelog

- [azure-prdsvc-terraform-streamanalyticsjob](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/stream-analytics/stream-analytics-quick-create-portal)
- [How to start an Azure Stream Analytics job](https://learn.microsoft.com/en-us/azure/stream-analytics/start-job)

### Terraform Docs

- [azure-prdsvc-terraform-streamanalyticsschduler](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/stream_analytics_job_schedule)

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
| [azurerm_stream_analytics_job_schedule.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/stream_analytics_job_schedule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_start_mode"></a> [start_mode](#input_start_mode) | (Required) The starting mode of the Stream Analytics Job. Possible values are JobStartTime, CustomTime and LastOutputEventTime. Setting start_mode to LastOutputEventTime is only possible if the job had been previously started and produced output. | `string` | n/a | yes |
| <a name="input_start_time"></a> [start_time](#input_start_time) | (Optional) The time in ISO8601 format at which the Stream Analytics Job should be started e.g. 2022-04-01T00:00:00Z. This property can only be specified if start_mode is set to CustomTime. | `string` | `null` | no |
| <a name="input_stream_analytics_job_id"></a> [stream_analytics_job_id](#input_stream_analytics_job_id) | (Required) The ID of the Stream Analytics Job that should be scheduled or started. Changing this forces a new resource to be created. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The ID of the Stream Analytics Job. |
| <a name="output_job_schedule_resource"></a> [job_schedule_resource](#output_job_schedule_resource) | The Job Schedule resource. |
| <a name="output_last_output_time"></a> [last_output_time](#output_last_output_time) | The time at which the Stream Analytics job last produced an output. |
<!-- END_TF_DOCS -->
