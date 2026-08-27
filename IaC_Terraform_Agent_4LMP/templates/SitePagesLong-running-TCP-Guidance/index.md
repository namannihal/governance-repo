# Guidance to Support Long-lived TCP Sessions

> ***This page is up to date as of 1st September 2025***

Some applications such as FIXHUB (using FIX Trading Protocol) and Real-Time Market Data Systems (RTMDS) require **long-lived TCP sessions** to maintain continuous, low-latency communication with trading counterparties. These persistent connections are essential for ensuring <u>immediate readiness</u> to trade and avoiding delays that could result in missed market opportunities or financial loss. These protocols incur a significant synchronization impact upon reconnect, as gaps in time have to be reconciled for position keeping and algorithmic strategies.

 

However it has been found that Azure infrastructure poses challenges to maintaining these sessions, including:

- **Azure Firewall Scale-In**, where a backend instance of the Firewall Scale Set is terminated, dropping connections. This affects Internet, DDN and Hub (to on-premise) firewalls.

- **Maintenance of Azure Firewall software**, done as a scale set rolling update, caused backend instance to be replaced, resulting in disconnections. This affects all Azure Firewalls.

- **Live Migration**, intended to keep a virtual machine running if an underlying hypervisor (host) is in ‘stress’ or about to die. Although the death of the hypervisor hardware cannot be mitigated - selective rebalancing uses Live Migration - currently Live Migration (in Azure, which functions differently to on-premise Hyper-V) is not currently capable of migrating TCP connections to the new hypervisor. This affects Azure Firewalls, App Gateways, Virtual Machines, AKS and SaaS products.

- **Maintenance of Hypervisor Hosts**, the Microsoft ‘fleet’ of hypervisors each undergo over 100 maintenance events per month. A number of which cause significant virtual machine freezes into tens of seconds. Some of the maintenance is to the network agent, which causes TCP connections to be dropped. Fleet maintenance occurs any time, and is not compatible with our Change Approval Management controls. This affects Azure Firewalls, App Gateways, Virtual Machines, AKS and SaaS products.

 

This page provides guidance for application teams to understand how to mitigate these issues, in the following categories:

- Mandatory mitigations for all connectivity paths

- Mitigations to support Public/Internet connections

- Mitigations to support Private/Intranet connections

- Mitigations to support Delivery Direct Network (DDN/Segment 4) connections

To achieve the best chance for maintaining the TCP session to your application, the following items should be performed by application teams

- **Raise a support ticket** with Microsoft to **disable live migration** for all VMs in the subscription

  - Impact - your VMs will no longer be automatically moved if there's a potential host failure, so you should [subscribe to scheduled events](https://learn.microsoft.com/en-us/azure/virtual-machines/windows/scheduled-events#query-for-events) for critical VMs and react accordingly

- For **VMs (excluding AKS)** which are hosting services that require the long-lived TCP session, ensure they are deployed either as:

  1.  VM using a [v6 SKU](https://techcommunity.microsoft.com/blog/azurecompute/announcing-general-availability-of-azure-dlde-v6-vms-powered-by-intel-emr-proces/4376186)

      - Microsoft have recommended to use the **v6 SKUs specifically** due to enhancements in the underlying [Azure Boost](https://learn.microsoft.com/en-us/azure/azure-boost/overview) hardware offload capabilities to deliver more robust network connectivity during maintenance updates

      - This requires an update to the Golden Image available in Greenfield and work is being tracked under [CPEP-6046](https://jira.refinitiv.com/browse/CPEP-6046) - ETA will be confirmed post Q4 PI Planning

  2.  Alternatively use dedicated hosts with defined maintenance windows that support your application requirements

      - If you cannot fill the dedicated host completely, then this option comes with increased cost

      - This option can be used if you cannot wait until the Golden Image is updated to support deployment of v6 SKU virtual machines

- Where the application requiring the long-lived TCP session is **running on AKS**, ensure the following:

  1.  Node pools should be configured to deploy VMs using a v6 SKU

      - This can be done today, as the AKS pattern uses the Marketplace image, so is not dependent on the Golden Image update referred above

The Azure Firewall is a key control point for traffic at the edge of the Azure virtual network, protecting traffic flows to and from the internet. To ensure that scale events to not disrupt the TCP session, application teams should do the following:

- Azure Firewall must be pinned to a **specific number of instances** to stop scale in/out events

  - A support ticket will need to be raised with Microsoft to request this, via normal SRE channels

  - The number of instances should be set to more than the peak workloads require. Microsoft have also recommended that the Firewall is pinned to a multiple of 3, to get a reasonably even distribution across the Availability Zones. 

 

In addition to the above, Microsoft have already enabled the following mitigations:

- Disabled Live Migration on all Azure Firewall VMs in the LSEG environments

- Scheduled Azure Firewall maintenance only occurs in an 8 hour window, on a Saturday starting at 1600UTC

If your application requires support of Long-lived TCP sessions to private networks, such as Segment 1 or Segment 2, a new capability will be available to be requested for your Landing Zone.

 

Application teams will be able to request enabling [ExpressRoute FastPath](https://learn.microsoft.com/en-us/azure/expressroute/about-fastpath) for their private connectivity. This will see an ExpressRoute Gateway deployed in the routable vnet, which will then support direct connectivity to required on-premises networks, bypassing the hub gateway and firewall.

 

Application teams should ensure that appropriate NSG rules are still in place to provide 5-tuple security rules.

 

**This capability will be offered only by exception, so <u>justification for using this must be included and approved in the application SAD.</u>**

 

Latest Update:

- Engineering for this feature is underway, and we are aiming to deliver this within Q3. Work can be tracked under [CPEP-5831](https://jira.refinitiv.com/browse/CPEP-5831)

The approved SAD describing Segment 4 connectivity, contains a solution that allows inbound connectivity to Azure using Private Endpoints, and outbound connections from Azure via application team managed proxies (eg. HAProxy).

 

A review of this architecture is required to validate if the solution will support long-lived TCP sessions via FastPath. This assessment is scheduled for Q3 2025, with a goal to make this solution available within Q4 2025 (pending any necessary governance approvals if found to be required).
