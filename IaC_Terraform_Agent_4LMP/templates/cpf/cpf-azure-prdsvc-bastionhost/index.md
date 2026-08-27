---
version: 1.0.0
available_versions:
  - 1.0.0
  - 0.4.0
  - 0.3.1
  - 0.3.0
  - 0.2.0
---

<!-- BEGIN_TF_DOCS -->
# Bastion Host module

## Overview

This terraform module creates an Azure Bastion Host and the associated resources.
Azure Bastion is a service to connect to a virtual machine using browser and the Azure portal, or via the native SSH or RDP client already installed on local computer. The Azure Bastion service is a fully platform-managed PaaS service that can be provisioned inside a virtual network. It provides secure and seamless RDP/SSH connectivity to a virtual machines directly over TLS from the Azure portal or via native client. When a connection is done via Azure Bastion, virtual machines don't need a public IP address, agent, or special client software.

## Prerequisites

- `Resource Group` name is required.
- `Virtual Network ` with `Azure Bastion Subnet ` and `Public IP` is required.
- `Azure Bastion Subnet ` delegation is required for Azure Bastion Host deployment.

## Guidance

#### Usage

- Azure Bastion protects your virtual machines from exposing RDP/SSH ports to the outside world, while still providing secure access using RDP/SSH.
- This module only creates Bastion only with `Standard` sku, due to security control `AZU-BST-SC_030` as tunneling can not be enabled for Bastion with `Basic` sku.

#### Security Considerations

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-BST-IA_010 | Azure AD authentication only must be used | Azure AD authentication only must be used (What) in the Access control (IAM) settings (How) in order to use modern robust and less prone to compromise authentication methods embedded within Azure Active Directory (Why) | False | False | Granular RBAC will be enabled using a separate module at bundle/pattern level |
| 2. | AZU-BST-AC_020 | Azure Bastion must disable shareable links | Azure Bastion must disable shareable links (What) in the Configuration settings (How) in order to use modern robust and less prone to compromise authentication methods embedded within Azure Active Directory (Why) | True | True | This control is Implemented using `shareable_link_enabled = false` |
| 3. | AZU-BST-AC_030 | Azure Bastion must disable IP based connections | Authorisation to Bastion must disable IP based connections (What) in the Configuration settings (How) in order to prevent access over IP address and use modern robust and less prone to compromise authentication methods embedded within Azure Active Directory (Why) | True | True | This control is Implemented using `ip_connect_enabled = false` |
| 4. | AZU-BST-AC_040 | Azure Bastion must only be accessible from LSEG managed devices | Azure Bastion must only be accessible from LSEG managed devices (What) via Azure AD Conditional access (How) in order to prevent access from unauthorised devices (Why) | False | False | As per the security control document, `Control implemented by technical configuration setting:False` |
| 5. | AZU-BST-AU_010 | Azure Bastion must send all diagnostic logs to a central Log Analytics workspace | Azure Bastion must send all diagnostic logs to a central Log Analytics workspace (What) within its Diagnostic settings (How) in order to support a security investigation after a security incident involving Azure Bastion (Why) | False | False | Diagnostics settings will be enabled using a separate module at bundle/pattern level |
| 6. | AZU-BST-AU_020 | Azure Bastion must send all diagnostic logs to a central SOC Storage Account | Azure Bastion must send all diagnostic logs to a central SOC Storage Account (What) within its Diagnostic settings (How) in order to provide an immutable copy to adhere to compliance requirements(Why) | False | False | Diagnostics settings will be enabled using a separate module at bundle/pattern level |
| 7. | AZU-BST-SC_010 | Azure Bastion must disable copy and paste | Azure Bastion must disable copy and paste (What) in the Configuration settings (How) in order to prevent data exposure to the internet (Why) | True | True | This control is Implemented using `copy_paste_enabled = false` |
| 8. | AZU-BST-SC_020 | Azure Bastion must disable file transfer | Azure Bastion must disable file transfer (What) in the Configuration settings (How) in order to prevent data exposure to the internet (Why) | True | True | This control is Implemented using `file_copy_enabled = false` |
| 9. | AZU-BST-SC_030 | Azure Bastion must enable tunnelling | Azure Bastion must enable tunnelling (What) in the Configuration settings (How) in order to use the native client and modern robust and less prone to compromise authentication methods embedded within Azure Active Directory (Why) | True | True | This control is Implemented using `tunneling_enabled = true` |

## SMCF Controls

| S. No.  | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|---------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types.<br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc.<br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC<br><br>Documentation | True | This control will be implemented using resource naming module.<br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames) |
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC<br><br>Policy | True | This control will be implemented using `tags` parameter.<br><br>This control is achieved by custom policy as described in the [clear listing page](https://dev.azure.com/LSEGroup/Foundation/_git/azu-plat-policy) from where it inherits all the mandatory tags. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties.<br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration. | Policies<br><br>Iac<br><br>Policies<br><br>Iac | True | This control will be implemented by having all the `Mandate` and most of the `Optional ` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring) | SMCF-OPS-03-02: Define and automate resource operation and security log collection<br><br>SMCF-OPS-03-03: Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs) | Policy<br><br>Documentation<br><br>Documentation | True | This control will be implemented by `DINE` Policy.<br><br>[Monitor Azure Bastion](https://learn.microsoft.com/en-us/azure/bastion/howto-metrics-monitor-alert)<br><br>[Cloud monitoring service level objectives ](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/monitor/service-level-objectives)<br><br>[Supported Metrics for Azure Bastion](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-network-bastionhosts-metrics) |
| 5. | [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC<br><br>Documentation | True | Deployed Azure Bastion in the Peered Virtual network.If there is an Azure region failure, perform a failover operation for your VMs to the DR region. Then, use the Azure Bastion host that's deployed in the DR region to connect to the VMs that are now deployed there.<br><br>[Azure Bastion and Disaster Recovery](https://learn.microsoft.com/en-us/azure/bastion/bastion-faq#dr) |
| 6. | [SMCF-OPS-07: Resource Protection](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-07-01: Prevent accidental or malicious deletion of production resources<br><br>SMCF-OPS-07-02: Prevent accidental misconfiguration of key production resources | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard based on application team requirement. <br><br>[Lock your resources to protect your infrastructure](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json) |
| 7. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package and has a JIT implementation in place.<br><br>[Roles required to access a Virtual Machine](https://learn.microsoft.com/en-us/azure/bastion/bastion-faq#roles) |

## Changelog

- [azure-prdsvc-terraform-bastionhost](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/bastion/)

### Terraform Docs

- [azurerm_virtual_network_peering](https://registry.terraform.io/providers/hashicorp/azurerm/3.61.0/docs/resources/bastion_host)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.5.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm) | >= 3.51 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) | >= 3.51 |

## Resources

| Name | Type |
|------|------|
| [azurerm_bastion_host.bastion_host](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/bastion_host) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_ip_configuration_name"></a> [ip_configuration_name](#input_ip_configuration_name) | (Required) The name of the IP configuration. Changing this forces a new resource to be created. The Subnet used for the Bastion Host must have the name AzureBastionSubnet and the subnet mask must be at least a /26. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_public_ip_address_id"></a> [public_ip_address_id](#input_public_ip_address_id) | (Required) Reference to a Public IP Address to associate with this Bastion Host. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_scale_units"></a> [scale_units](#input_scale_units) | (Optional) The number of scale units with which to provision the Bastion Host. Possible values are between 2 and 50. Defaults to 2. `scale_units` only can be changed when `sku` is `Standard`. `scale_units` is always `2` when `sku` is `Basic`. | `number` | `2` | no |
| <a name="input_subnet_id"></a> [subnet_id](#input_subnet_id) | (Required) Reference to a subnet in which this Bastion Host has been created. Changing this forces a new resource to be created. The Subnet used for the Bastion Host must have the name AzureBastionSubnet and the subnet mask must be at least a /26. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dns_name"></a> [dns_name](#output_dns_name) | The FQDN for the Bastion Host. |
| <a name="output_id"></a> [id](#output_id) | The ID of the created Bastion Host. |
| <a name="output_name"></a> [name](#output_name) | The name of the created Bastion Host. |
| <a name="output_resource"></a> [resource](#output_resource) | The Bastion Host resource. |
<!-- END_TF_DOCS -->
