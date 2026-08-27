<!-- BEGIN_TF_DOCS -->
# Linux VM and Managed Disks Pattern

## Overview

This terraform module creates a Linux VM, Managed Disks and associated resources.

## Notes

- This module creates Linux VM, Managed Disks along with CMK enabled via Disk Encryption Set
- It allows to create multiple managed disks and attach the same with Linux Virtual Machine
- Checks for existing Key vault value under variable `supporting_resource` and considers it, if it is a valid value else creates a new Key Vault with Private Endpoint Enabled
- Note that, existing Key vault resource passed under `supporting_resource` variable, must have an associated Private Endpoint
- SSH Key for Linux VM is stored as a secret in Key Vault

## Prerequisites

- A Resource Group where you want to create the Linux VM, Managed Disk, and associated resources.
- A Key Vault to generate and store the Key for CMK encryption and to Store the SSH key of Linux VM.
- A Virtual Network and Subnet where you plan to deploy the Private Endpoint.
- An Azure Private DNS Zone to resolve the Private Endpoint using DNS name.
- Nework Connectivity : If you have multiple Virtual Networks, you might need to setup the connectivity between the Virtual Network containing Gitlab Pipeline runner and the Virtual Network where you plan to deploy the Private Endpoints for the Storage Account.

## How to Use

- An example for using this pattern is shown in the .tests\deployTest folder. The folder contains the following terraform files:

    - main.tf : This file shows how we are using this pattern locally to deploy the Linux VM and Managed Disks
    - providers.tf : This file contains the required provider configuartion and backend configuration.

## Example

```tf
module "azure-prdsvc-terraform-linuxvirtualmachine-pattern" {
  source              = "../.."
  org_id              = local.org_id
  app_id              = local.app_id
  location            = local.location
  environment         = local.environment
  context             = local.context
  instance            = local.instance
  resource_group_name = local.resource_group_name

  network_interface = {
    ip_configurations = [
      {
        private_ip_address                                 = null
        private_ip_address_version                         = null
        private_ip_address_allocation                      = null
        subnet_id                                          = local.subnet_id
        primary                                            = true
        gateway_load_balancer_frontend_ip_configuration_id = null
      },
      {
        private_ip_address                                 = null
        private_ip_address_version                         = null
        private_ip_address_allocation                      = null
        subnet_id                                          = local.subnet_id
        primary                                            = false
        gateway_load_balancer_frontend_ip_configuration_id = null
      }
    ]
    dns_servers                    = null
    edge_zone                      = null
    accelerated_networking_enabled = null
    internal_dns_name_label        = null
  }

  linuxvirtualmachine = {
    size                         = "Standard_D2s_v3"
    admin_username               = local.admin_username
    username                     = local.username
    admin_ssh_public_key         = tls_private_key.rsa.public_key_openssh
    zone                         = null
    license_type                 = null
    zone                         = null
    availability_set_id          = null
    proximity_placement_group_id = null
    computer_name                = null
    source_image_reference       = null
    source_image_id              = null
    user_data                    = null
    vtpm_enabled                 = null
    custom_data                  = null
    edge_zone                    = null
    secure_boot_enabled          = null
    priority                     = "Regular"
    virtual_machine_scale_set_id = null
    dedicated_host_id            = null
    dedicated_host_group_id      = null
    os_disk = {
      storage_account_type = "StandardSSD_LRS"
      disk_size_gb         = 127
      caching              = "ReadWrite"
    }
    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts-gen2"
      version   = "latest"
    }
    termination_notification = {
      enabled = false
      timeout = "PT5M"
    }
    identity = {
      type         = "SystemAssigned"
      identity_ids = null
    }
  }

  manageddisk = {
    disk_1 = {
      availability_zone    = "1"
      storage_account_type = "StandardSSD_LRS"
      source_uri           = ""
      source_resource_id   = ""
      image_reference_id   = ""
      os_type              = null
      disk_size_gb         = "128"
      disk_number          = "001"
      diskattachment = {
        lun     = 0
        caching = "ReadWrite"
      }
    }
    disk_2 = {
      availability_zone    = "1"
      storage_account_type = "StandardSSD_LRS"
      source_uri           = ""
      source_resource_id   = ""
      image_reference_id   = ""
      os_type              = null
      disk_size_gb         = "32"
      disk_number          = "002"
      diskattachment = {
        lun     = 1
        caching = "ReadWrite"
      }
    }
    disk_3 = {
      availability_zone    = "1"
      storage_account_type = "StandardSSD_LRS"
      source_uri           = ""
      source_resource_id   = ""
      image_reference_id   = ""
      os_type              = null
      disk_size_gb         = "64"
      disk_number          = "003"
      diskattachment = {
        lun     = 2
        caching = "ReadOnly"
      }
    }
  }

  keyvault = {
    sku_name                        = "premium"
    enabled_for_deployment          = false
    enabled_for_disk_encryption     = true
    enabled_for_template_deployment = false
  }

  network_acls = {
    bypass = "AzureServices"
  }

  private_endpoint = {
    subnet_id                         = local.subnet_id
    is_manual_connection              = false
    dns_zone_group_name               = "default"
    private_dns_zone_ids              = local.private_dns_zone_ids
    static_ip_required                = false
    private_connection_resource_alias = null
    ip_configuration = {
      ip1 = {
        private_ip_address = "10.0.2.8"
        subresource_name   = "vault"
        member_name        = "default"
      }
    }
  }

  key_vault_secrets = {
    secret1 = {
      secret_number   = "001"
      value           = tls_private_key.rsa.private_key_openssh
      content_type    = null
      not_before_date = null
      expiration_date = null
    }
  }

  disk_encryption_set = {
    encryption_type = "EncryptionAtRestWithCustomerKey"
    key_details = {
      key_size        = 2048
      key_type        = "RSA"
      expiration_date = "2023-08-11T16:10:00Z"
    }
    rotation_policy = {
      notify_before_expiry = "P358D"
      time_before_expiry   = "P7D"
      time_after_creation  = null
      expire_after         = "P365D"
    }
  }

  supporting_resource = {
    key_vault_id = "/subscriptions/dce1fcba-b608-45ec-a2ad-87b80e6ed833/resourceGroups/a0a-12345-dev-rg-sol-we-001/providers/Microsoft.KeyVault/vaults/a0a12345devkvsolwe001"
  }
}
```

## Changelog

- [azure-prdsvc-terraform-linuxvmdiskkeyvault](CHANGELOG.md)

## Documentation
<!-- markdownlint-disable MD033 -->

### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.5.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm) | >= 3.51 |
| <a name="requirement_time"></a> [time](#requirement_time) | ~> 0.9 |

### Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_azure-prdsvc-terraform-diskencryptionset"></a> [azure-prdsvc-terraform-diskencryptionset](#module_azure-prdsvc-terraform-diskencryptionset) | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-diskencryptionset | 0.2.0 |
| <a name="module_azure-prdsvc-terraform-keyvaultprivatendpoint-pat"></a> [azure-prdsvc-terraform-keyvaultprivatendpoint-pat](#module_azure-prdsvc-terraform-keyvaultprivatendpoint-pat) | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvcpat/terraform/azure-prdsvcpat-terraform-keyvaultprivateendpoint | 0.2.0 |
| <a name="module_azure-prdsvc-terraform-linuxvirtualmachine"></a> [azure-prdsvc-terraform-linuxvirtualmachine](#module_azure-prdsvc-terraform-linuxvirtualmachine) | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-linuxvirtualmachine | 0.3.1 |
| <a name="module_azure-prdsvc-terraform-manageddisk"></a> [azure-prdsvc-terraform-manageddisk](#module_azure-prdsvc-terraform-manageddisk) | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-manageddisk | 0.2.1 |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_disk_encryption_set"></a> [disk_encryption_set](#input_disk_encryption_set) | (Required) A Disk Encryption Set block consists of below variables:<br>  encryption_type = "(Optional) The type of key used to encrypt the data of the disk. Changing this forces a new resource to be created."<br>  (Required) A key_details block as defined below:<br>    key_size        = "(Required) Size of the Key"<br>    key_type        = "(Required) Type of the Key"<br>    expiration_date = "(Required) Expiration date of the Key"<br>  (Optional) A rotation policy block as defined below<br>    object({<br>      notify_before_expiry = "(Required) Expire a Key Vault Key after given duration as an ISO 8601 duration."<br>      time_before_expiry   = "(Required) Rotate automatically at a duration before expiry as an ISO 8601 duration."<br>      time_after_creation  = "(Optional) Rotate automatically at a duration after create as an ISO 8601 duration."<br>      expire_after         = "(Required) Expire a Key Vault Key after given duration as an ISO 8601 duration."<br>    }) | <pre>object({<br>    key_details = object({<br>      key_size        = number<br>      key_type        = string<br>      expiration_date = string<br>    })<br>    rotation_policy = optional(object({<br>      notify_before_expiry = optional(string, "P358D")<br>      time_before_expiry   = optional(string, "P7D")<br>      time_after_creation  = optional(string, null)<br>      expire_after         = optional(string, "P365D")<br>    }))<br>    encryption_type = optional(string, "EncryptionAtRestWithCustomerKey")<br>  })</pre> | n/a | yes |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_keyvault"></a> [keyvault](#input_keyvault) | (Optional)  :<br>  sku_name                        = "(Optional) The Name of the Sku used for the Key Vault. Possible values are standard and premium."<br>  enabled_for_deployment          = "(Optional) Specifies whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault."<br>  enabled_for_disk_encryption     = "(Optional) Specifies whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys."<br>  enabled_for_template_deployment = "(Optional) Specifies whether Azure Resource Manager is permitted to retrieve secrets from the key vault." | <pre>object({<br>    sku_name                        = optional(string, "premium")<br>    enabled_for_deployment          = optional(bool, false)<br>    enabled_for_disk_encryption     = optional(bool, true)<br>    enabled_for_template_deployment = optional(bool, false)<br>  })</pre> | n/a | yes |
| <a name="input_linuxvirtualmachine"></a> [linuxvirtualmachine](#input_linuxvirtualmachine) | A Linux Virtual Machine that should be created with below variables:<br>  size                                 = "(Required) The SKU which should be used for this Virtual Machine."<br>  admin_username                       = "(Required) The username of the local administrator used for the Virtual Machine."<br>  username                             = "(Required) The Username for which this Public SSH Key should be configured. Changing this forces a new resource to be created."<br>  admin_ssh_public_key                 = "(Required) The Public Key which should be used for authentication, which needs to be at least 2048-bit and in ssh-rsa format. Changing this forces a new resource to be created."<br>  zone                                 = "(Optional)  Specifies the Availability Zones in which this Linux Virtual Machine should be located. Changing this forces a new Linux Virtual Machine to be created."<br>  license_type                         = "(Optional)  Specifies the BYOL Type for this Virtual Machine. Possible values are RHEL_BYOS and SLES_BYOS."<br>  availability_set_id                  = "(Optional) Specifies the ID of the Availability Set in which the Virtual Machine should exist. Changing this forces a new resource to be created."<br>  proximity_placement_group_id         = "(Optional) The ID of the Proximity Placement Group which the Virtual Machine should be assigned to."<br>  computer_name                        = "(Optional) Specifies the Hostname which should be used for this Virtual Machine."<br>  source_image_id                      = "(Optional) The ID of the Image which this Virtual Machine should be created from."<br>  image_marketplace                    = "(Optional) This will decide if you want to create VM from Marketplace Image or not?"<br>  secure_boot_enabled                  = "(Optional) Specifies whether secure boot should be enabled on the virtual machine. Changing this forces a new resource to be created."<br>  edge_zone                            = "(Optional) Specifies the Edge Zone within the Azure Region where this Linux Virtual Machine Scale Set should exist. Changing this forces a new Linux Virtual Machine Scale Set to be created."<br>  priority                             = "(Optional) Specifies the priority of this Virtual Machine. Possible values are Regular and Spot. Defaults to Regular. Changing this forces a new resource to be created."<br>  vtpm_enabled                         = "(Optional) Specifies whether vTPM should be enabled on the virtual machine. Changing this forces a new resource to be created."<br>  user_data                            = "(Optional) The Base64-Encoded User Data which should be used for this Virtual Machine."<br>  dedicated_host_id                    = "(Optional) The ID of a Dedicated Host where this machine should be run on. Conflicts with dedicated_host_group_id."<br>  dedicated_host_group_id              = "(Optional) The ID of a Dedicated Host Group that this Linux Virtual Machine should be run within. Conflicts with dedicated_host_id."<br>  custom_data                          = "(Optional) The custom data to be used for the Virtual Machine."<br>  virtual_machine_scale_set_id         = "(Optional) Specifies the Orchestrated Virtual Machine Scale Set that this Virtual Machine should be created within. Changing this forces a new resource to be created."<br>  boot_diagnostics_storage_account_uri = "(Optional) The Primary/Secondary Endpoint for the Azure Storage Account which should be used to store Boot Diagnostics."<br>  (Optional) os_disk variable consists of below items:<br>    object({<br>    storage_account_type   = "(Optional) The Type of Storage Account which should back this the Internal OS Disk. Possible values are Standard_LRS, StandardSSD_LRS, Premium_LRS, StandardSSD_ZRS and Premium_ZRS."<br>    disk_size_gb           = "(Optional) The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Machine is sourced from."<br>    caching                = "(Optional) The Type of Caching which should be used for the Internal OS Disk. Possible values are None, ReadOnly and ReadWrite."<br>  })<br>  (Optional) source_image_reference variable consists of below items:<br>    object({<br>    publisher = "(Required) Specifies the publisher of the image used to create the virtual machines. Changing this forces a new resource to be created."<br>    offer     = "(Required) Specifies the offer of the image used to create the virtual machines. Changing this forces a new resource to be created."<br>    sku       = "(Required) Specifies the SKU of the image used to create the virtual machines. Changing this forces a new resource to be created."<br>    version   = "(Required) Specifies the version of the image used to create the virtual machines. Changing this forces a new resource to be created."<br>  })<br>  (Optional) Specifies the Plan which should be used for this Virtual Machine:<br>    name      = "(Optional) Specifies the name of the image from the marketplace. Changing this forces a new resource to be created."<br>    publisher = "(Optional) Specifies the publisher of the image. Changing this forces a new resource to be created."<br>    product   = "(Optional) Specifies the product of the image from the marketplace. Changing this forces a new resource to be created."<br>  (Required) An identity block as defined below<br>  object({<br>    type         = "(Required) Specifies the type of Managed Service Identity that should be configured on this Linux Virtual Machine. Possible values are `SystemAssigned`, `UserAssigned`, `SystemAssigned, UserAssigned` (to enable both)."<br>    identity_ids = "(Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Linux Virtual Machine. This is required when `type` is set to `UserAssigned` or `SystemAssigned, UserAssigned`."<br>  })<br>  (Optional) A termination_notification block as defined below:<br>    enabled = "(Required) Should the termination notification be enabled on this Virtual Machine?"<br>    timeout = "(Optional) Length of time (in minutes, between 5 and 15) a notification to be sent to the VM on the instance metadata server till the VM gets deleted. The time duration should be specified in ISO 8601 format. Defaults to PT5M."<br>  }) | <pre>object({<br>    size                                 = string<br>    admin_username                       = string<br>    username                             = string<br>    admin_ssh_public_key                 = string<br>    zone                                 = optional(string, null)<br>    license_type                         = optional(string, null)<br>    availability_set_id                  = optional(string, null)<br>    proximity_placement_group_id         = optional(string, null)<br>    computer_name                        = optional(string, null)<br>    source_image_id                      = optional(string, null)<br>    image_marketplace                    = optional(bool, false)<br>    secure_boot_enabled                  = optional(bool, false)<br>    edge_zone                            = optional(string, null)<br>    priority                             = optional(string, "Regular")<br>    vtpm_enabled                         = optional(bool, false)<br>    user_data                            = optional(string, null)<br>    dedicated_host_id                    = optional(string, null)<br>    dedicated_host_group_id              = optional(string, null)<br>    custom_data                          = optional(string, null)<br>    virtual_machine_scale_set_id         = optional(string, null)<br>    boot_diagnostics_storage_account_uri = optional(string, null)<br>    os_disk = optional(object({<br>      storage_account_type = optional(string, "StandardSSD_LRS")<br>      disk_size_gb         = optional(number, 127)<br>      caching              = optional(string, "ReadWrite")<br>    }), null)<br>    source_image_reference = optional(object({<br>      publisher = string<br>      offer     = string<br>      sku       = string<br>      version   = string<br>    }), null)<br>    plan = optional(object({<br>      name      = optional(string)<br>      publisher = optional(string)<br>      product   = optional(string)<br>    }), null)<br>    identity = object({<br>      type         = optional(string, "SystemAssigned")<br>      identity_ids = optional(set(string), null)<br>    })<br>    termination_notification = optional(object({<br>      enabled = bool<br>      timeout = optional(string)<br>    }), null)<br>  })</pre> | n/a | yes |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_manageddisk"></a> [manageddisk](#input_manageddisk) | (Optional) Managed Disk that should be created with below variables:<br>  availability_zone      = "(Optional) The Availability Zone in which this Managed Disk should be located. Make sure the disk sku you want to use can be created in availability zone."<br>  storage_account_type   = "(Optional) The type of storage to use for the managed disk. Possible values are Standard_LRS, StandardSSD_ZRS, Premium_LRS, PremiumV2_LRS, Premium_ZRS, StandardSSD_LRS or UltraSSD_LRS."<br>  source_uri             = "(Optional) URI to a valid VHD file to be used for the disk creation."<br>  source_resource_id     = "(Optional) The ID of an existing Managed Disk or Snapshot to copy from."<br>  image_reference_id     = "(Optional) ID of an existing platform/marketplace disk image to copy from"<br>  os_type                = "(Optional) Specify a value when the source is an Import, Copy or Image."<br>  disk_size_gb           = "(Optional) The resource ID of a Disk Encryption Set which should be used to encrypt this Managed Disk."<br>  disk_number            = "(Required) The number of the disk. This can be used to differentiate between multiple disks attached to a Virtual Machine."<br>  (Optional) Disk Attachment that should be created with below variables:<br>    lun     = "The Logical Unit Number of the Data Disk, which needs to be unique within the Virtual Machine."<br>    caching = "(Optional) The Type of Caching which should be used for the Disk Attachment. Possible values are None, ReadOnly and ReadWrite." | <pre>map(object({<br>    availability_zone    = optional(string, null)<br>    storage_account_type = optional(string, "StandardSSD_LRS")<br>    source_uri           = optional(string, "")<br>    source_resource_id   = optional(string, "")<br>    image_reference_id   = optional(string, "")<br>    os_type              = optional(string, null)<br>    disk_size_gb         = optional(string, "128")<br>    disk_number          = string<br>    diskattachment = optional(object({<br>      lun     = number<br>      caching = optional(string, "ReadWrite")<br>    }))<br>  }))</pre> | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_private_endpoint"></a> [private_endpoint](#input_private_endpoint) | (Required) A Private Endpoint consists of below variables:<br>  subnet_id                         = "(Required) The ID of the Subnet from which Private IP Addresses will be allocated for this Private Endpoint. Changing this forces a new resource to be created."<br>  is_manual_connection              = "(Required) Does the Private Endpoint require Manual Approval from the remote resource owner? Changing this forces a new resource to be created."<br>  dns_zone_group_name               = "(Required) Specifies the Name of the Private DNS Zone Group."<br>  private_dns_zone_ids              = "(Required) Specifies the list of Private DNS Zones to include within the private_dns_zone_group."<br>  static_ip_required                = "(Required) Whether a Static IP is required to be assigned to Private Endpoint or not."<br>  private_connection_resource_alias = "(Optional) The Service Alias of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to. One of private_connection_resource_id or private_connection_resource_alias must be specified. Changing this forces a new resource to be created."<br>  ip_configuration = (Optional) map(object({<br>  private_ip_address = "(Required) Specifies the static IP address within the private endpoint's subnet to be used. Changing this forces a new resource to be created."<br>  subresource_name   = "(Optional) Specifies the subresource this IP address applies to."<br>  member_name        = "(Optional) Specifies the member name this IP address applies to."<br>})) | <pre>object({<br>    subnet_id                         = string<br>    is_manual_connection              = string<br>    dns_zone_group_name               = string<br>    private_dns_zone_ids              = list(string)<br>    static_ip_required                = bool<br>    private_connection_resource_alias = optional(string, null)<br>    ip_configuration = optional(map(object({<br>      private_ip_address = string<br>      subresource_name   = optional(string, "vault")<br>      member_name        = optional(string, "default")<br>    })), {})<br><br>  })</pre> | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_key_vault_secrets"></a> [key_vault_secrets](#input_key_vault_secrets) | (Required) An identity block as defined below<br>object({<br>  secret_number   = "(Required) Specifies secret number for multiple secrets to be created."<br>  value           = "(Required) Specifies the value of the Key Vault Secret."<br>  content_type    = "(Optional) Specifies the content type for the Key Vault Secret."<br>  not_before_date = "(Optional) Key not usable before the provided UTC datetime (Y-m-d'T'H:M:S'Z')."<br>  expiration_date = "(Optional) Expiration UTC datetime (Y-m-d'T'H:M:S'Z')."<br>}) | <pre>map(object({<br>    secret_number   = string<br>    value           = string<br>    content_type    = optional(string, null)<br>    not_before_date = optional(string, null)<br>    expiration_date = optional(string, null)<br>  }))</pre> | `{}` | no |
| <a name="input_network_acls"></a> [network_acls](#input_network_acls) | (Optional) The network ACL configuration for the Key Vault.<br>If not specified then the Key Vault will be created with a firewall that blocks access.<br>Specify `null` to create the Key Vault with no firewall.<br><br>- `bypass`                     - (Optional) Should Azure Services bypass the ACL. Possible values are `AzureServices` and `None`. Defaults to `None`.<br>- `default_action`             - (Optional) The default action when no rule matches. Possible values are `Allow` and `Deny`. Defaults to `Deny`.<br>- `ip_rules`                   - (Optional) A list of IP rules in CIDR format. Defaults to `[]`.<br>- `virtual_network_subnet_ids` - (Optional) When using with Service Endpoints, a list of subnet IDs to associate with the Key Vault. Defaults to `[]`. | <pre>object({<br>    bypass                     = optional(string, "None")<br>    default_action             = optional(string, "Deny")<br>    ip_rules                   = optional(list(string), [])<br>    virtual_network_subnet_ids = optional(list(string), [])<br>  })</pre> | `{}` | no |
| <a name="input_network_interface"></a> [network_interface](#input_network_interface) | A Network Interface that should be created and attached to this Virtual Machine.<br>ip_configurations = list(object({<br>  private_ip_address                                 = "(Optional) The Static IP Address which should be used. When `private_ip_address_allocation` is set to `Static` this field can be configured."<br>  private_ip_address_version                         = "(Optional) The IP Version to use. Possible values are `IPv4` or `IPv6`. Defaults to `IPv4`."<br>  private_ip_address_allocation                      = "(Required) The allocation method used for the Private IP Address. Possible values are `Dynamic` and `Static`. Defaults to `Dynamic`."<br>  subnet_id                                          = "(Required) The ID of the Subnet where the VM Network Interface should be located in."<br>  primary                                            = "(Optional) Is this the Primary IP Configuration? Must be `true` for the first `ip_configuration`. Defaults to `false`."<br>  gateway_load_balancer_frontend_ip_configuration_id = "(Optional) The Frontend IP Configuration ID of a Gateway SKU Load Balancer."<br>}))<br>dns_servers                    = "(Optional) A list of IP Addresses defining the DNS Servers which should be used for this Network Interface. Configuring DNS Servers on the Network Interface will override the DNS Servers defined on the Virtual Network."<br>edge_zone                      = "(Optional) Specifies the Edge Zone within the Azure Region where this Network Interface should exist. Changing this forces a new Network Interface to be created."<br>accelerated_networking_enabled = "(Optional) Should Accelerated Networking be enabled? Defaults to `false`. Only certain Virtual Machine sizes are supported for Accelerated Networking - [more information can be found in this document](https://docs.microsoft.com/azure/virtual-network/create-vm-accelerated-networking-cli). To use Accelerated Networking in an Availability Set, the Availability Set must be deployed onto an Accelerated Networking enabled cluster."<br>internal_dns_name_label        = "(Optional) The (relative) DNS Name used for internal communications between Virtual Machines in the same Virtual Network." | <pre>object({<br>    ip_configurations = list(object({<br>      private_ip_address                                 = optional(string)<br>      private_ip_address_version                         = optional(string, "IPv4")<br>      private_ip_address_allocation                      = optional(string, "Dynamic")<br>      subnet_id                                          = optional(string)<br>      primary                                            = optional(bool, false)<br>      gateway_load_balancer_frontend_ip_configuration_id = optional(string)<br>    }))<br>    dns_servers                    = optional(list(string))<br>    edge_zone                      = optional(string)<br>    accelerated_networking_enabled = optional(bool, false)<br>    internal_dns_name_label        = optional(string)<br>  })</pre> | <pre>{<br>  "accelerated_networking_enabled": null,<br>  "dns_servers": null,<br>  "edge_zone": null,<br>  "internal_dns_name_label": null,<br>  "ip_configurations": [<br>    {<br>      "gateway_load_balancer_frontend_ip_configuration_id": null,<br>      "primary": true,<br>      "private_ip_address": null,<br>      "private_ip_address_allocation": null,<br>      "private_ip_address_version": null,<br>      "subnet_id": null<br>    }<br>  ]<br>}</pre> | no |
| <a name="input_supporting_resource"></a> [supporting_resource](#input_supporting_resource) | (Optional) A supporting_resource block as defined below:<br>  key_vault_id = "(Optional) The ID of the existing Key Vault." | <pre>object({<br>    key_vault_id = optional(string)<br>  })</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

### Resources

| Name | Type |
|------|------|
| [time_sleep.wait_keyvault_pe](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resources.key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resources) | data source |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_diskencryptionset_resource"></a> [diskencryptionset_resource](#output_diskencryptionset_resource) | The Disk Encryption Set resource. |
| <a name="output_key_vault_private_endpoint_resource"></a> [key_vault_private_endpoint_resource](#output_key_vault_private_endpoint_resource) | The Key Vault and Private Endpoint resource. |
| <a name="output_linuxvirtualmachine_id"></a> [linuxvirtualmachine_id](#output_linuxvirtualmachine_id) | ID of the Linux Virtual Machine. |
| <a name="output_linuxvirtualmachine_name"></a> [linuxvirtualmachine_name](#output_linuxvirtualmachine_name) | Name of the Linux Virtual Machine. |
| <a name="output_linuxvirtualmachine_resource"></a> [linuxvirtualmachine_resource](#output_linuxvirtualmachine_resource) | The Linux Virtual Machine resource. |
| <a name="output_manageddisk_id"></a> [manageddisk_id](#output_manageddisk_id) | The ID of Managed Disks resources. |
| <a name="output_manageddisk_name"></a> [manageddisk_name](#output_manageddisk_name) | The name of Managed Disks resources. |
| <a name="output_manageddisk_resource"></a> [manageddisk_resource](#output_manageddisk_resource) | The Managed Disks resources. |

<!-- END_TF_DOCS -->
