---
version: 1.2.3
available_versions:
  - 1.2.3
  - 1.2.2
  - 1.2.1
  - 1.2.0
  - 1.1.2
---

<!-- BEGIN_TF_DOCS -->
# Windows Virtual Machine Module

## Overview

- This terraform module creates a windows virtual machine and associated resources.

## Prerequisites

  ### Required

  - `Resource Group`, `Virtual Network`, and `Route Table` (all three modules to be called if not existing).
  - `Subnet` to be used by the Private endpoint and the VM Network Interface IP Configs.
  - `Network Security Group` to be associated with the Subnet.
  - `Keyvault` module to create a secret to store Windows VM password.
  - `Private Endpoint` module to create a private connection to the Keyvault.
  - `Role assignment` module to assign "Key Vault Secrets User" role to the client on the created keyvault.
  - `Keyvault Secret` module to store the admin password of the Windows VM.
  - `Disk Encryption Set` module to be used by the OS disk of the Windows VM.

  | Cloud Products | Source |
  |--------|----------------|
  | azure-prdsvc-terraform-networksecuritygroup | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-networksecuritygroup |
  | azure-prdsvc-terraform-subnet | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-subnet |
  | azure-prdsvc-terraform-keyvault | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-keyvault |
  | azure-prdsvc-terraform-kv-privateendpoint | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-privateendpoint |
  | azure-prdsvc-terraform-roleassignment | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-roleassignment |
  | azure-prdsvc-terraform-keyvaultsecret | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-keyvaultsecret |
  | azure-prdsvc-terraform-diskencryptionset | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-diskencryptionset |
  ### Optional  
  - `User Assigned Identity` module for the Windows VM.
  - `Proximity Placement Group` module.

  | Cloud Products | Source |
  |--------|----------------|
  | azure-prdsvc-terraform-userassignedidentity | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-userassignedidentity |
  | azure-prdsvc-terraform-proximityplacementgroup | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-proximityplacementgroup |

  - `time_sleep` resource block to wait for the secret to get created till private connection is registered in the Private DNS Zone.
  - `random_password` resource block to generate admin password.

  [Image: Windows Virtual Machine]

## Guidance

#### Usage

- For testing purpose, we can follow the steps below:
  1. Use `random_password` to generate the administrator password,
  2. Use the same generated password to deploy the Windows Virtual Machine,
  3. Store the generated password as a secret in the Key Vault, named after the Virtal Machine name,
  4. Additional role(`Key Vault Secrets User`) is required  on the Key Vault to manage the password as Key Vault secret.
-- Use LSEG Golden Images stored in Shared Image Gallery to deploy Windows Virtual Machines. These Golden Images are maintained and managed by Share image gallery team. Windows Virtual Machine module takes ID of the Golden Images as Input using the Parameter `source_image_id`.
- The `Plan` block accepts specific Marketplace images from [Image Marketplace Portal](https://azuremarketplace.microsoft.com/en-us/marketplace/apps?filters=virtual-machine-images) which has the arguments referencing to categories of the images similar to `source_image_reference`, example:
  ```tf
    plan = {
       name      = "2016-Datacenter"
       product   = "WindowsServer"
       publisher = "MicrosoftWindowsServer"
   }
  ```
   However, if you are using this block, it will need an acceptance of the legal terms of the Image on Subscription. To do it, please refer the [link](https://learn.microsoft.com/en-us/cli/azure/vm/image/terms?view=azure-cli-latest). Hence, we have kept as null for now and creating VM using `source_image_id` variable.
- While using dedicated host, Virtual Machine size and host SKU should belong to the same family.
- Ensure that the Virtual Machine and associated resources are not part of a Proximity Placement Group if they are intended to be deployed to a dedicated host.
- If `maintenance_configuration` is required, define the following variables:
      patch_mode                                             = `AutomaticByPlatform`
      patch_assessment_mode                                  = `AutomaticByPlatform`
      bypass_platform_safety_checks_on_user_schedule_enabled = `true`
- To assign the `maintenance_assignment` to a Virtual Machine, set `maintenance_assignment_required` variable to `true`.
- To enable Ultra SSD data disk support on the Virtual Machine, set `ultra_ssd_enabled` to `true`. Note that Ultra SSD requires the VM to be deployed in a supported region and availability zone, and the VM size must support Ultra Disks.
- To verify the deployed User Data on the Virtual Machine Scale Set, we can follow the below steps:
    - Login to the individual instance using RDP with the `administrator username` and `password from Key Vault`,
    - Open PowerShell and query the Azure Instance Metadata Service (IMDS) to retrieve the user data:
      ```powershell
      $userData = Invoke-RestMethod `
        -Uri "http://169.254.169.254/metadata/instance/compute/userData?api-version=2021-12-13&format=text" `
        -Headers @{Metadata="true"}
      ```
    - Decode the Base64 response to verify the user data content:
      ```powershell
      [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($userData))
      ```

###### AzureRM 3.x to 4.x Upgrade Notes for Windows Virtual Machine

Product Impact -- Low

The Windows Virtual Machine module creates and manages a Network Interface resource as a core dependency. Due to this dependency relationship, changes to the Network Interface resource in the AzureRM provider 4.x upgrade directly impact this module.

Users in azurerm 3.x migrating to 4.x need to perform the following changes for the Network Interface resource:
  - The dns_servers property is no longer Computed, which may cause plan diffs if not explicitly set (add to ignore_changes if needed).
  - The deprecated enable_accelerated_networking property has been removed in favour of the accelerated_networking_enabled property.
  - The deprecated enable_ip_forwarding property has been removed in favour of the ip_forwarding_enabled property.

This module has been updated to use the new 4.x compliant properties (accelerated_networking_enabled and ip_forwarding_enabled) in the Network Interface configuration.

  - Wiki link for [AzureRM 4.x Upgrade](https://gitlab.dx1.lseg.com/groups/app/app-51310/azure/prdsvc/terraform/-/wikis/Terraform-AzureRM-Provider-Upgrade:-Version-3.x-to-4.x/windowsvirtualmachine) for details on the upgrade process.

For more details, refer to the official [AzureRM 4.x Upgrade Guide](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/4.0-upgrade-guide)

#### Security Considerations

- System Assigned Managed Identity is mandatory for using `AADLoginForWindows` extension.

#### Additional Information

- The network access settings for OS disk is not supported through azurerm provider [Active Issue on github](https://github.com/Azure/azure-rest-api-specs/issues/21325), therefore a separate resource block using azapi provider is added that can be used to enable/disable network access.
- According to security requirements, the OS disk should have public access disabled. However, due to a limitation on Azure, to enable the backup of a Virtual Machine along with its OS disk, public access for the OS disk must be enabled (Backup an Azure VM with disks that have public network access disabled is available in preview [source](https://learn.microsoft.com/en-us/azure/backup/backup-azure-vms-enhanced-policy?tabs=azure-portal)). Therefore, OS disk network-related settings are configurable through this module instead of permanently disabling public access.
- When VM is deployed using this mdule, by default public access is disabled for the OS disk, and can be configured using the `network_access_policy`and `public_network_access` properties within the `os_disk` variable as per backup requirements.

## Security Controls

| S. No. | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|--------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-VM-IA_010 | Use Managed Identity for accessing Azure Resources | Virtual Machines must enforce the use of its Managed Identity to authenticate to Azure resources where this is supported (What) in the Identity setting (How) in order to adhere to the principle of least privilege and remove the need to store credentials (Why) | True | True | Implemented using `identity{}` block in `azurerm_linux_virtual_machine` resource, default identity type is set to `SystemAssigned`. `System Assigned` Managed Identity is mandatory for using `aadsshlogin` and `aadsshlogin-selinux` extension to enable Entra ID authentication. |
| 2. | AZU-VM-IA_020 | Entra ID authentication only must be used for operating system authentication | Entra ID authentication only must be used for operating system authentication (What) within the Extensions + applications setting (How) in order to use modern robust and less prone to compromise authentication methods embedded within Microsoft Entra ID (Why) | False | False | Extension is not installed as Windows Server 2016 is not supported.`System Assigned` Managed Identity is mandatory for using `aadsshlogin` and `aadsshlogin-selinux` extension. |
| 3. | AZU-VM-IA_030 | Windows Virtual Machines must have their passwords rotated so they are distinct from the original value stored in the Terraform state file, meet LSEG complexity requirements and are stored in the LSEG approved secrets management system | Windows Virtual Machines must have their passwords rotated so they are distinct from the original value stored in the Terraform state file, meet LSEG complexity requirements and are stored in the LSEG approved secrets management system (What) in the reset password settings (How) in order to protect secrets by using a secure storage mechanism (Why) | False | False | Control is not relevant for Linux Virtual Machine. |
| 4. | AZU-VM-IA_040 | Linux Virtual Machines must use SSH keys and store the private key in Key Vault | Linux Virtual Machines must use LSEG Standard SSH keys stored in the LSEG approved secrets management system (What) in the Code deployment parameters (How) in order to protect keys by using a secure storage mechanism (Why) | False | False | Control cannot be implemented via technical configuration setting. |
| 5. | AZU-VM-AC_010 | Virtual Machines of different role types must not be in the same virtual network subnet | Virtual Machines of different role types must not be in the same virtual network subnet (What) in the Code deployment parameters (How) in order to control traffic flow between different resources (Why) | False | False | Control cannot be implemented via technical configuration setting. |
| 6. | AZU-VM-AC_020 | Virtual Machines must use Application Security Groups when operating with different roles and risk profiles in a tiered solution (e.g. web, application, and database servers) | Virtual Machines must use Application Security Groups when operating with different roles and risk profiles in a tiered solution (e.g. web, application, and database servers) (What) in ASG configurations, Virtual machine networking settings and NSG inbound and outbound rules (How) in order to enforce granular network traffic segregation between VM’s and limit the attack surface and lateral movement potential in case of compromise (Why) | False | False | Control cannot be implemented via technical configuration setting. |
| 7. | AZU-VM-AC_030 | Disable Public Network Access | Virtual Machines must enforce a network guardrail (What) within IP configurations in the Network interface (How) in order to prevent data exposure to the internet (Why) | True | True | Enforced by not using the optional parameter `public_ip_address_id` for each IP configuration defined in the Network Interface created. |
| 8. | AZU-VM-AC_040 | IP Forwarding must be disabled on Network Interfaces | IP Forwarding must be disabled on Network Interfaces (What) within IP configurations in the Network interface (How) in order to prevent unauthorised routing between network zones operating at different trust levels (Why) | True | True | Enforced by setting `enable_ip_forwarding = false` for the of Network Interface created. |
| 9. | AZU-VM-AC_050 | Virtual Machine Serial Console access must be disabled | Virtual Machine Serial Console access must be disabled (What) within the Boot Diagnostic Settings (How) to prevent unauthorised access avoiding defence and detection methods (Why) | True | True | Boot diagnostics is disabled by default. However if there comes a requirement to enable boot diagnostics for the troubleshooting of the Virtual Machines then it can be enabled by the passing the required input values to this module. |
| 10. | AZU-VM-CM_010 | Virtual Machines must only use LSEG Security Architecture approved golden images or marketplace VM images | Virtual Machines must only use LSEG Security Architecture approved golden images or marketplace VM images (What) in the Code deployment parameters (How) to operate with security hardened and patched images that are preinstalled with LSEG mandated agents (Why) | False | False | Control cannot be implemented via technical configuration setting. To be ensured by the Application Team. |
| 11. | AZU-VM-CM_020 | Virtual Machines must have Automanage disabled | Virtual Machines must be configured with an Automanage custom profile with all services disabled (What) within the Automanage settings (How) in order to prevent deviation from LSEG Cloud Security Architecture Standards (Why) | True | True | Pester Test case has been added to get the Automanage report of the VM and check if it's null or empty. |
| 12. | AZU-VM-RA_010 | Virtual Machines must have LSEG Standard Qualys agent installed | Virtual Machines must have LSEG Standard Qualys agent installed (What) via security solution in Defender for Cloud (How) in order to provide visibility of common vulnerabilities and exposures in LSEG's central vulnerability management platform (Why) | False | False | Golden Image team to ensure the Image has LSEG Standard Qualys agent installed. |
| 13. |  AZU-VM-SC_010 | Use Key Vaults for storing secrets used by VMs to access systems which cannot be granted through Managed Identity permissions | Secrets must be stored in Key Vault and not stored in Source Control or VM user data (What) in the Code deployment parameters (How) in order to protect secrets by using a secure storage mechanism (Why) | False | False | Control cannot be implemented via technical configuration setting. |
| 14. |  AZU-VM-SC_020 | Virtual Machines must enable Encryption at host | Virtual Machines must enable Encryption at host (What) within the Disks, Additional settings – subscription must be enabled first (How) in order to encrypt temporary disks, disk caches and data flow to storage service (Why) | True | True | Enforced by setting `encryption_at_host_enabled = true`. |
| 15. |  AZU-VM-SC_030 | Virtual Machines configured as a Web Server must be protected by an Azure managed PaaS service with WAF integration such as Front Door or Application Gateway | Virtual Machines configured as a Web Server must be protected by an Azure managed PaaS service with WAF integration such as Front Door or Application Gateway (What) in the Code deployment parameters (How) to protect web applications against common vulnerabilities and exploits (Why) | False | False | Control cannot be implemented via technical configuration setting. |
| 16. | AZU-VM-SC_040 | Virtual Machines must have a data classification tag | Virtual Machines must have a data classification tag (What) in the Tags setting (How) in order to differentiate assets technical control requirements and to assist Security Operations in prioritising possible data breach mitigation responses (Why) | False | False | Control cannot be implemented via technical configuration setting. |
| 17. |  AZU-VM-SI_010 | Virtual Machines must enable Trusted Launch (secure boot, vTPM, Integrity monitoring) when Azure Site recovery is not required | Virtual Machines must enable Trusted Launch (secure boot, vTPM, Integrity monitoring) when Azure Site recovery is not required (What) within the Configuration settings (How) to ensure the integrity and attestation of the boot process (Why) | True | True | Can be enabled using variables `vtpm_enabled = true` and `secure_boot_enabled = true`. These variables have default value of `false` and can be configured as required. |
| 18. |  AZU-VM-SI_011 | Virtual Machines must enable Trusted Launch (Integrity Monitoring) when Azure Site recovery is not required | Virtual Machines must enable Trusted Launch (Integrity Monitoring) when Azure Site recovery is not required (What) within the Configuration settings (How) to ensure the integrity and attestation of the boot process (Why) | False | False | This control can be enabled with an extension "Guest Attestation" which needs to be approved by the Policy team first. The link to support the same: [Boot Integrity Monitoring](https://learn.microsoft.com/en-us/azure/virtual-machines/boot-integrity-monitoring-overview?tabs=template). |
| 19. |  AZU-VM-SI_020 | Virtual Machines must only use LSEG Security Architecture approved Extensions | Virtual Machines must only use LSEG Security Architecture approved Extensions (What) in the Extensions + applications settings (How) to reduce the risks of unmanaged software or non-approved functionality (Why) | False | False | Control cannot be implemented via technical configuration setting. |
| 20. |  AZU-VM-SI_030 | Virtual Machines must be refreshed with the latest LSEG Security Architecture approved golden images or marketplace VM images in accordance with the requirements in the LSEG Vulnerability and Patch Management Standard | Virtual Machines must be refreshed with the latest LSEG Security Architecture approved golden images or marketplace VM images in accordance with the requirements in the LSEG Vulnerability and Patch Management Standard (What) in the Code deployment parameters (How) to operate with the latest security hardened and patched images that are preinstalled with LSEG mandated agents (Why) | False | False | Control cannot be implemented via technical configuration setting. There is no feature to check approved images in Terraform. |
| 21. |  AZU-VM-SI_040 | A mechanism must be deployed to facilitate central managed patching, binary installation and reconfiguration in case of priority needs including zero-day vulnerabilities or failures in the federated server management model | A mechanism must be deployed to facilitate central managed patching, binary installation and reconfiguration in case of priority needs including zero-day vulnerabilities or failures in the federated server management model (What) via a central managed server administration capability (How) to operate with the latest patched software and remove known vulnerabilities in operating systems and binaries (Why | False | False | Control cannot be implemented via technical configuration setting. |
| 22. | AZU-VM-SI_050 | Virtual Machines must have LSEG Standard CrowdStrike agent installed | Virtual Machines must have LSEG Standard CrowdStrike agent installed (What) built into the LSEG golden image (How) in order to provision LSEG standard endpoint detection and response capabilities (Why) | False | False | Golden Image team to ensure the Image has CrowdStrike agent installed. |

## SMCF Controls

| S. No. | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|--------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types. <br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc. <br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC <br><br>Documentation | True | This control has been implemented in all the cloud products using resource naming modules. <br><br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames)|
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC <br><br>Policy | True | Cloud products has paramter in place to accept the tag values. <br><br>This control will be implemented via Policy that inherits all the mandatory tags to the resources. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties. <br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration | Policies <br><br>IaC <br><br>Policies <br><br>IaC | True | This control will be implemented by having all the `Mandate` and most of the `Optional ` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring) | SMCF-OPS-03-02: Define and automate resource operation and security log collection <br><br><br><br><br>SMCF-OPS-03-03: Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs) | Policy <br><br><br><br>Documentation <br><br><br><br><br>Documentation | True | This control will be implemented by `DINE` Policy. <br><br>[Azure Virtual Machine logging](https://learn.microsoft.com/en-us/azure/azure-monitor/vm/tutorial-monitor-vm-guest) <br> [Cloud monitoring service level objectives](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/monitor/service-level-objectives) <br><br>[Supported Metrics for Virtual Machine](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-compute-virtualmachines-metrics) |
| 5. | [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC <br><br>Documentation | True | This control will be implemented by following parameters: `zones`, `availability_set_id`, `platform_fault_domain` for High Availability. <br><br> [Virtual Machines Availability Options](https://learn.microsoft.com/en-us/azure/virtual-machines/availability) <br><br> [Virtual Machines Backup & Recovery](https://learn.microsoft.com/en-us/azure/virtual-machines/backup-recovery) |
| 6. | [SMCF-OPS-07: Resource Protection](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-07-01: Prevent accidental or malicious deletion of production resources. <br><br> SMCF-OPS-07-02: Prevent accidental misconfiguration of key production resources | IaC <br><br>Documentation | False | This control will be implemented as per LSEG standard based on application Team requirement, no locks implemented yet via IaC. |
| 7. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals. | IaC <br><br>Documentation | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package and has a JIT implementation in place. |
| 8. | [SMCF-OPS-09 Update Management](https://dev.azure.com/LSEG/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1408/SMCF-OPS-09-Update-Management) | SMCF-OPS-09-01 Assess cloud resources for missing updates | Documentation | False | This control will be implemented as per LSEG standard based on application Team requirement. [Updates and Maintenance Overview](https://learn.microsoft.com/en-us/azure/virtual-machines/updates-maintenance-overview) |
| 9. | [SMCF-OPS-10 License Management](https://dev.azure.com/LSEG/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1409/SMCF-OPS-10-License-Management) | SMCF-OPS-10-01 Ensure licensing terms and conditions are followed | Policy | True | This control is implemented by accepting the license terms from a product level. There is a parameter: `license_type` which specifies the type of on-premise license (also known as Azure Hybrid Use Benefit). <br><br>Custom policy is in place to report on `Hybrid Use` Licence usage. |

## Changelog

- [azure-prdsvc-terraform-windowsvirtualmachine](CHANGELOG.md)

## References

### Microsoft Docs

- [Virtual Machine](https://learn.microsoft.com/en-us/azure/virtual-machines/overview)

### Terraform Docs

- [azurerm_network_interface](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface)
- [azurerm_windows_virtual_machine](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine)

## FAQ

1. Why the secrets are not getting created even after private endpoint is created?

   - It takes some time to create an entry in the Private DNS Zones for the private endpoint created in the Keyvault. That's why there's a `time_sleep` resource in the test main.tf file. This will make the Terraform wait after the private endpoint is created till the entry is done in the Private DNZ Zones.

2. What are the required variables for setting <b>Trusted Launch</b> for the supported Golden Image?

   - Put the values as `true` for the below variables:
    - vtpm_enabled
    - secure_boot_enabled
3. How to you deploy the Windows Virtual machine using Golden Images?

   - Provide the Windows Image ID to the `source_image_id` variable instead of using `source_image_reference` for the Marketplace images.

4. What to do if the pipeline fails due to a policy "Resource os_disk was disallowed by the policy, resources are not compliant according to the set definitions"?

   - Find out the policies applied for the disks.
   - Check the below points to make the os_disks compliant:
     - `networkAccessPolicy` to be disabled.
     - `dataClassificationTag` to be set similar to the VM.
     - The os_disk should be encrypted with CMK key and to do so, assign the `disk_encryption_set_id` to the os_disk by using <b>Disk Encryption Set</b> module call.

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

## Resources

| Name | Type |
|------|------|
| [azapi_update_resource.disk](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/update_resource) | resource |
| [azurerm_maintenance_assignment_virtual_machine.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/maintenance_assignment_virtual_machine) | resource |
| [azurerm_network_interface.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_network_interface_backend_address_pool_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_backend_address_pool_association) | resource |
| [azurerm_virtual_machine_extension.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [azurerm_windows_virtual_machine.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_password"></a> [admin_password](#input_admin_password) | (Required) The password of the local administrator used for the Virtual Machine. | `string` | n/a | yes |
| <a name="input_admin_username"></a> [admin_username](#input_admin_username) | (Required) The username of the local administrator used for the Virtual Machine. | `string` | n/a | yes |
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_availability_set_id"></a> [availability_set_id](#input_availability_set_id) | (Optional) Specifies the ID of the Availability Set in which the Virtual Machine should exist. | `string` | `null` | no |
| <a name="input_backend_address_pool_id"></a> [backend_address_pool_id](#input_backend_address_pool_id) | (Optional) The ID of the Load Balancer Backend Address Pool with the Network Interface should be connected to. Changing this forces a new resource to be created. | `list(string)` | `[]` | no |
| <a name="input_boot_diagnostics_storage_account_uri"></a> [boot_diagnostics_storage_account_uri](#input_boot_diagnostics_storage_account_uri) | (Optional) The Primary/Secondary Endpoint for the Azure Storage Account which should be used to store Boot Diagnostics. | `string` | `null` | no |
| <a name="input_bypass_platform_safety_checks_on_user_schedule_enabled"></a> [bypass_platform_safety_checks_on_user_schedule_enabled](#input_bypass_platform_safety_checks_on_user_schedule_enabled) | (Optional) Specify whether to skip platform scheduled patching when a user schedule is associated with the VM. Defaults to false. | `bool` | `false` | no |
| <a name="input_capacity_reservation_group_id"></a> [capacity_reservation_group_id](#input_capacity_reservation_group_id) | (Optional) Specifies the ID of the Capacity Reservation Group which the Virtual Machine should be allocated to. | `string` | `null` | no |
| <a name="input_computer_name"></a> [computer_name](#input_computer_name) | (Optional) Specifies the Hostname which should be used for this Virtual Machine. | `string` | `null` | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_custom_data"></a> [custom_data](#input_custom_data) | (Optional) The Base64-Encoded Custom Data which should be used for this Virtual Machine. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_dedicated_host_group_id"></a> [dedicated_host_group_id](#input_dedicated_host_group_id) | (Optional) The ID of a Dedicated Host Group that this Windows Virtual Machine should be run within. Conflicts with `dedicated_host_id`. | `string` | `null` | no |
| <a name="input_dedicated_host_id"></a> [dedicated_host_id](#input_dedicated_host_id) | (Optional) The ID of a Dedicated Host where this machine should be run on. Conflicts with `dedicated_host_group_id`. | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_identity"></a> [identity](#input_identity) | (Optional) An identity block as defined below<br/>object({<br/>  type         = "(Required) Specifies the type of Managed Service Identity that should be configured on this Windows Virtual Machine. Possible values are `SystemAssigned`, `UserAssigned`, `SystemAssigned, UserAssigned` (to enable both)."<br/>  identity_ids = "(Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Windows Virtual Machine. This is required when `type` is set to `UserAssigned` or `SystemAssigned, UserAssigned`."<br/>}) | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(set(string))<br/>  })</pre> | <pre>{<br/>  "identity_ids": null,<br/>  "type": "SystemAssigned"<br/>}</pre> | no |
| <a name="input_image_marketplace"></a> [image_marketplace](#input_image_marketplace) | (Optional) This will decide if you want to create VM from Marketplace Image or not? | `bool` | `false` | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_license_type"></a> [license_type](#input_license_type) | (Optional) Specifies the type of on-premise license (also known as Azure Hybrid Use Benefit) which should be used for this Virtual Machine. | `string` | `"None"` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_maintenance_assignment_required"></a> [maintenance_assignment_required](#input_maintenance_assignment_required) | (Optional) Specify whether the Maintenance Configuration should be assigned for this Virtual Machine. Defaults to false. | `bool` | `false` | no |
| <a name="input_maintenance_configuration_id"></a> [maintenance_configuration_id](#input_maintenance_configuration_id) | (Optional) The ID of the Maintenance Configuration to assign to the Virtual Machine. | `string` | `null` | no |
| <a name="input_network_interface"></a> [network_interface](#input_network_interface) | A Network Interface that should be created and attached to this Virtual Machine.<br/>ip_configurations = list(object({<br/>  private_ip_address                                 = "(Optional) The Static IP Address which should be used. When `private_ip_address_allocation` is set to `Static` this field can be configured."<br/>  private_ip_address_version                         = "(Optional) The IP Version to use. Possible values are `IPv4` or `IPv6`. Defaults to `IPv4`."<br/>  private_ip_address_allocation                      = "(Optional) The allocation method used for the Private IP Address. Possible values are `Dynamic` and `Static`. Defaults to `Dynamic`."<br/>  subnet_id                                          = "(Optional) The ID of the Subnet where the VM Network Interface should be located in."<br/>  primary                                            = "(Optional) Is this the Primary IP Configuration? Must be `true` for the first `ip_configuration`. Defaults to `false`."<br/>  gateway_load_balancer_frontend_ip_configuration_id = "(Optional) The Frontend IP Configuration ID of a Gateway SKU Load Balancer."<br/>}))<br/>dns_servers                    = "(Optional) A list of IP Addresses defining the DNS Servers which should be used for this Network Interface. Configuring DNS Servers on the Network Interface will override the DNS Servers defined on the Virtual Network."<br/>edge_zone                      = "(Optional) Specifies the Edge Zone within the Azure Region where this Network Interface should exist. Changing this forces a new Network Interface to be created."<br/>accelerated_networking_enabled = "(Optional) Should Accelerated Networking be enabled? Defaults to `false`. Only certain Virtual Machine sizes are supported for Accelerated Networking - [more information can be found in this document](https://docs.microsoft.com/azure/virtual-network/create-vm-accelerated-networking-cli). To use Accelerated Networking in an Availability Set, the Availability Set must be deployed onto an Accelerated Networking enabled cluster."<br/>ip_forwarding_enabled          = "(Optional) Should IP Forwarding be enabled? Defaults to `false`."<br/>internal_dns_name_label        = "(Optional) The (relative) DNS Name used for internal communications between Virtual Machines in the same Virtual Network." | <pre>object({<br/>    ip_configurations = list(object({<br/>      private_ip_address                                 = optional(string)<br/>      private_ip_address_version                         = optional(string, "IPv4")<br/>      private_ip_address_allocation                      = optional(string, "Dynamic")<br/>      subnet_id                                          = optional(string)<br/>      primary                                            = optional(bool, false)<br/>      gateway_load_balancer_frontend_ip_configuration_id = optional(string)<br/>    }))<br/>    dns_servers                    = optional(list(string))<br/>    edge_zone                      = optional(string)<br/>    accelerated_networking_enabled = optional(bool, false)<br/>    ip_forwarding_enabled          = optional(bool, false)<br/>    internal_dns_name_label        = optional(string)<br/>  })</pre> | <pre>{<br/>  "accelerated_networking_enabled": null,<br/>  "dns_servers": null,<br/>  "edge_zone": null,<br/>  "internal_dns_name_label": null,<br/>  "ip_configurations": [<br/>    {<br/>      "gateway_load_balancer_frontend_ip_configuration_id": null,<br/>      "primary": true,<br/>      "private_ip_address": null,<br/>      "private_ip_address_allocation": null,<br/>      "private_ip_address_version": null,<br/>      "subnet_id": null<br/>    }<br/>  ],<br/>  "ip_forwarding_enabled": false<br/>}</pre> | no |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_os_disk"></a> [os_disk](#input_os_disk) | (Required) A os_disk for the VM. The block supports the following<br/>object({<br/>  storage_account_type   = "(Optional) The Type of Storage Account which should back this the Internal OS Disk. Possible values are Standard_LRS, StandardSSD_LRS, Premium_LRS, StandardSSD_ZRS and Premium_ZRS."<br/>  disk_encryption_set_id = "(Required) The ID of the Disk Encryption Set which should be used to Encrypt this OS Disk."<br/>  disk_size_gb           = "(Optional) The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Machine is sourced from."<br/>  caching                = "(Optional) The Type of Caching which should be used for the Internal OS Disk. Possible values are None, ReadOnly and ReadWrite."<br/>  network_access_policy  = "(Optional) Policy for accessing the disk via network. Possible values are AllowAll, AllowPrivate and DenyAll."<br/>  public_network_access  = "(Optional) Policy for controlling export on the disk. Possible values are Disabled and Enabled."<br/>}) | <pre>object({<br/>    storage_account_type   = optional(string, "StandardSSD_LRS")<br/>    disk_encryption_set_id = string<br/>    disk_size_gb           = optional(number, 127)<br/>    caching                = optional(string, "ReadWrite")<br/>    network_access_policy  = optional(string, "DenyAll")<br/>    public_network_access  = optional(string, "Disabled")<br/>  })</pre> | n/a | yes |
| <a name="input_patch_assessment_mode"></a> [patch_assessment_mode](#input_patch_assessment_mode) | (Optional) Specify the mode of VM Guest Patching for the Virtual Machine. Possible values are `AutomaticByPlatform` or `ImageDefault`. Defaults to `ImageDefault`. | `string` | `"ImageDefault"` | no |
| <a name="input_patch_mode"></a> [patch_mode](#input_patch_mode) | (Optional) Specify the mode of in-guest patching to this Windows Virtual Machine. Possible values are `Manual`, `AutomaticByOS` and `AutomaticByPlatform`. Defaults to `AutomaticByOS`. | `string` | `"AutomaticByOS"` | no |
| <a name="input_plan"></a> [plan](#input_plan) | (Optional) A plan block supports the following<br/>object({<br/>  name      = "(Optional) Specifies the name of the image from the marketplace. Changing this forces a new resource to be created."<br/>  publisher = "(Optional) Specifies the publisher of the image. Changing this forces a new resource to be created."<br/>  product   = "(Optional) Specifies the product of the image from the marketplace. Changing this forces a new resource to be created."<br/>}) | <pre>object({<br/>    name      = optional(string)<br/>    publisher = optional(string)<br/>    product   = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_proximity_placement_group_id"></a> [proximity_placement_group_id](#input_proximity_placement_group_id) | (Optional) The ID of the Proximity Placement Group which the Virtual Machine should be assigned to. | `string` | `null` | no |
| <a name="input_reboot_setting"></a> [reboot_setting](#input_reboot_setting) | (Optional) Specify the reboot setting for platform scheduled patching. Possible values are Always, IfRequired and Never, `reboot_setting` can only be set when `patch_mode` is set to `AutomaticByPlatform`. | `string` | `"Never"` | no |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_secure_boot_enabled"></a> [secure_boot_enabled](#input_secure_boot_enabled) | (Optional) Specifies if vTPM (virtual Trusted Platform Module) and Trusted Launch is enabled for the Virtual Machine. Changing this forces a new resource to be created. | `bool` | `false` | no |
| <a name="input_size"></a> [size](#input_size) | (Required) The SKU which should be used for this Virtual Machine. | `string` | n/a | yes |
| <a name="input_source_image_id"></a> [source_image_id](#input_source_image_id) | (Optional) The ID of the Image which this Virtual Machine should be created from. | `string` | `null` | no |
| <a name="input_source_image_reference"></a> [source_image_reference](#input_source_image_reference) | (Optional) The source_image_reference block supports the following<br/>object({<br/>  publisher = "(Required) Specifies the publisher of the image used to create the virtual machines. Changing this forces a new resource to be created."<br/>  offer     = "(Required) Specifies the offer of the image used to create the virtual machines. Changing this forces a new resource to be created."<br/>  sku       = "(Required) Specifies the SKU of the image used to create the virtual machines. Changing this forces a new resource to be created."<br/>  version   = "(Required) Specifies the version of the image used to create the virtual machines. Changing this forces a new resource to be created."<br/>}) | <pre>object({<br/>    publisher = string<br/>    offer     = string<br/>    sku       = string<br/>    version   = string<br/>  })</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |
| <a name="input_timezone"></a> [timezone](#input_timezone) | (Optional) Specifies the Time Zone which should be used by the Virtual Machine, the possible values are defined here (https://jackstromberg.com/2017/01/list-of-time-zones-consumed-by-azure). Changing this forces a new resource to be created.Defaults to UTC. | `string` | `null` | no |
| <a name="input_ultra_ssd_enabled"></a> [ultra_ssd_enabled](#input_ultra_ssd_enabled) | (Optional) Should the capacity to enable Data Disks of the UltraSSD_LRS storage account type be supported on this Virtual Machine? Defaults to false. | `bool` | `false` | no |
| <a name="input_user_data"></a> [user_data](#input_user_data) | (Optional) The raw User Data which should be used for this Virtual Machine. The module will base64 encode it automatically. | `string` | `null` | no |
| <a name="input_user_data_file"></a> [user_data_file](#input_user_data_file) | (Optional) Path to a text file whose contents will be read and Base64 encoded as User Data for this Virtual Machine. Takes precedence over `user_data` when both are set. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_virtual_machine_extensions"></a> [virtual_machine_extensions](#input_virtual_machine_extensions) | (Optional) A Virtual Machine Extension block as defined below<br/>map(object({<br/>  name                        = "(Required) The name of the virtual machine extension peering."<br/>  publisher                   = "(Required) The publisher of the extension, available publishers can be found by using the Azure CLI.`az vm extension image list --location westus -o table`."<br/>  type                        = "(Required) The type of extension, available types for a publisher can be found using the Azure CLI."<br/>  type_handler_version        = "(Required) Specifies the version of the extension to use, available versions can be found using the Azure CLI."<br/>  auto_upgrade_minor_version  = "(Optional) Specifies if the platform deploys the latest minor version update to the type_handler_version specified."<br/>  automatic_upgrade_enabled   = "(Optional) Should the Extension be automatically updated whenever the Publisher releases a new version of this VM Extension?"<br/>  settings                    = "(Optional) The settings passed to the extension, these are specified as a JSON object in a string."<br/>  failure_suppression_enabled = "(Optional) Should failures from the extension be suppressed? Possible values are true or false. Defaults to false."<br/>  protected_settings          = "(Optional) The protected_settings passed to the extension, like settings, these are specified as a JSON object in a string."<br/>  provision_after_extensions  = "(Optional) Specifies the collection of extension names after which this extension needs to be provisioned."<br/>  protected_settings_from_key_vault = object({<br/>    secret_url      = "(Optional) Specifies the collection of extension names after which this extension needs to be provisioned."<br/>    source_vault_id = "(Required) The ID of the source Key Vault."<br/>  })<br/>})) | <pre>map(object({<br/>    name                        = string<br/>    publisher                   = string<br/>    type                        = string<br/>    type_handler_version        = string<br/>    auto_upgrade_minor_version  = optional(bool, false)<br/>    automatic_upgrade_enabled   = optional(bool, false)<br/>    settings                    = optional(string, null)<br/>    failure_suppression_enabled = optional(bool, false)<br/>    protected_settings          = optional(string, null)<br/>    provision_after_extensions  = optional(list(string), null)<br/>    protected_settings_from_key_vault = optional(object({<br/>      secret_url      = string<br/>      source_vault_id = string<br/>    }), null)<br/>  }))</pre> | `null` | no |
| <a name="input_virtual_machine_scale_set_id"></a> [virtual_machine_scale_set_id](#input_virtual_machine_scale_set_id) | (Optional) Specifies the Orchestrated Virtual Machine Scale Set that this Virtual Machine should be created within. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_vm_agent_platform_updates_enabled"></a> [vm_agent_platform_updates_enabled](#input_vm_agent_platform_updates_enabled) | (Optional) Specifies whether VMAgent Platform Updates is enabled. Defaults to false. | `bool` | `false` | no |
| <a name="input_vtpm_enabled"></a> [vtpm_enabled](#input_vtpm_enabled) | (Optional) The value will determine if Virtual Trusted Platform Module (vTPM) is enabled for the VM | `bool` | `false` | no |
| <a name="input_zone"></a> [zone](#input_zone) | (Optional) Specifies the Availability Zone in which this Windows Virtual Machine should be located. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The ID of the created virtual machine. |
| <a name="output_name"></a> [name](#output_name) | The name of the created virtual machine. |
| <a name="output_nic_id"></a> [nic_id](#output_nic_id) | The ID of the primary network interface of the virtual machine. |
| <a name="output_nic_name"></a> [nic_name](#output_nic_name) | The Name of the primary network interface of the virtual machine. |
| <a name="output_nic_resource"></a> [nic_resource](#output_nic_resource) | The primary network interface of the virtual machine. |
| <a name="output_resource"></a> [resource](#output_resource) | The Windows Virtual Machine resource. |
| <a name="output_vm_extension_resources"></a> [vm_extension_resources](#output_vm_extension_resources) | The extensions added for the virtual machine. |
<!-- END_TF_DOCS -->
