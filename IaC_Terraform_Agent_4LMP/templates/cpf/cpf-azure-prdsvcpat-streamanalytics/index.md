<!-- BEGIN_TF_DOCS -->
# Stream Analytics Service Pattern

[[_TOC_]]

This readme provides an overview of a service pattern for `azure-prdsvcpat-terraform-streamanalytics`. The solution proposed below provides an easy predefined template built on top of LSEG approved Cloud Products (with identified common configurations) and the service.

Here are some of the key advantages the proposed solution offers:

- **Rapid Deployment:** Service patterns are pre-defined templates that can be easily reused which accelerates the deployment process by eliminating the need to write configurations from scratch for each deployment, saving time and effort.
- **Standardization and Consistency:** Service patterns provide standardized templates and best practices for deploying specific infrastructure that promotes consistent configurations. This ensures consistency across deployments, reducing the likelihood of configuration drifts/errors and making it easier to maintain and scale infrastructure.
- **Documentation:** Service pattern comes with built-in documentation that explain the purpose and usage of various components.
- **Security and Compliance:** Service pattern built on top of approved Cloud Products incorporate security best practices and compliance requirements, ensuring that infrastructure is deployed with security in mind from the outset. This reduces the likelihood of security vulnerabilities.
- **Reuse, Sharing and customization:** Teams can share and reuse patterns across projects and organizations. Patterns can be adapted, and customized over time as infrastructure/business requirements change.
- **Version Control:** Patterns can be version-controlled, allowing teams to track changes, roll back to previous configurations if issues arise, and collaborate more effectively through version control systems.

## Pattern Description

This section contains the details of the azure service technical use case.

The following diagram shows the High Level Design for **Service pattern for Stream Analytics**:

[Image: StreamanalyticssvcpatHLD]

### Provisioned Azure services through IaC

- Stream Analytics Cluster
- Stream Analytics Job
- Stream Analytics Job Schedule

#### Simplified Usability

- This pattern significantly reduces user time and effort by eliminating the need to individually call each of the above mentioned modules. Instead, users can focus on passing the `required parameters` after invoking this service pattern.
- Additionally, this pattern seamlessly integrates essential resource blocks, such as the `time_sleep` block, which introduces necessary delays to ensure sufficient time for DNS zone establishment when configuring private endpoints for core products such as Disk Encryption Set, thereby ensuring the smooth creation of child resources.

### Secret management

- Azure Key Vault Private Endpoint pattern is offered as an optional component, and it serves as the repository for the Customer Managed Key (CMK) needed to activate encryption on the Storage Account. AKV is utilized for storing the CMK Key.
- If `persist_access_key` is set to true then you can store storage access key in `key vault`.

### Networking

- Networking in Azure Stream Analytics provides various options for securely managing data between inputs and outputs. While public network access is the default, using Virtual Network (VNet) integration, Private Endpoints and Managed Private Endpoints ensures more secure communication.
- Azure Stream Analytics allows you to set up Managed Private Endpoints to securely access inputs (like Event Hubs) and outputs (like SQL Databases) using private IP addresses. These are useful when using Azure Stream Analytics clusters that support Private Link connectivity.

### Identity Management

- Stream Analytics Job enforce the use of Managed Identity to authenticate to Azure resources in order to adhere to the principle of least privilege and remove the need to store credentials using identity{} block in `azurerm_stream_analytics_job` resource.

### Monitoring and Logging

- Stream Analytics sends all diagnostic logs to a central SOC Log Analytics workspace through DINE (Azure) policy within its Diagnostic settings in order to support a security investigation after a security incident involving a Storage Account.
- Stream Analytics sends all diagnostic logs to a central SOC Storage Account through DINE (Azure) policy within its Diagnostic settings in order to provide a copy to adhere to compliance requirements.

### Availability

- Azure Stream Analytics supports Availability Zones for all jobs. Any new dedicated cluster or new job will automatically benefit from Availability Zones, and, in case of disaster in a zone, will continue to run seamlessly by failing over to the other zones without the need of any user action. Availability Zones provide customers with the ability to withstand datacenter failures through redundancy and logical isolation of services. This will significantly reduce the risk of outage for your streaming pipelines. Note that Azure Stream Analytics jobs integrated with VNET don't currently support Availability Zones.
- Stream Analytics guarantees jobs in paired regions are updated in separate batches. Each batch has one or more regions which may be updated concurrently. The Stream Analytics service ensures any new update passes rigorous internal rings to have the highest quality. The service also proactively looks for many signals after deploying to each batch to get more confidence that there are no bugs introduced. The deployment of an update to Stream Analytics would not occur at the same time in a set of paired regions. As a result there is a sufficient time gap between the updates to identify potential issues and remediate them.
- Azure Stream Analytics does not provide automatic geo-failover, but you can achieve geo-redundancy by deploying identical Stream Analytics jobs in multiple Azure regions. Each job connects to a local input and local output sources. It is the responsibility of your application to both send input data into the two regional inputs and reconcile between the two regional outputs. The Stream Analytics jobs are two separate entities.

### Back Up

- If you want to move, copy or back up your Azure Stream Analytics jobs in Azure, the Azure Stream Analytics extension for Visual Studio Code allows you to export an existing job in Azure cloud to your local computer. All the configurations of your Stream Analytics job will be saved locally and you can resubmit it to another cloud region. Refer [here](https://learn.microsoft.com/en-us/azure/stream-analytics/copy-job) for more information.

### Other

- Pattern provides the capability to deploy Stream Analytics Cluster with Managed Private Endpoint.
- This Pattern also creates Stream Analytics Job Inputand Ouput as Eventhub,Stream analytics Output SQL, Eventhub Consumergroup and Java Script function UDF along with Stream Analytics Job

  ## Pattern Composability

The section describes what optional components are considered in the service pattern and which inputs govern and effect the deployement of these components

[Image: Stream Analytics Pattern Solution]

# Pattern Usage Guidance

## Pattern Use Cases

| Use Case | Default Behaviour | Input Control- variable | Comments |
|----------|-------------------|-------------------------|----------|
| Deploy Azure Stream Analytics Cluster | By Default the patterns deploys new stream analytics cluster | `streaming_capacity`| user needs to pass the value of `streaming_capacity` as part of deployment . |
| Deploy Managed Private endpoint for stream analytics cluster | By Default the patterns deploys new stream analytics cluster with managed private endpoint | `stream_analytics_cluster_name` | If we pass the `stream_analytics_cluster_name` variable it will create the managed private endpoint for stream analytic clusters . |
| Deploy Azure Stream Analytics Job | By Default the patterns deploys new stream analytics job | `stream_analytics_cluster_id` | If we passed the `stream_analytics_cluster_id` it will create stream analytics job.|
| Deploy eventhub consumer group | By Default the patterns deploys new eventhub consumer group | `eventhub_name` | user need to pass the `eventhub_name` for deploying event hub consumer group stream analytics job module.|
| Deploy Stream Analytic Job Input eventhub | By Default the patterns deploys new eventhub input for stream analytics job | `eventhub_name`,`eventhub_consumer_group_name`,`stream_analytics_job_id` | user need to pass the mentioned input variable for the creation of stream analytics job input|
| Deploy Stream Analytics Job output eventhub | By Default the patterns deploys new eventhub output for stream analytics job | `eventhub_name`,`eventhub_consumer_group_name`,`stream_analytics_job_id` | User need to pass the mentioned input variable for the creation of stream analytics job output|
| Deploy Stream Analytics Job output mssql | By Default the patterns deploys new mssql output for stream analytics job | `stream_analytics_job_name` | User need to pass the mentioned input variable for the creation of stream analytics job output|
| Deploy JAVA script UDF function for stream analytics Job | By Default the patterns deploys new JAVA script UDF function for stream analytics Job| `stream_analytics_job_name` | User need to pass the mentioned input variable for the creation of AVA script UDF function|
| Deploy Stream Analytics Jobschedule | By Default the patterns deploys new Stream analytics Jobschedule| `stream_analytics_job_id` | User need to pass the `stream_analytics_job_id` input variable for the creation of stream analytics job schedule|

## Additional Information

- The current pattern supports input as EventHub and output as EventHub along with Stream Analytics cluster with managed private endpoint configured.

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

- To `store` the `data snapshot` of `stream analytics job` in `storage account` it requires `private connectivity` betwee `storage account` and `stream analytics job` which is currently not available and it's in `preview`.
- To `send` the `data snapshot` of `stream analytics` to `storage account`, need `stream analytic cluster` with `managed private endpoint` enable which will allow stream anayltics job to send the data to storage account privately.
- After approving the managed endpoint from portal we need to add the same storage account in stream analytic job storage account.
- This module is having all the required attributes to create job storage account in stream analytics job however it's not visible on the portal as it requires storage account with private endpoint enable.
- Testing Notes
  - However the testing of storing data snapshot of stream analytics job in storage account is not possible without sending the data.
- Due to the above change, `job_storage_account` will always change to `null` post first run as expected and the below code shows changes displayed as per tf plan stage.
```
      - job_storage_account {
          - account_name        = "a1a51310devstpvsajuks028" -> null
          - authentication_mode = "Msi" -> null
        }
```
- Added `Storage Blob Data Contributor` role assignment for Stream Analytics Job Managed Identity scoped over Storage Account and Container for Storage account authentication and hence configuration of job_storage_account.
- In order to enable `job storage settings` in `stream analytics job`, need to use` storage account` module with privatendpoint enable.
- `Stream analytics cluster` supports `managed private endpoint` with target resource as `eventhub` and `storage account` as part of this module.
- Please make sure that the `approval` for `managed private endpoint` has to be provide `manually` from portal.
- Post `Manual Approval` only, stream analytics job will run successfully and even input and output will be able to establish connection with the Stream Analytics Job.

## Pattern Usage

### Prerequisites

- An existing `Resource Group`, `Eventhub Namespace`, `Storage Account`, `Key Vault and associated Private Endpoint`.

## Guidance

### Build and Test

1. Call the module whichever is needed to be deployed. As the example given below,

```
#-----------------------------------
# - Create Stream Analytics Pattern
#-----------------------------------
module "azure-prdsvc-terraform-streamanalytics-pattern" {
  source                 = "../.."
  org_id                 = local.org_id
  app_id                 = local.app_id
  location               = local.location
  environment            = local.environment
  context                = local.context
  instance               = local.instance_sa
  depends_on             = [module.azure_prdsvc_terraform_eventhub]
  resource_group_name    = data.azurerm_resource_group.this.name
  start_mode             = "CustomTime"
  sku_name               = "Standard"
  uai_principal_id       = module.azure_prdsvc_terraform_userassignedidentity.principal_id
  output_error_policy    = "Stop"
  content_storage_policy = "SystemAccount"
  streaming_capacity     = 36
  managed_private_endpoint = {
    managed_private_endpoint1 = {
      private_endpoint_name = "clusendpnt2"
      target_resource_id    = module.azure_prdsvc_terraform_eventhubnamespace.id
      subresource_name      = "namespace"
    }
  }

  transformation_query = <<QUERY
    SELECT *
    INTO [output5]
    FROM [input5]
QUERY

  job_storage_account_azapi = {
    enable_job_storage_account = true
    authentication_mode        = "ConnectionString"
    account_name               = module.azure_prdsvc_terraform_storageaccount.name
    account_id                 = module.azure_prdsvc_terraform_storageaccount.id
    container_id               = module.azure-prdsvc-terraform-storagecontainer.resource.resource_manager_id
    account_key                = module.azure_prdsvc_terraform_storageaccount.primary_access_key
  }

  stream_input_eventhub = {
    input5 = {
      eventhub_consumer_group_name = "streamanalytics-evncongrp-lseg2"
      eventhub_name                = module.azure_prdsvc_terraform_eventhub.name
      eventhub_resource_group_name = data.azurerm_resource_group.this.name
      servicebus_namespace         = module.azure_prdsvc_terraform_eventhubnamespace.name
      shared_access_policy_key     = module.azure_prdsvc_terraform_eventhubnamespace.resource.default_primary_key
      shared_access_policy_name    = "RootManageSharedAccessKey"
      partition_key                = null
      authentication_mode          = "Msi"
      input_eventhub_id            = module.azure_prdsvc_terraform_eventhub.id
    }
  }

  type            = "Json"
  encoding        = "UTF8"
  streaming_units = 1
  consumer_group = {
    name                    = "stream-analytics-consumer-group"
    eventhub_namespace_name = module.azure_prdsvc_terraform_eventhubnamespace.name
    eventhub_name           = module.azure_prdsvc_terraform_eventhub.name
    resource_group_name     = data.azurerm_resource_group.this.name
    user_metadata           = null
  }

  stream_output_eventhub = {
    output5 = {
      output_eventhub_name                = module.azure_prdsvc_terraform_eventhub.name
      output_eventhub_resource_group_name = data.azurerm_resource_group.this.name
      output_servicebus_namespace         = module.azure_prdsvc_terraform_eventhubnamespace.name
      output_shared_access_policy_key     = module.azure_prdsvc_terraform_eventhubnamespace.resource.default_primary_key
      output_shared_access_policy_name    = "RootManageSharedAccessKey"
      output_partition_key                = null
      output_authentication_mode          = "Msi"
      output_property_columns             = null
      output_eventhub_id                  = module.azure_prdsvc_terraform_eventhub.id
      output_serialization = {
        output_type     = "Json"
        output_encoding = "UTF8"
        output_format   = "Array"
      }
    }
  }
}

 ```
2. Update the source with right tag version.
3. Check the terraform variables file and update the values of org\_id, app\_id, location, context, instance and other necessary arguments for all the resources being deployed. Example displayed in .tests/deployTest folder.
4. If the plan is use to use the existing resouce available on azure then please make sure to use 'data block'.
5. **Note: The .tests/deployTest folder is for for deployment and unit test cases , Use only as reference and not as the exact implementation of the pattern.**

## Changelog

- [azure-prdsvcpat-terraform-streamanalyticspattern](CHANGELOG.md)

## References

### Microsoft Docs

- [Stream Analytics Cluster](https://learn.microsoft.com/en-us/azure/stream-analytics/cluster-overview)
- [Stream Analytics Job](https://learn.microsoft.com/en-us/azure/stream-analytics/stream-analytics-quick-create-portal)
- [Stream Analytics Job Schedule](https://learn.microsoft.com/en-us/azure/stream-analytics/start-job)

### Terraform Docs

- [azurerm\_stream\_analytics\_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/stream_analytics_cluster)
- [azurerm\_stream\_analytics\_job](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/stream_analytics_job)
- [azurerm\_stream\_analytics\_job\_schedule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/stream_analytics_job\_schedule)

### Service-Pattern-HLD

- [Stream Analytics Pattern](https://gitlab.dx1.lseg.com/groups/app/app-51310/azure/prdsvc/terraform/-/wikis/Stream-Analytics-Pattern)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | >= 1.10.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.51 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >= 0.10.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_time"></a> [time](#provider\_time) | >= 0.10.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_azure-prdsvc-terraform-resourcenames"></a> [azure-prdsvc-terraform-resourcenames](#module\_azure-prdsvc-terraform-resourcenames) | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames | 0.2.4 |
| <a name="module_azure-prdsvcpat-terraform-streamanalyticscluster"></a> [azure-prdsvcpat-terraform-streamanalyticscluster](#module\_azure-prdsvcpat-terraform-streamanalyticscluster) | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-streamanalyticscluster | 0.4.1 |
| <a name="module_azure-prdsvcpat-terraform-streamanalyticsjob"></a> [azure-prdsvcpat-terraform-streamanalyticsjob](#module\_azure-prdsvcpat-terraform-streamanalyticsjob) | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-streamanalyticsjob | 0.9.0 |
| <a name="module_azure-prdsvcpat-terraform-streamanalyticsjobschedule"></a> [azure-prdsvcpat-terraform-streamanalyticsjobschedule](#module\_azure-prdsvcpat-terraform-streamanalyticsjobschedule) | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-streamanalyticsjobschedule | 0.1.1 |

## Resources

| Name | Type |
|------|------|
| [time_sleep.wait_seconds_job](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app\_id](#input\_app\_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_compatibility_level"></a> [compatibility\_level](#input\_compatibility\_level) | (Optional) Specifies the compatibility level for this job - which controls certain runtime behaviours of the streaming job. Possible values are 1.0, 1.1 and 1.2 | `string` | `"1.2"` | no |
| <a name="input_consumer_group"></a> [consumer\_group](#input\_consumer\_group) | (Optional) The Consumer group consists of below variables:<br/>name                    = "(Required) The name of the Stream Input EventHub. Changing this forces a new resource to be created."<br/>eventhub\_namespace\_name = "(Required) Specifies the name of the grandparent EventHub Namespace. Changing this forces a new resource to be created."<br/>eventhub\_name           = "(Required) Specifies the name of the EventHub. Changing this forces a new resource to be created."<br/>resource\_group\_name     = "(Required) The name of the resource group in which the EventHub Consumer Group's grandparent Namespace exists. Changing this forces a new resource to be created."<br/>user\_metadata           = "(Optional) Specifies the user metadata." | <pre>object({<br/>    name                    = string<br/>    eventhub_namespace_name = string<br/>    eventhub_name           = string<br/>    resource_group_name     = string<br/>    user_metadata           = optional(string, null)<br/>  })</pre> | `null` | no |
| <a name="input_content_storage_policy"></a> [content\_storage\_policy](#input\_content\_storage\_policy) | (Optional) The policy for storing Stream Analytics content. Possible values are JobStorageAccount, SystemAccount | `string` | `"SystemAccount"` | no |
| <a name="input_context"></a> [context](#input\_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_data_locale"></a> [data\_locale](#input\_data\_locale) | (Optional) Specifies the Data Locale of the Job, which should be a supported .NET Culture. | `string` | `null` | no |
| <a name="input_encoding"></a> [encoding](#input\_encoding) | (Optional) The encoding of the incoming data in the case of input and the encoding of outgoing data in the case of output. It currently can only be set to UTF8. | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_events_late_arrival_max_delay_in_seconds"></a> [events\_late\_arrival\_max\_delay\_in\_seconds](#input\_events\_late\_arrival\_max\_delay\_in\_seconds) | (Optional) Specifies the maximum tolerable delay in seconds where events arriving late could be included. Supported range is -1 (indefinite) to 1814399 (20d 23h 59m 59s). | `number` | `0` | no |
| <a name="input_events_out_of_order_max_delay_in_seconds"></a> [events\_out\_of\_order\_max\_delay\_in\_seconds](#input\_events\_out\_of\_order\_max\_delay\_in\_seconds) | (Optional) Specifies the maximum tolerable delay in seconds where out-of-order events can be adjusted to be back in order. Supported range is 0 to 599 (9m 59s). | `number` | `5` | no |
| <a name="input_events_out_of_order_policy"></a> [events\_out\_of\_order\_policy](#input\_events\_out\_of\_order\_policy) | (Optional) Specifies the policy which should be applied to events which arrive out of order in the input event stream. Possible values are Adjust and Drop | `string` | `"Adjust"` | no |
| <a name="input_field_delimiter"></a> [field\_delimiter](#input\_field\_delimiter) | (Optional) The delimiter that will be used to separate comma-separated value (CSV) records. Possible values are (space), , (comma), (tab), \| (pipe) and ; | `string` | `null` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | (Optional) An identity block supports the following:<br/>object({<br/>  type         = "(Required) Specifies the type of Managed Service Identity that should be configured on this Stream Analytics Job. Possible values are SystemAssigned and UserAssigned."<br/>  identity\_ids = "(Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Cognitive Account."<br/>}) | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string), null)<br/>  })</pre> | <pre>{<br/>  "identity_ids": null,<br/>  "type": "SystemAssigned"<br/>}</pre> | no |
| <a name="input_instance"></a> [instance](#input\_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_job_storage_account_azapi"></a> [job\_storage\_account\_azapi](#input\_job\_storage\_account\_azapi) | (Optional) Object containing variable job\_storage\_account of Stream Analytics job<br/>object({<br/>  enable\_job\_storage\_account = "(Optional) Select whether to create Job Storage Account or not."<br/>  authentication\_mode        = "(Optional) The authentication mode of the storage account. The supported values are `ConnectionString`, `Msi`."<br/>  account\_name               = "(Optional) The name of the Azure storage account."<br/>  account\_key                = "(Optional) The account key for the Azure storage account."<br/>  account\_id                 = "(Optional) The storage account ID to be attached to Stream Analytics Job."<br/>  container\_id               = "(Optional) The ID the container inside storage account."<br/>}) | <pre>object({<br/>    enable_job_storage_account = optional(bool, true)<br/>    authentication_mode        = optional(string, "Msi")<br/>    account_name               = optional(string)<br/>    account_key                = optional(string)<br/>    account_id                 = optional(string)<br/>    container_id               = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_job_type"></a> [job\_type](#input\_job\_type) | (Optional) The type of the Stream Analytics Job. Possible values are Cloud and Edge | `string` | `"Cloud"` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_managed_private_endpoint"></a> [managed\_private\_endpoint](#input\_managed\_private\_endpoint) | (Optional) manage private endpoint configuration<br/>object({<br/>  private\_endpoint\_name  = "(Required) The name which should be used for this Stream Analytics Managed Private Endpoint. Changing this forces a new resource to be created."<br/>  target\_resource\_id     = "(Required) The ID of the Private Link Enabled Remote Resource which this Stream Analytics Private endpoint should be connected to. Changing this forces a new resource to be created."<br/>  subresource\_name       = "(Required) Specifies the sub resource name which the Stream Analytics Private Endpoint is able to connect to. Changing this forces a new resource to be created."<br/>}) | <pre>map(object({<br/>    private_endpoint_name = string<br/>    target_resource_id    = string<br/>    subresource_name      = string<br/>  }))</pre> | `{}` | no |
| <a name="input_org_id"></a> [org\_id](#input\_org\_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_output_error_policy"></a> [output\_error\_policy](#input\_output\_error\_policy) | (Optional) Specifies the policy which should be applied to events which arrive at the output and cannot be written to the external storage due to being malformed (such as missing column values, column values of wrong type or size). Possible values are Drop and Stop | `string` | `"Drop"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | (Optional) The Sku\_name to use for stream\_analytics\_job. Possible values are `Standard` and `StandardV2` | `string` | `"Standard"` | no |
| <a name="input_start_mode"></a> [start\_mode](#input\_start\_mode) | (Required) The starting mode of the Stream Analytics Job. Possible values are JobStartTime, CustomTime and LastOutputEventTime. Setting start\_mode to LastOutputEventTime is only possible if the job had been previously started and produced output. | `string` | n/a | yes |
| <a name="input_start_time"></a> [start\_time](#input\_start\_time) | (Optional) The time in ISO8601 format at which the Stream Analytics Job should be started e.g. 2022-04-01T00:00:00Z. This property can only be specified if start\_mode is set to CustomTime. | `string` | `null` | no |
| <a name="input_stream_function_javascript_udf"></a> [stream\_function\_javascript\_udf](#input\_stream\_function\_javascript\_udf) | (Optional) The Stream function Javascript Udf consists of below variables:<br/>  input = object({<br/>    type                    = "(Required) The Data Type for the Input Argument of this JavaScript Function. Possible values include array, any, bigint, datetime, float, nvarchar(max) and record."<br/>    configuration\_parameter = "(Optional) Is this input parameter a configuration parameter? Defaults to false."<br/>  })<br/>  output = object({<br/>    type = "(Required) The Data Type output from this JavaScript Function. Possible values include array, any, bigint, datetime, float, nvarchar(max) and record."<br/>  })<br/>  script = "(Required) The JavaScript of this UDF Function."<br/>}) | <pre>map(object({<br/>    input = object({<br/>      type                    = string<br/>      configuration_parameter = optional(string)<br/>    })<br/>    output = object({<br/>      type = string<br/>    })<br/>    script = string<br/>  }))</pre> | `{}` | no |
| <a name="input_stream_input_eventhub"></a> [stream\_input\_eventhub](#input\_stream\_input\_eventhub) | (Optional) <br/>object({<br/>  eventhub\_name                = "(Required) The name of the Event Hub."<br/>  eventhub\_resource\_group\_name = "(Required) The name of the Event Hub Resource Group."<br/>  servicebus\_namespace         = "(Required) The namespace that is associated with the desired Event Hub, Service Bus Queue, Service Bus Topic, etc."<br/>  shared\_access\_policy\_key     = "(Optional) The shared access policy key for the specified shared access policy."<br/>  shared\_access\_policy\_name    = "(Optional) The shared access policy name for the Event Hub, Service Bus Queue, Service Bus Topic, etc."<br/>  partition\_key                = "(Optional) The property the input Event Hub has been partitioned by."<br/>  authentication\_mode          = "(Optional) The authentication mode for the Stream Output."<br/>  input\_eventhub\_id            = "(Required) The ID of the Eventhub under Eventhubnamespace."<br/>}) | <pre>map(object({<br/>    eventhub_name                = string<br/>    eventhub_resource_group_name = string<br/>    servicebus_namespace         = string<br/>    shared_access_policy_key     = optional(string)<br/>    shared_access_policy_name    = optional(string)<br/>    partition_key                = optional(string)<br/>    authentication_mode          = optional(string)<br/>    input_eventhub_id            = string<br/>  }))</pre> | `{}` | no |
| <a name="input_stream_output_eventhub"></a> [stream\_output\_eventhub](#input\_stream\_output\_eventhub) | (Optional) <br/>object({<br/>  output\_eventhub\_name                = "(Required) The name of the Event Hub."<br/>  output\_eventhub\_resource\_group\_name = "(Required) The name of the Event Hub Resource Group."<br/>  output\_servicebus\_namespace         = "(Required) The namespace that is associated with the desired Event Hub, Service Bus Queue, Service Bus Topic, etc."<br/>  output\_shared\_access\_policy\_key     = "(Optional) The shared access policy key for the specified shared access policy."<br/>  output\_shared\_access\_policy\_name    = "(Optional) The shared access policy name for the Event Hub, Service Bus Queue, Service Bus Topic, etc."<br/>  output\_partition\_key                = "(Optional) The property the input Event Hub has been partitioned by."<br/>  output\_authentication\_mode          = "(Optional) The authentication mode for the Stream Output. Possible values are Msi and ConnectionString. Defaults to ConnectionString.<br/>  output\_property\_columns             = "(Optional) A list of property columns to add to the Event Hub output."<br/>  output\_eventhub\_id                  = "(Required) The ID of the Eventhub under Eventhubnamespace."<br/>  serialization                       = object({<br/>    output\_type            = "(Required) The serialization format used for outgoing data streams. Possible values are Avro, Csv, Json and Parquet."<br/>    output\_encoding        = "(Optional) The encoding of the incoming data in the case of input and the encoding of outgoing data in the case of output. It currently can only be set to UTF8."<br/>    output\_field\_delimiter = "(Optional) The delimiter that will be used to separate comma-separated value (CSV) records. Possible values are (space), , (comma), (tab), \| (pipe) and ;."<br/>    output\_format          = "(Optional) Specifies the format of the JSON the output will be written in. Possible values are Array and LineSeparated."<br/>}) | <pre>map(object({<br/>    output_eventhub_name                = string<br/>    output_eventhub_resource_group_name = string<br/>    output_servicebus_namespace         = string<br/>    output_shared_access_policy_key     = optional(string)<br/>    output_shared_access_policy_name    = optional(string)<br/>    output_partition_key                = optional(string)<br/>    output_authentication_mode          = optional(string, "ConnectionString")<br/>    output_property_columns             = optional(list(string))<br/>    output_eventhub_id                  = string<br/>    output_serialization = object({<br/>      output_type            = string<br/>      output_encoding        = optional(string, "UTF8")<br/>      output_field_delimiter = optional(string)<br/>      output_format          = optional(string)<br/>    })<br/>  }))</pre> | `{}` | no |
| <a name="input_stream_output_mssql"></a> [stream\_output\_mssql](#input\_stream\_output\_mssql) | (Optional) <br/> object({<br/>  output\_server              = "(Required) The SQL server url (fully\_qualified\_domain\_name). Changing this forces a new resource to be created."<br/>  output\_user                = "(Optional) Username used to login to the Microsoft SQL Server. Changing this forces a new resource to be created. Required if authentication\_mode is ConnectionString."<br/>  output\_database            = "(Required) The MS SQL database name where the reference table exists. Changing this forces a new resource to be created."<br/>  output\_password            = "(Optional) Password used together with username, to login to the Microsoft SQL Server. Required if authentication\_mode is ConnectionString."<br/>  output\_table               = "(Required) Table (name) in the database that the output points to. Changing this forces a new resource to be created."<br/>  output\_max\_batch\_count     = "(Optional) The max batch count to write to the SQL Database. Defaults to 10000. Possible values are between 1 and 1073741824."<br/>  output\_max\_writer\_count    = "(Optional) The max writer count for the SQL Database. Defaults to 1. Possible values are 0 which bases the writer count on the query partition and 1 which corresponds to a single writer."<br/>  output\_authentication\_mode = "(Optional) The authentication mode for the Stream Output. Possible values are Msi and ConnectionString. Defaults to ConnectionString."<br/>}) | <pre>map(object({<br/>    output_server              = string<br/>    output_user                = optional(string)<br/>    output_database            = string<br/>    output_password            = optional(string)<br/>    output_table               = string<br/>    output_max_batch_count     = optional(number, 10000)<br/>    output_max_writer_count    = optional(number, 1)<br/>    output_authentication_mode = optional(string, "ConnectionString")<br/>  }))</pre> | `{}` | no |
| <a name="input_streaming_capacity"></a> [streaming\_capacity](#input\_streaming\_capacity) | (Required) The number of streaming units supported by the Cluster. Accepted values are multiples of 36 in the range of 36 to 216 | `number` | n/a | yes |
| <a name="input_streaming_units"></a> [streaming\_units](#input\_streaming\_units) | (Optional) Specifies the number of streaming units that the streaming job uses. Supported values are 1, 3, 6 and multiples of 6 up to 120 | `number` | `3` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |
| <a name="input_transformation_query"></a> [transformation\_query](#input\_transformation\_query) | (Required) Specifies the query that will be run in the streaming job, written in Stream Analytics Query Language (SAQL). | `string` | n/a | yes |
| <a name="input_type"></a> [type](#input\_type) | (Required) The serialization format used for incoming data streams. Possible values are Avro, CSV and Json. | `string` | n/a | yes |
| <a name="input_uai_principal_id"></a> [uai\_principal\_id](#input\_uai\_principal\_id) | (Optional) Principal id of the User Assigned Identity. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_streamanalytics_cluster_id"></a> [streamanalytics\_cluster\_id](#output\_streamanalytics\_cluster\_id) | The resource ID of the stream analytics cluster. |
| <a name="output_streamanalytics_cluster_name"></a> [streamanalytics\_cluster\_name](#output\_streamanalytics\_cluster\_name) | The name of the stream analytics cluster. |
| <a name="output_streamanalytics_cluster_resource"></a> [streamanalytics\_cluster\_resource](#output\_streamanalytics\_cluster\_resource) | The stream analytics cluster resource. |
| <a name="output_streamanalytics_job_id"></a> [streamanalytics\_job\_id](#output\_streamanalytics\_job\_id) | The resource ID of the stream analytics job. |
| <a name="output_streamanalytics_job_name"></a> [streamanalytics\_job\_name](#output\_streamanalytics\_job\_name) | The name of the stream analytics job. |
| <a name="output_streamanalytics_job_resource"></a> [streamanalytics\_job\_resource](#output\_streamanalytics\_job\_resource) | The stream analytics job resource. |
| <a name="output_streamanalytics_jobschedule_id"></a> [streamanalytics\_jobschedule\_id](#output\_streamanalytics\_jobschedule\_id) | The resource ID of the stream analytics job. |
| <a name="output_streamanalytics_jobschedule_resource"></a> [streamanalytics\_jobschedule\_resource](#output\_streamanalytics\_jobschedule\_resource) | The stream analytics job resource. |
<!-- END_TF_DOCS -->
