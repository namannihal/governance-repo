<!-- BEGIN_TF_DOCS -->
# RedisCache   and Database Service Pattern

[[_TOC_]]

This readme provides an overview of an service pattern for RedisCache. The solution proposed below provides an easy predefined template built on top of LSEG approved Cloud Products (with identified common configurations) and the service pattern intended to help application teams with rapid deployments of infrastructure.

Here are some of the key advantages the proposed solution offers:

* **Rapid Deployment:** Service patterns are pre-defined templates that can be easily reused which accelerates the deployment process by eliminating the need to write configurations from scratch for each deployment, saving time and effort.
* **Standardization and Consistency:** Service patterns provide standardized templates and best practices for deploying specific  infrastructure that promotes consistent configurations. This ensures consistency across deployments, reducing the likelihood of configuration drifts/errors and making it easier to maintain and scale infrastructure.
* **Documentation:** Service pattern comes with built-in documentation that explain the purpose and usage of various components.
* **Security and Compliance:** Service pattern built on top of approved Cloud Products incorporate security best practices and compliance requirements, ensuring that infrastructure is deployed with security in mind from the outset. This reduces the likelihood of security vulnerabilities.
* **Reuse, Sharing and customization:** Teams can share and reuse patterns across projects and organizations. Patterns can be adapted, and customized over time as infrastructure/business requirements change.
* **Version Control:** Patterns can be version-controlled, allowing teams to track changes, roll back to previous configurations if issues arise, and collaborate more effectively through version control systems.

## Pattern Description

This section contains the details of the azure service technical use case.

The following diagram shows the High Level Design for **Service pattern for RedisCache**:

[Image: RedisCachesvcpatHLD]

**Note** Components in Green background are to be only deployed by the pattern IaC rest all other components are to be seen as dependencies.

### Provisioned Azure services through IaC

* Azure RedisCache
* Azure Keyvault with private endpoint (Optional).
* Subnet (Optional).
* Network Security group (Optional).
* Route Table (Optional).
* User managed identity
* Private Endpoint for Azure RedisCache (Optional).

### Identity management

* Redis to be authenticated via Redis key or Redis connection string.
* Note: Redis access keys are stored in the keyvault as secrets for which the expiration data can be set using the variable `key_vault_config.kv_secret_expiration_in_months`, Note that this is only the expiration date of the secret and not the access keys for the actual redis server.

### Secret management

* Azure Key Vault (AKV) is offered as an optional component, and it serves as the repository for the both primary and secondary keys/ connection string.

### Networking

* Above services are to be deployed in LSEG complaint non routable VNET (scaffolded in application landing zone).
* Redis to support both VNET integration and Private endpoints for connectivity as part of service pattern.
* Pattern to support VNET integration (VNET Injection) and private endpoint (Private Link) based connectivity, though Microsoft recommends Private Link based connectivity, Please refer [here](https://learn.microsoft.com/en-us/azure/azure-cache-for-redis/cache-network-isolation)
* Azure Redis VNET integration requires a Subnet. Subnet creation would be provided as an optional component.
* For external traffic (for ex: Hub VNET) specific ports (6380) and Redis dependencies are needed to be whitelisted in firewall component in routable VNET.

### Availability

* Pattern to support geo redundancy and zone replicas.

### Other Information

* Pattern to support only Basic, Standard and Premium skew.
* As per Redis product 99.9% availability is covered only in Standard and Premium sku, please refer Microsoft documentation [here](https://learn.microsoft.com/en-us/azure/well-architected/service-guides/azure-cache-redis/reliability)

### Security Consideration

1. Design will be based on [Security MEC](https://lsegroup.sharepoint.com/:x:/s/SecurityArchitecture/EYQvir35WzRCmLxqDffLLdYBjpA_dLmEnrzPvmHPT8xjfA?e=YJC4MB)
2. Admin management can be performed using via Azure Bastion to login in to Virtual machine through which Redis service can be reached.
3. All Keys / Connection string will managed in Key Vault.

### HA & DR

1. Service can be deployed across all AZ.
2. As a global service, high availability to be configurable.
3. Data durability is out of scope, means during unplanned failure data can be dropped.

### Back Up

1. Data durability is out of scope, means during unplanned failure data can be dropped.
2. No additional backup requirements are identified

## Pattern Composibilty

The section describes what optional components are considered in the service pattern and which inputs govern and effect the deployement of these components

[Image: RedisCachesvcpatHLD]

## Pattern usage Guidance

### Pattern Use Cases

| Use Case                                                                                                                                              | Default Behaviour                                                                                                                                                                                                                                                                                                      | Input Control - variable                                                             | Comments                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| ----------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Deploy Azure KeyVault or use an existing Keyvault                                                                                                     | By Default the patterns deploys Keyvault                                                                                                                                                                                                                                                                               | `key_vault_config.deploy_kv_and_pe`                                                  | The variable `key_vault_config.deploy_kv_and_pe` if set to true deploys the Azure keyvault with private endpoint the configurations of this keyvault can be manged under the key_vault_config varaiable.to use existing keyvault use the `key_vault_config.key_vault_id` input and set `key_vault_config.deploy_kv_and_pe` to false.                                                                                                                                                                                                                                                                                                                |
| Deploy RedisCache with Vnet-injection or Private endpoint                                                                                             | The Pattern deploys Redis cache with Private endpoint by default.                                                                                                                                                                                                                                                      | `network_config.use_vnet_injection`                                                  | By default the value of `network_config.use_vnet_injection` is false, which implies that RedisCache is deployed with private endpoint. If the value is set to true, a subnet is deployed along with NSG and Routetable. With a set of Required NSG rules. THe configuraion of these resouces can be managed through `network_config` varaible. More details can be found here [cache-how-to-premium-vnet](https://learn.microsoft.com/en-us/azure/azure-cache-for-redis/cache-how-to-premium-vnet)                              |
| Deploy Route table or use exisisting routetable                                                                                                       | The Pattern deploys a new route table by default with routes from onprem, azure and internet forwarded to firewall.                                                                                                                                                                                                    | `network_config.route_table`                                                         | If the value of `network_config.route_table.route_table_id` is not provided, a new route table is deployed with 3 routes by default, which is also configurable by using `network_config.route_table.route`                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| Deploy Redis cache as secondary server                                                                                                                | The pattern deploys Redis Cache as primary server without any linked servers by default                                                                                                                                                                                                                                | `deploy_as_secondary_linked_server`                                                  | To deploy Redis Cache as secondary use the flag `deploy_as_secondary_linked_server` along with the variables `var.primary_redis_cache_name`, `var.primary_redis_cache_resource_group_name`                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| Deploy Redis cache with HA refer to this [link](https://learn.microsoft.com/en-us/azure/azure-cache-for-redis/cache-high-availability) for more info. | The pattern deploys Redis cache using `zones` as `[]` and Redis cache is deployed as primary with no linked secondary servers                                                                                                                                                                                          | `deploy_as_secondary_linked_server`, `zones`                                         | To deploy Redis With Zone reduncacy use the `zones` variable to deploy redis into multiple zones. To achive geo_redundancy deploy multiple redis caches one as primary and the other as secondary in different regions and use the `deploy_as_secondary_linked_server` parameter to deploy as secondary                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| Enable AAD authentication in redis cache   | By default AAD authentication is disabled  | `redis_congiguration.active_directory_authentication_enabled`                                               | When AAD is enabled , Adding a manged identity or service principal to connect to Redis cache is mandatory. This identity is assigned Data Owner Access Policy By default. `policy_assignments` can be used to set additional policies.                                                                                                                                                                                                                                                                                                                                                                                                                   

### Pattern Usage

#### Prerequisites

1. Routable and Non-routable Virtual networks
2. Peering between Routabe and Non-routable Virtual networks

#### Build and Test

1. Call the module whichever is needs to be deployed. As the example given below,

```tf
  module "azure-prdsvcpat-terraform-rediscache" {
    source              = "git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvcpat/terraform/azure-prdsvcpat-terraform-rediscache?ref=<pattern-version-tag>"
    org_id              = var.org_id
    app_id              = var.app_id
    location            = var.location
    environment         = var.environment
    context             = local.context
    instance            = var.instance
    tags                = var.tags

    #### Platform and Application Dependencies ####
    resource_group_name         = var.resource_group_name
    shared_nrtbl_vnet_id        = var.shared_nrtbl_vnet_id
    privateendpoint_subnet_id   = var.privateendpoint_subnet_id
    firewall_private_ip_address = var.azure_firewall_id != null ? data.azurerm_firewall.afw[0].ip_configuration[0].private_ip_address : null

    #### Redis Service Pattern Variables
    key_vault_config                        = var.key_vault_config
    network_config                          = var.network_config
    capacity                                = var.capacity
    sku                                     = var.sku
    patch_schedule                          = var.patch_schedule
    replicas_per_master                     = var.replicas_per_master
    replicas_per_primary                    = var.replicas_per_primary
    shard_count                             = var.shard_count
    zones                                   = var.zones
    deploy_as_secondary_linked_server       = var.deploy_as_secondary_linked_server
    primary_redis_cache_name                = var.primary_redis_cache_name
    primary_redis_cache_resource_group_name = var.primary_redis_cache_resource_group_name
    redis_configuration                     = var.redis_configuration
    policy_assignments                      = var.policy_assignments
    firewall_rules                          = var.firewall_rules
}
```

1. Update the source with right tag version.
2. Check the terraform.tfvars file and update the values of org_id, app_id, location, context and instance.
3. If the plan is use to use the existing resouce available on azure then plase make an use of 'data block'
4. Update the values of variables in '.tfvars file'. In above example all `var.` varaibles are coming from the terraform.tfvars file in the .tests/deployTest folder.
5. **Note: The .tests/deployTest folder is for for deployment and unit test cases , Use only as reference and not as the exact implementation of the pattern.**

## Changelog

* [azure-prdsvcpat-terraform-rediscache](CHANGELOG.md)

## References

### Microsoft Docs

* [Official Documentation](https://learn.microsoft.com/en-us/azure/azure-cache-for-redis/cache-overview)

### Terraform Docs

* [azurerm\_redis\_cache](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/redis_cache)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.5.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm) | >= 3.51, <= 3.117 |
| <a name="requirement_time"></a> [time](#requirement_time) | ~>0.12.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_time"></a> [time](#provider_time) | ~>0.12.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_azure-prdsvc-terraform-keyvault"></a> [azure-prdsvc-terraform-keyvault](#module_azure-prdsvc-terraform-keyvault) | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-keyvault | 0.7.0 |
| <a name="module_azure-prdsvc-terraform-networksecuritygroup"></a> [azure-prdsvc-terraform-networksecuritygroup](#module_azure-prdsvc-terraform-networksecuritygroup) | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-networksecuritygroup | 0.6.1 |
| <a name="module_azure-prdsvc-terraform-privateendpoint-akv"></a> [azure-prdsvc-terraform-privateendpoint-akv](#module_azure-prdsvc-terraform-privateendpoint-akv) | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-privateendpoint | 0.7.0 |
| <a name="module_azure-prdsvc-terraform-privateendpoint-redis"></a> [azure-prdsvc-terraform-privateendpoint-redis](#module_azure-prdsvc-terraform-privateendpoint-redis) | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-privateendpoint | 0.7.0 |
| <a name="module_azure-prdsvc-terraform-rediscache"></a> [azure-prdsvc-terraform-rediscache](#module_azure-prdsvc-terraform-rediscache) | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-rediscache | 0.6.0 |
| <a name="module_azure-prdsvc-terraform-redislinkedserver"></a> [azure-prdsvc-terraform-redislinkedserver](#module_azure-prdsvc-terraform-redislinkedserver) | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-redislinkedserver | 0.1.3 |
| <a name="module_azure-prdsvc-terraform-routetable"></a> [azure-prdsvc-terraform-routetable](#module_azure-prdsvc-terraform-routetable) | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-routetable | 0.5.1 |
| <a name="module_azure-prdsvc-terraform-subnet-redis"></a> [azure-prdsvc-terraform-subnet-redis](#module_azure-prdsvc-terraform-subnet-redis) | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-subnet | 0.8.2 |
| <a name="module_azure-prdsvc-terraform-userassignedidentity"></a> [azure-prdsvc-terraform-userassignedidentity](#module_azure-prdsvc-terraform-userassignedidentity) | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-userassignedidentity | 0.3.1 |
| <a name="module_azure_prdsvc_terraform_keyvaultsecret_redis_primary_access_key"></a> [azure_prdsvc_terraform_keyvaultsecret_redis_primary_access_key](#module_azure_prdsvc_terraform_keyvaultsecret_redis_primary_access_key) | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-keyvaultsecret | 0.3.0 |
| <a name="module_azure_prdsvc_terraform_keyvaultsecret_redis_secondary_access_key"></a> [azure_prdsvc_terraform_keyvaultsecret_redis_secondary_access_key](#module_azure_prdsvc_terraform_keyvaultsecret_redis_secondary_access_key) | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-keyvaultsecret | 0.3.0 |

## Resources

| Name | Type |
|------|------|
| [time_rotating.expiration_date](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/rotating) | resource |
| [time_sleep.wait_keyvault_pe](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [time_sleep.wait_redis_pe](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_capacity"></a> [capacity](#input_capacity) | (Required) The size of the Redis cache to deploy. Valid values for a `C` SKU family (`Basic` or `Standard`) are `0`, `1`, `2`, `3`, `4`, `5`, `6`. For `P` SKU family (`Premium`) valid values are `1`, `2`, `3`, `4`. | `number` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_deploy_as_secondary_linked_server"></a> [deploy_as_secondary_linked_server](#input_deploy_as_secondary_linked_server) | (Optional). Boolean, If set to true the Redis Cache is deployed and then linked as a secondary cache for geo-replication. Cannot be enabled when Zone-Redundancy is implemented. | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_firewall_private_ip_address"></a> [firewall_private_ip_address](#input_firewall_private_ip_address) | (Optional). Azure firewall private Ip Address. Used when creating routes to firewall during route table creation. | `string` | `null` | no |
| <a name="input_firewall_rules"></a> [firewall_rules](#input_firewall_rules) | "(Optional) List of Azure Redis Cache firewall rule specification."<br/>object({<br/>  name              = (Required) Specifies the name of the Firewall Rule.<br/>  start_ip_address  = (Required) The starting IP Address to allow through the firewall for this rule<br/>  end_ip_address    = (Required) The ending IP Address to allow through the firewall for this rule<br/>}) | <pre>list(object({<br/>    name             = string<br/>    start_ip_address = string<br/>    end_ip_address   = string<br/>  }))</pre> | `[]` | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_key_vault_config"></a> [key_vault_config](#input_key_vault_config) | Object with cofigration for the Keyvault. As defined below<br/>    context                         = context to be used for KeyVaults being deployed resources.<br/>    instance                        = instance to be used for KeyVaults being deployed resources.<br/>    deploy_kv_and_pe                = (Optional). Boolean to deploy KeyVault and Private Endpoint for KeyVault. Default is true.<br/>    key_vault_id                    = (Optional). KeyVault ID to be used for Private Endpoint for KeyVault. Required if deploy_kv_and_pe is false.<br/>    enabled_for_deployment          = (Optional). Boolean to enable KeyVault for deployment. Default is false.<br/>    enabled_for_disk_encryption     = (Optional). Boolean to enable KeyVault for disk encryption. Default is true.<br/>    enabled_for_template_deployment = (Optional). Boolean to enable KeyVault for template deployment. Default is false.<br/>    soft_delete_retention_days      = (Optional) The number of days that items should be retained for once soft-deleted.<br/>    sku_name                        = (Optional). Sku name for KeyVault. Default is premium.<br/>    kv_secret_expiration_in_months  = (Required). Number of months for which the secrets in KeyVault should be valid.<br/>    kv_admin_role_app_spn_object_id = (Required). Object ID for the SPN to add KeyVault administrator role.<br/>    kv_secret_instance                     = (Optional).  Instance to be used for KeyVault secrets being deployed resources.<br/>    secret_name_redis_primary_access_key   = (Optional).  Secret name for Redis primary access key.<br/>    secret_name_redis_secondary_access_key = (Optional).  Secret name for Redis secondary access key.<br/>    network_acls = (Optional). Object with network ACLs for KeyVault. As defined below<br/>        {<br/>            bypass                     = (Optional). Specifies whether traffic is bypassed for Azure services. Default is None. Possible values are None, AzureServices, Logging, Metrics, or AzureServices,Logging,Metrics.<br/>            default_action             = (Optional). Specifies the default action of allow or deny when no other rules match. Default is Deny. Possible values are Allow and Deny.<br/>            ip_rules                   = (Optional). List of IP addresses or CIDR ranges to whitelist. Only IPV4 addresses are allowed. This list must not include IP address ranges within Azure services. This list can include IP addresses ranges from on-premises ranges.<br/>            virtual_network_subnet_ids = (Optional). List of virtual network subnet ids to whitelist. This list must not include IP address ranges within Azure services.<br/>        }<br/>    private_endpoint = (Optional). Object with private endpoint configuration for KeyVault. As defined below<br/>        {<br/>            is_manual_connection              = (Optional). Boolean to indicate if the connection is manual. Default is false.<br/>            static_ip_required                = (Optional). Boolean to indicate if static IP is required. Default is false.<br/>            private_connection_resource_id    = (Optional). Resource ID of the private connection. Required if is_manual_connection is true.<br/>            private_connection_resource_alias = (Optional). Resource alias of the private connection. Required if is_manual_connection is true.<br/>            kv_ip_configuration = (Optional). Object with IP configuration for KeyVault. As defined below<br/>                {<br/>                    private_ip_address = (Required). Private IP address of the IP configuration.<br/>                    subresource_name   = (Optional). Subresource name of the IP configuration. Default is vault.<br/>                    member_name        = (Optional). Member name of the IP configuration. Default is default.<br/>                }<br/>        } | <pre>object({<br/>    context                                = optional(string, null)<br/>    instance                               = optional(string, null)<br/>    deploy_kv_and_pe                       = optional(bool, true)<br/>    key_vault_id                           = optional(string, null)<br/>    enabled_for_deployment                 = optional(bool, false)<br/>    enabled_for_disk_encryption            = optional(bool, true)<br/>    enabled_for_template_deployment        = optional(bool, false)<br/>    soft_delete_retention_days             = optional(number, 30)<br/>    sku_name                               = optional(string, "premium")<br/>    kv_secret_expiration_in_months         = number<br/>    kv_admin_role_app_spn_object_id        = optional(string, null)<br/>    kv_secret_instance                     = optional(string, null)<br/>    secret_name_redis_primary_access_key   = optional(string, null)<br/>    secret_name_redis_secondary_access_key = optional(string, null)<br/>    network_acls = optional(object({<br/>      bypass                     = optional(string, "None")<br/>      default_action             = optional(string, "Deny")<br/>      ip_rules                   = optional(list(string), [])<br/>      virtual_network_subnet_ids = optional(list(string), [])<br/>    }), {})<br/>    private_endpoint = optional(object({<br/>      is_manual_connection              = optional(bool, false)<br/>      static_ip_required                = optional(bool, false)<br/>      private_connection_resource_id    = optional(string, null)<br/>      private_connection_resource_alias = optional(string, null)<br/>      kv_ip_configuration = optional(map(object({<br/>        private_ip_address = string<br/>        subresource_name   = optional(string, "vault")<br/>        member_name        = optional(string, "default")<br/>      })), {})<br/>    }), null)<br/>  })</pre> | n/a | yes |
| <a name="input_key_vault_tags"></a> [key_vault_tags](#input_key_vault_tags) | (Optional) Key Vault related tags to be set on key vault child resources. | `map(any)` | `{}` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_network_config"></a> [network_config](#input_network_config) | Object with cofigration for Network, As Defined below<br/>  context                     = context to be used for all networking resources.      <br/>  instance                    = instance tpo be used for all networking resources.<br/>  use_vnet_injection          = (Optional) Whether to use vnet Injection with Redis cache, Requires Premium SKU, Defaults to false.<br/>  redis_subnet = (Optional). Only required when use_vnet_injection is set to true => {<br/>    address_prefix = IP address CIDRs for deploying the subnet where Redis is going to be Deployed. if use_vnet_injection is set to true.<br/>    private_static_ip_address = (Optional). The Static IP Address to assign to the Redis Cache when hosted inside the Virtual Network. Changing this forces a new resource to be created.<br/>    enforce_private_link_endpoint_network_policies = (Optional) Enable or disable network policies for the Private Endpoint on the subnet.<br/>    private_link_service_network_policies_enabled  = (Optional) Enable or disable network policies for the Private Link Service on the subnet.<br/>  }<br/>  nsg_security_rules = (Optional). Map of objects mentioned below security rules of the NSG to be deployed and attached with PSQL Subnet. As defined below<br/>      {<br/>          name                                       = "(Required) The name of the security rule."<br/>          description                                = "(Optional) A description for this rule. Restricted to 140 characters."<br/>          priority                                   = "(Required) Specifies the priority of the rule. The value can be between 100 and 4096. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule."<br/>          direction                                  = "(Required) The direction specifies if rule will be evaluated on incoming or outgoing traffic. Possible values are Inbound and Outbound."<br/>          access                                     = "(Required) Specifies whether network traffic is allowed or denied. Possible values are Allow and Deny."<br/>          protocol                                   = "(Required) Network protocol this rule applies to. Possible values include Tcp, Udp, Icmp, Esp, Ah or * (which matches all)."<br/>          source_port_range                          = "(Optional) Source Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if source_port_ranges is not specified."<br/>          destination_port_range                     = "(Optional) Destination Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if destination_port_ranges is not specified."<br/>          source_address_prefix                      = "(Optional) CIDR or source IP range or * to match any IP. Tags such as VirtualNetwork, AzureLoadBalancer and Internet can also be used. This is required if source_address_prefixes is not specified."<br/>          destination_address_prefix                 = "(Optional) CIDR or destination IP range or * to match any IP. Tags such as VirtualNetwork, AzureLoadBalancer and Internet can also be used. This is required if destination_address_prefixes is not specified."<br/>          source_application_security_group_ids      = "(Optional) A List of source Application Security Group IDs"<br/>          destination_application_security_group_ids = "(Optional) A List of destination Application Security Group IDs"<br/>      }<br/>  route_table = (Optional). Object with route table configuration for PSQL Subnet. As defined below<br/>        {<br/>            route_table_id                = (Optional). Route table ID to be used for PSQL Subnet. Required if route is not provided.<br/>            route                         = (Optional). A Map of objects mentioned below for route configuration of the route table.<br/>                {<br/>                    name                   = "(Required) The name of the route."<br/>                    address_prefix         = "(Required) The destination CIDR to which the route applies."<br/>                    next_hop_type          = "(Required) The type of Azure hop the packet should be sent to. Possible values are VirtualNetworkGateway, VnetLocal, Internet, VirtualAppliance and None."<br/>                    next_hop_in_ip_address = "(Optional) The IP address packets should be forwarded to. Next hop values are only allowed in routes where the next hop type is VirtualAppliance."<br/>                }<br/>            disable_bgp_route_propagation = (Optional). Boolean flag which controls propagation of routes learned by BGP on that route table. True means disable. False means enable. Default is false.<br/>        } | <pre>object({<br/>    context            = optional(string, null)<br/>    instance           = optional(string, null)<br/>    use_vnet_injection = optional(bool, false)<br/>    nsg_security_rules = optional(map(object({<br/>      name                                       = string<br/>      description                                = string<br/>      priority                                   = number<br/>      direction                                  = string<br/>      access                                     = string<br/>      protocol                                   = string<br/>      source_port_range                          = string<br/>      destination_port_range                     = string<br/>      source_address_prefix                      = string<br/>      destination_address_prefix                 = string<br/>      source_application_security_group_ids      = list(string)<br/>      destination_application_security_group_ids = list(string)<br/>    })), {})<br/>    route_table = optional(object({<br/>      route_table_id = optional(string, null)<br/>      route = optional(map(object({<br/>        name                   = string<br/>        address_prefix         = string<br/>        next_hop_type          = string<br/>        next_hop_in_ip_address = string<br/>      })), null)<br/>      disable_bgp_route_propagation = optional(bool, false)<br/>      }), {<br/>      route_table_id                = null<br/>      disable_bgp_route_propagation = false<br/>      route                         = null<br/>    })<br/>    redis_subnet = optional(object({<br/>      subnet_id                                      = optional(string, null)<br/>      address_prefix                                 = optional(string, null)<br/>      private_static_ip_address                      = optional(string, null)<br/>      enforce_private_link_endpoint_network_policies = optional(string, "Disabled")<br/>      private_link_service_network_policies_enabled  = optional(bool, false)<br/>    }), null)<br/>    private_endpoint = optional(object({<br/>      is_manual_connection              = optional(bool, false)<br/>      static_ip_required                = optional(bool, false)<br/>      private_connection_resource_id    = optional(string, null)<br/>      private_connection_resource_alias = optional(string, null)<br/>      ip_configuration = optional(map(object({<br/>        private_ip_address = string<br/>        subresource_name   = optional(string, "redisCache")<br/>        member_name        = optional(string, "redisCache")<br/>      })), {})<br/>    }), null)<br/>  })</pre> | `null` | no |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_patch_schedule"></a> [patch_schedule](#input_patch_schedule) | "(Optional) The scheduled maintenance for Azure Cache for Redis service to regularly updates the cache with the latest platform features and fixes."<br/>object({<br/>  day_of_week    = (Required) the Weekday name - possible values include Monday, Tuesday, Wednesday etc.<br/>  start_hour_utc = (Optional) the Start Hour for maintenance in UTC - possible values range from 0 - 23.<br/>}) | <pre>object({<br/>    day_of_week    = string<br/>    start_hour_utc = optional(number, 5)<br/>  })</pre> | n/a | yes |
| <a name="input_policy_assignments"></a> [policy_assignments](#input_policy_assignments) | "(Optional) Map of Access policy assignments for redis cache."<br/>object({<br/>  name                = (Required) The name of the Redis Cache Access Policy Assignment. Changing this forces a new Redis Cache Access Policy Assignment to be created.<br/>  access_policy_name  = (Required) The name of the Access Policy to be assigned. Changing this forces a new Redis Cache Access Policy Assignment to be created.<br/>  object_id           = (Required) The principal ID to be assigned the Access Policy. Changing this forces a new Redis Cache Access Policy Assignment to be created.<br/>  object_id_alias     = (Required) The alias of the principal ID. User-friendly name for object ID. Also represents username for token based authentication. Changing this forces a new Redis Cache Access Policy Assignment to be created.<br/>}) | <pre>map(object({<br/>    name               = string<br/>    access_policy_name = string<br/>    object_id          = string<br/>    object_id_alias    = string<br/>  }))</pre> | `{}` | no |
| <a name="input_primary_redis_cache_name"></a> [primary_redis_cache_name](#input_primary_redis_cache_name) | (Optional). The name of the primary Redis Cache. Required when 'deploy_as_secondary_linked_server' is set to true the Redis Cache is deployed and then linked as a secondary cache for geo-replication. | `string` | `null` | no |
| <a name="input_primary_redis_cache_resource_group_name"></a> [primary_redis_cache_resource_group_name](#input_primary_redis_cache_resource_group_name) | (Optional). The name of the resource group where primary Redis Cache is deployed. Required when 'deploy_as_secondary_linked_server' is set to true the Redis Cache is deployed and then linked as a secondary cache for geo-replication. | `string` | `null` | no |
| <a name="input_privateendpoint_subnet_id"></a> [privateendpoint_subnet_id](#input_privateendpoint_subnet_id) | (Required.) The resource id of the subnet to deploy private endpoints into. | `string` | `null` | no |
| <a name="input_redis_configuration"></a> [redis_configuration](#input_redis_configuration) | "(Optional) Amount of replicas to create per master for this Redis Cache."<br/>object({<br/>  aof_backup_enabled              = (Optional) Enable or disable AOF persistence for this Redis Cache. Defaults to false.<br/>  aof_storage_connection_string_0 = (Optional) First Storage Account connection string for AOF persistence.<br/>  aof_storage_connection_string_1 = (Optional) Second Storage Account connection string for AOF persistence.<br/>  enable_authentication           = (Optional) If set to false, the Redis instance will be accessible without authentication. Defaults to true.<br/>  active_directory_authentication_enabled = (Optional) Enable Microsoft Entra (AAD) authentication. Defaults to false.<br/>  maxmemory_reserved              = (Optional) Value in megabytes reserved for non-cache usage e.g. failover. Defaults are shown below.<br/>  maxmemory_delta                 = (Optional) The max-memory delta for this Redis instance. Defaults are shown below.<br/>  maxfragmentationmemory_reserved = (Optional) Value in megabytes reserved to accommodate for memory fragmentation. Defaults are shown below.<br/>  maxmemory_policy                = (Optional) How Redis will select what to remove when maxmemory is reached. Defaults are shown below. Defaults to volatile-lru.<br/>  rdb_backup_enabled              = (Optional) Is Backup Enabled? Only supported on Premium SKUs. Defaults to false.<br/>  rdb_backup_frequency            = (Optional) The Backup Frequency in Minutes. Only supported on Premium SKUs. Possible values are: 15, 30, 60, 360, 720 and 1440.<br/>  rdb_backup_max_snapshot_count   = (Optional) The maximum number of snapshots to create as a backup. Only supported for Premium SKUs.<br/>  rdb_storage_connection_string   = (Optional) The Connection String to the Storage Account. Only supported for Premium SKUs. <br/>}) | <pre>object({<br/>    aof_backup_enabled                      = optional(bool, false)<br/>    aof_storage_connection_string_0         = optional(string, null)<br/>    aof_storage_connection_string_1         = optional(string, null)<br/>    enable_authentication                   = optional(bool, true)<br/>    active_directory_authentication_enabled = optional(bool, false)<br/>    maxmemory_reserved                      = optional(number, 10)<br/>    maxmemory_delta                         = optional(number, 2)<br/>    maxfragmentationmemory_reserved         = optional(number, 10)<br/>    maxmemory_policy                        = optional(string, null)<br/>    rdb_backup_enabled                      = optional(bool, false)<br/>    rdb_backup_frequency                    = optional(number)<br/>    rdb_backup_max_snapshot_count           = optional(number, null)<br/>    rdb_storage_connection_string           = optional(number, null)<br/>  })</pre> | <pre>{<br/>  "active_directory_authentication_enabled": false,<br/>  "aof_backup_enabled": false,<br/>  "aof_storage_connection_string_0": null,<br/>  "aof_storage_connection_string_1": null,<br/>  "enable_authentication": true,<br/>  "maxfragmentationmemory_reserved": 10,<br/>  "maxmemory_delta": 2,<br/>  "maxmemory_policy": null,<br/>  "maxmemory_reserved": 10,<br/>  "rdb_backup_enabled": false,<br/>  "rdb_backup_frequency": null,<br/>  "rdb_backup_max_snapshot_count": null,<br/>  "rdb_storage_connection_string": null<br/>}</pre> | no |
| <a name="input_replicas_per_master"></a> [replicas_per_master](#input_replicas_per_master) | (Optional) Amount of replicas to create per master for this Redis Cache. | `number` | `null` | no |
| <a name="input_replicas_per_primary"></a> [replicas_per_primary](#input_replicas_per_primary) | (Optional) Amount of replicas to create per primary for this Redis Cache. If both replicas_per_primary and replicas_per_master are set, they need to be equal. | `number` | `null` | no |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Reqired). The name of the Application Resource Group. This Resource group usually contains the Application resources(app infra resources). | `string` | n/a | yes |
| <a name="input_shard_count"></a> [shard_count](#input_shard_count) | (Optional) Only available when using the Premium SKU The number of Shards to create on the Redis Cluster. | `number` | `null` | no |
| <a name="input_shared_nrtbl_vnet_id"></a> [shared_nrtbl_vnet_id](#input_shared_nrtbl_vnet_id) | (Reqired). The ARM Resource Id of the Non-Routeable Virtual Network in shared Resource group. | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input_sku) | (Required) The SKU of Redis Cache. Possible values are `Basic`, `Standard` or `Premium`. | `string` | `"Standard"` | no |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |
| <a name="input_use_system_assigned_identity"></a> [use_system_assigned_identity](#input_use_system_assigned_identity) | (Required) Indicates that the system assigned identity should be used for CMK or not. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_zones"></a> [zones](#input_zones) | (Optional) Specifies a list of Availability Zones in which this Redis Cache should be located. Changing this forces a new Redis Cache to be created. | `list(string)` | `[]` | no |

## Note
| Note |
|------|
| * enable_authentication (in redis_configuration):<br>  This controls whether clients must authenticate (using access keys or Azure AD) to connect to the Redis cache. If set to true, authentication is required; if false, anyone can connect (not recommended for production).<br><br>  * disable_access_key_authentication (top-level variable):<br>  This controls whether access key authentication is allowed at all. If set to true, clients cannot use access keys to authenticate—they must use Azure AD authentication instead. If false, access key authentication is permitted. |


## Outputs

| Name | Description |
|------|-------------|
| <a name="output_keyvault"></a> [keyvault](#output_keyvault) | The keyvault module outputs. |
| <a name="output_keyvault-pe"></a> [keyvault-pe](#output_keyvault-pe) | The keyvault-pe module outputs. |
| <a name="output_keyvaultsecret_redis-primary_access_key"></a> [keyvaultsecret_redis-primary_access_key](#output_keyvaultsecret_redis-primary_access_key) | The KeyVault Secret Module outputs for primary access key. |
| <a name="output_keyvaultsecret_redis-secondary_access_key"></a> [keyvaultsecret_redis-secondary_access_key](#output_keyvaultsecret_redis-secondary_access_key) | The KeyVault Secret Module outputs for secondary access key. |
| <a name="output_networksecuritygroup"></a> [networksecuritygroup](#output_networksecuritygroup) | The networksecuritygroup module outputs. |
| <a name="output_privateendpoint-redis"></a> [privateendpoint-redis](#output_privateendpoint-redis) | The privateendpoint redis module outputs. |
| <a name="output_rediscache"></a> [rediscache](#output_rediscache) | The rediscache module outputs. |
| <a name="output_redislinkedserver"></a> [redislinkedserver](#output_redislinkedserver) | The redislinkedserver redis module outputs. |
| <a name="output_routetable"></a> [routetable](#output_routetable) | The routetable module outputs. |
| <a name="output_subnet"></a> [subnet](#output_subnet) | The subnet module outputs. |
| <a name="output_userassignedidentity"></a> [userassignedidentity](#output_userassignedidentity) | The userassignedidentity module outputs. |
<!-- END_TF_DOCS -->
