---
version: 1.2.1
available_versions:
  - 1.2.1
  - 1.2.0
  - 1.1.0
  - 1.0.4
  - 1.0.3
---

<!-- BEGIN_TF_DOCS -->
# Container App Environment module


## Overview

This terraform module creates a Container App Environment and it's associated resources such as:

- container app environment certificate
- container app environment dapr component
- container app environment storage

This module also provides the capability of deploying multiple workload profiles with different types.

## Prerequisites

- `Resource Group`
- `Network Security Group`
- `Subnet`
- `Key Vault`
- `Private Endpoint` for Key Vault
- `Key Vault Secret`
- `User Assigned Identity`
- `Storage Account`
- `Private Endpoint` for Storage Account
- `Storage Share`

## Guidance

#### Usage

AzureRM 4.x Upgrade Notes for Container App Environment

Impact analysis -- Medium

Users migrating from azurerm 3.x to 4.x need to perform the following changes:

- Added `infrastructure_resource_group_name` optional variable support to main resource configuration
- Added `logs_destination` optional variable support for flexible logging destination configuration  
- Added `log_analytics_workspace_id` optional variable support for workspace linking

Wiki link for [AzureRM 4.x Upgrade](https://gitlab.dx1.lseg.com/groups/app/app-51310/azure/prdsvc/terraform/-/wikis/Terraform-AzureRM-Provider-Upgrade:-Version-3.x-to-4.x/Container-App-Environment) for details on the upgrade process.

For more details, refer to the official [AzureRM 4.x Upgrade Guide](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/4.0-upgrade-guide)

- As per terraform registry, the argument infrastructure_subnet_id is given as optional for resource type "azurerm_container_app_environment". During terraform run time, it's been populated to have the infrastructure_subnet_id as mandatory. Without which terraform deployment fails, hence parameterised as a required user input variable.

- Following up the latest security norms, inbound traffic across container app with in the container environment is limited to Vnet. Hence, apps cannot be exposed to public internet. Therefore the above mentioned point referring to infrastructure_subnet_id stays mandatory. This configuration is accomplished in conjunction with 'internal ingress'.

- Container apps environment offers two types:

  - Workload profile
  - Consumption only

- Workload profile: Run serverless apps with support for scale-to-zero and pay only for resources your apps use with the consumption profile. You can also run apps with customized hardware and increased cost predictability using dedicated workload profiles.

Workload profile offers different types:

- Consumption
- D4
- D8
- D16
- D32
- E4
- E8
- E16
- E32

- Please be noted workload profile offering Consumption type must have a name of Consumption and an environment may only have one Consumption Workload Profile.

### Workload Profiles Usage Guide

#### Without Premium Ingress (Standard Setup)

Define your application workload profiles using the `workload_profile` variable. The `Consumption` profile is always included automatically.

```hcl
module "containerappenvironment" {
  source = "path/to/module"
  # ... other required variables ...

  workload_profile = {
    "app-profile" = {
      name                  = "app-profile"
      workload_profile_type = "D4"
      maximum_count         = 5
      minimum_count         = 1
    }
  }
}
```

#### With Premium Ingress

Premium Ingress requires a **dedicated workload profile** exclusively for the ingress proxy. This profile must **not** be shared with container apps or jobs.

Define your app profiles in `workload_profile` and the ingress profile in `premium_ingress_configuration`:

```hcl
module "containerappenvironment" {
  source = "path/to/module"
  # ... other required variables ...

  workload_profile = {
    "app-profile" = {
      name                  = "app-profile"
      workload_profile_type = "D4"
      maximum_count         = 5
      minimum_count         = 1
    }
  }

  premium_ingress_configuration = {
    workload_profile = {
      name                  = "ingress-profile"
      workload_profile_type = "D4"
      maximum_count         = 5
      minimum_count         = 2   # Must be at least 2
    }
    request_idle_timeout             = 10   # Optional, 4-30 minutes, default 4
    header_count_limit               = 100  # Optional, default 100
    termination_grace_period_seconds = 480  # Optional, 0-3600, default 480
  }
}
```

> **Important Notes:**
> - The ingress workload profile is automatically registered on the environment. Do **not** add it to the `workload_profile` variable.
> - The ingress profile `minimum_count` must be at least **2**. Azure will reject the configuration otherwise.
> - Recommended workload profile types for ingress: **D4, D8, D16, D32**. Each ingress proxy instance uses 1 vCPU core.

- Consumption only: Run serverless apps with support for scale-to-zero and pay only for resources your apps use.

- Container app environment network selection depends upon the environment type. The minimum subnet size for workload profile should be /27 and subnet must be delegated to Microsoft.App/environments. Similarly, the minimum subnet size for consumption only should be /23. Please refer the subnet section for more details. https://learn.microsoft.com/en-us/azure/container-apps/networking?tabs=consumption-only-env%2Cazure-cli

- In order to have custom DNS server integrated with Vnet and to be functional with container app environment. Please refer the below link particularly at DNS section.
https://learn.microsoft.com/en-us/azure/container-apps/networking?tabs=workload-profiles-env%2Cazure-cli

- In our test main.tf file, we are not passing any value for DNS server and hence default Azure provided DNS server is configured.

- To enable peer-to-peer encryption, it is essential to create a log analytics workspace.

### Additional Information

- The repo variable `PESTER_IMAGE_POST_DEPLOYMENT` is used to refer to the latest pester image during post deployment stage, in order to install the `Az.App` package in line 74 of pipeline.yml file. Please approach the DX1 maintainers to set this up before running the validation pipeline.

- CPD product enables Azure Monitor, after which Azure Policy will add diagnostic settings to the Log Analytics workspace. For existing products, users should manually remediate.

### Others

#### Well-Architected Framework(WAF) for containerregistry

- Wiki link [WAF for containerregistry](https://gitlab.dx1.lseg.com/groups/app/app-51310/azure/prdsvc/terraform/-/wikis/Cloud-Products-Well-Architecture-Framework-Principles---WAF/Container-App-Environment) for details on the WAF principles (Resiliency and Disaster Recovery(DR), Security, Cost Optimization and Operation Excellence).

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-ACA-AC_030 | Enforce internal-only ingress | Container Apps must enforce internal-only ingress (What) within the Deployment settings (How) in order to ensure inbound communication for Container Apps is limited to callers within the Container App environment. (Why) | True| True | Implemented the argument "internal_load_balancer_enabled = true" in the resource block of azurerm_container_app_environment. |

## Changelog

- [azure-prdsvc-terraform-containerappenvironment](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/container-apps/environment)

### Terraform Docs

- [azurerm_container_app_environment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_app_environment)
- [azurerm_container_app_environment_certificate](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_app_environment_certificate)
- [azurerm_container_app_environment_dapr_component](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_app_environment_dapr_component)
- [azurerm_container_app_environment_storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_app_environment_storage)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.5.0 |
| <a name="requirement_azapi"></a> [azapi](#requirement_azapi) | >=1.9 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm) | >=4.33 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azapi"></a> [azapi](#provider_azapi) | >=1.9 |
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) | >=4.33 |
| <a name="provider_time"></a> [time](#provider_time) | n/a |

## Resources

| Name | Type |
|------|------|
| [azapi_update_resource.premium_ingress](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/update_resource) | resource |
| [azurerm_container_app_environment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_app_environment) | resource |
| [azurerm_container_app_environment_certificate.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_app_environment_certificate) | resource |
| [azurerm_container_app_environment_dapr_component.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_app_environment_dapr_component) | resource |
| [azurerm_container_app_environment_storage.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_app_environment_storage) | resource |
| [time_sleep.wait_for_cae](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_dapr_component"></a> [dapr_component](#input_dapr_component) | (Optional)<br/>map(object({<br/>  name          = (Required) The name for this Dapr component. Changing this forces a new resource to be created.<br/>  type          = (Required) The Dapr Component Type. For example state.azure.blobstorage. Changing this forces a new resource to be created.<br/>  version       = (Required) The version of the component.<br/>  ignore_errors = (Optional) Should the Dapr sidecar to continue initialisation if the component fails to load. Defaults to false<br/>  init_timeout  = (Optional) The timeout for component initialisation as a ISO8601 formatted string. e.g. 5s, 2h, 1m. Defaults to 5s<br/>  scopes        = (Optional) A list of scopes to which this component applies<br/>  metadata      = (Optional) One or more metadata blocks as detailed below.<br/>  map(object({<br/>    name        = (Required) The name of the Metadata configuration item.<br/>    secret_name = (Optional) The name of a secret specified in the secrets block that contains the value for this metadata configuration item.<br/>    value       = (Optional) The value for this metadata configuration item.<br/>  }))<br/>  secret        = (Optional) A secret block as detailed below.<br/>  map(object({<br/>    name  = (Required) The Secret name.<br/>    value = (Required) The value for this secret.<br/>  }))<br/>})) | <pre>map(object({<br/>    name          = string<br/>    type          = string<br/>    version       = string<br/>    ignore_errors = optional(bool, false)<br/>    init_timeout  = optional(string)<br/>    scopes        = optional(list(string))<br/>    metadata = optional(map(object({<br/>      name        = string<br/>      secret_name = optional(string)<br/>      value       = optional(string)<br/>    })))<br/>    secret = optional(map(object({<br/>      name  = string<br/>      value = string<br/>    })))<br/>  }))</pre> | `null` | no |
| <a name="input_dapr_connectionstring"></a> [dapr_connectionstring](#input_dapr_connectionstring) | (Optional) Application Insights connection string used by Dapr to export Service to Service communication telemetry. | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_environment_certificate"></a> [environment_certificate](#input_environment_certificate) | (Optional)<br/>map(object({<br/>  name                    = "(Required) The name of the Container Apps Environment Certificate. Changing this forces a new resource to be created."<br/>  certificate_blob_base64 = "(Optional) The Certificate Private Key as a base64 encoded PFX or PEM. Changing this forces a new resource to be created. One of certificate_blob_base64 and certificate_key_vault must be set."<br/>  certificate_password    = "(Optional) The password for the Certificate. Changing this forces a new resource to be created. Required if certificate_blob_base64 is specified."<br/>  certificate_key_vault   = "(Optional) A certificate_key_vault block. One of certificate_blob_base64 and certificate_key_vault must be set."<br/>  object({<br/>    identity            = "(Optional) The managed identity to authenticate with Azure Key Vault. Possible values are the resource ID of user-assigned identity, and System for system-assigned identity. Defaults to System."<br/>    key_vault_secret_id = "(Required) The ID of the Key Vault Secret containing the certificate."<br/>  })<br/>  tags                    = "(Optional) A mapping of tags to assign to the resource."<br/>})) | <pre>map(object({<br/>    name                    = string<br/>    certificate_blob_base64 = optional(string)<br/>    certificate_password    = optional(string)<br/>    certificate_key_vault = optional(object({<br/>      identity            = optional(string, "System")<br/>      key_vault_secret_id = string<br/>    }))<br/>    tags = optional(map(string))<br/>  }))</pre> | `null` | no |
| <a name="input_environment_storage"></a> [environment_storage](#input_environment_storage) | (Optional)<br/>map(object({<br/>  name         = (Required) The name for this Container App Environment Storage. Changing this forces a new resource to be created.<br/>  account_name = (Required) The Azure Storage Account in which the Share to be used is located. Changing this forces a new resource to be created.<br/>  access_key   = (Required) The Storage Account Access Key.<br/>  share_name   = (Required) The name of the Azure Storage Share to use. Changing this forces a new resource to be created.<br/>  access_mode  = (Required) The access mode to connect this storage to the Container App. Possible values include ReadOnly and ReadWrite. Changing this forces a new resource to be created.<br/>})) | <pre>map(object({<br/>    name         = string<br/>    account_name = string<br/>    access_key   = string<br/>    share_name   = string<br/>    access_mode  = string<br/>  }))</pre> | `null` | no |
| <a name="input_infrastructure_resource_group_name"></a> [infrastructure_resource_group_name](#input_infrastructure_resource_group_name) | (Optional) Name of the platform-managed resource group created for the Managed Environment to host infrastructure resources. Changing this forces a new resource to be created. Only valid if a workload_profile is specified. If infrastructure_subnet_id is specified, this resource group will be created in the same subscription as infrastructure_subnet_id | `string` | `null` | no |
| <a name="input_infrastructure_subnet_id"></a> [infrastructure_subnet_id](#input_infrastructure_subnet_id) | (Required) The existing Subnet to use for the Container Apps Control Plane. Changing this forces a new resource to be created. The Subnet must have a /21 or larger address space. | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_id"></a> [log_analytics_workspace_id](#input_log_analytics_workspace_id) | (Optional) The ID for the Log Analytics Workspace to link this Container Apps Managed Environment to. Required if logs_destination is set to log-analytics. Cannot be set if logs_destination is set to azure-monitor. | `string` | `null` | no |
| <a name="input_logs_destination"></a> [logs_destination](#input_logs_destination) | (Optional) Where the application logs will be saved for this Container Apps Managed Environment. Possible values include log-analytics and azure-monitor. Omitting this value will result in logs being streamed only. | `string` | `"azure-monitor"` | no |
| <a name="input_mutual_tls_enabled"></a> [mutual_tls_enabled](#input_mutual_tls_enabled) | (Optional) Should mutual transport layer security (mTLS) be enabled. Enabling mTLS for your applications may increase response latency and reduce maximum throughput in high-load scenarios. | `bool` | `true` | no |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_premium_ingress_configuration"></a> [premium_ingress_configuration](#input_premium_ingress_configuration) | (Optional) Premium Ingress configuration for the Managed Environment. Enables dedicated workload profile support for the ingress component and allows increasing the idle timeout.<br/>NOTE:<br/>  - The workload profile for Premium Ingress is defined within this variable and is automatically registered on the environment. Users do NOT need to add it separately to the 'workload_profile' variable.<br/>  - The ingress workload profile must NOT be shared with container apps or jobs. It is exclusively used by the ingress proxy.<br/>  - The workload profile must have a minimum_count of at least 2. Azure will reject the configuration otherwise.<br/>  - D4-D32 workload profile types are recommended. Each ingress proxy instance is allocated 1 vCPU core.<br/>object({<br/>  workload_profile = (Required) The dedicated workload profile configuration for the ingress component. Must not be shared with container apps or jobs.<br/>  object({<br/>    name                  = (Required) Name of the workload profile used by the ingress component. Must be unique and not overlap with app workload profiles.<br/>    workload_profile_type = (Required) Workload profile type. Recommended values: D4, D8, D16, D32. Possible values also include E4, E8, E16 and E32.<br/>    maximum_count         = (Required) The maximum number of instances.<br/>    minimum_count         = (Required) The minimum number of instances. Must be at least 2.<br/>  })<br/>  request_idle_timeout             = (Optional) Duration (in minutes) before idle requests are timed out. Must be between 4 and 30 inclusive. Defaults to 4 minutes.<br/>  header_count_limit               = (Optional) Maximum number of headers per request allowed by the ingress. Must be at least 1. Defaults to 100.<br/>  termination_grace_period_seconds = (Optional) Time (in seconds) to allow active connections to complete on termination. Must be between 0 and 3600. Defaults to 480 seconds.<br/>}) | <pre>object({<br/>    workload_profile = object({<br/>      name                  = string<br/>      workload_profile_type = string<br/>      maximum_count         = number<br/>      minimum_count         = number<br/>    })<br/>    request_idle_timeout             = optional(number, 4)<br/>    header_count_limit               = optional(number, 100)<br/>    termination_grace_period_seconds = optional(number, 480)<br/>  })</pre> | `null` | no |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |
| <a name="input_workload_profile"></a> [workload_profile](#input_workload_profile) | (Optional)<br/>map(object({<br/>  name                  = (Required) The name of the workload profile.<br/>  workload_profile_type = (Required) Workload profile type for the workloads to run on. Possible values include Consumption, D4, D8, D16, D32, E4, E8, E16 and E32. A Consumption type must have a name of Consumption and an environment may only have one Consumption Workload Profile.<br/>  maximum_count         = (Required) The maximum number of instances of workload profile that can be deployed in the Container App Environment.<br/>  minimum_count         = (Required) The minimum number of instances of workload profile that can be deployed in the Container App Environment.<br/>})) | <pre>map(object({<br/>    name                  = string<br/>    workload_profile_type = string<br/>    maximum_count         = number<br/>    minimum_count         = number<br/>  }))</pre> | `null` | no |
| <a name="input_zone_redundancy_enabled"></a> [zone_redundancy_enabled](#input_zone_redundancy_enabled) | (Optional) Should the Container App Environment be created with Zone Redundancy enabled? Defaults to false. Changing this forces a new resource to be created. Can only be set to true if infrastructure_subnet_id is specified. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_env_certificate_resource"></a> [env_certificate_resource](#output_env_certificate_resource) | The Container App Environment Certificate resource. |
| <a name="output_env_daprcomponent_resource"></a> [env_daprcomponent_resource](#output_env_daprcomponent_resource) | The Container App Environment Dapr Component resource. |
| <a name="output_env_storage_resource"></a> [env_storage_resource](#output_env_storage_resource) | The Container App Environment Storage resource. |
| <a name="output_id"></a> [id](#output_id) | The ID of the Container App Environment. |
| <a name="output_name"></a> [name](#output_name) | The name of the Container App Environment. |
| <a name="output_resource"></a> [resource](#output_resource) | The Container App Environment resource. |
| <a name="output_workload_profile"></a> [workload_profile](#output_workload_profile) | The name of the Workload Profile. |
<!-- END_TF_DOCS -->
