<!-- BEGIN_TF_DOCS -->
# Azure Kubernetes Service (AKS) solution pattern [GOVI0001950](https://lseg.service-now.com/x/lsegp/cto/record/x_lsegp_eag_governance_item/0734dd1983fcc6503408b1c8beaad361)

Azure-prdsvcpat-terraform-aks-private is a terraform module which enables Azure Kubernetes Service in LSEG.

## Documentation

Detailed documentation is available on the project [website](https://ci.pages.dx1.lseg.com/containers/website/projects/aks/about/overview/).

## Support

For incidents requests, features or enhancements check [Cloud SRE support](https://lsegroup.sharepoint.com/sites/CloudCentral/SitePages/LMP-SRE-Incident-&-Request-Mgmt.aspx)

Details: https://lseg.stackenterprise.co/articles/23298

## Terraform docs

The terraform documentation in README.md file is auto-generated using terraform-docs. Please review the header.md file in-case there are any changes to be added in README.md

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.5.0 |
| <a name="requirement_azapi"></a> [azapi](#requirement_azapi) | ~> 2.6.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement_azuread) | ~> 3.4 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm) | ~> 4.69 |
| <a name="requirement_helm"></a> [helm](#requirement_helm) | ~> 3.0 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement_kubectl) | ~> 2.2.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement_kubernetes) | ~> 2.37 |
| <a name="requirement_local"></a> [local](#requirement_local) | 2.5.3 |
| <a name="requirement_null"></a> [null](#requirement_null) | 3.2.4 |
| <a name="requirement_time"></a> [time](#requirement_time) | ~> 0.13.1 |
| <a name="requirement_tls"></a> [tls](#requirement_tls) | ~> 4.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) | ~> 4.69 |
| <a name="provider_helm"></a> [helm](#provider_helm) | ~> 3.0 |
| <a name="provider_kubectl"></a> [kubectl](#provider_kubectl) | ~> 2.2.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider_kubernetes) | ~> 2.37 |
| <a name="provider_time"></a> [time](#provider_time) | ~> 0.13.1 |
| <a name="provider_tls"></a> [tls](#provider_tls) | ~> 4.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_add_group_rbac1"></a> [add_group_rbac1](#module_add_group_rbac1) | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-roleassignment | 0.2.2 |
| <a name="module_agentpool_msi_rbac1"></a> [agentpool_msi_rbac1](#module_agentpool_msi_rbac1) | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-roleassignment | 0.2.2 |
| <a name="module_azure-prdsvc-terraform-aks-cluster"></a> [azure-prdsvc-terraform-aks-cluster](#module_azure-prdsvc-terraform-aks-cluster) | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-kubernetescluster | 2.0.4 |
| <a name="module_azure-prdsvc-terraform-aks-cluster-additional-pool"></a> [azure-prdsvc-terraform-aks-cluster-additional-pool](#module_azure-prdsvc-terraform-aks-cluster-additional-pool) | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-kubernetesclusternodepool | 1.2.0 |
| <a name="module_azure-prdsvc-terraform-containerregistry"></a> [azure-prdsvc-terraform-containerregistry](#module_azure-prdsvc-terraform-containerregistry) | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-containerregistry | 1.0.0 |
| <a name="module_azure-prdsvc-terraform-keyvaultkey-kms"></a> [azure-prdsvc-terraform-keyvaultkey-kms](#module_azure-prdsvc-terraform-keyvaultkey-kms) | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-keyvaultkey | 0.3.0 |
| <a name="module_azure-prdsvc-terraform-nsg"></a> [azure-prdsvc-terraform-nsg](#module_azure-prdsvc-terraform-nsg) | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-networksecuritygroup | 0.6.0 |
| <a name="module_azure-prdsvc-terraform-privateendpoint-acr"></a> [azure-prdsvc-terraform-privateendpoint-acr](#module_azure-prdsvc-terraform-privateendpoint-acr) | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-privateendpoint | 0.7.0 |
| <a name="module_azure-prdsvc-terraform-routetable"></a> [azure-prdsvc-terraform-routetable](#module_azure-prdsvc-terraform-routetable) | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-routetable | 1.0.1 |
| <a name="module_azure-prdsvc-terraform-subnet-aks"></a> [azure-prdsvc-terraform-subnet-aks](#module_azure-prdsvc-terraform-subnet-aks) | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-subnet | 0.8.3 |
| <a name="module_azure-prdsvc-terraform-userassignedidentity"></a> [azure-prdsvc-terraform-userassignedidentity](#module_azure-prdsvc-terraform-userassignedidentity) | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-userassignedidentity | 0.3.1 |
| <a name="module_kubelet_identity_rbac_capacity_additional"></a> [kubelet_identity_rbac_capacity_additional](#module_kubelet_identity_rbac_capacity_additional) | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-roleassignment | 0.2.2 |
| <a name="module_kubelet_identity_rbac_capacity_default"></a> [kubelet_identity_rbac_capacity_default](#module_kubelet_identity_rbac_capacity_default) | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-roleassignment | 0.2.2 |
| <a name="module_msi_rbac"></a> [msi_rbac](#module_msi_rbac) | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-roleassignment | 0.2.2 |
| <a name="module_spn_rbac1"></a> [spn_rbac1](#module_spn_rbac1) | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-roleassignment | 0.2.2 |
| <a name="module_spn_rbac_acr"></a> [spn_rbac_acr](#module_spn_rbac_acr) | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-roleassignment | 0.2.2 |
| <a name="module_user_assign_identity_rbac1"></a> [user_assign_identity_rbac1](#module_user_assign_identity_rbac1) | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-roleassignment | 0.2.3 |
| <a name="module_user_assign_identity_rbac2"></a> [user_assign_identity_rbac2](#module_user_assign_identity_rbac2) | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-roleassignment | 0.2.2 |
| <a name="module_user_assign_identity_rbac3"></a> [user_assign_identity_rbac3](#module_user_assign_identity_rbac3) | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-roleassignment | 0.2.2 |

## Resources

| Name | Type |
|------|------|
| [azurerm_disk_encryption_set.des](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/disk_encryption_set) | resource |
| [azurerm_key_vault_key.kek](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key) | resource |
| [azurerm_key_vault_key.kek1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key) | resource |
| [azurerm_private_dns_zone_virtual_network_link.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [helm_release.flux_operator](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubectl_manifest.flux](https://registry.terraform.io/providers/alekc/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.kustomization_infra_common](https://registry.terraform.io/providers/alekc/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.kustomization_istio](https://registry.terraform.io/providers/alekc/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.kustomization_istio_gateway](https://registry.terraform.io/providers/alekc/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.kustomization_karpenter](https://registry.terraform.io/providers/alekc/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.kustomization_keda](https://registry.terraform.io/providers/alekc/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.kustomization_nginx](https://registry.terraform.io/providers/alekc/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.source_infra_common](https://registry.terraform.io/providers/alekc/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.source_infra_helm](https://registry.terraform.io/providers/alekc/kubectl/latest/docs/resources/manifest) | resource |
| [kubernetes_config_map.flux-cluster-config](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map) | resource |
| [kubernetes_secret.flux-helm-secrets](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_secret.gitlabtoken](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [time_sleep.flux_crds](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [time_sleep.wait_for_des_reader_sync](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [time_sleep.wait_for_rbac_sync](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [time_sleep.wait_for_rbac_sync_des](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [tls_private_key.eus_ssh](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [azurerm_client_config.spn](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_firewall.afw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/firewall) | data source |
| [azurerm_subscription.sub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acr"></a> [acr](#input_acr) | Azure container registry values. Check example in .test/deployTest folder for more details | <pre>object({<br/>    instance                 = string<br/>    sku_tier                 = string<br/>    retention_policy_in_days = string<br/>    identity_type            = optional(string, "SystemAssigned")<br/>    georeplications          = any<br/>    encryption               = optional(bool, true)<br/>    network_rule_set         = optional(any, null)<br/>    trust_policy_enabled     = optional(bool, false)<br/>    zone_redundancy_enabled  = bool<br/>    data_endpoint_enabled    = bool<br/>    tags                     = optional(any, null)<br/>    pe_static_ip_required    = optional(bool, false)<br/>    pe_ip_configuration      = any<br/>  })</pre> | `null` | no |
| <a name="input_acr_encryption_enable"></a> [acr_encryption_enable](#input_acr_encryption_enable) | Enable encryption for ACR | `bool` | `false` | no |
| <a name="input_add_group"></a> [add_group](#input_add_group) | Azure AD groups that should have Read access to AKS cluster | `any` | `null` | no |
| <a name="input_additional_network_security_rules"></a> [additional_network_security_rules](#input_additional_network_security_rules) | Network security Rules | <pre>map(object({<br/>    name                                       = string<br/>    description                                = optional(string)<br/>    protocol                                   = string<br/>    source_port_range                          = optional(string)<br/>    source_port_ranges                         = optional(list(string))<br/>    destination_port_range                     = optional(string)<br/>    destination_port_ranges                    = optional(list(string))<br/>    source_address_prefix                      = optional(string)<br/>    source_address_prefixes                    = optional(list(string))<br/>    source_application_security_group_ids      = optional(list(string))<br/>    destination_address_prefix                 = optional(string)<br/>    destination_address_prefixes               = optional(list(string))<br/>    destination_application_security_group_ids = optional(list(string))<br/>    access                                     = string<br/>    priority                                   = number<br/>    direction                                  = string<br/>  }))</pre> | `null` | no |
| <a name="input_additional_nodepool"></a> [additional_nodepool](#input_additional_nodepool) | AKS user node pool map | <pre>map(object({<br/>    node_pool_name                    = string<br/>    node_pool_vm_size                 = string<br/>    node_pool_os_disk_size_gb         = number<br/>    node_pool_os_disk_type            = optional(string, "Managed")<br/>    node_pool_mode                    = optional(string, "User")<br/>    node_pool_os_type                 = optional(string, "Linux")<br/>    node_pool_node_labels             = map(string)<br/>    node_pool_node_count              = number<br/>    node_pool_auto_scaling_enabled    = bool<br/>    node_pool_min_count               = number<br/>    node_pool_max_count               = number<br/>    node_pool_max_pods                = number<br/>    node_pool_custom_ca_trust_enabled = optional(bool, false)<br/>    node_pool_host_encryption_enabled = optional(bool, true)<br/>    node_pool_host_group_id           = optional(string, null)<br/>    node_pool_node_public_ip_enabled  = optional(bool, false)<br/>    node_pool_fips_enabled            = optional(bool, false)<br/>    node_pool_priority                = optional(string, "Regular")<br/>    eviction_policy                   = optional(string, "Delete")<br/>    node_pool_spot_max_price          = number<br/>    node_pool_node_taints             = any<br/>    node_pool_zones                   = optional(list(number), ["1", "2", "3"])<br/>    kubernetes_version                = optional(string)<br/>    user_node_pool_linux_os_config    = optional(any, null)<br/>    user_node_pool_upgrade_settings = optional(any, {<br/>      max_surge = "10%"<br/>    })<br/>    node_pool_capacity_reservation_group_id = optional(string, null)<br/>    node_pool_temporary_name_for_rotation   = optional(string, "tmpaddpool1")<br/>  }))</pre> | `{}` | no |
| <a name="input_aks"></a> [aks](#input_aks) | Azure Kubernetes Service Configuration. Check example in .test/deployTest folder for more details | <pre>object({<br/>    automatic_upgrade_channel                       = optional(string, null)<br/>    node_os_upgrade_channel                         = optional(string, "None")<br/>    enable_disk_encryption_aks                      = optional(string)<br/>    kubernetes_version                              = string<br/>    private_public_fqdn_enabled                     = optional(bool, false)<br/>    sku_tier                                        = optional(string, "Standard")<br/>    support_plan                                    = optional(string, "KubernetesOfficial")<br/>    workload_autoscaler_profile                     = map(string)<br/>    default_node_pool_name                          = optional(string, "default")<br/>    default_node_pool_node_count                    = optional(number, null)<br/>    default_node_pool_vm_size                       = optional(string, "Standard_D2s_v5")<br/>    default_node_pool_capacity_reservation_group_id = optional(string, null)<br/>    default_node_pool_auto_scaling_enabled          = optional(bool, true)<br/>    default_node_pool_host_encryption_enabled       = optional(bool, true)<br/>    default_node_pool_node_public_ip_enabled        = optional(bool, false)<br/>    default_node_pool_fips_enabled                  = optional(bool, false)<br/>    default_node_pool_kubelet_disk_type             = optional(string, "OS")<br/>    default_node_pool_host_group_id                 = optional(string, null)<br/>    default_node_pool_max_pods                      = optional(number, 110)<br/>    default_node_pool_node_public_ip_prefix_id      = optional(string, null)<br/>    default_node_pool_node_labels                   = optional(any, null)<br/>    default_node_pool_only_critical_addons_enabled  = optional(bool, null)<br/>    default_node_pool_orchestrator_version          = optional(string)<br/>    default_node_pool_os_disk_size_gb               = optional(number, 128)<br/>    default_node_pool_os_disk_type                  = optional(string, "Managed")<br/>    default_node_pool_os_sku                        = optional(string, "Ubuntu")<br/>    default_node_pool_proximity_placement_group_id  = optional(string, null)<br/>    default_node_pool_scale_down_mode               = optional(string, null)<br/>    default_node_pool_zones                         = optional(list(number), ["1", "2", "3"])<br/>    default_node_pool_ultra_ssd_enabled             = optional(bool, false)<br/>    default_node_pool_min_count                     = optional(number)<br/>    default_node_pool_max_count                     = optional(number)<br/>    default_node_pool_kubelet_config                = optional(any, null)<br/>    default_node_pool_linux_os_config               = optional(any, null)<br/>    default_node_pool_upgrade_settings = optional(any, {<br/>      max_surge = "10%"<br/>    })<br/>    default_node_pool_temporary_name_for_rotation  = optional(string, "tmpnodepool1")<br/>    key_management_service_keyvault_network_access = optional(string, "Private")<br/>    edge_zone                                      = optional(any, null)<br/>    auto_scaler_profile = optional(object({<br/>      balance_similar_node_groups      = optional(bool)<br/>      expander                         = optional(string, "random")<br/>      max_graceful_termination_sec     = optional(number)<br/>      max_node_provisioning_time       = optional(string)<br/>      max_unready_nodes                = optional(number)<br/>      max_unready_percentage           = optional(number)<br/>      new_pod_scale_up_delay           = optional(string)<br/>      scale_down_delay_after_add       = optional(string)<br/>      scale_down_delay_after_delete    = optional(string)<br/>      scale_down_delay_after_failure   = optional(string)<br/>      scan_interval                    = optional(string, "10s")<br/>      scale_down_unneeded              = optional(string)<br/>      scale_down_unready               = optional(string)<br/>      scale_down_utilization_threshold = optional(number)<br/>      empty_bulk_delete_max            = optional(number)<br/>      skip_nodes_with_local_storage    = optional(bool)<br/>      skip_nodes_with_system_pods      = optional(bool, true)<br/>    }))<br/>    key_vault_secrets_rotation_interval = optional(string, "2m")<br/>    maintenance_window                  = optional(any, null)<br/>    maintenance_window_auto_upgrade = optional(object({<br/>      frequency   = string<br/>      interval    = number<br/>      day_of_week = string<br/>      start_time  = string<br/>      utc_offset  = string<br/>      duration    = number<br/>      }), {<br/>      frequency   = "Weekly"<br/>      interval    = 1<br/>      day_of_week = "Friday"<br/>      start_time  = "00:00"<br/>      utc_offset  = "+00:00"<br/>      duration    = 4<br/>    })<br/>    maintenance_window_node_os = optional(object({<br/>      frequency   = string<br/>      interval    = number<br/>      day_of_week = string<br/>      start_time  = string<br/>      utc_offset  = string<br/>      duration    = number<br/>      }), {<br/>      frequency   = "Weekly"<br/>      interval    = 1<br/>      day_of_week = "Friday"<br/>      start_time  = "00:00"<br/>      utc_offset  = "+00:00"<br/>      duration    = 4<br/>    })<br/>    network_profile             = map(string)<br/>    service_principal           = optional(any, null)<br/>    monitor_metrics             = optional(any, null)<br/>    web_app_routing             = optional(any, null)<br/>    identity_type               = optional(string, "UserAssigned")<br/>    linux_profile_adminusername = string<br/>  })</pre> | n/a | yes |
| <a name="input_aks_subnet"></a> [aks_subnet](#input_aks_subnet) | AKS subnet configuration | <pre>object({<br/>    address_prefixes                               = string<br/>    enforce_private_link_endpoint_network_policies = optional(string, "Disabled")<br/>    private_link_service_network_policies_enabled  = optional(bool, false)<br/>    enable_nsg_association                         = optional(bool, false)<br/>    instance                                       = string<br/>  })</pre> | n/a | yes |
| <a name="input_akv"></a> [akv](#input_akv) | Azure keyvault configuration values | <pre>object({<br/>    expiration_date = optional(string, null)<br/>    rotation_policy = optional(map(string), {<br/>      expire_after         = "P365D"<br/>      notify_before_expiry = "P351D"<br/>      time_before_expiry   = null<br/>      time_after_creation  = "P358D"<br/>    })<br/>    key_opts = optional(list(string), ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"])<br/>  })</pre> | n/a | yes |
| <a name="input_akv_key_acr"></a> [akv_key_acr](#input_akv_key_acr) | Azure Key Vault Key for ACR Configuration. Check example in .test/deployTest folder for more details | <pre>object({<br/>    key_name        = string<br/>    key_type        = optional(string, "RSA-HSM")<br/>    key_size        = optional(number, "2048")<br/>    expiration_date = optional(string, null)<br/>    rotation_policy = optional(map(string), {<br/>      expire_after         = "P365D"<br/>      notify_before_expiry = "P351D"<br/>      time_before_expiry   = null<br/>      time_after_creation  = "P358D"<br/>    })<br/>    key_opts = optional(list(string), ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"])<br/>  })</pre> | n/a | yes |
| <a name="input_akv_key_cmk"></a> [akv_key_cmk](#input_akv_key_cmk) | Azure Key Vault Key for AKS CMK Configuration. Check example in .test/deployTest folder for more details | <pre>object({<br/>    key_name        = string<br/>    key_type        = optional(string, "RSA-HSM")<br/>    key_size        = optional(number, "2048")<br/>    expiration_date = optional(string, null)<br/>    rotation_policy = optional(map(string), {<br/>      expire_after         = "P365D"<br/>      notify_before_expiry = "P351D"<br/>      time_before_expiry   = null<br/>      time_after_creation  = "P358D"<br/>    })<br/>    key_opts = optional(list(string), ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"])<br/>  })</pre> | n/a | yes |
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_app_resource_group_name"></a> [app_resource_group_name](#input_app_resource_group_name) | Routable app resource group name | `string` | `null` | no |
| <a name="input_artifactory_token"></a> [artifactory_token](#input_artifactory_token) | Artifactory registry token | `string` | `""` | no |
| <a name="input_artifactory_url"></a> [artifactory_url](#input_artifactory_url) | Artifactory registry URL | `string` | `"artifactory.lseg.com"` | no |
| <a name="input_artifactory_username"></a> [artifactory_username](#input_artifactory_username) | Artifactory registry username | `string` | `""` | no |
| <a name="input_azure_firewall"></a> [azure_firewall](#input_azure_firewall) | Define existing Azure firewall Name and Resource Group. Check example in .test/deployTest folder for more details | `map(string)` | `{}` | no |
| <a name="input_azure_key_vault_id"></a> [azure_key_vault_id](#input_azure_key_vault_id) | ID for existing Key-Vault | `string` | n/a | yes |
| <a name="input_azurerm_disk_encryption_set"></a> [azurerm_disk_encryption_set](#input_azurerm_disk_encryption_set) | Disk Encryption set configuration Values | <pre>object({<br/>    name                      = string<br/>    encryption_type           = string<br/>    auto_key_rotation_enabled = bool<br/>  })</pre> | n/a | yes |
| <a name="input_client_id"></a> [client_id](#input_client_id) | SPN client ID. Fetched from DX1 vault | `string` | n/a | yes |
| <a name="input_client_secret"></a> [client_secret](#input_client_secret) | SPN client Secret. Fetched from DX1 vault | `string` | n/a | yes |
| <a name="input_cloudability_access_key"></a> [cloudability_access_key](#input_cloudability_access_key) | cloudability access key | `string` | n/a | yes |
| <a name="input_cloudability_env_id"></a> [cloudability_env_id](#input_cloudability_env_id) | cloudability environment id | `string` | n/a | yes |
| <a name="input_cloudability_secret_key"></a> [cloudability_secret_key](#input_cloudability_secret_key) | cloudability secret key | `string` | n/a | yes |
| <a name="input_cloudability_upload_region"></a> [cloudability_upload_region](#input_cloudability_upload_region) | cloudability upload region | `string` | `"eu-central-1"` | no |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_datadog_container_registry"></a> [datadog_container_registry](#input_datadog_container_registry) | n/a | `string` | `"gcr.io"` | no |
| <a name="input_datadog_site"></a> [datadog_site](#input_datadog_site) | n/a | `string` | `"datadoghq.eu"` | no |
| <a name="input_dd_api_key"></a> [dd_api_key](#input_dd_api_key) | Datadog API key | `string` | n/a | yes |
| <a name="input_deploy_acr_and_privateendpoint"></a> [deploy_acr_and_privateendpoint](#input_deploy_acr_and_privateendpoint) | Enable this to Deploy ACR and private endpoint for it | `bool` | `false` | no |
| <a name="input_deploy_additional_nodepool"></a> [deploy_additional_nodepool](#input_deploy_additional_nodepool) | Deploy Additional User Node Pool | `bool` | `false` | no |
| <a name="input_deploy_istio"></a> [deploy_istio](#input_deploy_istio) | Enable this setting to deploy Istio Service Mesh. Default is 'false' | `bool` | `false` | no |
| <a name="input_deploy_istio_gateway"></a> [deploy_istio_gateway](#input_deploy_istio_gateway) | Deploy Istio ingress gateway | `bool` | `false` | no |
| <a name="input_deploy_karpenter"></a> [deploy_karpenter](#input_deploy_karpenter) | Enable AKS Node Auto Provisioning (Karpenter) | `bool` | `false` | no |
| <a name="input_deploy_keda"></a> [deploy_keda](#input_deploy_keda) | Enable this setting to deploy Keda. Default is 'false' | `bool` | `false` | no |
| <a name="input_deploy_nginx_ingress"></a> [deploy_nginx_ingress](#input_deploy_nginx_ingress) | Enable this setting to deploy Nginx Ingress Controller. Default is 'false' | `bool` | `false` | no |
| <a name="input_deploy_private_dns_zone_vnet_link"></a> [deploy_private_dns_zone_vnet_link](#input_deploy_private_dns_zone_vnet_link) | Deploy Virtual network link for Routable Vnet | `bool` | `false` | no |
| <a name="input_dx1_pat_token"></a> [dx1_pat_token](#input_dx1_pat_token) | DX1 User Personal Access Token Value | `string` | n/a | yes |
| <a name="input_dx1_user"></a> [dx1_user](#input_dx1_user) | DX1 User Personal Access Token Name | `string` | n/a | yes |
| <a name="input_enable_artifactory"></a> [enable_artifactory](#input_enable_artifactory) | Enable this setting to use Artifactory registry for istio, keda and nginx images. Default is 'false' | `bool` | `false` | no |
| <a name="input_enable_disk_encryption_aks"></a> [enable_disk_encryption_aks](#input_enable_disk_encryption_aks) | Enable Disk Encryption for AKS | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_falcon_cid"></a> [falcon_cid](#input_falcon_cid) | Crowdstrike Agent CID | `string` | n/a | yes |
| <a name="input_falcon_docker_password"></a> [falcon_docker_password](#input_falcon_docker_password) | Crowdstrike Docker registry password | `string` | n/a | yes |
| <a name="input_falcon_docker_username"></a> [falcon_docker_username](#input_falcon_docker_username) | Crowdstrike Docker registry username | `string` | n/a | yes |
| <a name="input_falcon_token"></a> [falcon_token](#input_falcon_token) | Crowdstrike falcon token | `string` | n/a | yes |
| <a name="input_flux_version"></a> [flux_version](#input_flux_version) | (Optional) Version of the flux operator | `string` | `"2.x"` | no |
| <a name="input_gitops_aks_common_repo_reference"></a> [gitops_aks_common_repo_reference](#input_gitops_aks_common_repo_reference) | GitOps common repo reference type, can be branch or tag | `string` | `"tag"` | no |
| <a name="input_gitops_aks_common_repo_version"></a> [gitops_aks_common_repo_version](#input_gitops_aks_common_repo_version) | Always use tag revisions for all environments. | `string` | `""` | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_node_resource_group"></a> [node_resource_group](#input_node_resource_group) | (Optional) Custom name for the AKS node resource group. Required for regions with long CLI names (e.g. germanywestcentral) to prevent exceeding Azure's 80-character resource group name limit. If not set, Azure auto-generates the name as MC_{resource_group}_{cluster_name}_{location}. | `string` | `null` | no |
| <a name="input_nrt_vnet_id"></a> [nrt_vnet_id](#input_nrt_vnet_id) | Non-Routable virtual Network ID | `string` | n/a | yes |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_pe_subnet_id"></a> [pe_subnet_id](#input_pe_subnet_id) | Subnet ID for use by Private Endpoints | `string` | n/a | yes |
| <a name="input_rt_vnet_id"></a> [rt_vnet_id](#input_rt_vnet_id) | Routable virtual Network ID | `string` | n/a | yes |
| <a name="input_shared_vnet_name"></a> [shared_vnet_name](#input_shared_vnet_name) | Non Routetable vnet name | `string` | `null` | no |
| <a name="input_subscription_id"></a> [subscription_id](#input_subscription_id) | Subscription ID where resources will be deployed | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |
| <a name="input_time_delay"></a> [time_delay](#input_time_delay) | Added Time delay for RBAC sync | `string` | `"90s"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_acr_resource"></a> [acr_resource](#output_acr_resource) | Azure Container Registry Details |
| <a name="output_aks-cluster-additional-pool"></a> [aks-cluster-additional-pool](#output_aks-cluster-additional-pool) | AKS cluster additional nodepool details |
| <a name="output_aks_id"></a> [aks_id](#output_aks_id) | ID of the AKS Cluster |
| <a name="output_aks_managed_identity_resource"></a> [aks_managed_identity_resource](#output_aks_managed_identity_resource) | User assigned Identity details |
| <a name="output_aks_name"></a> [aks_name](#output_aks_name) | The name of the AKS Cluster |
| <a name="output_aks_resource"></a> [aks_resource](#output_aks_resource) | Resource details of the AKS cluster |
| <a name="output_aks_rg_name"></a> [aks_rg_name](#output_aks_rg_name) | AKS Cluster Resource Group Name |
| <a name="output_nsg"></a> [nsg](#output_nsg) | Network Security Group Details |
| <a name="output_oidc_issuer_url"></a> [oidc_issuer_url](#output_oidc_issuer_url) | The OIDC Issuer URL of the AKS cluster. Used for federated credential integration with Azure AD Workload Identity. |
| <a name="output_routetable"></a> [routetable](#output_routetable) | Route Table details |
| <a name="output_subnet-aks"></a> [subnet-aks](#output_subnet-aks) | AKS Subnet details |
<!-- END_TF_DOCS -->
