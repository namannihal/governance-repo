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
# Azure Arc Hybrid Compute Machines module


## Overview

This terraform module creates an Azure Arc Hybrid Compute Machines and associated resources.

## Prerequisites

- Consider the following basic requirements when planning your deployment:
  - Your machines must run a supported `operating system` for the Connected Machine agent.
  - Your machines must have connectivity from your on-premises network or other cloud environment to resources in Azure, either directly or through a proxy server.
  - To install and configure the Azure Connected Machine agent, you must have an account with elevated privileges (i.e. administrator/root) over the Machine.

- Azure Arc-enabled servers support the installation of the Connected Machine agent on physical servers and virtual machines hosted outside of Azure. This includes support for virtual machines running on platforms like:
  - VMware (including Azure VMware Solution)
  - Azure Stack HCI
  - Other cloud environments

### IMPORTANT

1. This module is designed to onboard a single VM to Azure Arc and deploy the Arc service.
2. Due to Terraform limitations, this module cannot be fully automated. As noted in the Prerequisites, we require a machine outside of Azure, making complete testing impossible.
3. The primary purpose of this module was to enable ESU (Extended Security Updates) for Windows 2012 through Azure Arc, which requires onboarding Hybrid Machines to the Azure Arc service. So, if you have a Hybrid Machine that meets all prerequisites, this module can be used to onboard it to Azure Arc.
4. If you want to manage ARC, please reach out to cyber team and get the required approval to add your team to the below listed permissions:
   - Azure Connected Machine Onboarding - to onboard machines.
   - Azure Connected Machine Resource Administrator - to read, modify, and delete a machine.
   - Microsoft.HybridCompute / privateLinkScopes / read [Link](https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles#reader).
5. Please make sure the [prerequisites](https://learn.microsoft.com/en-us/azure/azure-arc/servers/prerequisites) are met first.
6. Since we don't have a Hybrid Machine to fully test this, the status of the deployed Azure VM will show "Not Connected". The only available check is the "Get-AzConnectedMachine" PowerShell command, so the test file has been left empty.

## Guidance

#### Usage

- `CloudMetadata`: This object doesn't contain any properties to set during deployment. All properties are `ReadOnly`.
- `automatic_upgrade_enabled` can only be set during creation. Any later change will be ignored.
- When `automatic_upgrade_enabled` is set to true, the `type_handler_version` is automatically updated by the Azure platform when a new version is available and any change in `type_handler_version` will be automatically ignored.
- When `automatic_upgrade_enabled` is set to `false` and no `type_handler_version` is specified, the type_handler_version change should be manually ignored by `ignore_changes` lifecycle block. This is because the `type_handler_version` is set by the `Azure platform` when the extension is created.
- When `automatic_upgrade_enabled` is set to `false` and `type_handler_version` is specified, the provider will check whether the version prefix is aligned with user input. For example, if user specifies 1.24 in type_handler_version, 1.24.1 will be considered as no diff.

#### Security Considerations

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-ARC-SC_010 | Credentials for other resources/systems must be stored in Azure Key Vault when Managed Identities cannot be used. | Credentials for other resources/systems must be stored in Azure Key Vault (What) via code deployment settings (How) in order to ensure the security of credentials (Why) | False | False | This control cannot be implemented with technical configuration setting and will be done with LSEG standards. |

## SMCF Controls

| S. No.  | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|---------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types.<br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc.<br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC<br><br>Documentation | False | This control can be implemented by the users by following the naming conventions of Azure ARC untill the Resource Naming module can be used.<br><br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames) |
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC<br><br>Policy | True | This control will be implemented using `tags` parameter.<br><br>This control is achieved by custom policy as described in the [clear listing page](https://dev.azure.com/LSEGroup/Foundation/_git/azu-plat-policy) from where it inherits all the mandatory tags. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties.<br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration. | Policies<br><br>Iac<br><br>Policies<br><br>Iac | True | This control will be implemented by having all the `Mandate` and most of the `Optional ` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring) | SMCF-OPS-03-02: Define and automate resource operation and security log collection<br><br>SMCF-OPS-03-03: Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs) | Policy<br><br>Documentation<br><br>Documentation | True | This control will be implemented by `DINE` Policy.<br><br>[Management and monitoring for Azure Arc-enabled servers](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/scenarios/hybrid/arc-enabled-servers/eslz-management-and-monitoring-arc-server)<br><br>[Monitor a hybrid machine with VM insights](https://learn.microsoft.com/en-us/azure/azure-arc/servers/learn/tutorial-enable-vm-insights)<br><br>[Cloud monitoring service level objectives](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/monitor/service-level-objectives)<br><br>[Data collected](https://learn.microsoft.com/en-us/azure/azure-monitor/agents/log-analytics-agent#data-collected) |
| 5. | [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC<br><br>Documentation | False | This control is not implemented because BCDR approach requires at least two Azure ARC resources in different regions. <br><br>[Reliability in a hybrid workload](https://learn.microsoft.com/en-us/azure/well-architected/hybrid/hybrid-reliability?bc=%2Fazure%2Fcloud-adoption-framework%2F_bread%2Ftoc.json&toc=%2Fazure%2Fcloud-adoption-framework%2Fscenarios%2Fhybrid%2Ftoc.json) |
| 6. | [SMCF-OPS-07: Resource Protection](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-07-01: Prevent accidental or malicious deletion of production resources<br><br>SMCF-OPS-07-02: Prevent accidental misconfiguration of key production resources | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard based on application team requirement. <br><br>[Lock your resources to protect your infrastructure](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json) |
| 7. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package and has a JIT implementation in place. <br><br>[Identity and access management for Azure Arc-enabled servers](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/scenarios/hybrid/arc-enabled-servers/eslz-identity-and-access-management) |
| 8. | [SMCF-OPS-09 Update Management](https://dev.azure.com/LSEG/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1408/SMCF-OPS-09-Update-Management) | SMCF-OPS-09-01 Assess cloud resources for missing updates | Documentation | False | This control will be implemented as per LSEG standard based on application Team requirement.<br><br>[Updates and Maintenance Overview](https://learn.microsoft.com/en-us/azure/automation/overview?bc=%2Fazure%2Fcloud-adoption-framework%2F_bread%2Ftoc.json&toc=%2Fazure%2Fcloud-adoption-framework%2Fscenarios%2Fhybrid%2Ftoc.json#update-management) |
| 9. | [SMCF-OPS-10 License Management](https://dev.azure.com/LSEG/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1409/SMCF-OPS-10-License-Management) | SMCF-OPS-10-01 Ensure licensing terms and conditions are followed | Policy | False | Custom policy is in place to report on Hybrid Use Licence usage. |

## Changelog

- [azure-prdsvc-terraform-arcmachine](CHANGELOG.md)

## References

### Microsoft Docs

- [Azure Arc-enabled servers](https://learn.microsoft.com/en-us/azure/azure-arc/servers/)

### Terraform Docs

- No `azurerm` provider available for creating/adding the Arc Hybrid Compute Machines, hence, the deployment is done using `azapi` provider for the main product.
  [Microsoft.HybridCompute machines](https://learn.microsoft.com/en-us/azure/templates/microsoft.hybridcompute/machines?pivots=deployment-language-terraform)

- However, we have `azurerm` provider for the Extensions and the Private Link Scope of the same module:
  - [azurerm_arc_machine_extension](https://registry.terraform.io/providers/hashicorp/azurerm/3.112.0/docs/resources/arc_machine_extension)
  - [azurerm_arc_private_link_scope](https://registry.terraform.io/providers/hashicorp/azurerm/3.112.0/docs/resources/arc_private_link_scope)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.5.0 |
| <a name="requirement_azapi"></a> [azapi](#requirement_azapi) | >= 1.9 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm) | >=4.33 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azapi"></a> [azapi](#provider_azapi) | >= 1.9 |
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) | >=4.33 |

## Resources

| Name | Type |
|------|------|
| [azapi_resource.this](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) | resource |
| [azurerm_arc_machine_extension.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/arc_machine_extension) | resource |
| [azurerm_arc_private_link_scope.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/arc_private_link_scope) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_agentUpgrade"></a> [agentUpgrade](#input_agentUpgrade) | (Optional) The info of the machine w.r.t Agent Upgrade:<br/>object({<br/>    correlationId          = "(Optional) The correlation ID passed in from RSM per upgrade."<br/>    desiredVersion         = "(Optional) Specifies the version info w.r.t AgentUpgrade for the machine."<br/>    enableAutomaticUpgrade = "(Optional) Specifies if RSM should try to upgrade this machine."<br/>  }) | <pre>object({<br/>    correlationId          = optional(string, null)<br/>    desiredVersion         = optional(string, null)<br/>    enableAutomaticUpgrade = optional(bool, false)<br/>  })</pre> | `{}` | no |
| <a name="input_arc_machine_extensions"></a> [arc_machine_extensions](#input_arc_machine_extensions) | (Optional) A Hybrid Compute Machine Extension block as defined below<br/>map(object({<br/>  name                      = "(Required) The name which should be used for this Hybrid Compute Machine Extension. Changing this forces a new Hybrid Compute Machine Extension to be created."<br/>  publisher                 = "(Required) The name of the extension handler publisher, such as `Microsoft.Azure.Monitor`. Changing this forces a new Hybrid Compute Machine Extension to be created."<br/>  type                      = "(Required) Specifies the type of the extension. For example CustomScriptExtension or AzureMonitorLinuxAgent. Changing this forces a new Hybrid Compute Machine Extension to be created."<br/>  automatic_upgrade_enabled = "(Optional) Indicates whether the extension should be automatically upgraded by the platform if there is a newer version available. Supported values are true and false. Defaults to true."<br/>  force_update_tag          = "(Optional) How the extension handler should be forced to update even if the extension configuration has not changed."<br/>  protected_settings        = "(Optional) The protected_settings passed to the extension, like settings, these are specified as a JSON object in a string."<br/>  settings                  = "(Optional) The settings passed to the extension, these are specified as a JSON object in a string."<br/>  type_handler_version      = "(Optional) Specifies the version of the extension to use, available versions can be found using the Azure CLI."<br/>})) | <pre>map(object({<br/>    name                      = string<br/>    publisher                 = string<br/>    type                      = string<br/>    automatic_upgrade_enabled = optional(bool, false)<br/>    force_update_tag          = optional(string, null)<br/>    protected_settings        = optional(string, null)<br/>    settings                  = optional(string, null)<br/>    type_handler_version      = optional(string)<br/>  }))</pre> | `null` | no |
| <a name="input_arc_private_link_scope"></a> [arc_private_link_scope](#input_arc_private_link_scope) | (Optional) Azure Arc Private Link Scope configuration:<br/>object({<br/>  arc_private_link_scope_name   = "(Required) The name which should be used for the Azure Arc Private Link Scope. Changing this forces a new Azure Arc Private Link Scope to be created."<br/>  public_network_access_enabled = "(Optional) Indicates whether machines associated with the private link scope can also use public Azure Arc service endpoints. Possible values are `true` and `false`. Defaults to `false`."<br/>  }) | <pre>object({<br/>    arc_private_link_scope_name   = string<br/>    public_network_access_enabled = optional(bool, false)<br/>  })</pre> | `null` | no |
| <a name="input_clientPublicKey"></a> [clientPublicKey](#input_clientPublicKey) | (Optional) Public Key that the client provides to be used during initial resource onboarding. | `string` | `null` | no |
| <a name="input_identity"></a> [identity](#input_identity) | (Optional) An identity block as defined below<br/>object({<br/>  type         = "(Required) Type of managed service identity (where both SystemAssigned and UserAssigned types are allowed)."<br/>  identity_ids = "(Optional) The set of user assigned identities associated with the resource."<br/>}) | <pre>object({<br/>    type         = string<br/>    identity_ids = list(string)<br/>  })</pre> | <pre>{<br/>  "identity_ids": null,<br/>  "type": "SystemAssigned"<br/>}</pre> | no |
| <a name="input_kind"></a> [kind](#input_kind) | (Optional) Indicates which kind of Arc machine placement on-premises, values accepted `AVS`, `AWS`, `EPS`, `GCP`, `HCI`, `SCVMM`, `VMware`. | `string` | `null` | no |
| <a name="input_licenseProfile"></a> [licenseProfile](#input_licenseProfile) | (Optional) Specifies the License related properties for a machine:<br/>object({<br/>  esuProfile = (Optional) Properties for the Machine ESU profile:<br/>  object({<br/>    licenseAssignmentState = "(Optional) Describes the license assignment state. Possible values are `Assigned` or `NotAssigned`."<br/>    assignedLicense = The assigned license resource:<br/>    object({<br/>      geo-location = "(Required) The geo-location where the resource lives."<br/>      properties = (Required) Hybrid Compute License properties:<br/>      object({<br/>        licenseDetails = Describes the properties of a License:<br/>        object({<br/>          edition    = "(Optional) Describes the edition of the license. The values are either `Standard` or `Datacenter`."<br/>          processors = "(Optional) Describes the number of processors."<br/>          state      = "(Optional) Describes the state of the license. The values are either `Activated` or `Deactivated`."<br/>          target     = "(Optional) Describes the license target server. The values are either `Windows Server 2012 R2` or `Windows Server 2012`."<br/>          type       = "(Optional) Describes the license core type. The values are either `pCore` or `vCore`."<br/>        })<br/>        licenseType = "(Optional) The type of the license resource. Accepts `ESU`."<br/>        tenantId    = "(Optional)	Describes the tenant id."<br/>      })<br/>    })<br/>  })<br/>}) | <pre>object({<br/>    esuProfile = optional(object({<br/>      licenseAssignmentState = optional(string, "NotAssigned")<br/>      assignedLicense = optional(object({<br/>        geo-location = string<br/>        properties = object({<br/>          licenseDetails = optional(object({<br/>            edition    = optional(string, "Standard")<br/>            processors = optional(number)<br/>            state      = optional(string, "Deactivated")<br/>            target     = optional(string, "Windows Server 2012")<br/>            type       = optional(string, "vCore")<br/>          }))<br/>          tenantId = optional(string, null)<br/>        })<br/>      }))<br/>    }))<br/>  })</pre> | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_locationData"></a> [locationData](#input_locationData) | (Optional) Metadata pertaining to the geographic location of the resource:<br/>object({<br/>    city            = "(Optional) The city or locality where the resource is located."<br/>    countryOrRegion = "(Optional) The country or region where the resource is located."<br/>    district        = "(Optional) The district, state, or province where the resource is located."<br/>    can_name        = "(Required) A canonical name for the geographic or physical location. `Max length = 256`."<br/>  }) | <pre>object({<br/>    city            = optional(string)<br/>    countryOrRegion = optional(string)<br/>    district        = optional(string)<br/>    can_name        = string<br/>  })</pre> | `null` | no |
| <a name="input_mssqlDiscovered"></a> [mssqlDiscovered](#input_mssqlDiscovered) | (Optional) Specifies whether any MS SQL instance is discovered on the machine. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input_name) | (Required) The Name of the Azure Arc Hybrid Compute machines. | `string` | n/a | yes |
| <a name="input_osType"></a> [osType](#input_osType) | (Optional) The type of Operating System (windows/linux). | `string` | `null` | no |
| <a name="input_parentClusterResourceId"></a> [parentClusterResourceId](#input_parentClusterResourceId) | (Optional) The resource id of the parent cluster (Azure HCI) this machine is assigned to, if any. | `string` | `null` | no |
| <a name="input_parent_id"></a> [parent_id](#input_parent_id) | (Required) To deploy to a resource group, use the ID of that resource group. | `string` | n/a | yes |
| <a name="input_patchSettings_linux"></a> [patchSettings_linux](#input_patchSettings_linux) | (Optional) Specifies the linux configuration patch settings for update management.:<br/>object({<br/>  assessmentMode_linux = "(Optional) Specifies the assessment mode. The values can be `AutomaticByPlatform` or `ImageDefault`."<br/>  patchMode_linux      = "(Optional) Specifies the patch mode. The values can be among `AutomaticByOS`, `AutomaticByPlatform`, `ImageDefault`, and `Manual`."<br/>  }) | <pre>object({<br/>    assessmentMode_linux = optional(string, "AutomaticByPlatform")<br/>    patchMode_linux      = optional(string, "AutomaticByOS")<br/>  })</pre> | `null` | no |
| <a name="input_patchSettings_windows"></a> [patchSettings_windows](#input_patchSettings_windows) | (Optional) Specifies the linux configuration patch settings for update management.:<br/>object({<br/>  assessmentMode_windows = "(Optional) Specifies the assessment mode. The values can be `AutomaticByPlatform` or `ImageDefault`."<br/>  patchMode_windows      = "(Optional) Specifies the patch mode. The values can be among `AutomaticByOS`, `AutomaticByPlatform`, `ImageDefault`, and `Manual`."<br/>  }) | <pre>object({<br/>    assessmentMode_windows = optional(string, "AutomaticByPlatform")<br/>    patchMode_windows      = optional(string, "AutomaticByOS")<br/>  })</pre> | `null` | no |
| <a name="input_privateLinkScopeResourceId"></a> [privateLinkScopeResourceId](#input_privateLinkScopeResourceId) | (Optional) The resource id of the private link scope this machine is assigned to, if any. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_serviceStatus_extension"></a> [serviceStatus_extension](#input_serviceStatus_extension) | (Optional) The state of the extension service on the Arc-enabled machine:<br/>object({<br/>  startupType_ext = "(Optional) The behavior of the service when the Arc-enabled machine starts up."<br/>  status_ext      = "(Optional) The current status of the service."<br/>  }) | <pre>object({<br/>    startupType_ext = optional(string)<br/>    status_ext      = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_serviceStatus_guest"></a> [serviceStatus_guest](#input_serviceStatus_guest) | (Optional) The state of the guest configuration service on the Arc-enabled machine:<br/>object({<br/>  startupType_guest = "(Optional) The behavior of the service when the Arc-enabled machine starts up."<br/>  status_guest      = "(Optional) The current status of the service."<br/>  }) | <pre>object({<br/>    startupType_guest = optional(string)<br/>    status_guest      = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |
| <a name="input_vmId"></a> [vmId](#input_vmId) | (Required) Specifies the hybrid machine unique ID. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arc_machine_extension_resources"></a> [arc_machine_extension_resources](#output_arc_machine_extension_resources) | The Extensions added for the arc machine. |
| <a name="output_arc_private_link_scope_resources"></a> [arc_private_link_scope_resources](#output_arc_private_link_scope_resources) | The Private link scope for the Arc Machine. |
| <a name="output_id"></a> [id](#output_id) | The ID of the created arc machine. |
| <a name="output_name"></a> [name](#output_name) | The Name of the created arc machine. |
| <a name="output_resource"></a> [resource](#output_resource) | The Azure Arc Hybrid Compute Machine resource. |
<!-- END_TF_DOCS -->
