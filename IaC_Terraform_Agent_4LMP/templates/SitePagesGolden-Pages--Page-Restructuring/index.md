# LMP Azure Golden Images

## Overview

 

A golden image, also known as a master image, is a pre-configured VM or OS image. In Azure, the golden image contains necessary configurations, security agents, and compliance benchmarks for a specific application deployment.

 

## Available images in LMP Azure

In continuation of image creation process described above, once the images are made available under Shared Image Gallery of LSEG Subscription with proper versioning, application team is supposed to use the latest image available for creation of their respective VMs for Application deployment.

 

In Confluence, you can find the communication channel where details about every image release in every tenant can be found:

[Azure Golden Image Pipelines - Releases - Public Cloud Platform - Enterprise Confluence](https://confluence.refinitiv.com/display/PCP/Azure+Golden+Image+Pipelines+-+Releases)

 

<a href="https://confluence.refinitiv.com/display/PCP/Azure+Golden+Images+-+LSEGroup" data-interception="off" target="_blank" rel="noopener noreferrer">Click here to access the Release Notes for LSEG.com</a>

 

Below images have been published in LSEG Dev subscription:

 

- RHEL 8.10 Std base

  <span class="fontColorRed">**Please note:** Beginning 20 February 2026, SRE will discontinue the release and maintenance of all non‑trusted launch images. Prior notifications were issued to all application teams on 14 October 2025 to use alternative trusted launch images.</span>

- RHEL 8.10 (with Trusted Launch security type)

- RHEL 9

- Ubuntu 20.04

  <span class="fontColorRed">**Please note:** Ubuntu 20.04 has reached End of Life (EOL) and is no longer supported from 31st May 2025. As a result, GI will no longer provide images, updates, or build support for Ubuntu 20.04. Application teams are required to migrate to Ubuntu 22.04 version as soon as possible.</span>

- Ubuntu 22.04

- Windows Server 2019

- Windows Server 2022

   

***Azure compute gallery***: a1a51386devgalgimageuks02

***Azure compute gallery resource id***: "/subscriptions/0d03b955-d606-4f60-8550-79c3b700ab22/resourceGroups/a1a-51386-dev-rg-gimage-uks-01/providers/Microsoft.Compute/galleries/a1a51386devgalgimageuks02"

| **Name** | **Type** | **Resource Group** | **Location** | **Subscription** | **Sharing Method** |
|----|----|----|----|----|----|
| a1a51386devgalgimageuks02 | Azure compute gallery | a1a-51386-dev-rg-gimage-uks-01 | uksouth | a1a-51386-dev-test-sub-gimage-02 | RBAC |

 

**Golden image Definition Dev**

| **Name** | **Provisioning State** | **OS type** | **OS state** | **VM generation** | **Location** |
|----|----|----|----|----|----|
| windows-server-2019-full-x64-base | Succeeded | Windows | Generalized | V2 | uksouth |
| rhel-server-9-standard-x64 | Succeeded | Linux | Generalized | V2 | uksouth |
| windows-server-2022-full-x64 | Succeeded | Windows | Generalized | V2 | uksouth |
| rhel-server-8-standard-x64 | Succeeded | Linux | Generalized | V2 | uksouth |
| ubuntu-server-22.04-standard-x64 | Succeeded | Linux | Generalized | V2 | uksouth |

 

**Golden Image Resource ID LSEG Dev**

<table>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<thead>
<tr>
<th><strong>Name</strong></th>
<th><strong>Image Resource ID</strong></th>
</tr>
</thead>
<tbody>
<tr>
<td>windows-server-2019-full-x64-base</td>
<td><p>/subscriptions/0d03b955-d606-4f60-8550-79c3b700ab22/resourceGroups/a1a-51386-dev-rg-gimage-uks-01/providers/Microsoft.Compute/galleries/a1a51386devgalgimageuks02/images/windows-server-2019-full-x64-base</p>
<p><strong>NVMe(For v6 SKU)</strong>: /subscriptions/0d03b955-d606-4f60-8550-79c3b700ab22/resourceGroups/a1a-51386-dev-rg-gimage-uks-01/providers/Microsoft.Compute/galleries/a1a51386devgalgimageuks02/images/windows-server-2019-full-x64-nvme</p></td>
</tr>
<tr>
<td>rhel-server-9-standard-x64</td>
<td><p>/subscriptions/0d03b955-d606-4f60-8550-79c3b700ab22/resourceGroups/a1a-51386-dev-rg-gimage-uks-01/providers/Microsoft.Compute/galleries/a1a51386devgalgimageuks02/images/rhel-server-9-standard-x64</p>
<p><strong>NVMe(For v6 SKU)</strong>: /subscriptions/0d03b955-d606-4f60-8550-79c3b700ab22/resourceGroups/a1a-51386-dev-rg-gimage-uks-01/providers/Microsoft.Compute/galleries/a1a51386devgalgimageuks02/images/rhel-server-9-standard-x64-nvme</p></td>
</tr>
<tr>
<td>windows-server-2022-full-x64</td>
<td><p>/subscriptions/0d03b955-d606-4f60-8550-79c3b700ab22/resourceGroups/a1a-51386-dev-rg-gimage-uks-01/providers/Microsoft.Compute/galleries/a1a51386devgalgimageuks02/images/windows-server-2022-full-x64</p>
<p><strong>NVMe(For v6 SKU)</strong>: /subscriptions/0d03b955-d606-4f60-8550-79c3b700ab22/resourceGroups/a1a-51386-dev-rg-gimage-uks-01/providers/Microsoft.Compute/galleries/a1a51386devgalgimageuks02/images/windows-server-2022-full-x64-nvme</p></td>
</tr>
<tr>
<td>rhel-server-8-standard-x64</td>
<td><p>/subscriptions/0d03b955-d606-4f60-8550-79c3b700ab22/resourceGroups/a1a-51386-dev-rg-gimage-uks-01/providers/Microsoft.Compute/galleries/a1a51386devgalgimageuks02/images/rhel-server-8-standard-x64</p>
<p><strong>NVMe(For v6 SKU)</strong>: /subscriptions/0d03b955-d606-4f60-8550-79c3b700ab22/resourceGroups/a1a-51386-dev-rg-gimage-uks-01/providers/Microsoft.Compute/galleries/a1a51386devgalgimageuks02/images/rhel-server-8-standard-x64-nvme</p></td>
</tr>
<tr>
<td>ubuntu-server-22.04-standard-x64</td>
<td><p>/subscriptions/0d03b955-d606-4f60-8550-79c3b700ab22/resourceGroups/a1a-51386-dev-rg-gimage-uks-01/providers/Microsoft.Compute/galleries/a1a51386devgalgimageuks02/images/ubuntu-server-22.04-standard-x64</p>
<p><strong>NVMe(For v6 SKU)</strong>: /subscriptions/0d03b955-d606-4f60-8550-79c3b700ab22/resourceGroups/a1a-51386-dev-rg-gimage-uks-01/providers/Microsoft.Compute/galleries/a1a51386devgalgimageuks02/images/ubuntu-server-22.04-standard-x64-nvme</p></td>
</tr>
</tbody>
</table>

 

 <a href="https://confluence.refinitiv.com/display/PCP/Azure+Golden+Images+-+LSEGroup" data-interception="off" target="_blank" rel="noopener noreferrer">Click here to access the Release Notes for LSEG.com</a>

 

Below images have been published in LSEG PreProd subscription:

 

- RHEL 8.10 Std base

  <span class="fontColorRed">**Please note:** Beginning 20 February 2026, SRE will discontinue the release and maintenance of all non‑trusted launch images. Prior notifications were issued to all application teams on 14 October 2025 to use alternative trusted launch images.</span>

- RHEL 8.10 (with Trusted Launch security type)

- RHEL 9

- Ubuntu 20.04

  <span class="fontColorRed">**Please note:** Ubuntu 20.04 has reached End of Life (EOL) and is no longer supported from 31st May 2025. As a result, GI will no longer provide images, updates, or build support for Ubuntu 20.04. Application teams are required to migrate to Ubuntu 22.04 version as soon as possible.</span>

- Ubuntu 22.04

- Windows Server 2019

- Windows Server 2022

 

***Azure compute gallery***: a1a51386pprgalgimageuks01

***Azure compute gallery resource id***: “/subscriptions/0048b14f-cb7c-4a41-a4f9-9613cbadccac/resourceGroups/a1a-51386-ppr-rg-gimage-uks-01/providers/Microsoft.Compute/galleries/a1a51386pprgalgimageuks01”

| **Name** | **Type** | **Resource Group** | **Location** | **Subscription** | **Sharing Method** |
|----|----|----|----|----|----|
| a1a51386pprgalgimageuks01 | Azure compute gallery | a1a-51386-ppr-rg-gimage-uks-01 | uksouth | a1a-51386-ppr-sub-gimage-01 | RBAC |

 

**Golden image Definition PreProd**

| **Name** | **Provisioning State** | **OS type** | **OS state** | **VM generation** | **Location** |
|----|----|----|----|----|----|
| windows-server-2019-full-x64-base | Succeeded | Windows | Generalized | V2 | uksouth |
| rhel-server-9-standard-x64 | Succeeded | Linux | Generalized | V2 | uksouth |
| windows-server-2022-full-x64 | Succeeded | Windows | Generalized | V2 | uksouth |
| rhel-server-8-standard-x64 | Succeeded | Linux | Generalized | V2 | uksouth |
| ubuntu-server-22.04-standard-x64 | Succeeded | Linux | Generalized | V2 | uksouth |

 

**Golden Image Resource ID LSEG PreProd**

<table>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<thead>
<tr>
<th><strong>Name</strong></th>
<th><strong>Image Resource ID</strong></th>
</tr>
</thead>
<tbody>
<tr>
<td>windows-server-2019-full-x64-base</td>
<td><p>/subscriptions/0048b14f-cb7c-4a41-a4f9-9613cbadccac/resourceGroups/a1a-51386-ppr-rg-gimage-uks-01/providers/Microsoft.Compute/galleries/a1a51386pprgalgimageuks01/images/windows-server-2019-full-x64-base</p>
<p><strong>NVMe(For v6 SKU):</strong> /subscriptions/0048b14f-cb7c-4a41-a4f9-9613cbadccac/resourceGroups/a1a-51386-ppr-rg-gimage-uks-01/providers/Microsoft.Compute/galleries/a1a51386pprgalgimageuks01/images/windows-server-2019-full-x64-nvme</p></td>
</tr>
<tr>
<td>rhel-server-9-standard-x64</td>
<td><p>/subscriptions/0048b14f-cb7c-4a41-a4f9-9613cbadccac/resourceGroups/a1a-51386-ppr-rg-gimage-uks-01/providers/Microsoft.Compute/galleries/a1a51386pprgalgimageuks01/images/rhel-server-9-standard-x64</p>
<p><strong>NVMe(For v6 SKU)</strong>: /subscriptions/0048b14f-cb7c-4a41-a4f9-9613cbadccac/resourceGroups/a1a-51386-ppr-rg-gimage-uks-01/providers/Microsoft.Compute/galleries/a1a51386pprgalgimageuks01/images/rhel-server-9-standard-x64-nvme</p></td>
</tr>
<tr>
<td>windows-server-2022-full-x64</td>
<td><p>/subscriptions/0048b14f-cb7c-4a41-a4f9-9613cbadccac/resourceGroups/a1a-51386-ppr-rg-gimage-uks-01/providers/Microsoft.Compute/galleries/a1a51386pprgalgimageuks01/images/windows-server-2022-full-x64</p>
<p><strong>NVMe(For v6 SKU)</strong>: /subscriptions/0048b14f-cb7c-4a41-a4f9-9613cbadccac/resourceGroups/a1a-51386-ppr-rg-gimage-uks-01/providers/Microsoft.Compute/galleries/a1a51386pprgalgimageuks01/images/windows-server-2022-full-x64-nvme</p></td>
</tr>
<tr>
<td>rhel-server-8-standard-x64</td>
<td><p>/subscriptions/0048b14f-cb7c-4a41-a4f9-9613cbadccac/resourceGroups/a1a-51386-ppr-rg-gimage-uks-01/providers/Microsoft.Compute/galleries/a1a51386pprgalgimageuks01/images/rhel-server-8-standard-x64</p>
<p><strong>NVMe(For v6 SKU)</strong>: /subscriptions/0048b14f-cb7c-4a41-a4f9-9613cbadccac/resourceGroups/a1a-51386-ppr-rg-gimage-uks-01/providers/Microsoft.Compute/galleries/a1a51386pprgalgimageuks01/images/rhel-server-8-standard-x64-nvme</p></td>
</tr>
<tr>
<td>ubuntu-server-22.04-standard-x64</td>
<td><p>/subscriptions/0048b14f-cb7c-4a41-a4f9-9613cbadccac/resourceGroups/a1a-51386-ppr-rg-gimage-uks-01/providers/Microsoft.Compute/galleries/a1a51386pprgalgimageuks01/images/ubuntu-server-22.04-standard-x64</p>
<p><strong>NVMe(For v6 SKU)</strong>: /subscriptions/0048b14f-cb7c-4a41-a4f9-9613cbadccac/resourceGroups/a1a-51386-ppr-rg-gimage-uks-01/providers/Microsoft.Compute/galleries/a1a51386pprgalgimageuks01/images/ubuntu-server-22.04-standard-x64-nvme</p></td>
</tr>
</tbody>
</table>

<a href="https://confluence.refinitiv.com/display/PCP/Azure+Golden+Images+-+LSEGroup" data-interception="off" target="_blank" rel="noopener noreferrer">Click here to access the Release Notes for LSEG.com</a>

 

Below images have been published in LSEG Prod subscription:

 

- RHEL 8.10 Std base

  <span class="fontColorRed">**Please note:** Beginning 20 February 2026, SRE will discontinue the release and maintenance of all non‑trusted launch images. Prior notifications were issued to all application teams on 14 October 2025 to use alternative trusted launch images.</span>

- RHEL 8.10 (with Trusted Launch security type)

- RHEL 9

- Ubuntu 20.04

  <span class="fontColorRed">**Please note:** Ubuntu 20.04 has reached End of Life (EOL) and is no longer supported from 31st May 2025. As a result, GI will no longer provide images, updates, or build support for Ubuntu 20.04. Application teams are required to migrate to Ubuntu 22.04 version as soon as possible.</span>

- Ubuntu 22.04

- Windows Server 2019

- Windows Server 2022

 

***Azure compute gallery***: a1a51386prdgalgimageuks01

***Azure compute gallery resource id***: “/subscriptions/6bfd6036-2d64-4bf8-a2e9-79a4ebf3c29e/resourceGroups/a1a-51386-prd-rg-gimage-uks-01/providers/Microsoft.Compute/galleries/a1a51386prdgalgimageuks01”

| **Name** | **Type** | **Resource Group** | **Location** | **Subscription** | **Sharing Method** |
|----|----|----|----|----|----|
| a1a51386prdgalgimageuks01 | Azure compute gallery | a1a-51386-prd-rg-gimage-uks-01 | uksouth | a1a-51386-prd-sub-gimage-01 | RBAC |

 

**Golden image Definition Prod**

| **Name** | **Provisioning State** | **OS type** | **OS state** | **VM generation** | **Location** |
|----|----|----|----|----|----|
| windows-server-2019-full-x64-base | Succeeded | Windows | Generalized | V2 | uksouth |
| rhel-server-9-standard-x64 | Succeeded | Linux | Generalized | V2 | uksouth |
| windows-server-2022-full-x64 | Succeeded | Windows | Generalized | V2 | uksouth |
| rhel-server-8-standard-x64 | Succeeded | Linux | Generalized | V2 | uksouth |
| ubuntu-server-22.04-standard-x64 | Succeeded | Linux | Generalized | V2 | uksouth |

 

**Golden Image Resource ID LSEG Prod**

<table>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<thead>
<tr>
<th><strong>Name</strong></th>
<th><strong>Image Resource ID</strong></th>
</tr>
</thead>
<tbody>
<tr>
<td>windows-server-2019-full-x64-base</td>
<td><p>/subscriptions/6bfd6036-2d64-4bf8-a2e9-79a4ebf3c29e/resourceGroups/a1a-51386-prd-rg-gimage-uks-01/providers/Microsoft.Compute/galleries/a1a51386prdgalgimageuks01/images/windows-server-2019-full-x64-base</p>
<p><strong>NVMe(For v6 SKU)</strong>: /subscriptions/6bfd6036-2d64-4bf8-a2e9-79a4ebf3c29e/resourceGroups/a1a-51386-prd-rg-gimage-uks-01/providers/Microsoft.Compute/galleries/a1a51386prdgalgimageuks01/images/windows-server-2019-full-x64-nvme</p></td>
</tr>
<tr>
<td>rhel-server-9-standard-x64</td>
<td><p>/subscriptions/6bfd6036-2d64-4bf8-a2e9-79a4ebf3c29e/resourceGroups/a1a-51386-prd-rg-gimage-uks-01/providers/Microsoft.Compute/galleries/a1a51386prdgalgimageuks01/images/rhel-server-9-standard-x64</p>
<p><strong>NVMe(For v6 SKU)</strong>: /subscriptions/6bfd6036-2d64-4bf8-a2e9-79a4ebf3c29e/resourceGroups/a1a-51386-prd-rg-gimage-uks-01/providers/Microsoft.Compute/galleries/a1a51386prdgalgimageuks01/images/rhel-server-9-standard-x64-nvme</p></td>
</tr>
<tr>
<td>windows-server-2022-full-x64</td>
<td><p>/subscriptions/6bfd6036-2d64-4bf8-a2e9-79a4ebf3c29e/resourceGroups/a1a-51386-prd-rg-gimage-uks-01/providers/Microsoft.Compute/galleries/a1a51386prdgalgimageuks01/images/windows-server-2022-full-x64</p>
<p><strong>NVMe(For v6 SKU)</strong>: /subscriptions/6bfd6036-2d64-4bf8-a2e9-79a4ebf3c29e/resourceGroups/a1a-51386-prd-rg-gimage-uks-01/providers/Microsoft.Compute/galleries/a1a51386prdgalgimageuks01/images/windows-server-2022-full-x64-nvme</p></td>
</tr>
<tr>
<td>rhel-server-8-standard-x64</td>
<td><p>/subscriptions/6bfd6036-2d64-4bf8-a2e9-79a4ebf3c29e/resourceGroups/a1a-51386-prd-rg-gimage-uks-01/providers/Microsoft.Compute/galleries/a1a51386prdgalgimageuks01/images/rhel-server-8-standard-x64</p>
<p><strong>NVMe(For v6 SKU)</strong>: /subscriptions/6bfd6036-2d64-4bf8-a2e9-79a4ebf3c29e/resourceGroups/a1a-51386-prd-rg-gimage-uks-01/providers/Microsoft.Compute/galleries/a1a51386prdgalgimageuks01/images/rhel-server-8-standard-x64-nvme</p></td>
</tr>
<tr>
<td>ubuntu-server-22.04-standard-x64</td>
<td><p>/subscriptions/6bfd6036-2d64-4bf8-a2e9-79a4ebf3c29e/resourceGroups/a1a-51386-prd-rg-gimage-uks-01/providers/Microsoft.Compute/galleries/a1a51386prdgalgimageuks01/images/ubuntu-server-22.04-standard-x64</p>
<p><strong>NVMe(For v6 SKU)</strong>: /subscriptions/6bfd6036-2d64-4bf8-a2e9-79a4ebf3c29e/resourceGroups/a1a-51386-prd-rg-gimage-uks-01/providers/Microsoft.Compute/galleries/a1a51386prdgalgimageuks01/images/ubuntu-server-22.04-standard-x64-nvme</p></td>
</tr>
</tbody>
</table>

<a href="https://confluence.refinitiv.com/display/PCP/Azure+Golden+Images+-+LMSP0" data-interception="off" target="_blank" rel="noopener noreferrer">Click here to access the Release Notes for LMPS0</a>

 

Below images have been published in LMSP0 SHD subscription:

 

- RHEL 8.10 Std base

  <span class="fontColorRed">**Please note:** Beginning 20 February 2026, SRE will discontinue the release and maintenance of all non‑trusted launch images. Prior notifications were issued to all application teams on 14 October 2025 to use alternative trusted launch images.</span>

- RHEL 8.10 (with Trusted Launch security type)

- RHEL 9

- Ubuntu 20.04

  <span class="fontColorRed">**Please note:** Ubuntu 20.04 has reached End of Life (EOL) and is no longer supported from 31st May 2025. As a result, GI will no longer provide images, updates, or build support for Ubuntu 20.04. Application teams are required to migrate to Ubuntu 22.04 version as soon as possible.</span>

- Ubuntu 22.04

- Windows Server 2019

- Windows Server 2022

 

***Azure compute gallery***: a0a51386devgalgimageuks01

***Azure compute gallery resource id***: “/subscriptions/e3e5a4d5-6e95-4f8e-a30e-802c7af7ce98/resourceGroups/a0a-51386-dev-rg-gimage-uks-01/providers/Microsoft.Compute/galleries/a0a51386devgalgimageuks01”

| **Name** | **Type** | **Resource Group** | **Location** | **Subscription** | **Sharing Method** |
|----|----|----|----|----|----|
| a0a51386devgalgimageuks01 | Azure compute gallery | a0a-51386-dev-rg-gimage-uks-01 | uksouth | a0a-51386-dev-test-sub-gimage-01 | RBAC |

 

**Golden image Definition LMSP0 SHD**

| **Name** | **Provisioning State** | **OS type** | **OS state** | **VM generation** | **Location** |
|----|----|----|----|----|----|
| windows-server-2019-full-x64-base | Succeeded | Windows | Generalized | V2 | uksouth |
| rhel-server-9-standard-x64 | Succeeded | Linux | Generalized | V2 | uksouth |
| windows-server-2022-full-x64 | Succeeded | Windows | Generalized | V2 | uksouth |
| rhel-server-8-standard-x64 | Succeeded | Linux | Generalized | V2 | uksouth |
| ubuntu-server-20.04-standard-x64 | Succeeded | Linux | Generalized | V2 | uksouth |
| ubuntu-server-22.04-standard-x64 | Succeeded | Linux | Generalized | V2 | uksouth |

 

**Golden Image Resource ID LMSP0 SHD**

<table>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<thead>
<tr>
<th><strong>Name</strong></th>
<th><strong>Image Resource ID</strong></th>
</tr>
</thead>
<tbody>
<tr>
<td>windows-server-2019-full-x64-base</td>
<td><p>/subscriptions/e3e5a4d5-6e95-4f8e-a30e-802c7af7ce98/resourceGroups/a0a-51386-dev-rg-gimage-uks-01/providers/Microsoft.Compute/galleries/a0a51386devgalgimageuks01/images/windows-server-2019-full-x64-base</p>
<p><strong>NVMe(For v6 SKU)</strong>: /subscriptions/e3e5a4d5-6e95-4f8e-a30e-802c7af7ce98/resourceGroups/a0a-51386-dev-rg-gimage-uks-01/providers/Microsoft.Compute/galleries/a0a51386devgalgimageuks01/images/windows-server-2019-full-x64-nvme</p></td>
</tr>
<tr>
<td>rhel-server-9-standard-x64</td>
<td><p>/subscriptions/e3e5a4d5-6e95-4f8e-a30e-802c7af7ce98/resourceGroups/a0a-51386-dev-rg-gimage-uks-01/providers/Microsoft.Compute/galleries/a0a51386devgalgimageuks01/images/rhel-server-9-standard-x64</p>
<p><strong>NVMe(For v6 SKU)</strong>: /subscriptions/e3e5a4d5-6e95-4f8e-a30e-802c7af7ce98/resourceGroups/a0a-51386-dev-rg-gimage-uks-01/providers/Microsoft.Compute/galleries/a0a51386devgalgimageuks01/images/rhel-server-9-standard-x64-nvme</p></td>
</tr>
<tr>
<td>windows-server-2022-full-x64</td>
<td><p>/subscriptions/e3e5a4d5-6e95-4f8e-a30e-802c7af7ce98/resourceGroups/a0a-51386-dev-rg-gimage-uks-01/providers/Microsoft.Compute/galleries/a0a51386devgalgimageuks01/images/windows-server-2022-full-x64</p>
<p><strong>NVMe(For v6 SKU)</strong>: /subscriptions/e3e5a4d5-6e95-4f8e-a30e-802c7af7ce98/resourceGroups/a0a-51386-dev-rg-gimage-uks-01/providers/Microsoft.Compute/galleries/a0a51386devgalgimageuks01/images/windows-server-2022-full-x64-nvme</p></td>
</tr>
<tr>
<td>rhel-server-8-standard-x64</td>
<td><p>/subscriptions/e3e5a4d5-6e95-4f8e-a30e-802c7af7ce98/resourceGroups/a0a-51386-dev-rg-gimage-uks-01/providers/Microsoft.Compute/galleries/a0a51386devgalgimageuks01/images/rhel-server-8-standard-x64</p>
<p><strong>NVMe(For v6 SKU)</strong>: /subscriptions/e3e5a4d5-6e95-4f8e-a30e-802c7af7ce98/resourceGroups/a0a-51386-dev-rg-gimage-uks-01/providers/Microsoft.Compute/galleries/a0a51386devgalgimageuks01/images/rhel-server-8-standard-x64-nvme</p></td>
</tr>
<tr>
<td>ubuntu-server-22.04-standard-x64</td>
<td><p>/subscriptions/e3e5a4d5-6e95-4f8e-a30e-802c7af7ce98/resourceGroups/a0a-51386-dev-rg-gimage-uks-01/providers/Microsoft.Compute/galleries/a0a51386devgalgimageuks01/images/ubuntu-server-22.04-standard-x64</p>
<p><strong>NVMe(For v6 SKU)</strong>: /subscriptions/e3e5a4d5-6e95-4f8e-a30e-802c7af7ce98/resourceGroups/a0a-51386-dev-rg-gimage-uks-01/providers/Microsoft.Compute/galleries/a0a51386devgalgimageuks01/images/ubuntu-server-22.04-standard-x64-nvme</p></td>
</tr>
</tbody>
</table>

<a href="https://confluence.refinitiv.com/display/PCP/Azure+Golden+Images+-+LMSP1" data-interception="off" target="_blank" rel="noopener noreferrer">Click here to access the Release Notes for LMSP1</a>

 

Below images have been published in LMSP1 SHD subscription:

 

- RHEL 8.10 Std base

  <span class="fontColorRed">**Please note:** Beginning 20 February 2026, SRE will discontinue the release and maintenance of all non‑trusted launch images. Prior notifications were issued to all application teams on 14 October 2025 to use alternative trusted launch images.</span>

- RHEL 8.10 (with Trusted Launch security type)

- RHEL 9

- Ubuntu 20.04

  <span class="fontColorRed">**Please note:** Ubuntu 20.04 has reached End of Life (EOL) and is no longer supported from 31st May 2025. As a result, GI will no longer provide images, updates, or build support for Ubuntu 20.04. Application teams are required to migrate to Ubuntu 22.04 version as soon as possible.</span>

- Ubuntu 22.04

- Windows Server 2019

- Windows Server 2022

 

***Azure compute gallery***: a0b51386shdgalgimageeus201

***Azure compute gallery resource id***: “/subscriptions/284292b4-7df2-4cc2-bf34-f08157672460/resourceGroups/a0b-51386-shd-rg-gimage-eus2-01/providers/Microsoft.Compute/galleries/a0b51386shdgalgimageeus201/”

| **Name** | **Type** | **Resource Group** | **Location** | **Subscription** | **Sharing Method** |
|----|----|----|----|----|----|
| a0b51386shdgalgimageeus201 | Azure compute gallery | a0b-51386-dev-rg-gimage-uks-01 | uksouth | a0b-51386-shd-rg-gimage-eus2-01 | RBAC |

 

**Golden image Definition LMSP1 SHD**

| **Name** | **Provisioning State** | **OS type** | **OS state** | **VM generation** | **Location** |
|----|----|----|----|----|----|
| windows-server-2019-full-x64-base | Succeeded | Windows | Generalized | V2 | eastus2 |
| rhel-server-9-standard-x64 | Succeeded | Linux | Generalized | V2 | eastus2 |
| windows-server-2022-full-x64 | Succeeded | Windows | Generalized | V2 | eastus2 |
| rhel-server-8-standard-x64 | Succeeded | Linux | Generalized | V2 | eastus2 |
| ubuntu-server-22.04-standard-x64 | Succeeded | Linux | Generalized | V2 | eastus2 |

 

**Golden Image Resource ID LMSP1 SHD**

<table>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<thead>
<tr>
<th><strong>Name</strong></th>
<th><strong>Image Resource ID</strong></th>
</tr>
</thead>
<tbody>
<tr>
<td>windows-server-2019-full-x64-base</td>
<td><p>/subscriptions/284292b4-7df2-4cc2-bf34-f08157672460/resourceGroups/a0b-51386-shd-rg-gimage-eus2-01/providers/Microsoft.Compute/galleries/a0b51386shdgalgimageeus201/images/windows-server-2019-full-x64-base</p>
<p><strong>NVMe(For v6 SKU):</strong> /subscriptions/284292b4-7df2-4cc2-bf34-f08157672460/resourceGroups/a0b-51386-shd-rg-gimage-eus2-01/providers/Microsoft.Compute/galleries/a0b51386shdgalgimageeus201/images/windows-server-2019-full-x64-nvme</p></td>
</tr>
<tr>
<td>rhel-server-9-standard-x64</td>
<td><p>/subscriptions/284292b4-7df2-4cc2-bf34-f08157672460/resourceGroups/a0b-51386-shd-rg-gimage-eus2-01/providers/Microsoft.Compute/galleries/a0b51386shdgalgimageeus201/images/rhel-server-9-standard-x64</p>
<p><strong>NVMe(For v6 SKU):</strong> /subscriptions/284292b4-7df2-4cc2-bf34-f08157672460/resourceGroups/a0b-51386-shd-rg-gimage-eus2-01/providers/Microsoft.Compute/galleries/a0b51386shdgalgimageeus201/images/rhel-server-9-standard-x64-nvme</p></td>
</tr>
<tr>
<td>windows-server-2022-full-x64</td>
<td><p>/subscriptions/284292b4-7df2-4cc2-bf34-f08157672460/resourceGroups/a0b-51386-shd-rg-gimage-eus2-01/providers/Microsoft.Compute/galleries/a0b51386shdgalgimageeus201/images/windows-server-2022-full-x64</p>
<p><strong>NVMe(For v6 SKU):</strong> /subscriptions/284292b4-7df2-4cc2-bf34-f08157672460/resourceGroups/a0b-51386-shd-rg-gimage-eus2-01/providers/Microsoft.Compute/galleries/a0b51386shdgalgimageeus201/images/windows-server-2022-full-x64-nvme</p></td>
</tr>
<tr>
<td>rhel-server-8-standard-x64</td>
<td><p>/subscriptions/284292b4-7df2-4cc2-bf34-f08157672460/resourceGroups/a0b-51386-shd-rg-gimage-eus2-01/providers/Microsoft.Compute/galleries/a0b51386shdgalgimageeus201/images/rhel-server-8-standard-x64</p>
<p><strong>NVMe(For v6 SKU):</strong> /subscriptions/284292b4-7df2-4cc2-bf34-f08157672460/resourceGroups/a0b-51386-shd-rg-gimage-eus2-01/providers/Microsoft.Compute/galleries/a0b51386shdgalgimageeus201/images/rhel-server-8-standard-x64-nvme</p></td>
</tr>
<tr>
<td>ubuntu-server-22.04-standard-x64</td>
<td><p>/subscriptions/284292b4-7df2-4cc2-bf34-f08157672460/resourceGroups/a0b-51386-shd-rg-gimage-eus2-01/providers/Microsoft.Compute/galleries/a0b51386shdgalgimageeus201/images/ubuntu-server-22.04-standard-x64</p>
<p><strong>NVMe(For v6 SKU):</strong> /subscriptions/284292b4-7df2-4cc2-bf34-f08157672460/resourceGroups/a0b-51386-shd-rg-gimage-eus2-01/providers/Microsoft.Compute/galleries/a0b51386shdgalgimageeus201/images/ubuntu-server-22.04-standard-x64-nvme</p></td>
</tr>
</tbody>
</table>

 

<a href="https://confluence.refinitiv.com/display/PCP/Azure+Golden+Images+-+LSEG+SaaS" data-interception="off" target="_blank" rel="noopener noreferrer">Click here to access the Release Notes for LSEG SaaS</a>

 

Below images have been published in LSEG SaaS SHD subscription:

 

- RHEL 8.10 Std base

  <span class="fontColorRed">**Please note:** Beginning 20 February 2026, SRE will discontinue the release and maintenance of all non‑trusted launch images. Prior notifications were issued to all application teams on 14 October 2025 to use alternative trusted launch images.</span>

- RHEL 8.10 (with Trusted Launch security type)

- RHEL 9

- Ubuntu 20.04

  <span class="fontColorRed">**Please note:** Ubuntu 20.04 has reached End of Life (EOL) and is no longer supported from 31st May 2025. As a result, GI will no longer provide images, updates, or build support for Ubuntu 20.04. Application teams are required to migrate to Ubuntu 22.04 version as soon as possible.</span>

- Ubuntu 22.04

- Windows Server 2019

- Windows Server 2022

 

***Azure compute gallery***: [a1b51386shdgalgimageeus201](https://portal.azure.com/#%40lsegsaas.onmicrosoft.com/resource/subscriptions/1d3b9872-5b6d-4151-b033-99f51e532312/resourceGroups/a1b-51386-shd-rg-gimage-eus2-01/providers/Microsoft.Compute/galleries/a1b51386shdgalgimageeus201)

***Azure compute gallery resource id***: “/subscriptions/1d3b9872-5b6d-4151-b033-99f51e532312/resourceGroups/a1b-51386-shd-rg-gimage-eus2-01/providers/Microsoft.Compute/galleries/a1b51386shdgalgimageeus201”

| **Name** | **Type** | **Resource Group** | **Location** | **Subscription** | **Sharing Method** |
|----|----|----|----|----|----|
| [a1b51386shdgalgimageeus201](https://portal.azure.com/#%40lsegsaas.onmicrosoft.com/resource/subscriptions/1d3b9872-5b6d-4151-b033-99f51e532312/resourceGroups/a1b-51386-shd-rg-gimage-eus2-01/providers/Microsoft.Compute/galleries/a1b51386shdgalgimageeus201) | Azure compute gallery | a0b-51386-dev-rg-gimage-uks-01 | eastus2 | a1b-51386-shd-corporate-sub-gimage-01 | RBAC |

 

**Golden image Definition LSEG SaaS SHD**

| **Name** | **Provisioning State** | **OS type** | **OS state** | **VM generation** | **Location** |
|----|----|----|----|----|----|
| windows-server-2019-full-x64-base | Succeeded | Windows | Generalized | V2 | eastus2 |
| rhel-server-9-standard-x64 | Succeeded | Linux | Generalized | V2 | eastus2 |
| windows-server-2022-full-x64 | Succeeded | Windows | Generalized | V2 | eastus2 |
| rhel-server-8-standard-x64 | Succeeded | Linux | Generalized | V2 | eastus2 |
| ubuntu-server-22.04-standard-x64 | Succeeded | Linux | Generalized | V2 | eastus2 |

 

**Golden Image Resource ID LSEG SaaS SHD**

<table>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<thead>
<tr>
<th><strong>Name</strong></th>
<th><strong>Image Resource ID</strong></th>
</tr>
</thead>
<tbody>
<tr>
<td>windows-server-2019-full-x64-base</td>
<td><p>/subscriptions/1d3b9872-5b6d-4151-b033-99f51e532312/resourceGroups/a1b-51386-shd-rg-gimage-eus2-01/providers/Microsoft.Compute/galleries/a1b51386shdgalgimageeus201/images/windows-server-2019-full-x64-base</p>
<p><strong>NVMe(For v6 SKU):</strong> /subscriptions/1d3b9872-5b6d-4151-b033-99f51e532312/resourceGroups/a1b-51386-shd-rg-gimage-eus2-01/providers/Microsoft.Compute/galleries/a1b51386shdgalgimageeus201/images/windows-server-2019-full-x64-nvme</p></td>
</tr>
<tr>
<td>rhel-server-9-standard-x64</td>
<td><p>/subscriptions/1d3b9872-5b6d-4151-b033-99f51e532312/resourceGroups/a1b-51386-shd-rg-gimage-eus2-01/providers/Microsoft.Compute/galleries/a1b51386shdgalgimageeus201/images/rhel-server-9-standard-x64</p>
<p><strong>NVMe(For v6 SKU):</strong> /subscriptions/1d3b9872-5b6d-4151-b033-99f51e532312/resourceGroups/a1b-51386-shd-rg-gimage-eus2-01/providers/Microsoft.Compute/galleries/a1b51386shdgalgimageeus201/images/rhel-server-9-standard-x64-nvme</p></td>
</tr>
<tr>
<td>windows-server-2022-full-x64</td>
<td><p>/subscriptions/1d3b9872-5b6d-4151-b033-99f51e532312/resourceGroups/a1b-51386-shd-rg-gimage-eus2-01/providers/Microsoft.Compute/galleries/a1b51386shdgalgimageeus201/images/windows-server-2022-full-x64</p>
<p><strong>NVMe(For v6 SKU):</strong> /subscriptions/1d3b9872-5b6d-4151-b033-99f51e532312/resourceGroups/a1b-51386-shd-rg-gimage-eus2-01/providers/Microsoft.Compute/galleries/a1b51386shdgalgimageeus201/images/windows-server-2022-full-x64-nvme</p></td>
</tr>
<tr>
<td>rhel-server-8-standard-x64</td>
<td><p>/subscriptions/1d3b9872-5b6d-4151-b033-99f51e532312/resourceGroups/a1b-51386-shd-rg-gimage-eus2-01/providers/Microsoft.Compute/galleries/a1b51386shdgalgimageeus201/images/rhel-server-8-standard-x64</p>
<p><strong>NVMe(For v6 SKU):</strong> /subscriptions/1d3b9872-5b6d-4151-b033-99f51e532312/resourceGroups/a1b-51386-shd-rg-gimage-eus2-01/providers/Microsoft.Compute/galleries/a1b51386shdgalgimageeus201/images/rhel-server-8-standard-x64-nvme</p></td>
</tr>
<tr>
<td>ubuntu-server-22.04-standard-x64</td>
<td><p>/subscriptions/1d3b9872-5b6d-4151-b033-99f51e532312/resourceGroups/a1b-51386-shd-rg-gimage-eus2-01/providers/Microsoft.Compute/galleries/a1b51386shdgalgimageeus201/images/ubuntu-server-22.04-standard-x64</p>
<p><strong>NVMe(For v6 SKU):</strong> /subscriptions/1d3b9872-5b6d-4151-b033-99f51e532312/resourceGroups/a1b-51386-shd-rg-gimage-eus2-01/providers/Microsoft.Compute/galleries/a1b51386shdgalgimageeus201/images/ubuntu-server-22.04-standard-x64-nvme</p></td>
</tr>
</tbody>
</table>

## Unsupported VM Sizes for LSEG Golden Images

The table below lists the unsupported VM sizes for each LSEG custom Golden Image. 

 

<table>
<thead>
<tr>
<th><strong>GI Name</strong></th>
<th><strong>Unsupported VM Size</strong></th>
</tr>
</thead>
<tbody>
<tr>
<td>windows-server-2019-full-x64-base</td>
<td rowspan="5">D2pds_v6, D2plds_v6, D2pls_v6, D2ps_v6, D4pds_v6, D4plds_v6, D4pls_v6, D4ps_v6, D8pds_v6, D8plds_v6, D8pls_v6, D8ps_v6, D16pds_v6, D16plds_v6, D16pls_v6, D16ps_v6, D32pds_v6, D32plds_v6, D32pls_v6, D32ps_v6, D48pds_v6, D48plds_v6, D48pls_v6, D48ps_v6, D64pds_v6, D64plds_v6, D64pls_v6, D64ps_v6, D96pds_v6, D96plds_v6, D96pls_v6, D96ps_v6, E2pds_v6, E2ps_v6, E4pds_v6, E4ps_v6, E8pds_v6, E8ps_v6, E16pds_v6, E16ps_v6, E32pds_v6, E32ps_v6, E48pds_v6, E48ps_v6, E64pds_v6, E64ps_v6, E96pds_v6, E96ps_v6</td>
</tr>
<tr>
<td>windows-server-2022-full-x64</td>
</tr>
<tr>
<td>rhel-server-8-standard-x64</td>
</tr>
<tr>
<td>rhel-server-9-standard-x64</td>
</tr>
<tr>
<td>ubuntu-server-22.04-standard-x64</td>
</tr>
</tbody>
</table>

 

## Status of upcoming images

The Golden Images are in a continuous development process at the time being. Besides what already exists, we are planning on releasing additional images based on operating systems you may find below. A descriptive status can be found as well.

 

**No images upcoming in the foreseeable future.**

## Agents and Services in Golden Images

**Embedded Features / Tools / Software**

- qualys-cloud-agent
- falcon-sensor
- datadog-agent
- CIS Benchmark

**Firewall ports required for Qualys, CrowdStrike and Datadog to connect with the services, application team must enable these endpoints and ports on their Azure firewall to communicate the security tools.**

 

| **Endpoint** | **Ports** | **Agent** |
|----|----|----|
| qualysguard.qg2.apps.qualys.eu | 443 | Qualys |
| qualysapi.qg2.apps.qualys.eu | 443 | Qualys |
| distribution.qg2.apps.qualys.eu | 443 | Qualys |
| monitoring.qg2.apps.qualys.eu | 443 | Qualys |
| orchestrator.qg2.apps.qualys.eu | 443 | Qualys |
| qgadmin.qg2.apps.qualys.eu | 443 | Qualys |
| scanservice1.qg2.apps.qualys.eu | 443 | Qualys |
| qagpublic.qg2.apps.qualys.eu | 443 | Qualys |
| camspublic.qg2.apps.qualys.eu | 443 | Qualys |
| camspm.qg2.apps.qualys.eu | 443 | Qualys |
| camsrepo.qg2.apps.qualys.eu | 443 | Qualys |
| [ts01-b.cloudsink.net](http://ts01-b.cloudsink.net/) | 443 | CrowdStrike |
| [lfodown01-b.cloudsink.net](http://lfodown01-b.cloudsink.net/) | 443 | CrowdStrike |
| [lfoup01-b.cloudsink.net](http://lfoup01-b.cloudsink.net/) | 443 | CrowdStrike |
| *\*.datadoghq.eu* | 443 | Datadog |
| datadoghq.com | 443 | Datadog |

 

## How to use Golden Images in LMP Azure

The CPF team's Virtual Machine Terraform Module streamlines Azure Virtual Machine Deployment. This ensures consistency across different environments.

 

1.  Navigate to  <a href="https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-linuxvirtualmachine/-/blob/main/main.tf" data-interception="off" target="_blank" rel="noopener noreferrer">Terraform module</a>

     

    **Deployment Process:** 

    - Verify whether the Service Principal Name (SPN) has the required read-only access to the Azure Compute Gallery.
    - Execute the Terraform scripts to deploy the virtual machines using Golden Images

     

2.  **Module Configuration:** Update the image resource id in the virtual machine terraform module.

***Note :***

 

- *To access the Golden images in Azure, your Service Principal Name (SPN) should have the read-only access to the Azure compute gallery, where all the golden images are published. As per the process this should be taken care by the Subscription vending process.*

## How to request a Policy Exemption to deploy Azure VM/VMSS from approved older Golden Images.

Deployment of Azure Virtual Machines (VM) and Virtual Machines Scale Sets (VMSS) using older image versions from the Shared Compute Galley is currently restricted by Azure Policy definition “**Custom-VMOnlyUseSecurityApprovedImages-1.0.0**”, allowing only the latest approved images. With security team approvals to use specific older image version, we request a policy exemption via the exemption manager to proceed with deployment.

 

Please note that all resources deployed with older images must be updated to latest version within 90 days as part of Golden Image lifecycle management.

 

[doc/howto.md · main · app / Account Lifecycle - Governance / Policy Exemption Automation / Exemption Manager · GitLab](https://gitlab.dx1.lseg.com/app/app-51382/policy-exemption-automation/exemption-manager/-/blob/main/doc/howto.md)

 

## OS Hardening and CIS Documentation

As part of our Golden Image creation process, operating system hardening is implemented using LSEG CIS benchmarks, with detailed documentation on the specific CIS controls for each operating system available at the following confluence link. 

 

[OS Hardening - Security Architecture and Design - Enterprise Confluence](https://confluence.refinitiv.com/spaces/PSAR/pages/852090604/OS+Hardening)

 

These pages define the details of each OS hardening profile and link to the related resources like the GitLab repos that contain the profile kits and the upstream CIS Workbench benchmarks. The information in these pages are very useful when investigating if the hardening is causing a specific issue.

 

 

 

CIS Benchmark details and remediation guidance are available through the CIS Workbench Benchmark URL - <https://workbench.cisecurity.org/>  accessing this information requires registration on the CIS Benchmark website using your LSEG email address.

 

 

 

If you are certain that the issue lies with the hardening profile, then you can contact Cloud Security Engineering directly on this issue:

 

1.  Teams Channel

     

[Cloud Security Engineering Support \| Golden Image Support ; Patching, Agents, Hardening \| Microsoft Teams](https://teams.microsoft.com/l/channel/19:b6e77889b76f4de5b69373800e25ca49%40thread.tacv2/Golden%20Image%20Support%20%3b%20Patching%2c%20Agents%2c%20Hardening?groupId=b45ff8d0-3933-4f75-a68c-3cc7b2818303&tenantId=287e9f0e-91ec-4cf0-b7a4-c63898072181)

 

   2. Clone the "**Golden Images :: Raise Issue**" story on JIRA:

 

<https://jira.refinitiv.com/secure/RapidBoard.jspa?rapidView=21448>

 

## Golden Image Re-baking Process

Click hereTo access the Golden Images re-baking process<a href="/sites/CloudCentral/SitePages/Golden-Images--Re-baking-Process.aspx" data-sp-prop-name="button.linkUrl"></a>

 

The Golden Image Creation Process Workflow contains the following features:

 

1.  **Development of Golden Image:**
    - Connect DX1Repo with LSEG.COM Dev subscription via a GitLab pipeline.

      This supports continuous integration and deployment. This results in automating the process.

       
2.  **Component Integration:** Ensure the following component are integrated.
    - Security Agents: CrowdStrike and Qualys

    - Monitoring Agent: Datadog

    - OS Hardening Scripts

      This enhances security and robustness of the base image.

       
3.  **Image Testing and Validation:** Verify whether the image meets the LSEG's standards before commencing production.
    - Deploy a VM to check all parameters

      This helps maintain integrity and security of the deployment environment.

       
4.  **Publishing and Testing:** Provide traceability and easy access to different image versions.
    - Publish the image to the Azure Computer Gallery with proper versioning and tags.

      This enhances management and rollback capabilities.

       
5.  **Deployment to Pre-Prod and Production:** Ensure consistent and controlled transition through different stages of the environment,
    - Deploy images from DEV to Pre-Prod (PPR) and then to production.

      This reduces the risk and ensures stability. 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

**Golden Image Retrieval** 

- The Golden Image is pulled from the LSEG Azure compute gallery. 

 

**Customization and Deployment** 

- The image is customized as per the app team’s requirements. 

- The customized image is deployed to a non-production Azure compute gallery within a dedicated resource group in the app team's Azure subscription. 

- Using a development (non-prod) gallery for internal testing allows app team to build as many times as needed without scanning the VMs every time. 

 

**Temporary VM Creation** 

- A temporary virtual machine (VM) is created from the image in the non-production compute gallery. 

 

**Vulnerability Testing** 

- The VM is tested for vulnerabilities by the Qualys team, and the report is analyzed. The vulnerability report can take up to 4 hours to complete. 

- If vulnerabilities are found, the app team must resolve them. A new image is then deployed, and a new VM is created and tested. 

- So long as there are no Critical (Sev 5), High (Sev 4), or Medium (Sev 3) vulnerabilities found in the Qualys scanning report, you are good to publish to the production gallery. 

- The LSEG Golden Image may contain vulnerabilities for which approval has been obtained, such as those considered insignificant for LSEG. These approved vulnerabilities may also be present in a re-baked image. Only the Qualys team can grant these approvals. 

 

**Image Publication** 

- When no more vulnerabilities are reported, the image can be safely published to a production compute gallery and then consumed by the app team. The LSEG Golden Image may contain vulnerabilities for which approval has been obtained, such as those considered insignificant for LSEG. Such approved vulnerabilities may also be contained in a re-baked image. Only Qualys team can grand this approvals. 

- App team must use a dedicated private Azure Compute Gallery for storing re-baked images.  

- App team must ensure that a re-baked image published in a production gallery is always tested first, with no exceptions. 

 

 

**Golden Image re-baking prerequisites for application team**** **

 

To ensure the ability to build your own golden image (re-baking) the application team must satisfied the following prerequisites. Additionally, access to the relevant components and services should be granted. 

- The application team must be familiar with the Packer concept and have the necessary technical knowledge and experience to work with re-baking image. 

- Access to Golden Image Azure Compute Gallery on app team SPNs 

- Capture the details of application team Azure subscription, SPN, resource group, vNet, subnet. 

- Collect the details of packages which needs to be integrated in the image. 

- Setup the proper permission (read-write and modify) on app team SPN, for packer build. Re-baked Image needs to be published in the separate resource group 

- Prepare DX1 CI/CD runner to be packer client session on it communicate with temporary (build) machine over local network (ssh or winrm ports). For Windows build its recommended to have permanent Azure KeyVault (used for winrm’s TLS keys and certificates) to avoid build failures related to policy violation related to Key Vault. 

- Request necessary security approvals for Azure Firewall and Azure Policy exceptions. This Azure Policy exceptions should cover private non-prod and prod Azure Compute Galleries for storing re-backed images. The example below is provided just for illustration purposes. The final list of Azure Firewall Whitelisting are varied by environment and app team requirements. 

 

 

## Patch Management for Azure Virtual Machines

Click HerePatch Management using Azure Update Manager<a href="/sites/CloudCentral/SitePages/Patch%20Management.aspx?xsdata=MDV8MDJ8fGM3ZDhiZmYwYjdmMjQ2MjU5MjM4MDhkZGNkYzVmOTdhfDI4N2U5ZjBlOTFlYzRjZjBiN2E0YzYzODk4MDcyMTgxfDB8MHw2Mzg4OTI5NzIzMzQyODk0NjR8VW5rbm93bnxWR1ZoYlhOVFpXTjFjbWwwZVZObGNuWnBZMlY4ZXlKRFFTSTZJbFJsWVcxelgwRlVVRk5sY25acFkyVmZVMUJQVEU5R0lpd2lWaUk2SWpBdU1DNHdNREF3SWl3aVVDSTZJbGRwYmpNeUlpd2lRVTRpT2lKUGRHaGxjaUlzSWxkVUlqb3hNWDA9fDF8TDJOb1lYUnpMekU1T2pFNE1EazNaRGhoTFRZeVpqSXRORFU1WVMxaU1XRTBMV1E0Tnpjd01tUTNNbUl3WWw5bVlXVXlNV1V3WVMxalpqZGlMVFF4T0RZdFltWTRaUzB4TURVeVpqUTBPVEV6Wm1WQWRXNXhMbWRpYkM1emNHRmpaWE12YldWemMyRm5aWE12TVRjMU16Y3dNRFF6TWprd013PT18NDQ5MThhNGIwYWM3NDU4ZTkyMzgwOGRkY2RjNWY5N2F8MTE0YzcwNmRjYTJjNGUyNmJiYTg3NTY3OWQwMThhODQ%3D&amp;sdata=U1ZWd243TVVBU1k0ZDRXYTdJMkVVUzM0R3BhcVNXSFBjc1h5ZmttK3hXND0%3D&amp;ovuser=287e9f0e-91ec-4cf0-b7a4-c63898072181%2cneethu.jose%40lseg.com&amp;OR=Teams-HL&amp;CT=1753706068394&amp;clickparams=eyJBcHBOYW1lIjoiVGVhbXMtRGVza3RvcCIsIkFwcFZlcnNpb24iOiI0OS8yNTA3MDMxODgwOSIsIkhhc0ZlZGVyYXRlZFVzZXIiOmZhbHNlfQ%3D%3D" data-sp-prop-name="button.linkUrl"></a>

## Need help?

This section contains answers to questions that have been asked by application teams / stakeholders who consume Golden Images.

#### If your question is not in here, you may request help by sending your query to CPEAzureStormtrooper@lseg.com.

------------------------------------------------------------------------

## Q & A

**Question:**  
As we conduct a refresh of Golden Images every 90 days for our Linux VMs, I wanted to understand the best approach for managing the application data residing on the data disks of these Azure VMs. Is there a recommended strategy to ensure that this data is not impacted during the VM refresh process?

 

**Answer:**  
When managing application data on data disks of Azure VMs while performing a refresh of Golden Images every 90 days, you need to ensure that the data on these disks is preserved and not impacted by the refresh process.

**OS Disk for System Files**: Use the OS disk exclusively for the operating system and application binaries.  
**Data Disks for Application Data**: Store application data on separate data disks. This separation ensures that the data disks can be detached and reattached to the new VM instance without affecting the data.

**Snapshots\Backup** - take regular snapshots and\or backup of your data disks. This provides an additional layer of protection and allows you to restore data in case something goes wrong during the refresh process.

Ensure that your Terraform code manages the VMs and data disks separately. When recreating VMs using new golden images, the code should detach the data disks from the old VM and reattach them to the new VM.

 

**Question**:  
I cannot ssh (bastion) into the VM or my SSH has timed out. What to do?

**Answer**:  
You must create a user and group into the allow list in the SSH configuration. More details here:  
https://lseg.stackenterprise.co/questions/25579/25580

Continue to Step 5: Cloud Product Framework<a href="/sites/CloudCentral/SitePages/LMP-Azure-CPF.aspx" data-sp-prop-name="linkUrl"></a>

***If you have any questions, please reach out to SRE***

 

[**Cloud SRE Request Form**](https://lseg.service-now.com/esc?id=sc_cat_item&table=sc_cat_item&sys_id=0df298841b6a4290f369ea01b24bcbbd)

 

[**Cloud SRE - Report an Incident - Support Hub**](https://lseg.service-now.com/esc?id=sc_cat_item&sys_id=84171d5683ebc298d84b9860ceaad34a)

On this pageHow to use Golden Images<a href="/sites/CloudCentral" data-sp-prop-name="baseUrl"></a><a href="/sites/CloudCentral/SitePages/Golden-Image-Creation-Process.aspx?xsdata=MDV8MDJ8fGM2ZTZkNzVkYjU3ZDQxN2I0MmRjMDhkY2EwMDg2MjIyfDI4N2U5ZjBlOTFlYzRjZjBiN2E0YzYzODk4MDcyMTgxfDB8MHw2Mzg1NjEyMDUwNDYzNjI4NDR8VW5rbm93bnxWR1ZoYlhOVFpXTjFjbWwwZVZObGNuWnBZMlY4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazkwYUdWeUlpd2lWMVFpT2pFeGZRPT18MXxMMk5vWVhSekx6RTVPakU0TURrM1pEaGhMVFl5WmpJdE5EVTVZUzFpTVdFMExXUTROemN3TW1RM01tSXdZbDlsTnpSalptUmtZeTAwWmpneExUUmtaVFV0WVRNd09TMDFOekF6T1RabE9EbGpPRGxBZFc1eExtZGliQzV6Y0dGalpYTXZiV1Z6YzJGblpYTXZNVGN5TURVeU16Y3dNemcyT1E9PXw0ZTQ1Yzk3M2I3ODg0YjQwNDJkYzA4ZGNhMDA4NjIyMnxiM2M1MzhmYWQ0NjU0OWVkYTEzYWIwODUzNmRiN2FiNg%3D%3D&amp;sdata=M1dGWG95dGtXTGhCRlRTYmhDR0dWV0pyTnBML1Y0WEhaQ1JleGVtZHhvZz0%3D&amp;ovuser=287e9f0e-91ec-4cf0-b7a4-c63898072181%2cneethu.jose%40lseg.com&amp;OR=Teams-HL&amp;CT=1720605914615&amp;clickparams=eyJBcHBOYW1lIjoiVGVhbXMtRGVza3RvcCIsIkFwcFZlcnNpb24iOiIyNy8yNDA1MzEwNjMwMSIsIkhhc0ZlZGVyYXRlZFVzZXIiOmZhbHNlfQ%3D%3D#how-to-use-golden-images-in-lmp-azure" data-sp-prop-name="items[0].sourceItem.url"></a>Ask the Cloud community using the 'lmp-azure' tag in Stack OverflowFind what you are looking for? Please provide feedback<a href="/sites/CloudCentral" data-sp-prop-name="baseUrl"></a><a href="https://lseg.stackenterprise.co/users/login?returnurl=https://lseg.stackenterprise.co/" data-sp-prop-name="items[0].sourceItem.url"></a><a href="https://forms.microsoft.com/Pages/ResponsePage.aspx?id=Dp9-KOyR8Ey3pMY4mAchgYp9CRjyYppFsaTYdwLXKwtUOEg0RUE0MUdFTUJBUzdLV1NKQTVJQVA4Qy4u" data-sp-prop-name="items[1].sourceItem.url"></a>Return to New to LSEG Cloud<a href="/sites/CloudCentral/SitePages/New-to-LSEG-Cloud-Platform---Start-Here-old.aspx" data-sp-prop-name="linkUrl"></a>LMP Azure - Support & Request Catalog<a href="/sites/CloudCentral" data-sp-prop-name="baseUrl"></a><a href="/sites/CloudCentral/SitePages/LMP-Azure-Support.aspx" data-sp-prop-name="items[0].sourceItem.url"></a>
