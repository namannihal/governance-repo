# Azure Networking

The nuances of the spoke's architecture are touched upon in the below sections.

## Networking in LSEG.com

LSEG.com tenant has a hub and spoke architecture.  A spoke is application specific, hosted in a specific and has its own IP addressing scheme.  A hub is a shared resource and plays no direct role in your application spokes other than being the gateway to access any other resources outside of your spoke.  This includes privately accessible resources in our other public clouds and on premise, including controlling spoke to spoke communications in LSEG.com.

The below diagram illustrates a typical application spoke architecture in LMP.  The left side representing a Segment1 Heritage Refinitiv spoke and the right a Segment 2 Heritage LSEG spoke. 

Servers hosted at LSEG.com are aligned to a new operating model that does not allow direct access from users work devices directly to servers and services. The new access methodology is through ZScaler Private Access (ZPA).  By default ZPA AppConnectors have access to all spokes within the same region and environment on TCP:443(https), for example:  AppConnecters in Segment1 dev have access to all spokes in all regions in segmen1 dev  
  
ZPA onboarding process can be found at the below link:  
[ZScaler Private Access (ZPA) – Application Onboarding Process](/sites/CloudCentral/SitePages/ZScaler-Private-Access-(ZPA)-–-Application-Onboarding-Process.aspx?xsdata=MDV8MDJ8fGVlZDgwMmNkMTAxYjQ0MWZhMjRkMDhkY2ZhNjEwOTI3fDI4N2U5ZjBlOTFlYzRjZjBiN2E0YzYzODk4MDcyMTgxfDB8MHw2Mzg2NjA1NDE4NTIxMzE5MTd8VW5rbm93bnxWR1ZoYlhOVFpXTjFjbWwwZVZObGNuWnBZMlY4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazkwYUdWeUlpd2lWMVFpT2pFeGZRPT18MXxMMk5vWVhSekx6RTVPamcxTURreE1tSmpMV1pqTlRJdE5EZ3lOeTFoTmpaa0xUWm1PR016TldWaVpERmtZVjloTmprNU16QTROUzAxTUdSbExUUXpOVEF0WVdJMU15MWxZak14TjJWaU16bGhNR0ZBZFc1eExtZGliQzV6Y0dGalpYTXZiV1Z6YzJGblpYTXZNVGN6TURRMU56TTRORGMzTkE9PXxiNDM0OGE4NDZjYmU0NTNiM2ZmNzA4ZGNmYTYxMDkyNXxlNjU1OWYxNDljZWM0M2JkOGI5NmI1OTUyZTYyM2I3ZA%3D%3D&sdata=d0RLQTM4U0x2d1psK1ZZYXI0SVFua0E1djRRL3llbTBiVi9QdlN2VGhLdz0%3D&ovuser=287e9f0e-91ec-4cf0-b7a4-c63898072181%2cdarren.mears%40lseg.com)  
  
URLs will have to be onboarded to ZPA to use this default access, for any other ports you will need to raise a FW request alongside the ZPA onboarding request.  
  
Out of management style connectivity is also possible through the Azure Bastion service, this is a limited form of connectivity of last resort.

Application landing zones(spokes) are provisioned with two VNETs, a /23 routable VNET and a /17 non-routable VNET.  The routable is used to communicate with internal Azure systems, whereas the non-routable is used to deploy your application components.

#### Routable VNET

The subnets relevant to your application in the routable VNET are: 

| **Subnets**  | **Azure Resources**  | **Purpose**  |
|----|----|----|
| Bastion Subnet  | Azure Bastion | This subnet hosts Azure Bastion. Azure Bastion is one option to provide end-user access to virtual machines. |
| Application Gateway Subnet | Application Gateway | Hosting Azure Application Gateway with Web Application Firewall (WAF) for ingress http(s) traffic to workloads.  |
| Workload Subnet | Workload resources (To be decided) | Used to provision Private-Endpoints and workloads that require direct access due to applications not being compatible with NAT. |
| FW Subnet | Azure FW | This subnet is the translated source of outbound connections from the non-routable VNET to other internal LSEG resources. |

  
There are other subnets in the routable VNET not used directly by the application teams that provide infrastructure functionality. These are:

- FW Subnet to host your subscription firewall
- Diagnostic Subnet reserved for operational use cases
- Gateway subnet that provides routing functionalities

#### **Non-Routable VNET**

The non-routable VNET is provisioned as a /17. This is not reachable directly from anywhere outside of your subscription. The /17 VNET is for you to deploy specific subnets to host your applications internal components as per your design. Outbound access from these components would traverse the Subscriptions FW and be NAT’d (Network Address Translation Type D) to the spoke FWs addressing in the routable subnet for internal communications and the public address for public access. Inbound access would be facilitated through either a Private-Endpoint or an Application-Gateway.

The following table details the Non-Routable address spaces for particular regions: 

| Region               | Location             | Non-Routable Address Space |
|----------------------|----------------------|----------------------------|
| Central US           | Chicago              | 100.69.0.0/17              |
| East Asia            | Hong Kong            | 100.71.0.0/17              |
| East US              | Virginia             | 100.68.0.0/17              |
| East US 2            | Virginia             | 100.72.0.0/17              |
| North Europe         | Dublin               | 100.66.0.0/17              |
| South East Asia      | Singapore            | 100.70.0.0/17              |
| UK South             | London               | 100.64.0.0/17              |
| UK West              | Cardiff              | 100.65.0.0/17              |
| West Europe          | Amsterdam            | 100.67.0.0/17              |
| Japan East           | Japan East           | 100.73.0.0/17              |
| Germany West Central | Germany West Central | 100.74.0.0/17              |

#### **Firewalling**

The below table shows how the subnets above play a part in the connectivity definitions and subsequent network connectivity requests.

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 25%" />
<col style="width: 25%" />
<col style="width: 25%" />
</colgroup>
<tbody>
<tr>
<td>Data Flow Type</td>
<td>Description</td>
<td>Source addressing</td>
<td>Destination addressing</td>
</tr>
<tr>
<td><p>From Application Spoke to Public target</p>
<p>*Controlled by central FW function</p></td>
<td>Connection to a public services accessed over the internet. Including LSEG publicly available resources.</td>
<td>Non-routable source subnet </td>
<td>The FQDN to be accessed<br />
or <br />
the specific IPs to be accessed.</td>
</tr>
<tr>
<td>Inbound from public sources.<br />
<br />
*controlled by NSG</td>
<td>Any exposed endpoint on the internet that will be consumed publicly.</td>
<td>This connectivity profile is not covered by the traditional networks teams and is application lead currently.</td>
<td> </td>
</tr>
<tr>
<td>From Application Spoke to Private target<br />
<br />
*Controlled by central FW function</td>
<td>Connectivity to any other private interface outside of the source application spoke itself.</td>
<td>Non-routable source subnet <br />
or<br />
Routable workload subnet</td>
<td>Destination IPs that are being connected to.</td>
</tr>
<tr>
<td>From private source to a privately published application spoke service<br />
<br />
*Controlled by central FW function</td>
<td>Connectivity from another privately accessible source. This includes services hosted in any private DC on the LSEG WAN, other cloud hosted services as well as any other application spoke.</td>
<td>Source IP addresses where connections will originate from.</td>
<td>Application gateway subnet or the routable workload subnet when using a PrivateEndpoint.</td>
</tr>
</tbody>
</table>

  
 

As a part of the request process, each private data flow will require you to specify bandwidth requirements. Understanding the nature of the flow will enable our planning teams to optimize LSEG network resources. There is zero tolerance for an outage in this area so due care must be taken.

**What data do I need to provide?**  
The key data points are how much bandwidth on average, how large is the largest peak, what is the data frequency and in which direction the data flows. For example, a log shipping job for a business-hours only application could have 5Mbps average, 50Mbps peak on a 9-to-5 weekdays only schedule as it's a business hour only service. The direction of data transfer would be from the primary logging service to the secondary. Data direction can be defined as bidirectional if the primary and secondary log services could switch roles in our example.

**How can I find out what my application currently requires?**  
If you do not have monitoring in place for this already it may be challenging.  You can monitor bandwidth on your existing services network interface cards. For some services you can calculate it; for example, an FTP service could be roughly calculated by the size and frequency of files transferred. We do not need exact bandwidth numbers, more an indication based on your expertise of your application of the general scale.  If uncertain enter a default amount of 10-50Mb and this can be adjusted once more evidence is gathered.  
  
**Do I need to specify bandwidth for public connections?**  
No bandwidth needs to be specified for public connections.

Private DNS for Azure is managed through the existing RIANA/BANANA solutions. The below links are to the knowledge articles for those. They are intended to be self-service for application teams, as they are for other non Azure environments.  
  
[RIANA Sharepoint Home](/teams/RIANA/SitePages/Guides-%26-Tutorials.aspx)  
[RIANA Guides and Tutorials](/teams/RIANA/SitePages/Guides-%26-Tutorials.aspx)  
  
The migration squads have created the below knowledge article to explain how DNS resolution works for application teams migration to Azure.   
  
[DNS Resolution & Network traffic Inbound flow for apps deployed in Azure - Overview](https://dev.azure.com/LSEGroup/Migration/_wiki/wikis/Migration.wiki/6830/DNS-Resolution-Network-traffic-Inbound-flow-for-apps-deployed-in-Azure)  
 

## **Requesting Connectivity 🌐**

**AppConn (Application Connectivity)** is an internally developed web application for holistic application connectivity management. Whenever a Azure endpoint needs to have a connection enabled to/from it, which will communicate with a resource that is outside the network of origin of that Azure endpoint, then the user will need to create an AppConn request. The Connectivity team will review, approve and enable the connection on all required firewalls in path.

To get started with AppConn please lick the link below.

AppConn - Connectivity Made SimpleClick on the link below to know how to request connectivity.<a href="/sites/CloudCentral/SitePages/AppConn---redefining-connectivity.aspx?promotedState=0" data-sp-prop-name="button.linkUrl"></a>

## Need help?

For engagement to the Azure Network Implementation Group team for networking assistance for migrations, reach out to:

|                |                    |                         |
|----------------|--------------------|-------------------------|
| **Name**       | **Role**           | **Email**               |
| Harini, Gvsk   | NIG Team PM        | gvsk.harini@lseg.com    |
| Suran Fernando | NIG Team Tech Lead | suran.fernando@lseg.com |
| Darren Mears   | NIG Team Lead      | darren.mears@lseg.com   |

 

Azure - Support & Request Catalog<a href="/sites/CloudCentral" data-sp-prop-name="baseUrl"></a><a href="/sites/CloudCentral/SitePages/LMP-Azure-Support.aspx" data-sp-prop-name="items[0].sourceItem.url"></a>On this pageNetwork Overview 🔎Requesting Connectivity 🌐 Administrative Access In Lseg.comIP Addressing and FirewallingBandwidthDNS<a href="/sites/CloudCentral" data-sp-prop-name="baseUrl"></a><a href="/sites/CloudCentral/SitePages/LMP-Azure-Networking.aspx#network-overview" data-sp-prop-name="items[0].sourceItem.url"></a><a href="/sites/CloudCentral/SitePages/LMP-Azure-Networking.aspx#requesting-connectivity-%F0%9F%8C%90" data-sp-prop-name="items[1].sourceItem.url"></a><a href="/sites/CloudCentral/SitePages/LMP-Azure-Networking.aspx#administrative-access-in-lseg.com" data-sp-prop-name="items[2].sourceItem.url"></a><a href="/sites/CloudCentral/SitePages/LMP-Azure-Networking.aspx#ip-addressing" data-sp-prop-name="items[3].sourceItem.url"></a><a href="/sites/CloudCentral/SitePages/LMP-Azure-Networking.aspx#bandwidth" data-sp-prop-name="items[4].sourceItem.url"></a><a href="/sites/CloudCentral/SitePages/LMP-Azure-Networking.aspx#dns" data-sp-prop-name="items[5].sourceItem.url"></a>Have a question? Ask us on StackAsk the Cloud community using the 'lmp-azure' tag in Stack OverflowFind what you are looking for? Please provide feedback<a href="/sites/CloudCentral" data-sp-prop-name="baseUrl"></a><a href="https://lseg.stackenterprise.co/users/login?returnurl=https://lseg.stackenterprise.co/" data-sp-prop-name="items[0].sourceItem.url"></a><a href="https://forms.microsoft.com/Pages/ResponsePage.aspx?id=Dp9-KOyR8Ey3pMY4mAchgYp9CRjyYppFsaTYdwLXKwtUOEg0RUE0MUdFTUJBUzdLV1NKQTVJQVA4Qy4u" data-sp-prop-name="items[1].sourceItem.url"></a>Return to New to LSEG Cloud<a href="/sites/CloudCentral/SitePages/New-to-LSEG-Cloud-Platform---Start-Here-old.aspx" data-sp-prop-name="linkUrl"></a>
