---
version: 1.0.2
available_versions:
  - 1.0.2
  - 1.0.1
  - 1.0.0
  - 0.2.1
  - 0.2.0
---

<!-- BEGIN_TF_DOCS -->
# Relay Service

## Overview

This terraform module creates a relay namespace and associated resources.

## Prerequisites

- `Resource Group` should exist.

## Guidance

#### Usage

- The Azure Relay service enables to securely expose services that run in corporate network to the public cloud. This is achieved without opening a port on firewall, or making intrusive changes to the corporate network infrastructure.
- Relay service module comprises four resource types such as `Relay Namespace`, `Relay Namespace Authorization Rule`, `WCF Relay`, `WCF Authorization Rule`.
- `Hybrid Relay Connection`, `Hybrid Authorization Rule` are out of scope for this module.
- The number of shared access authorization rules per namespace, queue, topic is 12. Please note that subsequent rules for creation are rejected.
- Since `Public network access` is disabled, application users need to use private endpoint to establish the connectivity with the Relay service at the time of deployment.
- If there is no requirement to have the `WCF Authorization Rules` to be created. Users can set the variable `create_wcf_rules` to `false` to bypass.
- Multiple Wcf relays, rules and their association are achieved by matching the `relay_name` object of wcf_authorization_rules variable with the `keys` of wcf_relay map object as shown below.

```
  wcf_relay = { #multiple relays
    relay1 = {
      name                      = "relay1"
      relayType                 = "NetTcp"
      requiresTransportSecurity = true
      userMetadata              = "Relay 1 metadata"
    },
    relay2 = {
      name                      = "relay2"
      relayType                 = "Http"
      requiresTransportSecurity = false
      userMetadata              = "Relay 2 metadata"
    }
  }

  wcf_authorization_rules = { #multiple rules against relay servers
    key1 = {
      relay_name = "relay1"
      name       = "AuthRule1"
      rights     = ["Send"]
    },
    key2 = {
      relay_name = "relay1"
      name       = "AuthRule2"
      rights     = ["Listen"]
    },
    key3 = {
      relay_name = "relay2"
      name       = "AuthRule3"
      rights     = ["Send"]
    }
  }
```

#### Security Considerations

- Public network access for relay service is disabled as per below implemented property.
    ```
    body = jsonencode({
      properties = {
        publicNetworkAccess = "Disabled"
    }
  })
    ```

#### Additional Information

- AzAPI using `Microsoft.Relay/namespaces/wcfRelays/authorizationRules` experiences issues while creating muliptle rules concurrently. There is no issue with creation of single rule. All we observed during the deployment phase is that messaging gateway not able to handle multiple requests at a time and leads to failure apparently.
- To limit the rate-off and introduce delay after each resource creation. The native argument `locks` of azapi resource is implemented in the code. Basically it's used to create one resource at a time during the iteration process.
- During idempotency tests, it is observed that `location` attribute inherits the wcf relay and wcf authorization rules from the parent relay namespace resource. Though this attribute is not required to be defined at both resource types of AzAPI provider, terraform reapply causes force replacement of location attribute and resulting the wcf relay and it's rule resources to be deleted and recreated.
- Support case of AzAPI provider reveals that there is an upstream API issue and hence the location attribute is not getting updated properly. We've been advised with a workaround of disabling the `schema_validation` in code and to explicitly add the property `location` and ignore the same with `ignore_changes` of lifecycle meta argument for both the resources. The resource redeployment is currently mitigated from being deleted and recreated. Also, this issue shall be seen fixed in the upcoming API versions as stated by the AzAPI provider. We will update the module accordingly once the reported bug is fixed.

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-ARN-AC_010 | Disable Public Network Access | Azure Relay must enforce a network guardrail where possible (What) within Networking settings (How) in order to prevent unauthorised access and data exposure to the internet (Why) | True  | True | This control is implemented by hardcoding the value as `Disabled` against the property `publicNetworkAccess` |
| 2. | AZU-ARN-AC_020 | Client Authorisation must be enabled | Client Authorisation must be enabled (What) within WCF relay settings  (How) To prevent anonymous unauthorised access to the Relay that could create a service interruption  (Why) | True | True | This control is implemented by hardcoding the value to `true` against the property `requiresClientAuthorization` |
| 3. | AZU-ARN-AU_010 | Send all diagnostic log categories to a central SOC Log Analytics workspace | Azure Relay must send all diagnostic logs to a central SOC Log Analytics workspace (What) via Diagnostic settings (How) in order to support a security investigation after a security incident (Why) | False | False |  SOC related control: Will be implemented through policy at management group level. |
| 4. | AZU-ARN-AU_020 | Send all diagnostic log categories to a central SOC Storage Account | Azure Relay must send all diagnostic logs to a central SOC Storage Account (What) via Diagnostic settings (How) In order to provide an immutable copy to adhere to compliance requirements (Why) | False | False | SOC related control: Will be implemented through policy at management group level. |
| 5. | AZU-ARN-AU_030 |  Sending diagnostic logs to a partner solution requires CyberSecurity risk assessment and approval | Sending diagnostic logs to a partner solution requires CyberSecurity risk assessment and approval (What) within Diagnostic settings (How) in order to prevent sensitive data leakage to third parties outside of LSEG control (Why) | False | False | This control will be implemented by LSEG standard policy. |
| 6. | AZU-ARN-SC_010 | Network connections to the Azure WCF Relays control and data planes must use TLS encryption |  Network connections to the Azure WCF Relays control and data planes must use TLS encryption (What) within Overview WCF relay settings (How) in order to use modern techniques to establish robust encrypted data channels over untrusted networks  (Why) | True | True | This control is implemented by hardcoding the value to `true` against the property `requiresTransportSecurity` |
| 7. | AZU-ARN-SC_020 | Use a minimum of TLS version 1.2 for network connections to Azure WCF endpoints | Network connections to WCF endpoints must enforce a minimum TLS version of 1.2  (What) within the on-premises data gateway application (How) in order to use modern techniques to establish robust encrypted data channels over untrusted networks  (Why) | False | False | This control will be implemented by LSEG standard policy. |
| 8. | AZU-ARN-SC_030 | Azure Relay must not be able to corrupt the centrally managed private link private DNS zones when making a private endpoint for Azure Relay | Azure Relay must have an Azure DeployIfNotExists policy to update the centrally managed private link private DNS zones with its private A record (What) via policy to management group mapping (How) to ensure there is no ability for the Azure App Deployment team to have authorisation over these zones that could allow them to corrupt this file and impact service availability | False | False | This control will be implemented by LSEG standard policy. |

## SMCF Controls

| S. No.  | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|---------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types.<br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc.<br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC<br><br>Documentation | True | This control will be implemented using resource naming module.<br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames) |
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC<br><br>Policy | True | This control will be implemented using `tags` parameter.<br><br>This control is achieved by custom policy as described in the [clear listing page](https://dev.azure.com/LSEGroup/Foundation/_git/azu-plat-policy) from where it inherits all the mandatory tags. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties.<br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration. | Policies<br><br>Iac<br><br>Policies<br><br>Iac | True | This control will be implemented by having all the `Mandate` and most of the `Optional ` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring) | SMCF-OPS-03-02: Define and automate resource operation and security log collection<br><br>SMCF-OPS-03-03: Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs) | Policy<br><br>Documentation<br><br>Documentation | True | This control will be implemented by `DINE` Policy.<br><br>[Azure Relay metrics in Azure Monitor ](https://learn.microsoft.com/en-us/azure/azure-relay/relay-metrics-azure-monitor)<br><br>[Enable diagnostics logs for Azure Relay Hybrid Connections ](https://learn.microsoft.com/en-us/azure/azure-relay/diagnostic-logs)<br><br>[Supported metrics for Azure Relay ](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-relay-namespaces-metrics) |
| 5.| [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC<br><br>Documentation | False | This control shall be implemented by deploying `Relay Namespace` in multiple availability zones manually, since no arguments representing `High-Availability` are available at code level. <br><br>[Reliability guidance overview ](https://learn.microsoft.com/en-us/azure/reliability/overview-reliability-guidance) |
| 6. | [SMCF-OPS-07: Resource Protection](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-07-01: Prevent accidental or malicious deletion of production resources<br><br>SMCF-OPS-07-02: Prevent accidental misconfiguration of key production resources | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard based on application team requirement. <br><br>[Lock your resources to protect your infrastructure](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json) |
| 7. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package and has a JIT implementation in place. <br><br>[Azure Relay authentication and authorization ](https://learn.microsoft.com/en-us/azure/azure-relay/relay-authentication-and-authorization) |

## Changelog

- [azure-prdsvc-terraform-relaynamespace](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/azure-relay/relay-what-is-it)

### Terraform Docs

- [azurerm_relay_namespace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/relay_namespace)
- [azurerm_relay_namespace_authorization_rule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/relay_namespace_authorization_rule)
- [azapi_resource](https://learn.microsoft.com/en-us/azure/templates/microsoft.relay/namespaces/wcfrelays?pivots=deployment-language-terraform)
- [azapi_resource](https://learn.microsoft.com/en-us/azure/templates/microsoft.relay/namespaces/wcfrelays/authorizationrules?pivots=deployment-language-terraform)

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
| [azapi_resource.wcf](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) | resource |
| [azapi_resource.wcfrules](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) | resource |
| [azapi_update_resource.publicnetworkaccess](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/update_resource) | resource |
| [azurerm_relay_namespace.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/relay_namespace) | resource |
| [azurerm_relay_namespace_authorization_rule.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/relay_namespace_authorization_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_create_wcf_rules"></a> [create_wcf_rules](#input_create_wcf_rules) | (Optional) To create wcf rules or not. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_namespace_authorization"></a> [namespace_authorization](#input_namespace_authorization) | (Optional)<br/>map(object({<br/>  name   = (Required) The name which should be used for this Azure Relay Namespace Authorization Rule. Changing this forces a new Azure Relay Namespace Authorization Rule to be created.<br/>  listen = (Optional) Grants listen access to this Authorization Rule. Defaults to false.<br/>  send   = (Optional) Grants send access to this Authorization Rule. Defaults to false.<br/>  manage = (Optional) Grants manage access to this Authorization Rule. When this property is true - both listen and send must be set to true too. Defaults to false. For namespace auth rule to be created, any one of the three must be set to true.<br/>})) | <pre>map(object({<br/>    name   = string<br/>    listen = optional(bool, false)<br/>    send   = optional(bool, false)<br/>    manage = optional(bool, false)<br/>  }))</pre> | `null` | no |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku_name](#input_sku_name) | (Required) The name of the SKU to use. At this time the only supported value is Standard. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |
| <a name="input_wcf_authorization_rules"></a> [wcf_authorization_rules](#input_wcf_authorization_rules) | (Optional)<br/>map(object({<br/>  relay_name = (Required) The name of the WCF Relay.<br/>  name       = (Required) The authorization rule name.<br/>  rights     = (Required) String array containing any of: "Listen", "Manage", "Send". Providing manage rights requires both listen and send to be selected.<br/>})) | <pre>map(object({<br/>    relay_name = string<br/>    name       = string<br/>    rights     = list(string)<br/>  }))</pre> | `null` | no |
| <a name="input_wcf_relay"></a> [wcf_relay](#input_wcf_relay) | (Required)<br/>map(object({<br/>  name                      = (Required) The name of the WCF Relay.<br/>  relayType                 = (Required) The value of the WCF relay type should either be "Http" or "NetTcp".<br/>  userMetadata              = (Optional) The usermetadata is a placeholder to store user-defined string data for the WCF Relay endpoint. For example, it can be used to store descriptive data, such as list of teams and their contact information. Also, user-defined configuration settings can be stored.<br/>})) | <pre>map(object({<br/>    name         = string<br/>    relayType    = string<br/>    userMetadata = optional(string)<br/>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The ID of the created relay namespace. |
| <a name="output_name"></a> [name](#output_name) | The Name of the relay namespace. |
| <a name="output_namespace_authorization_id"></a> [namespace_authorization_id](#output_namespace_authorization_id) | The ID of the relay namespace authorization rule. |
| <a name="output_namespace_authorization_name"></a> [namespace_authorization_name](#output_namespace_authorization_name) | The Name of the relay namespace authorization rule. |
| <a name="output_namespace_authorization_resource"></a> [namespace_authorization_resource](#output_namespace_authorization_resource) | The Resource of the created relay namespace authorization rule. |
| <a name="output_resource"></a> [resource](#output_resource) | The Resource of the created relay namespace. |
| <a name="output_wcf_authorization_resource"></a> [wcf_authorization_resource](#output_wcf_authorization_resource) | The Resource of the created wcf authorization rule. |
| <a name="output_wcf_authorization_rule_name"></a> [wcf_authorization_rule_name](#output_wcf_authorization_rule_name) | The Name of the wcf authorization rule. |
| <a name="output_wcf_relay_name"></a> [wcf_relay_name](#output_wcf_relay_name) | The Name of the wcf relay. |
| <a name="output_wcf_resource"></a> [wcf_resource](#output_wcf_resource) | The Resource of the created wcf relay. |
<!-- END_TF_DOCS -->
