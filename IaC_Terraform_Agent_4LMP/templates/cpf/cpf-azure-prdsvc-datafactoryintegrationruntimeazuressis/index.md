---
version: 1.0.1
available_versions:
  - 1.0.1
  - 1.0.0
  - 0.1.0
---

<!-- BEGIN_TF_DOCS -->
# Azure Data Factory IntegrationRuntime SSIS module


## Overview

This terraform module creates a Azure Data Factory IntegrationRuntime SSIS.

It's a dedicated compute environment within Azure Data Factory (ADF) that enables execution of SQL Server Integration Services (SSIS) packages in the cloud.
Essentially, it's a managed cluster of Azure VMs tailored to run SSIS workloads using your familiar SSIS deployment models. It supports both the project deployment model (using SSISDB on Azure SQL or Managed Instance) and the package deployment model (using MSDB or file system storage).

## Prerequisites

This module requires the following pre-existing dependent Azure resources:

- Resource Group, Virtual Network (both modules to be called if not existing, if allowed by the deployment permissions).
- Subnet to be used by the Key Vault Private endpoint.
- Network Security Group to be associated with the Subnet.
- Route Table to be associated with the Subnet.
- Key Vault for resource Customer Managed Key encryption.
- Private Endpoint to create a private connection to the Key Vault.
- User Assigned Identity leveraged for both identity and Customer Managed Key encryption.
- Data factory module required to create the datafactory SSIS IR(<https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-datafactory>).

## Guidance

#### Usage

##### SQL Server Integration Services Integration Runtime (SSIS IR)

- This resource is dependent on an Azure Data Factory resource(<https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-datafactory>).
- The `express_vnet_integration` block in the SSIS Integration Runtime (IR) Terraform configuration is used to enable Express Virtual Network (VNet) Integration for the SSIS IR in Azure Data Factory. (<https://learn.microsoft.com/en-us/azure/data-factory/azure-ssis-integration-runtime-express-virtual-network-injection>)
- To enable `express virtual network` injection, the user creating Azure-SSIS IR must be granted the necessary RBAC permissions to join the virtual network/subnet. The following subnet delegation configuration is required:

```hcl
delegation = [
  {
    delegation_name         = "ssis-delegation"
    service_delegation_name = "Microsoft.Batch/batchAccounts"
    service_delegation_action = [
      "Microsoft.Network/virtualNetworks/subnets/action",
      "Microsoft.Network/virtualNetworks/subnets/join/action"
    ]
  }
]
```

```hcl
 express_vnet_integration = {
        subnet_id = module.azure_prdsvc_terraform_subnet_ssisir.id
      }
```

- It is expected for an Azure-SSIS Integration Runtime (IR) to be in a `Stopped` state after deployment to prevent unnecessary costs for idle computing resources. To run SSIS packages after the IR has been deployed, it must be manually started in the portal or Start and stop an Azure-SSIS integration runtime on a schedule(<https://learn.microsoft.com/en-us/azure/data-factory/how-to-schedule-azure-ssis-integration-runtime>).

#### Security Considerations

- This module doesn't deploy the required Private Endpoints to connect to the Data Factory instance. Please use `azure-prdsvc-terraform-privateendpoint` module to create the Private endpoint and see the appropriate settings in this article [Azure Private Link for Azure Data Factory](https://docs.microsoft.com/en-us/azure/data-factory/data-factory-private-link).private endpoint is required for ADF, but not for SSIS IR.

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-DF-SC_130 |  SQL Server Integration Services integration runtimes on Azure Data Factory should be joined to a virtual network | Azure Data Factory SSIS IR should use virtual network injection (What) in the code deployment parameters (How) to provide secure access to other Azure services and govern outbound requests with NSGs and UDRs (Why) | True | False | The control is implemented on `azurerm_data_factory_integration_runtime_azure_ssis` by adding the `express_vnet_integration` block. This Control is not tested using pester test case due to the limitation of Powershell. |
| 2. | AZU-DF-SC_140 |  Azure Data Factory must not allow creation of integration runtimes that are deployed into an Azure Managed Network | Azure Data Factory must not allow creation of runtimes within an Azure Managed Network (What) within the network configuration settings (How) to ensure pipelines are run on infrastructure that is owned and managed by LSEG to reduce the risk of data exfiltration (Why) | False | False | This control will be implemented by setting a policy as stated.

## Changelog

- [azure-prdsvc-terraform-datafactoryintegrationruntimeazuressis](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/data-factory/)

### Terraform Docs

- [azurerm_data_factory_integration_runtime_azure_ssis](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_integration_runtime_azure_ssis)

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
| [azurerm_data_factory_integration_runtime_azure_ssis.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_integration_runtime_azure_ssis) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_ssis_integration_runtime"></a> [ssis_integration_runtime](#input_ssis_integration_runtime) | (Optional) A map of SSIS Integration Runtime configurations, where the key is the runtime name and the value is the configuration object:<br/>  data_factory_id                  = "(Required) The ID of the Data Factory in which to create the Azure-SSIS Integration Runtime."<br/>  location                         = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."<br/>  node_size                        = "(Required) The size of the nodes on which the Azure-SSIS Integration Runtime runs. Valid values are: Standard_D2_v3, Standard_D4_v3, Standard_D8_v3, Standard_D16_v3, Standard_D32_v3, Standard_D64_v3, Standard_E2_v3, Standard_E4_v3, Standard_E8_v3, Standard_E16_v3, Standard_E32_v3, Standard_E64_v3, Standard_D1_v2, Standard_D2_v2, Standard_D3_v2, Standard_D4_v2, Standard_A4_v2 and Standard_A8_v2"<br/>  number_of_nodes                  = "(Optional) Number of nodes for the Azure-SSIS Integration Runtime. Max is 10. Defaults to 1."<br/>  credential_name                  = "(Optional) The name of a Data Factory Credential that the SSIS integration will use to access data sources.If credential_name is omitted, the integration runtime will use the Data Factory assigned identity."<br/>  max_parallel_executions_per_node = "(Optional) Defines the maximum parallel executions per node. Defaults to 1. Max is 1."<br/>  edition                          = "(Optional) The Azure-SSIS Integration Runtime edition. Valid values are Standard and Enterprise. Defaults to Standard."<br/>  license_type                     = "(Optional) The type of the license that is used. Valid values are LicenseIncluded and BasePrice. Defaults to LicenseIncluded."<br/><br/>  catalog_info = "(Optional) A catalog_info block for SSIS catalog configuration:<br/>    server_endpoint         = "(Required) The endpoint of an Azure SQL Server that will be used to host the SSIS catalog."<br/>    administrator_login     = "(Optional) Administrator login name for the SQL Server."<br/>    administrator_password  = "(Optional) Administrator login password for the SQL Server."<br/>    pricing_tier           = "(Optional)  Pricing tier for the database that will be created for the SSIS catalog. Valid values are: Basic, S0, S1, S2, S3, S4, S6, S7, S9, S12, P1, P2, P4, P6, P11, P15, GP_S_Gen5_1, GP_S_Gen5_2, GP_S_Gen5_4, GP_S_Gen5_6, GP_S_Gen5_8, GP_S_Gen5_10, GP_S_Gen5_12, GP_S_Gen5_14, GP_S_Gen5_16, GP_S_Gen5_18, GP_S_Gen5_20, GP_S_Gen5_24, GP_S_Gen5_32, GP_S_Gen5_40, GP_Gen5_2, GP_Gen5_4, GP_Gen5_6, GP_Gen5_8, GP_Gen5_10, GP_Gen5_12, GP_Gen5_14, GP_Gen5_16, GP_Gen5_18, GP_Gen5_20, GP_Gen5_24, GP_Gen5_32, GP_Gen5_40, GP_Gen5_80, BC_Gen5_2, BC_Gen5_4, BC_Gen5_6, BC_Gen5_8, BC_Gen5_10, BC_Gen5_12, BC_Gen5_14, BC_Gen5_16, BC_Gen5_18, BC_Gen5_20, BC_Gen5_24, BC_Gen5_32, BC_Gen5_40, BC_Gen5_80, HS_Gen5_2, HS_Gen5_4, HS_Gen5_6, HS_Gen5_8, HS_Gen5_10, HS_Gen5_12, HS_Gen5_14, HS_Gen5_16, HS_Gen5_18, HS_Gen5_20, HS_Gen5_24, HS_Gen5_32, HS_Gen5_40 and HS_Gen5_80. Mutually exclusive with elastic_pool_name."<br/>    elastic_pool_name      = "(Optional) The name of SQL elastic pool where the database will be created for the SSIS catalog. Mutually exclusive with pricing_tier."<br/>    dual_standby_pair_name = "(Optional) The dual standby Azure-SSIS Integration Runtime pair with SSISDB failover."<br/><br/>  copy_compute_scale = "(Optional) A copy_compute_scale block for Data Factory Integration Runtime:<br/>    data_integration_unit = "(Optional) Specifies the data integration unit number setting reserved for copy activity execution. Supported values are multiples of 4 in range 4-256."<br/>    time_to_live         = "(Optional) Specifies the time to live (in minutes) setting of integration runtime which will execute copy activity. Possible values are at least 5"<br/><br/>  custom_setup_script = "(Optional) A custom_setup_script block for Azure-SSIS Integration Runtime:<br/>    blob_container_uri = "(Required) The blob endpoint for the container which contains a custom setup script that will be run on every node on startup."<br/>    sas_token          = "(Required) A container SAS token that gives access to the files."<br/><br/>  express_vnet_integration = "(Required) An express_vnet_integration block for Azure-SSIS Integration Runtime:<br/>    subnet_id = "(Required) ID of the subnet to which the nodes of the Azure-SSIS Integration Runtime will be added."<br/><br/>  command_key = "(Optional) A list of command_key blocks for Azure-SSIS Integration Runtime:<br/>    target_name        = "(Required) The target computer or domain name."<br/>    user_name          = "(Required) The username for the target device."<br/>    password           = "(Optional) The password for the target device."<br/>    key_vault_password = "(Optional) A key_vault_secret_reference block with the following properties:<br/>      linked_service_name = "(Required) Specifies the name of an existing Key Vault Data Factory Linked Service."<br/>      secret_name         = "(Required) Specifies the secret name in Azure Key Vault."<br/>      secret_version      = "(Optional) Specifies the secret version in Azure Key Vault."<br/>      parameters          = "(Optional) A map of parameters to associate with the Key Vault Data Factory Linked Service."<br/><br/>  component = "(Optional) A list of component blocks for Azure-SSIS Integration Runtime:<br/>    name              = "(Required) The Component Name installed for the Azure-SSIS Integration Runtime."<br/>    license           = "(Optional) The license used for the Component."<br/>    key_vault_license = "(Optional) A key_vault_secret_reference block with the following properties:<br/>      linked_service_name = "(Required) Specifies the name of an existing Key Vault Data Factory Linked Service."<br/>      secret_name         = "(Required) Specifies the secret name in Azure Key Vault."<br/>      secret_version      = "(Optional) Specifies the secret version in Azure Key Vault."<br/>      parameters          = "(Optional) A map of parameters to associate with the Key Vault Data Factory Linked Service."<br/><br/>  package_store = "(Optional) A list of package_store blocks for Azure-SSIS Integration Runtime:<br/>    name                = "(Required) Name of the package store."<br/>    linked_service_name = "(Required) Name of the Linked Service to associate with the packages."<br/><br/>  proxy = "(Optional) A proxy block for Azure-SSIS Integration Runtime:<br/>    self_hosted_integration_runtime_name = "(Required) Name of Self Hosted Integration Runtime as a proxy."<br/>    staging_storage_linked_service_name  = "(Required) Name of Azure Blob Storage linked service to reference the staging data store to be used when moving data between self-hosted and Azure-SSIS integration runtimes."<br/>    path                                 = "(Optional) The path in the data store to be used when moving data between Self-Hosted and Azure-SSIS Integration Runtimes."<br/><br/>  pipeline_external_compute_scale = "(Optional) A pipeline_external_compute_scale block for Azure-SSIS Integration Runtime:<br/>    number_of_external_nodes = "(Optional) Specifies the number of the external nodes, which should be greater than 0 and less than 11."<br/>    number_of_pipeline_nodes = "(Optional) Specifies the number of the pipeline nodes, which should be greater than 0 and less than 11."<br/>    time_to_live             = "(Optional) Specifies the time to live (in minutes) setting of integration runtime which will execute copy activity. Possible values are at least 5."<br/>  <br/>  express_custom_setup = "(Optional) An express_custom_setup block for Azure-SSIS Integration Runtime:<br/>    command_key = "(Optional) A list of command_key blocks with the following properties:<br/>      target_name        = "(Required) The target computer or domain name."<br/>      user_name          = "(Required) The username for the target device."<br/>      password           = "(Optional) The password for the target device."<br/>      key_vault_password = "(Optional) A key_vault_secret_reference block with the following properties:<br/>        linked_service_name = "(Required) Specifies the name of an existing Key Vault Data Factory Linked Service."<br/>        secret_name         = "(Required) Specifies the secret name in Azure Key Vault."<br/>        secret_version      = "(Optional) Specifies the secret version in Azure Key Vault."<br/>        parameters          = "(Optional) A map of parameters to associate with the Key Vault Data Factory Linked Service."<br/>  <br/>    component = "(Optional) A list of component blocks with the following properties:<br/>      name              = "(Required) The Component Name installed for the Azure-SSIS Integration Runtime."<br/>      license           = "(Optional) The license used for the Component."<br/>      key_vault_license = "(Optional) A key_vault_secret_reference block with the following properties:<br/>        linked_service_name = "(Required) Specifies the name of an existing Key Vault Data Factory Linked Service."<br/>        secret_name         = "(Required) Specifies the secret name in Azure Key Vault."<br/>        secret_version      = "(Optional) Specifies the secret version in Azure Key Vault."<br/>        parameters          = "(Optional) A map of parameters to associate with the Key Vault Data Factory Linked Service."<br/>  <br/>    environment       = "(Optional) The Environment Variables for the Azure-SSIS Integration Runtime."<br/>    powershell_version = "(Optional) The version of Azure Powershell installed for the Azure-SSIS Integration Runtime." | <pre>map(object({<br/>    data_factory_id                  = string<br/>    location                         = string<br/>    node_size                        = string<br/>    number_of_nodes                  = optional(number, 1)<br/>    credential_name                  = optional(string, null)<br/>    max_parallel_executions_per_node = optional(number, 1)<br/>    edition                          = optional(string, "Standard")<br/>    license_type                     = optional(string, "LicenseIncluded")<br/>    catalog_info = optional(object({<br/>      server_endpoint        = string<br/>      administrator_login    = optional(string, null)<br/>      administrator_password = optional(string, null)<br/>      pricing_tier           = optional(string, null)<br/>      elastic_pool_name      = optional(string, null)<br/>      dual_standby_pair_name = optional(string, null)<br/>    }), null)<br/>    copy_compute_scale = optional(object({<br/>      data_integration_unit = optional(number, null)<br/>      time_to_live          = optional(number, null)<br/>    }), null)<br/>    custom_setup_script = optional(object({<br/>      blob_container_uri = string<br/>      sas_token          = string<br/>    }), null)<br/>    express_vnet_integration = object({<br/>      subnet_id = string<br/>    })<br/>    command_key = optional(list(object({<br/>      target_name = string<br/>      user_name   = string<br/>      password    = optional(string, null)<br/>      key_vault_password = optional(object({<br/>        linked_service_name = string<br/>        secret_name         = string<br/>        secret_version      = optional(string, null)<br/>        parameters          = optional(map(string), {})<br/>      }), null)<br/>    })), [])<br/>    component = optional(list(object({<br/>      name    = string<br/>      license = optional(string, null)<br/>      key_vault_license = optional(object({<br/>        linked_service_name = string<br/>        secret_name         = string<br/>        secret_version      = optional(string, null)<br/>        parameters          = optional(map(string), {})<br/>      }), null)<br/>    })), [])<br/>    package_store = optional(list(object({<br/>      name                = string<br/>      linked_service_name = string<br/>    })), [])<br/>    proxy = optional(object({<br/>      self_hosted_integration_runtime_name = string<br/>      staging_storage_linked_service_name  = string<br/>      path                                 = optional(string, null)<br/>    }), null)<br/>    pipeline_external_compute_scale = optional(object({<br/>      number_of_external_nodes = optional(number, null)<br/>      number_of_pipeline_nodes = optional(number, null)<br/>      time_to_live             = optional(number, null)<br/>    }), null)<br/>    express_custom_setup = optional(object({<br/>      command_key = optional(list(object({<br/>        target_name = string<br/>        user_name   = string<br/>        password    = optional(string, null)<br/>        key_vault_password = optional(object({<br/>          linked_service_name = string<br/>          secret_name         = string<br/>          secret_version      = optional(string, null)<br/>          parameters          = optional(map(string), {})<br/>        }), null)<br/>      })), [])<br/>      component = optional(list(object({<br/>        name    = string<br/>        license = optional(string, null)<br/>        key_vault_license = optional(object({<br/>          linked_service_name = string<br/>          secret_name         = string<br/>          secret_version      = optional(string, null)<br/>          parameters          = optional(map(string), {})<br/>        }), null)<br/>      })), [])<br/>      environment        = optional(map(string), {})<br/>      powershell_version = optional(string, null)<br/>    }), null)<br/>  }))</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | Map of Azure-SSIS Integration Runtime IDs |
| <a name="output_name"></a> [name](#output_name) | Map of Azure-SSIS Integration Runtime names |
| <a name="output_resource"></a> [resource](#output_resource) | Map of Azure-SSIS Integration Runtime resources |
<!-- END_TF_DOCS -->
