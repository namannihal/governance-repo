<!-- BEGIN_TF_DOCS -->
# Key Vault Private Endpoint Service Pattern

[[_TOC_]]

This readme provides an overview of a service pattern for `azure-prdsvcpat-terraform-keyvaultprivateendpoint`. The solution proposed below provides an easy predefined template built on top of LSEG approved Cloud Products (with identified common configurations) and the service pattern intended to help application teams with rapid deployments of infrastructure.

Here are some of the key advantages the proposed solution offers:

- **Rapid Deployment:** Service patterns are pre-defined templates that can be easily reused which accelerates the deployment process by eliminating the need to write configurations from scratch for each deployment, saving time and effort.
- **Standardization and Consistency:** Service patterns provide standardized templates and best practices for deploying specific infrastructure that promotes consistent configurations. This ensures consistency across deployments, reducing the likelihood of configuration drifts/errors and making it easier to maintain and scale infrastructure.
- **Documentation:** Service pattern comes with built-in documentation that explain the purpose and usage of various components.
- **Security and Compliance:** Service pattern built on top of approved Cloud Products incorporate security best practices and compliance requirements, ensuring that infrastructure is deployed with security in mind from the outset. This reduces the likelihood of security vulnerabilities.
- **Reuse, Sharing and customization:** Teams can share and reuse patterns across projects and organizations. Patterns can be adapted, and customized over time as infrastructure/business requirements change.
- **Version Control:** Patterns can be version-controlled, allowing teams to track changes, roll back to previous configurations if issues arise, and collaborate more effectively through version control systems.

## Pattern Description

This section contains the details of the azure service technical use case.

The following diagram shows the High Level Design for **Service pattern for Key Vault Private Endpoint**:

[Image: KeyVaultPEsvcpatHLD]

### Provisioned Azure services through IaC

- Azure Key Vault
- Azure Key Vault Private Endpoint
- Azure Key Vault Key (Optional)
- Azure Key Vault Secret (Optional)
- Azure Key Vault Certificate (Optional)

#### Simplified Usability

- This pattern significantly reduces user time and effort by eliminating the need to individually call each of the above mentioned modules. Instead, users can focus on passing the `required parameters` after invoking this service pattern.
- Additionally, this pattern seamlessly integrates essential resource blocks, such as the `time_sleep` block, which introduces necessary delays to ensure sufficient time for DNS zone establishment when configuring the private endpoint for Key vault, thereby ensuring the smooth creation of child resources.

### Key Management

- Azure Key Vault can be used as a Key Management solution. Azure Key Vault makes it easy to create and control the encryption keys used to encrypt your data.
- Key Vault keys are automatically rotated every 12 months via Rotation policy settings to reduce the risk that a stolen or cryptanalysis compromised key can be maliciously used.
- Key Vault keys are persisted in an FIPS 140-2 Level 2 HSM backed vault via the Pricing tier setting to reduce the risk that a key can be compromised.
- The default Key type is set to `RSA-HSM`, user can change it to RSA during provisioning (if required).

### Secret Management

- Azure Key Vault can be used to Securely store and tightly control access to tokens, passwords, certificates, API keys, and other secrets

### Certificate Management

- Azure Key Vault lets you easily provision, manage, and deploy public and private Transport Layer Security/Secure Sockets Layer (TLS/SSL) certificates for use with Azure and your internal connected resources.

#### Networking

- Key vault has several sub-resources like keys, secrets and certificates which are created after the default creation of a private endpoint and allowing a sufficient time sleep for it to start kicking in.
- Key vault `network_rules` must bypass `AzureServices` to allow access to its sub-resources over private network.
- Creation of private endpoint requires subnet ID with valid CIDR, and association of NSG and Route Table.

#### Monitoring and Logging

- Key Vault sends all diagnostic logs to a central SOC Storage Account and central Log Analytics Workspace within its Diagnostic settings through DINE Azure policy in order to provide a copy to adhere to compliance requirements.

## Pattern Composability

The section describes what optional components are considered in the service pattern and which inputs govern and effect the deployement of these components

[Image: Key Vault Private Endpoint Pattern Solution]

# Pattern Usage Guidance

## Pattern Use Cases

| Use Case | Default Behaviour | Input Control- variable | Comments |
|----------|-------------------|-------------------------|----------|
| Create Azure Key Vault | By Default the patterns deploys a new key vault with `enable_rbac_authorization` as `true`, `purge_protection_enabled` as `true` and `public_network_access_enabled` as `false` | `enable_rbac_authorization`, `purge_protection_enabled` and `public_network_access_enabled` | By default, key vault gets created with above mentioned properties but user has to option to pass valid values and deploy resource based on application requirement. |
| Deploy Private Endpoint for Key vault | By Default, the pattern deploys private endpoint for key vault | module `azure-prdsvc-terraform-privateendpoint`  | A private endpoint to the keyvault is created by default using the `azure-prdsvc-terraform-privateendpoint` module |
| Create Key Vault Key post Private Endpoint configuration | By Default, the pattern provides the option to deploy keys in key vault | `key_vault_keys`| `var.key_vault_keys` is a map of objects with default set to empty object, else user can pass the necessary arguments to create the resource. |
| Create Key Vault Secret post Private Endpoint configuration | By Default, the pattern provides the option to deploy secrets in key vault | `key_vault_secrets`| `var.key_vault_secrets` is a map of objects with default set to empty object, else user can pass the necessary arguments to create the resource. |
| Create Key Vault Certificate post Private Endpoint configuration | By Default, the pattern provides the option to deploy certificates in key vault | `key_vault_certificates`| `var.key_vault_secrets` is a map of objects with default set to empty object, else user can pass the necessary arguments to create the resource. |

### Special Use Cases

| Use Case | Default Behaviour | Input Control- variable | Comments |
|----------|-------------------|-------------------------|----------|
| Leveraging Key Vault Private Endpoint for CMK Encryption | By default the pattern deploys a key vault and a private endpoint with a sufficient time_sleep allowing the private endpoint to be established. | module `azure-prdsvcpat-terraform-keyvaultprivateendpoint` | This pattern can be directly invoked in other cloud products that require CMK Encryption instead of creating a key vault and private endpoint resource individually. |
| Leveraging Key Vault Private Endpoint for storing passwords | By default the pattern deploys a key vault and a private endpoint with a sufficient time_sleep allowing the private endpoint to be established. Once that's done, we will be able to create key vault secrets. | module `azure-prdsvcpat-terraform-keyvaultprivateendpoint`, and passing the key vault secret specific arguments within `key_vault_secrets` | This pattern can be directly invoked in other cloud products such as `databases`, `virtual machines`, etc that require passwords to be stored as secrets. |

## Additional Information

1. Azure Key Vault is one of several key management solutions in Azure that helps in key, secrets and certificate management.
2. Azure Key Vault has two service tiers: Standard, which encrypts with a software key, and a Premium tier, which includes hardware security module(HSM)-protected keys.
3. The pattern can deploy a key vault of SKU type Standard or Premium. By default `sku_name` is `premium` as the key vault must be a HSM backed vault which can be achieved through premium account tier.
4. The key vault is purge protected by default and has a soft delete retention period of 30 days by default. The `soft_delete_retention_days` variable can be set between `30 to 90 days` to accommodate the security controls of MySQL Flexible Server product.
5. The `Key vault Administrator` role is assigned by default to the `Service Principal/User` running this Terraform plan/workspace. This is to grant the `Service Principal/User` permissions to create and manage secrets.
5. The default expiration date for the Key vault Key is set to one year from the date of provisioning if no value is provided for the expiration date.
6. Automated cryptographic key rotation in Key Vault allows users to configure Key Vault to automatically generate a new key version at a specified frequency. To configure rotation, you can use key rotation policy, which can be defined on each individual key. For more information on key rotation visit [Configure cryptographic key auto-rotation in Azure Key Vault](https://learn.microsoft.com/en-us/azure/key-vault/keys/how-to-configure-key-rotation)
7. Cryptographic best practices recommend rotating encryption keys at least every two years.
8. Key Vault strips newlines. To preserve newlines in multi-line secrets try replacing them with `\n` or by base 64 encoding them with `replace(file("my_secret_file"), "/\n/", "\n")` or `base64encode(file("my_secret_file"))`, respectively.
9. `Key_usage` parameter in key vault certifcates is case-sensitive. When choosing to create and "EC" or "EC-HSM" keys, don't add `Key_usage` as "dataEncipherment", "keyEncipherment", "encipherOnly", "decipherOnly" as it's not supported and throws an error "Unsupported key operation(s): "encrypt", "decrypt". Supported values are "sign", "verify"."
10. `RSA-HSM` and `EC-HSM`key types should have the "exportable" value as false. `EC and EC-HSM keys` when created doesn't add Subject, Issuer, Serial Number, and Subject Alternative Name.
11. Elliptic Curve Name: P-256 cannot be used with key size (384) or (521).\r\n", hence, keep the values of `Curve` and `key_size` matching such as with "P-256", key\_size should be 256.
12. When creating a `Key Vault Certificate`, at least one of certificate or certificate_policy is required. Provide certificate to import an existing certificate, certificate_policy to generate a new certificate.
13. To convert a private key to pkcs8 format with openssl use: `openssl pkcs8 -topk8 -nocrypt -in private\_key.pem > private\_key\_pk8.pem`
14. Key vault key and secret supports only up to 15 tags. Please refer link:
- [Key vault key tags](https://learn.microsoft.com/en-us/azure/key-vault/keys/about-keys-details)
- [Key vault secret tags](https://learn.microsoft.com/en-us/azure/key-vault/secrets/about-secrets#secret-tags)

## Pattern Usage

### Prerequisites

- A Resource Group where you want to create the Key Vault.
- A Virtual Network and Subnet where you plan to deploy the Private Endpoint.
- Nework Connectivity : If you have multiple Virtual Networks, you need to setup the connectivity between the Virtual Network containing Gitlab Pipeline runner and the Virtual Network where you plan to deploy the Private Endpoints for the Key Vault.

## Guidance

### Build and Test

1. Call the module whichever is needed to be deployed. As the example given below,

```
module "keyvaultprivateendpoint" {
  source                          = "../../"
  depends_on                      = [data.azurerm_resource_group.this]
  org_id                          = local.org_id
  app_id                          = local.app_id
  location                        = local.location
  environment                     = local.environment
  context                         = local.context
  instance                        = local.instance
  resource_group_name             = data.azurerm_resource_group.this.name
  sku_name                        = "premium"
  enabled_for_deployment          = false
  enabled_for_disk_encryption     = false
  enabled_for_template_deployment = false
  network_acls = {
    bypass = "AzureServices"
  }

  private_endpoint = {
    subnet_id                         = module.azure-prdsvc-terraform-subnet.id
    is_manual_connection              = false
    private_connection_resource_alias = null
    static_ip_required                = false
  }

  key_vault_keys = {
    kv_key1 = {
      key_number      = "01"
      expiration_date = "2025-01-01T00:00:00Z"
      rotation_policy = {
        notify_before_expiry = "P351D"
        time_before_expiry   = null
        time_after_creation  = "P358D"
        expire_after         = "P365D"
      }
      key_opts = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]
    }
    kv_key2 = {
      key_number      = "02"
      expiration_date = "2025-01-01T00:00:00Z"
      rotation_policy = {
        notify_before_expiry = "P351D"
        time_before_expiry   = null
        time_after_creation  = "P358D"
        expire_after         = "P365D"
      }
      key_opts = ["unwrapKey", "verify", "wrapKey"]
    }
  }

  key_vault_secrets = {}

  key_vault_certificates = {
    kv_certificate1 = {
      cert_number            = "01"
      path_of_certificate    = null
      password               = null
      issuer_parameters_name = "Self"
      ec_key_required        = false
      curve                  = "P-256"
      key_type               = "RSA-HSM"
      key_size               = 3072
      reuse_key              = true
      action_type            = "AutoRenew"
      content_type           = "application/x-pkcs12"
      trigger = {
        days_before_expiry  = 30
        lifetime_percentage = null
      }
      key_usage = ["cRLSign", "digitalSignature", "keyAgreement", "nonRepudiation", "keyCertSign", "keyEncipherment"] # Case-Sensitive
      x509_certificate_properties = {
        # Server Authentication = 1.3.6.1.5.5.7.3.1
        # Client Authentication = 1.3.6.1.5.5.7.3.2
        extended_key_usage = ["1.3.6.1.5.5.7.3.1"]
        subject_alternative_names = {
          dns_names = ["internal.contoso.com", "domain.hello.world"]
        }
        subject            = "CN=hello-world"
        validity_in_months = 12
      }
    }
  }
}
```
2. Update the source with right tag version.
2. Check the terraform variables file and update the values of org_id, app_id, location, context, instance and other necessary arguments for all the resources being deployed. Example displayed in .tests/deployTest folder.
3. If the plan is use to use the existing resouce available on azure then please make sure to use 'data block'.
4. **Note: The .tests/deployTest folder is for for deployment and unit test cases , Use only as reference and not as the exact implementation of the pattern.**

## Changelog

- [azure-prdsvcpat-terraform-keyvaultprivateendpoint](CHANGELOG.md)

## References

### Microsoft Docs

- [Key Vault](https://learn.microsoft.com/en-us/azure/key-vault/general/overview)
- [Keys](https://learn.microsoft.com/en-us/azure/key-vault/keys/about-keys)
- [Secrets](https://learn.microsoft.com/en-us/azure/key-vault/secrets/about-secrets)
- [Certificates](https://learn.microsoft.com/en-us/azure/key-vault/certificates/about-certificates)

### Terraform Docs

- [azurerm_key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault)
- [azurerm_key_vault_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key)
- [azurerm_key_vault_certificate](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_certificate)
- [azurerm_key_vault_secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret)

### Service-Pattern-HLD

- [Key-Vault-PE-Pattern](https://gitlab.dx1.lseg.com/groups/app/app-51310/azure/prdsvc/terraform/-/wikis/Key-Vault-PE-Pattern)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.5.0 |
| <a name="requirement_time"></a> [time](#requirement_time) | ~> 0.9 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_time"></a> [time](#provider_time) | ~> 0.9 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_azure_prdsvc_terraform_keyvault"></a> [azure_prdsvc_terraform_keyvault](#module_azure_prdsvc_terraform_keyvault) | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-keyvault | 0.8.1 |
| <a name="module_azure_prdsvc_terraform_keyvaultcertificate"></a> [azure_prdsvc_terraform_keyvaultcertificate](#module_azure_prdsvc_terraform_keyvaultcertificate) | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-keyvaultcertificate | 0.4.1 |
| <a name="module_azure_prdsvc_terraform_keyvaultkey"></a> [azure_prdsvc_terraform_keyvaultkey](#module_azure_prdsvc_terraform_keyvaultkey) | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-keyvaultkey | 0.4.2 |
| <a name="module_azure_prdsvc_terraform_keyvaultsecret"></a> [azure_prdsvc_terraform_keyvaultsecret](#module_azure_prdsvc_terraform_keyvaultsecret) | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-keyvaultsecret | 0.3.2 |
| <a name="module_azure_prdsvc_terraform_privateendpoint_vault"></a> [azure_prdsvc_terraform_privateendpoint_vault](#module_azure_prdsvc_terraform_privateendpoint_vault) | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-privateendpoint | 0.7.2 |

## Resources

| Name | Type |
|------|------|
| [time_sleep.wait_keyvault_pe](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_enabled_for_deployment"></a> [enabled_for_deployment](#input_enabled_for_deployment) | (Optional) Specifies whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault. | `bool` | `false` | no |
| <a name="input_enabled_for_disk_encryption"></a> [enabled_for_disk_encryption](#input_enabled_for_disk_encryption) | (Optional) Specifies whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys. | `bool` | `false` | no |
| <a name="input_enabled_for_template_deployment"></a> [enabled_for_template_deployment](#input_enabled_for_template_deployment) | (Optional) Specifies whether Azure Resource Manager is permitted to retrieve secrets from the key vault. | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_key_vault_certificates"></a> [key_vault_certificates](#input_key_vault_certificates) | (Optional) A map of Key vault certificates to be created using following variables:<br/>  cert_number            = "(Required) Specifies certificate number for multiple certificates to be created."<br/>  import_certificate     = "(Required) Choose to import certificate or to generate one."<br/>  path_of_certificate    = "(Optional) Provide the path of the existing certificate. (Required) in case of import_certificate as True."<br/>  issuer_parameters_name = "(Required) The name of the Certificate Issuer. Changing this forces a new resource to be created."<br/>  ec_key_required        = "(Required) Do you want to create an `EC` key?"<br/>  curve                  = "(Optional) Specifies the curve to use when creating an EC key. Possible values are P-256, P-256K, P-384, and P-521.This field will be required in a future release if key_type is EC or EC-HSM. Changing this forces a new resource to be created."<br/>  key_type               = "(Required) Specifies the type of key. Changing this forces a new resource to be created."<br/>  key_size               = "(Optional) The size of the key used in the certificate. This property is required when using RSA keys. Changing this forces a new resource to be created."<br/>  reuse_key              = "(Required) Is the key reusable? Changing this forces a new resource to be created."<br/>  action_type            = "(Required) The Type of action to be performed when the lifetime trigger is triggerec. Changing this forces a new resource to be created."<br/>  content_type           = "(Required) The Content-Type of the Certificate, such as application/x-pkcs12 for a PFX or application/x-pem-file for a PEM. Changing this forces a new resource to be created."<br/>  key_usage              = "(Required) A list of uses associated with this Key. Possible values are cRLSign, dataEncipherment, decipherOnly, digitalSignature, encipherOnly, keyAgreement, keyCertSign, keyEncipherment and nonRepudiation. Changing this forces a new resource to be created."<br/>  trigger = object({<br/>    days_before_expiry  = optional(number, null)<br/>    lifetime_percentage = optional(string, null)<br/>  })<br/>  x509_certificate_properties = object({<br/>    extended_key_usage = "(Optional) A list of Extended/Enhanced Key Usages. Changing this forces a new resource to be created."<br/>    subject            = "(Required) The Certificate's Subject. Changing this forces a new resource to be created."<br/>    subject_alternative_names = list(object({<br/>      dns_names = "(Optional) A list of alternative DNS names (FQDNs) identified by the Certificate. Changing this forces a new resource to be created."<br/>      emails    = "(Optional) A list of email addresses identified by this Certificate. Changing this forces a new resource to be created."<br/>      upns      = "(Optional) A list of User Principal Names identified by the Certificate. Changing this forces a new resource to be created."<br/>    }))<br/>    validity_in_months = "(Required) The Certificates Validity Period in Months. Changing this forces a new resource to be created."<br/>  })<br/>})) | <pre>map(object({<br/>    cert_number            = string<br/>    path_of_certificate    = optional(string, null)<br/>    issuer_parameters_name = string<br/>    ec_key_required        = bool<br/>    curve                  = optional(string, "P-256")<br/>    key_type               = string<br/>    key_size               = optional(number, 2048)<br/>    reuse_key              = bool<br/>    action_type            = string<br/>    content_type           = string<br/>    key_usage              = list(string)<br/>    trigger = object({<br/>      days_before_expiry  = optional(number, null)<br/>      lifetime_percentage = optional(string, null)<br/>    })<br/>    x509_certificate_properties = object({<br/>      extended_key_usage = optional(list(string))<br/>      subject            = string<br/>      subject_alternative_names = object({<br/>        dns_names = optional(list(string))<br/>        emails    = optional(list(string))<br/>        upns      = optional(list(string))<br/>      })<br/>      validity_in_months = string<br/>    })<br/>  }))</pre> | `{}` | no |
| <a name="input_key_vault_keys"></a> [key_vault_keys](#input_key_vault_keys) | (Optional) A map of Key vault key object variables:<br/>  key_number = "(Required) Specifies key number for multiple keys to be created."<br/>  key_type   = "(Optional) Specifies the Key Type to use for the Key Vault Key."<br/>  key_size   = "(Optional) Specifies the Size of the RSA key to create in bytes. Allowed values are 1024, 2048, 3072 or 4096."<br/>  not_before_date = "(Optional) Key not usable before the provided UTC datetime (Y-m-d'T'H:M:S'Z')."<br/>  expiration_date = "(Required) Expiration UTC datetime (Y-m-d'T'H:M:S'Z')."<br/>  key_opts        = "(Required) A list of JSON web key operations. Possible values include: decrypt, encrypt, sign, unwrapKey, verify and wrapKey."<br/>  rotation_policy = (Optional) object({<br/>    notify_before_expiry = "(Required) Expire a Key Vault Key after given duration as an ISO 8601 duration."<br/>    time_before_expiry   = "(Required) Rotate automatically at a duration before expiry as an ISO 8601 duration."<br/>    time_after_creation  = "(Optional) Rotate automatically at a duration after create as an ISO 8601 duration."<br/>    expire_after         = "(Required) Expire a Key Vault Key after given duration as an ISO 8601 duration.<br/>  }) | <pre>map(object({<br/>    key_number      = string<br/>    key_type        = optional(string, "RSA-HSM")<br/>    key_size        = optional(number, 4096)<br/>    not_before_date = optional(string, null)<br/>    expiration_date = string<br/>    key_opts        = list(string)<br/>    rotation_policy = object({<br/>      notify_before_expiry = string<br/>      time_before_expiry   = string<br/>      time_after_creation  = optional(string, null)<br/>      expire_after         = string<br/>    })<br/>  }))</pre> | `{}` | no |
| <a name="input_key_vault_secrets"></a> [key_vault_secrets](#input_key_vault_secrets) | (Optional) A map of key vault secrets to be created with following variables:<br/>  secret_number   = "(Required) Specifies secret number for multiple secrets to be created."<br/>  value           = "(Required) Specifies the value of the Key Vault Secret. Changing this will create a new version of the Key Vault Secret."<br/>  content_type    = "(Optional) Specifies the content type of the Key Vault Secret."<br/>  not_before_date = "(Optional) Key not usable before the provided UTC datetime (Y-m-d'T'H:M:S'Z')."<br/>  expiration_date = "(Optional) Expiration UTC datetime (Y-m-d'T'H:M:S'Z')." | <pre>map(object({<br/>    secret_number   = string<br/>    value           = string<br/>    content_type    = optional(string, null)<br/>    not_before_date = optional(string, null)<br/>    expiration_date = optional(string, null)<br/>  }))</pre> | `{}` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_network_acls"></a> [network_acls](#input_network_acls) | (Optional) The network ACL configuration for the Key Vault.<br/>If not specified then the Key Vault will be created with a firewall that blocks access.<br/>Specify `null` to create the Key Vault with no firewall.<br/><br/>- `bypass` - (Optional) Should Azure Services bypass the ACL. Possible values are `AzureServices` and `None`. Defaults to `None`.<br/>- `default_action` - (Optional) The default action when no rule matches. Possible values are `Allow` and `Deny`. Defaults to `Deny`.<br/>- `ip_rules` - (Optional) A list of IP rules in CIDR format. Defaults to `[]`.<br/>- `virtual_network_subnet_ids` - (Optional) When using with Service Endpoints, a list of subnet IDs to associate with the Key Vault. Defaults to `[]`. | <pre>object({<br/>    bypass                     = optional(string, "None")<br/>    default_action             = optional(string, "Deny")<br/>    ip_rules                   = optional(list(string), [])<br/>    virtual_network_subnet_ids = optional(list(string), [])<br/>  })</pre> | `{}` | no |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_private_endpoint"></a> [private_endpoint](#input_private_endpoint) | (Required) Private Endpoint variables for Keyvault:<br/>  subnet_id                         = "(Required) The ID of the Subnet from which Private IP Addresses will be allocated for this Private Endpoint. Changing this forces a new resource to be created."<br/>  is_manual_connection              = "(Optional) Does the Private Endpoint require Manual Approval from the remote resource owner? Changing this forces a new resource to be created."<br/>  static_ip_required                = "(Optional) Whether a Static IP is required to be assigned to Private Endpoint or not."<br/>  private_connection_resource_id    = "(Optional) The ID of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to. One of `private_connection_resource_id` or `private_connection_resource_alias` must be specified. Changing this forces a new resource to be created."<br/>  private_connection_resource_alias = "(Optional) The Service Alias of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to. One of private_connection_resource_id or private_connection_resource_alias must be specified. Changing this forces a new resource to be created."<br/>  ip_configuration = (Optional) map(object({<br/>  private_ip_address = "(Required) Specifies the static IP address within the private endpoint's subnet to be used. Changing this forces a new resource to be created."<br/>  subresource_name   = "(Optional) Specifies the subresource this IP address applies to."<br/>  member_name        = "(Optional) Specifies the member name this IP address applies to."<br/>})) | <pre>object({<br/>    subnet_id                         = string<br/>    is_manual_connection              = optional(bool, false)<br/>    static_ip_required                = optional(bool, false)<br/>    private_connection_resource_id    = optional(string, null)<br/>    private_connection_resource_alias = optional(string, null)<br/>    ip_configuration = optional(map(object({<br/>      private_ip_address = string<br/>      subresource_name   = optional(string, "vault")<br/>      member_name        = optional(string, "default")<br/>    })), {})<br/>  })</pre> | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) The name of the Resource group for key vault creation. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku_name](#input_sku_name) | (Optional) The Name of the Sku used for the Key Vault. Possible values are standard and premium. | `string` | `"premium"` | no |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_key_vault_certificate_id"></a> [key_vault_certificate_id](#output_key_vault_certificate_id) | The ID's of the Key Vault Certificate. |
| <a name="output_key_vault_certificate_resource"></a> [key_vault_certificate_resource](#output_key_vault_certificate_resource) | The Resource of the Key Vault Certificate. |
| <a name="output_key_vault_id"></a> [key_vault_id](#output_key_vault_id) | The ID of the Key Vault. |
| <a name="output_key_vault_key_id"></a> [key_vault_key_id](#output_key_vault_key_id) | The ID's of the Key Vault Key. |
| <a name="output_key_vault_key_resource"></a> [key_vault_key_resource](#output_key_vault_key_resource) | The Resource of the Key Vault Key. |
| <a name="output_key_vault_name"></a> [key_vault_name](#output_key_vault_name) | The name of the Key Vault. |
| <a name="output_key_vault_resource"></a> [key_vault_resource](#output_key_vault_resource) | The Resource of the Key Vault. |
| <a name="output_key_vault_secret_id"></a> [key_vault_secret_id](#output_key_vault_secret_id) | The ID's of the Key Vault Secret. |
| <a name="output_key_vault_secret_resource"></a> [key_vault_secret_resource](#output_key_vault_secret_resource) | The Resource of the Key Vault Secret. |
| <a name="output_vault_private_endpoint_id"></a> [vault_private_endpoint_id](#output_vault_private_endpoint_id) | The ID of the Private Endpoint used for the Key Vault. |
<!-- END_TF_DOCS -->
