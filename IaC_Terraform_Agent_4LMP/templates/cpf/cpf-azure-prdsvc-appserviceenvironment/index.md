---
version: 1.0.2
available_versions:
  - 1.0.2
  - 1.0.1
  - 1.0.0
  - 0.3.4
  - 0.3.3
---

<!-- BEGIN_TF_DOCS -->
# App Service Environment (ASE) module

## Overview

- This terraform module creates an [App Service Environment](https://docs.microsoft.com/en-us/azure/app-service/environment/overview) [**Version 3**](https://docs.microsoft.com/en-us/azure/app-service/environment/overview#feature-differences) and its associated resources.

## Prerequisites

A delegated `Subnet` is  required in already existing `virtual network` for ASE.

## Guidance

#### Usage

- **App Service Environment v3** is deployed **into a single subnet** in a VNet:
  - The subnet needs to be empty and cannot be used for anything else,
  - The subnet's recommended size is `/24` with 256 addresses or larger CIDR,
  - The subnet cannot be of size `/29` or below,
  - Once the subnet is associated with an ASE, its size cannot be changed,
  - The **subnet's region sets the region the ASE v3** is deployed into,
  - The subnet requires a delegation to `Microsoft.Web/hostingEnvironments`.

- `internal_load_balancing_mode` has been hardcoded to `"Web, Publishing"` for Internal Virtual IP,
- The underlying API does not currently support changing Tags on this resource. Making changes in the portal for tags will cause Terraform to detect a change that will force a recreation of the `ASE V3` that's why ignore_changes lifecycle meta-argument has been used to prevent that.
- Setting `Zone_redundant` value will provision 2 Physical Hosts for the App Service Environment v3, this is done at additional cost, please be aware of the [pricing commitment](https://techcommunity.microsoft.com/t5/apps-on-azure/announcing-app-service-environment-v3-ga/ba-p/2517990).
- Availability zone support is described here per [regions](https://docs.microsoft.com/en-us/azure/app-service/environment/overview#regions):
  - Zone Redundant ASEv3 is **available** in `West Europe` and `North Europe`=> `zone_redundant` = `true` OR `false`.
- You can only set either `dedicated_host_count` or `zone_redundant` but not both.
- The underlying API does not currently support changing `Tags` on this resource. Making changes in the portal for tags will cause Terraform to detect a change that will force a recreation of the ASEV3 unless `ignore_changes` lifecycle meta-argument is used.
- To enable InternalEncryption, another `cluster_setting` needs to be added as below:
    cluster_setting {
    name  = "InternalEncryption"
    value = true
  }
  By default, if not specified, it's disabled. Also, the name and value should exactly be the same as mentioned above otherwise it throws an error as Invalid value.

#### Security Considerations

- The network security configuration needs to allow access from the App Service Environment management addresses on ports `454` and `455`. If you block access from those addresses, your App Service Environment will become unhealthy and then become suspended. The TCP traffic that comes in on ports `454` and `455` must go back out from the same VIP, or you will have an asymmetric routing problem.

#### Additional Information

- Sometimes, ASE takes more than 4 hours to deploy, in such cases, make sure to increase Project Timeout and vault secret expiration time to at least 5-6 hours.

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-ASE-IA_020 | Use a Managed Identity for accessing Azure Resources | App Service Environment must enforce the use of a Managed Identity to authenticate to Azure resources where this is supported (What) within targets access control settings (How) in order to remove the need to store credentials (Why) | False | False | Adding identity is not supported in terraform resource for App Service Env v3. |
| 2. | AZU-ASE-AC_010 | Disable Public Network Access | App Service Environment must enforce a network guardrail (What) within code deployment parameters (How) in order to prevent unauthorised access and data exposure to the internet (Why) | True | True | `internal_load_balancing_mode = "Web, Publishing"` is hardcoded in the module. This setting allows the app service environment to be deployed with an Internal Virtual IP address. Therefore, the inbound address for all the apps will be an address in the App Service Environment subnet, which will not be the internet-addressable address and apps will not be in a public Domain Name System. |
| 3. | AZU-ASE-AU_010 | Send all diagnostic log categories to a central SOC Log Analytics workspace | App Service Environment must send all diagnostic logs to a central SOC Log Analytics workspace (What) within Diagnostic settings (How) in order to support a security investigation after a security incident (Why) | False | False | To be implemented via policy. |
| 4. | AZU-ASE-AU_020 | Send all diagnostic log categories to a central SOC Storage Account | App Service Environment must send all diagnostic logs to a central SOC Storage Account (What) within Diagnostic settings (How) In order to provide an immutable copy to adhere to compliance requirements (Why) | False | False | To be implemented via policy. |
| 5. | AZU-ASE-AU_030 | Sending diagnostic logs to a partner solution requires CyberSecurity risk assessment and approval | Sending diagnostic logs to a partner solution requires CyberSecurity risk assessment and approval (What) within Diagnostic settings (How) in order to prevent sensitive data leakage to third parties outside of LSEG control (Why) | False | False | Control cannot be implemented via terraform. |
| 6. | AZU-ASE-SC_010 | Use a minimum of TLS version 1.2 for network connections to the App Service Environment control and data planes | App Service Environment must enforce a minimum TLS version of 1.2 (What) within Configuration settings (How) in order to use modern techniques to establish robust encrypted data channels over untrusted networks (Why) | True | True | TLS 1.0 and 1.1 have been disabled in `cluster_setting` block. |
| 7. | AZU-ASE-SC_020 | Azure App Deployment must not be able to corrupt the centrally managed private link private DNS zones when making a private endpoint for App Service Environment | App Service Environment must have an Azure DeployIfNotExists policy to update the centrally managed private link private DNS zones with its private A record (What) via Policy to management group mapping (How) to ensure there is no ability for the Azure App Deployment team to have authorisation over these zones that could allow them to corrupt this file and impact service availability (Why) | False | False | To be implemented via policy. |
| 8. | AZU-ASE-SC_030 | Azure App Deployment must not be able to corrupt the centrally managed private link private DNS zones when making a private endpoint for App Service Environment SCM portal | App Service Environment SCM portal must have an Azure DeployIfNotExists policy to update the centrally managed private link private DNS zones with its private A record (What) via Policy to management group mapping (How) to ensure there is no ability for the Azure App Deployment team to have authorisation over these zones that could allow them to corrupt this file and impact service availability (Why) | False | False | To be implemented via policy. |
| 9. | AZU-ASE-SC_040 | App Service Environment must enable internal encryption | App Service Environment must enable internal encryption (What) within Configuration settings (How) in order to encrypt internal network traffic, the pagefile and worker disks (Why) | True | True | Internal encryption has been enabled via `cluster_setting` block. |

## SMCF Controls

| S. No.  | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|---------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types.<br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc.<br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC<br><br>Documentation | True | This control will be implemented using resource naming module.<br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames) |
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC<br><br>Policy | True | This control will be implemented using `tags` parameter.<br><br>This control is achieved by custom policy as described in the [clear listing page](https://dev.azure.com/LSEGroup/Foundation/_git/azu-plat-policy) from where it inherits all the mandatory tags. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties.<br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration. | Policies<br><br>Iac<br><br>Policies<br><br>Iac | True | This control will be implemented by having all the `Mandate` and most of the `Optional ` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring) | SMCF-OPS-03-02: Define and automate resource operation and security log collection<br><br>SMCF-OPS-03-03: Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs) | Policy<br><br>Documentation<br><br>Documentation | True | This control will be implemented by `DINE` Policy.<br><br>[Enable diagnostics logging for apps in Azure App Service](https://learn.microsoft.com/en-us/azure/app-service/troubleshoot-diagnostic-logs#supported-log-types)<br><br>[Supported metrics for Microsoft.Web/hostingEnvironments](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-web-hostingenvironments-metrics)<br><br>[Cloud monitoring service level objectives](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/monitor/service-level-objectives) |
| 5. | [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC<br><br>Documentation | True | This control will be implemented by following parameters: `zone_redundant` variable to enable High Availablity and to prepare for disaster recovery in a multi-region geography, you can use either an active-active or active-passive architecture.<br><br>[Reliability in Azure App Service](https://learn.microsoft.com/en-us/azure/reliability/reliability-app-service?tabs=graph%2Ccli) |
| 6. | [SMCF-OPS-07: Resource Protection](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-07-01: Prevent accidental or malicious deletion of production resources<br><br>SMCF-OPS-07-02: Prevent accidental misconfiguration of key production resources | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard based on application team requirement. <br><br>[Lock your resources to protect your infrastructure](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json) |
| 7. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package and has a JIT implementation in place.<br><br>[Azure built-in roles](https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles)<br><br>[Certificates and the App Service Environment](https://learn.microsoft.com/en-us/azure/app-service/environment/overview-certificates) |

## Changelog

- [azure-prdsvc-terraform-appserviceenvironment](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documention](https://learn.microsoft.com/en-us/azure/app-service/environment/overview)

### Terraform Docs

- [azurerm_app_service_environment_v3](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_environment_v3)

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
| [azurerm_app_service_environment_v3.ase](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_environment_v3) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_new_private_endpoint_connections"></a> [allow_new_private_endpoint_connections](#input_allow_new_private_endpoint_connections) | (Optional) Should new Private Endpoint Connections be allowed. | `bool` | `true` | no |
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_dedicated_host_count"></a> [dedicated_host_count](#input_dedicated_host_count) | (Optional) This ASEv3 should use dedicated Hosts. Possible values are 2.  You can only set either dedicated_host_count or zone_redundant but not both. Changing this forces a new resource to be created. | `number` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet_id](#input_subnet_id) | (Required) An empty subnet id for the ASE. It's recommended size is /24 with 256 addresses. It is not allowed to be deployed into a subnet size of /29 or above - This Subnet requires a delegation to Microsoft.Web/hostingEnvironments. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |
| <a name="input_zone_redundant"></a> [zone_redundant](#input_zone_redundant) | (Optional) Set to true to deploy the ASEv3 with availability zones supported. Zonal ASEs can be deployed in some regions, you can refer to Availability Zone support for App Service Environments. You can only set either dedicated_host_count or zone_redundant but not both. Changing this forces a new resource to be created. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dns_suffix"></a> [dns_suffix](#output_dns_suffix) | The DNS suffix of the App Service Environment V3. |
| <a name="output_external_inbound_ip_addresses"></a> [external_inbound_ip_addresses](#output_external_inbound_ip_addresses) | The external inbound IP addresses of the App Service Environment V3. |
| <a name="output_id"></a> [id](#output_id) | The ID of the created App Service Environment. |
| <a name="output_inbound_network_dependencies"></a> [inbound_network_dependencies](#output_inbound_network_dependencies) | The inbound_network_dependencies of the App Service Environment V3. |
| <a name="output_internal_inbound_ip_addresses"></a> [internal_inbound_ip_addresses](#output_internal_inbound_ip_addresses) | The internal inbound IP addresses of the App Service Environment V3. |
| <a name="output_ip_ssl_address_count"></a> [ip_ssl_address_count](#output_ip_ssl_address_count) | The number of IP SSL addresses reserved for the App Service Environment V3. |
| <a name="output_linux_outbound_ip_addresses"></a> [linux_outbound_ip_addresses](#output_linux_outbound_ip_addresses) | Outbound addresses of Linux based Apps in ase App Service Environment V3. |
| <a name="output_location"></a> [location](#output_location) | The location where the App Service Environment exists. |
| <a name="output_name"></a> [name](#output_name) | The name of the created App Service Environment. |
| <a name="output_pricing_tier"></a> [pricing_tier](#output_pricing_tier) | Pricing tier for the front end instances. |
| <a name="output_resource"></a> [resource](#output_resource) | The App Service Environment resource. |
| <a name="output_windows_outbound_ip_addresses"></a> [windows_outbound_ip_addresses](#output_windows_outbound_ip_addresses) | Outbound addresses of Windows based Apps in ase App Service Environment V3. |
<!-- END_TF_DOCS -->
