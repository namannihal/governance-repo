---
version: 1.3.0
available_versions:
  - 1.3.0
  - 1.2.1
  - 1.2.0
  - 1.1.1
  - 1.1.0
---

<!-- BEGIN_TF_DOCS -->
# AKS Additional Node Pool module


## Overview

This terraform module creates a AKS Additional Node Pool and associated resources.

## Prerequisites

  ### Required

  - Resource Group, Virtual Network, and Route Table (all three modules to be called if not existing).
  - Routable and Non-routable Virtual networks
  - Peering between Routable and Non-routable Virtual networks
  - Azure Firewall and Firewall policy for AKS outbound traffic. Azure firewall rules can be found here: https://learn.microsoft.com/en-us/azure/aks/egress-udr#deploy-a-cluster-with-outbound-type-of-udr-and-azure-firewall and https://learn.microsoft.com/en-us/azure/firewall/protect-azure-kubernetes-service#restrict-egress-traffic-using-azure-firewall
  - Azure key vault to be preprovisioned for KMS and CMK. App SPN needs to have "Key Vault Secrets Officer" on key vault resource group.
  - Azure storage account to store the terraform remote state file.

  | Cloud Products | Source |
  |--------|----------------|
  | azure-prdsvc-terraform-networksecuritygroup | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-networksecuritygroup |
  | azure-prdsvc-terraform-subnet | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-subnet |
  | azure-prdsvc-terraform-keyvault | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-keyvault |
  | azure-prdsvc-terraform-kv-privateendpoint | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-privateendpoint |
  | azure-prdsvc-terraform-roleassignment | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-roleassignment |
  | azure-prdsvc-terraform-diskencryptionset | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-diskencryptionset |
  ### Optional  

  - Jump box to connect to the Private AKS cluster.
  - Bastion host to connect to the vm over a private Network.

  | Cloud Products | Source |
  |--------|----------------|
  | azure-prdsvc-terraform-bastionhost | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-bastionhost |
  | azure-prdsvc-terraform-linuxvirtualmachine | git::https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-linuxvirtualmachine |

  - `time_sleep` resource block to wait for the secret to get created till private connection is registered in the Private DNS Zone.
  - `random_password` resource block to generate admin password.

## Guidance

#### Usage

- This module creates a Additional node pool for Azure kubernaties service (AKS)
- To perform the deployment, of Additional node pool for Azure kubernaties service (AKS) in new or existing AKS cluster.
- a **Azure kubernaties service (AKS)** (to deploy the additional node pool),
- Resource Group, subnets and Azure kubernaties service (AKS) must be created to deploy this module,
- The Service Principal (SPN) used to deploy this module **must have `Azure Kubernetes Service RBAC Cluster Admin` role or equivalent assigned** on the **subscription scope**

#### Security Considerations

- The KubeAPI Server for the AKS cluster will be accessible only from the app subscription via jumpbox, and not from any other subscriptions.
- Load Balancer services created by the Cluster will always be internal only.

#### Additional Information

- Kindly refer to https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvcpat/terraform/azure-prdsvcpat-terraform-aks-private to use our AKS pattern to deploy AKS cluster and other related resources.

## Security Controls

Currently, as per LSEG Approved Security requirements, both `Kubernetes Cluster` and `Kubernetes Cluster Node Pool` share the same security controls. It is implemented at Kubernetes Cluster product.

## Changelog

- [azure-prdsvc-terraform-aks-cluster-additional-pool](CHANGELOG.md)

## References ###

### Microsoft Docs ###

- [Official Documentaion](https://learn.microsoft.com/en-us/azure/aks/use-multiple-node-pools)

### Terraform Docs ###

- [Additional node pool for Azure Kubernetes Service (AKS)](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster_node_pool)

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
| [azurerm_kubernetes_cluster_node_pool.aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster_node_pool) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_eviction_policy"></a> [eviction_policy](#input_eviction_policy) | (Optional) The Eviction Policy which should be used for Virtual Machines within the Virtual Machine Scale Set powering this Node Pool. Possible values are Deallocate and Delete. Changing this forces a new resource to be created. | `string` | `"Delete "` | no |
| <a name="input_kubernetes_cluster_id"></a> [kubernetes_cluster_id](#input_kubernetes_cluster_id) | (Required) The ID of the Kubernetes Cluster where this Node Pool should exist. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_kubernetes_version"></a> [kubernetes_version](#input_kubernetes_version) | (Optional) Version of Kubernetes specified when creating the AKS managed cluster.If not specified, the latest recommended version will be used at provisioning time (but won't auto-upgrade). | `string` | `null` | no |
| <a name="input_node_pool_auto_scaling_enabled"></a> [node_pool_auto_scaling_enabled](#input_node_pool_auto_scaling_enabled) | (Optional) Whether to enable auto-scaler. | `bool` | `true` | no |
| <a name="input_node_pool_host_encryption_enabled"></a> [node_pool_host_encryption_enabled](#input_node_pool_host_encryption_enabled) | (Optional) Should the nodes in this Node Pool have host encryption enabled? Changing this forces a new resource to be created. | `bool` | `false` | no |
| <a name="input_node_pool_node_public_ip_enabled"></a> [node_pool_node_public_ip_enabled](#input_node_pool_node_public_ip_enabled) | (Optional) Should each node have a Public IP Address? Changing this forces a new resource to be created. | `bool` | `false` | no |
| <a name="input_node_pool_fips_enabled"></a> [node_pool_fips_enabled](#input_node_pool_fips_enabled) | (Optional) Should the nodes in this Node Pool have Federal Information Processing Standard enabled? Changing this forces a new resource to be created. | `bool` | `false` | no |
| <a name="input_node_pool_max_count"></a> [node_pool_max_count](#input_node_pool_max_count) | (Optional) The maximum number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be greater than or equal to min_count | `number` | `3` | no |
| <a name="input_node_pool_max_pods"></a> [node_pool_max_pods](#input_node_pool_max_pods) | (Optional) The maximum number of pods that can run on each agent. Changing this forces a new resource to be created. | `number` | `50` | no |
| <a name="input_node_pool_min_count"></a> [node_pool_min_count](#input_node_pool_min_count) | (Optional) The minimum number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be less than or equal to max_count | `number` | `1` | no |
| <a name="input_node_pool_mode"></a> [node_pool_mode](#input_node_pool_mode) | (Optional) Should this Node Pool be used for System or User resources? Possible values are System and User. Defaults to User. | `string` | `"User"` | no |
| <a name="input_node_pool_name"></a> [node_pool_name](#input_node_pool_name) | (Required) The name of the Node Pool which should be created within the Kubernetes Cluster. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_node_pool_node_count"></a> [node_pool_node_count](#input_node_pool_node_count) | (Optional) The initial number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 (inclusive) for user pools and between 1 and 1000 (inclusive) for system pools and must be a value in the range min_count - max_count. | `number` | `1` | no |
| <a name="input_node_pool_node_labels"></a> [node_pool_node_labels](#input_node_pool_node_labels) | (Optional) A map of Kubernetes labels which should be applied to nodes in this Node Pool. | `map(string)` | `null` | no |
| <a name="input_node_pool_node_taints"></a> [node_pool_node_taints](#input_node_pool_node_taints) | (Optional) A list of Kubernetes taints which should be applied to nodes in the agent pool (e.g key=value:NoSchedule). Changing this forces a new resource to be created. | `list(string)` | `[]` | no |
| <a name="input_node_pool_host_group_id"></a> [node_pool_host_group_id](#input_node_pool_host_group_id) | (Optional) Dedicated host group id. | `string` | `null` | no |
| <a name="input_node_pool_os_disk_size_gb"></a> [node_pool_os_disk_size_gb](#input_node_pool_os_disk_size_gb) | (Optional) The Agent Operating System disk size in GB. Changing this forces a new resource to be created. | `number` | `128` | no |
| <a name="input_node_pool_os_disk_type"></a> [node_pool_os_disk_type](#input_node_pool_os_disk_type) | (Optional) The type of disk which should be used for the Operating System. Possible values are `Ephemeral` and `Managed`. Changing this forces a new resource to be created. | `string` | `"Managed"` | no |
| <a name="input_node_pool_os_type"></a> [node_pool_os_type](#input_node_pool_os_type) | (Optional) The Operating System which should be used for this Node Pool. Changing this forces a new resource to be created. Possible values are Linux and Windows. Defaults to Linux. | `string` | `"Linux"` | no |
| <a name="input_node_pool_priority"></a> [node_pool_priority](#input_node_pool_priority) | (Optional) The Priority for Virtual Machines within the Virtual Machine Scale Set that powers this Node Pool. Possible values are Regular and Spot. Defaults to Regular. Changing this forces a new resource to be created. | `string` | `"Regular"` | no |
| <a name="input_node_pool_spot_max_price"></a> [node_pool_spot_max_price](#input_node_pool_spot_max_price) | (Optional) The maximum price you're willing to pay in USD per Virtual Machine. Valid values are -1 (the current on-demand price for a Virtual Machine) or a positive value with up to five decimal places. Changing this forces a new resource to be created. | `string` | `"-1"` | no |
| <a name="input_node_pool_vm_size"></a> [node_pool_vm_size](#input_node_pool_vm_size) | (Required) The SKU which should be used for the Virtual Machines used in this Node Pool. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_node_pool_vnet_subnet_id"></a> [node_pool_vnet_subnet_id](#input_node_pool_vnet_subnet_id) | (Optional) The ID of the Subnet where this Node Pool should exist. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_node_pool_zones"></a> [node_pool_zones](#input_node_pool_zones) | (Optional) Specifies a list of Availability Zones in which this Kubernetes Cluster Node Pool should be located. Changing this forces a new Kubernetes Cluster Node Pool to be created. | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_user_node_pool_linux_os_config"></a> [default_node_pool_linux_os_config](#input_user_node_pool_linux_os_config) | <pre>(Optional)<br/>{<br/>  swap_file_size_mb             = string - (Optional) Specifies the size of swap file on each node in MB. Changing this forces a new resource to be created.<br/>  transparent_huge_page_defrag  = string - (Optional) specifies the defrag configuration for Transparent Huge Page. Possible values are `always`, `defer`, `defer+madvise`, `madvise` and `never`. Changing this forces a new resource to be created.<br/>  transparent_huge_page_enabled = string - (Optional) Specifies the Transparent Huge Page enabled configuration. Possible values are `always`, `madvise` and `never`. Changing this forces a new resource to be created.<br/>      <br/>  sysctl_config = { // (Optional) A `sysctl_config` block as defined below. Changing this forces a new resource to be created.<br/>    fs_aio_max_nr                      = number - (Optional) The sysctl setting fs.aio-max-nr. Must be between `65536` and `6553500`. Changing this forces a new resource to be created.<br/>    fs_file_max                        = number - (Optional) The sysctl setting fs.file-max. Must be between `8192` and `12000500`. Changing this forces a new resource to be created.<br/>    fs_inotify_max_user_watches        = number - (Optional) The sysctl setting fs.inotify.max_user_watches. Must be between `781250` and `2097152`. Changing this forces a new resource to be created.<br/>    fs_nr_open                         = number - (Optional) The sysctl setting fs.nr_open. Must be between `8192` and `20000500`. Changing this forces a new resource to be created.<br/>    kernel_threads_max                 = number - (Optional) The sysctl setting kernel.threads-max. Must be between `20` and `513785`. Changing this forces a new resource to be created.<br/>    net_core_netdev_max_backlog        = number - (Optional) The sysctl setting net.core.netdev_max_backlog. Must be between `1000` and `3240000`. Changing this forces a new resource to be created.<br/>    net_core_optmem_max                = number - (Optional) The sysctl setting net.core.optmem_max. Must be between `20480` and `4194304`. Changing this forces a new resource to be created.<br/>    net_core_rmem_default              = number - (Optional) The sysctl setting net.core.rmem_default. Must be between `212992` and `134217728`. Changing this forces a new resource to be created.<br/>    net_core_rmem_max                  = number - (Optional) The sysctl setting net.core.rmem_max. Must be between `212992` and `134217728`. Changing this forces a new resource to be created.<br/>    net_core_somaxconn                 = number - (Optional) The sysctl setting net.core.somaxconn. Must be between `4096` and `3240000`. Changing this forces a new resource to be created.<br/>    net_core_wmem_default              = number - (Optional) The sysctl setting net.core.wmem_default. Must be between `212992` and `134217728`. Changing this forces a new resource to be created.<br/>    net_core_wmem_max                  = number - (Optional) The sysctl setting net.core.wmem_max. Must be between `212992` and `134217728`. Changing this forces a new resource to be created.<br/>    net_ipv4_ip_local_port_range_max   = number - (Optional) The sysctl setting net.ipv4.ip_local_port_range max value. Must be between `1024` and `60999`. Changing this forces a new resource to be created.<br/>    net_ipv4_ip_local_port_range_min   = number - (Optional) The sysctl setting net.ipv4.ip_local_port_range min value. Must be between `1024` and `60999`. Changing this forces a new resource to be created.<br/>    net_ipv4_neigh_default_gc_thresh1  = number - (Optional) The sysctl setting net.ipv4.neigh.default.gc_thresh1. Must be between `128` and `80000`. Changing this forces a new resource to be created.<br/>    net_ipv4_neigh_default_gc_thresh2  = number - (Optional) The sysctl setting net.ipv4.neigh.default.gc_thresh2. Must be between `512` and `90000`. Changing this forces a new resource to be created.<br/>    net_ipv4_neigh_default_gc_thresh3  = number - (Optional) The sysctl setting net.ipv4.neigh.default.gc_thresh3. Must be between `1024` and `100000`. Changing this forces a new resource to be created.<br/>    net_ipv4_tcp_fin_timeout           = number - (Optional) The sysctl setting net.ipv4.tcp_fin_timeout. Must be between `5` and `120`. Changing this forces a new resource to be created.<br/>    net_ipv4_tcp_keepalive_intvl       = number - (Optional) The sysctl setting net.ipv4.tcp_keepalive_intvl. Must be between `10` and `75`. Changing this forces a new resource to be created.<br/>    net_ipv4_tcp_keepalive_probes      = number - (Optional) The sysctl setting net.ipv4.tcp_keepalive_probes. Must be between `1` and `15`. Changing this forces a new resource to be created.<br/>    net_ipv4_tcp_keepalive_time        = number - (Optional) The sysctl setting net.ipv4.tcp_keepalive_time. Must be between `30` and `432000`. Changing this forces a new resource to be created.<br/>    net_ipv4_tcp_max_syn_backlog       = number - (Optional) The sysctl setting net.ipv4.tcp_max_syn_backlog. Must be between `128` and `3240000`. Changing this forces a new resource to be created.<br/>    net_ipv4_tcp_max_tw_buckets        = number - (Optional) The sysctl setting net.ipv4.tcp_max_tw_buckets. Must be between `8000` and `1440000`. Changing this forces a new resource to be created.<br/>    net_ipv4_tcp_tw_reuse              = number - (Optional) The sysctl setting net.ipv4.tcp_tw_reuse. Changing this forces a new resource to be created.<br/>    net_netfilter_nf_conntrack_buckets = number - (Optional) The sysctl setting net.netfilter.nf_conntrack_buckets. Must be between `65536` and `147456`. Changing this forces a new resource to be created.<br/>    net_netfilter_nf_conntrack_max     = number - (Optional) The sysctl setting net.netfilter.nf_conntrack_max. Must be between `131072` and `589824`. Changing this forces a new resource to be created.<br/>    vm_max_map_count                   = number - (Optional) The sysctl setting vm.max_map_count. Must be between `65530` and `262144`. Changing this forces a new resource to be created.<br/>    vm_swappiness                      = number - (Optional) The sysctl setting vm.swappiness. Must be between `0` and `100`. Changing this forces a new resource to be created.<br/>    vm_vfs_cache_pressure              = number - (Optional) The sysctl setting vm.vfs_cache_pressure. Must be between `0` and `100`. Changing this forces a new resource to be created.<br/>  }<br/>}</pre>**NOTE**: If a property isn't required then it must be explicitly set as an empty list or `null`. | <pre>object({<br/>    swap_file_size_mb             = string<br/>    transparent_huge_page_defrag  = string<br/>    transparent_huge_page_enabled = string<br/><br/>    sysctl_config = object({<br/>      fs_aio_max_nr                      = number<br/>      fs_file_max                        = number<br/>      fs_inotify_max_user_watches        = number<br/>      fs_nr_open                         = number<br/>      kernel_threads_max                 = number<br/>      net_core_netdev_max_backlog        = number<br/>      net_core_optmem_max                = number<br/>      net_core_rmem_default              = number<br/>      net_core_rmem_max                  = number<br/>      net_core_somaxconn                 = number<br/>      net_core_wmem_default              = number<br/>      net_core_wmem_max                  = number<br/>      net_ipv4_ip_local_port_range_max   = number<br/>      net_ipv4_ip_local_port_range_min   = number<br/>      net_ipv4_neigh_default_gc_thresh1  = number<br/>      net_ipv4_neigh_default_gc_thresh2  = number<br/>      net_ipv4_neigh_default_gc_thresh3  = number<br/>      net_ipv4_tcp_fin_timeout           = number<br/>      net_ipv4_tcp_keepalive_intvl       = number<br/>      net_ipv4_tcp_keepalive_probes      = number<br/>      net_ipv4_tcp_keepalive_time        = number<br/>      net_ipv4_tcp_max_syn_backlog       = number<br/>      net_ipv4_tcp_max_tw_buckets        = number<br/>      net_ipv4_tcp_tw_reuse              = number<br/>      net_netfilter_nf_conntrack_buckets = number<br/>      net_netfilter_nf_conntrack_max     = number<br/>      vm_max_map_count                   = number<br/>      vm_swappiness                      = number<br/>      vm_vfs_cache_pressure              = number<br/>    })<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aks_additional_nodepool_id"></a> [aks_additional_nodepool_id](#output_aks_additional_nodepool_id) | The ID of the created aks additional nodepool. |
| <a name="output_aks_additional_nodepool_name"></a> [aks_additional_nodepool_name](#output_aks_additional_nodepool_name) | The Name of the created aks additional nodepool. |
| <a name="output_resource"></a> [resource](#output_resource) | The aks additional nodepool resource. |
<!-- END_TF_DOCS -->
