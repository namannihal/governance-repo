# Azure Regions

## Supported regions in LSEG.com

The Region is considered as **Ready** when:

- A subscription is able to be vended
- On-prems Connectivity is enabled for the region
- ZPA and Datadog Tooling integrated

 

Segments represent what LSEG network address space the region is able to be connected to. Note that one subscription can only be linked to ONE segment. If you need connectivity to both segments, you need 2 subscriptions.

Please refer to [SAD DA-119 PROD Azure Live Live Transport Networking.docx](/:w:/r/teams/LMFoundationFM/_layouts/15/Doc.aspx?sourcedoc=%7b157A4D72-2B56-4BA7-8497-17F19F10A2BB%7d&file=SAD%20DA-119%20PROD%20Azure%20Live%20Live%20Transport%20Networking.docx&fromShare=true&action=default&mobileredirect=true&isSPOFile=1&xsdata=MDV8MDJ8fGIyZGFlZTU0YmQ0NDQxYzA4OGQ3MDhkZDYyZWYyYjQ1fDI4N2U5ZjBlOTFlYzRjZjBiN2E0YzYzODk4MDcyMTgxfDB8MHw2Mzg3NzU1MDE1MTkxNjU1NTV8VW5rbm93bnxWR1ZoYlhOVFpXTjFjbWwwZVZObGNuWnBZMlY4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazkwYUdWeUlpd2lWMVFpT2pFeGZRPT18MXxMMk5vWVhSekx6RTVPak00T1dZeE1HVTVMVEpoTWpZdE5HSTRaaTFoWmpZNExUQmhZalpsWVRGaFlqRTFaRjltTjJVM1pXWTRNeTAzT0dObExUUXlOMll0WVROa05pMDBPV1V3TnpReFpUazBPR0ZBZFc1eExtZGliQzV6Y0dGalpYTXZiV1Z6YzJGblpYTXZNVGMwTVRrMU16TTFNVEExTVE9PXwwZDg4Y2FjNDIxZGQ0N2M1MTgwMDA4ZGQ2MmVmMmI0NXw4MjM3MDU4MmJmNDQ0MDBkYjYyNTU0MzFkYmE0ZGU5MQ%3D%3D&sdata=V1N2emdGaExwMWVhR1hhMENjaVE5aCs2VmRncUZWWVgvOVVadFNHRHl4MD0%3D&ovuser=287e9f0e-91ec-4cf0-b7a4-c63898072181%2cVandana.Rana%40lseg.com) for Segments reference on Page 13

 

|  |  |
|----|----|
| **Segment**  | **Descriptions**  |
| **Segment 1 - hRft **  | Administrative Domain / Control / Area - (hRft) - Greenfield, All VNETs, resources, apps, landing zones, connected to the heritage Refinitiv WAN, SIGMA, (SDNET). Onward connectivity to all the Refinitiv DCs, Brownfield cloud AWS, Brownfield Azure, LMP Side of Refinitiv. On-Prem DBORs. Synonymous with and purely Refinitiv. 90% of the Apps. Connectivity at the end of the ExpressRoute for Seg1 is SIGMA  |
| **Segment 2 - hLSEG**  | Administrative Domain / Control / Area - (hLSEG) - Greenfield, All VNETs, resources, apps, landing zones, connected to the heritage LSEG WAN, CNF. Onward connectivity to all the LSEG DCs, Brownfield cloud AWS, Brownfield Azure, LMP Side of LSEG. Synonymous with and purely LSEG. 10% of the Apps. Connectivity at the end of the ExpressRoute for Seg2 is CNF  |
| **Segment 3 - Internet**  | Internet (Egress) - Centralised Egress, VPC Module/POD, Share firewalls to go to the internet. Typically, smaller Apps where it's very expensive to have your own firewall. Shared Service with VNET Peering. Criteria applies. No reach-back to on-prem system.  |
| **Segment 4 - Delivery Direct**  | Delivery Direct - Customer Connectivity Hub - Refinitiv: Customers are connected via Private WAN to connect to consumer services in AWS or AZURE. Big private WAN - has 3000 customers. Delivery Direct Network. Guaranteed SLAs. Leased lines into Customer Buildings. Bolt-on to either Seg 1 or Seg 2 for the delivery direct network. For apps currently being published to the Delivery Direct Network. Y/N if yes, then Seg 4 Bolted onto either 1 or 2  |
| **Segment 5 - Backup**  | Out of Band Backup - Back pocket - Landing Zone with its own dedicated Express Route (High Bandwidth) that's logically separated from the other segments to enable high-bandwidth backups. Not to be used for standard Azure App Backup, more specifically for backups between on-prem and cloud and Visa-Versa. Purely for backups to Cloud, kept away from Application Traffic. NOT MIGRATION TRAFFIC!  |
| **Segment 6 - Live-Live**  | Live-Live - Real-Time data feeds, specialised where SLAs are extremely important and Real-Time data feeds. On the WAN there are logical and physical networks, RED and BLUE, mimics what we have in the on-prem DCs. Live-Live, mega resilience. The application sends traffic to the endpoint, two paths at the same time. The far-end application uses the packet that got there first. Source sends it to two paths/pipes and the first packets to arrive is used. A number of Circuits to RED and a number of Circuits to BLUE.  |
| **Segment 7 - Highly Regulated**  | Highly Regulated - Technically identical to Seg1 and Seg2 - only difference is, the change process and the ability to do deploy apps on this landing zone. VERY Controlled. More processed driven with longer change control. May have different Governance / Policy requirements. RBAC model may differ.  |
| **Segment 8 - LSEG SaaS**  | Customer/LSEGSaaS.com - Separate tenant for the strategic initiatives. Dedicated to the LMP/Microsoft Partnership. Only a set of Application workstreams at the moment. Restricted application sharing, LMP/Microsoft Co-Innovation  |

 

 

***Azure regional capacity and decision tree is defined here*** [Region Inflations Decision tree](/:f:/r/teams/LMFoundationFM/Shared%20Documents/General/01%20Squads/04%20Compute%20Storage%20Resiliency/Region%20Inflations%20Decision%20tree?csf=1&web=1&e=tAusRx) : [Azure Regions Decision Tree - May 2025.pptx](/:p:/r/teams/LMFoundationFM/Shared%20Documents/General/01%20Squads/04%20Compute%20Storage%20Resiliency/Region%20Inflations%20Decision%20tree/Azure%20Regions%20Decision%20Tree%20-%20May%202025.pptx?d=wf9a9e59cb12f4362be6a6df453899534&csf=1&web=1&e=oYrs4F)

 

 

**ZPA Design Decisions:**

[ZScaler Private Access (ZPA) – Application Onboarding Process (sharepoint.com)](/sites/CloudCentral/SitePages/ZScaler-Private-Access-(ZPA)-–-Application-Onboarding-Process.aspx?e=4%3afe8cf05a1edf43afa973d59451167013&web=1&sharingv2=true&fromShare=true&at=9&CID=17292190-ef35-48ac-b800-cd63da31b3b6&OR=Teams-HL&CT=1724166897360&clickparams=eyJBcHBOYW1lIjoiVGVhbXMtRGVza3RvcCIsIkFwcFZlcnNpb24iOiI0OS8yNDA3MTEyODgyNSIsIkhhc0ZlZGVyYXRlZFVzZXIiOmZhbHNlfQ%3D%3D)

 

<table>
<tbody>
<tr>
<td colspan="3"><p><strong>Azure Greenfield</strong></p></td>
</tr>
<tr>
<td><strong>Environment</strong></td>
<td><strong>ZPA App connectors</strong></td>
<td><strong>Connectivity</strong></td>
</tr>
<tr>
<td>Prod</td>
<td>All Regions</td>
<td>ZPA Spoke-to-Application Spoke</td>
</tr>
<tr>
<td>Pre-Prod</td>
<td>East US2, UK South and South-East Asia</td>
<td>ZPA Spoke-to-Application Spoke in same region. Other regions use SDNet/Hub-to-Hub</td>
</tr>
<tr>
<td>Dev</td>
<td>UK South</td>
<td>ZPA Spoke-to-Application Spoke in same region. Other regions use SDNet/Hub-to-Hub</td>
</tr>
</tbody>
</table>

 

***Please note that the information on this page is accurate at the time of publication and is a dynamic picture. Please refer back to this page at intervals to ensure that delivery is still in alignment with your needs.***

 

**Segment 1**

 

<table>
<colgroup>
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
</colgroup>
<thead>
<tr>
<th><p>Region</p></th>
<th>Env(s) in scope</th>
<th><p>Approvals (FRF, CTEF &amp; CAF) </p></th>
<th>Network Ready</th>
<th><p>Datadog Ready</p>
<p>(Per Region)</p></th>
<th><p>Dev Ready</p></th>
<th><p>Dev ZPA Ready</p></th>
<th><p>PreProd  Ready</p></th>
<th><p>PreProd ZPA Ready</p></th>
<th><p>Prod Ready</p></th>
<th><p>Prod ZPA Ready</p></th>
</tr>
</thead>
<tbody>
<tr>
<td><p><strong>UK South</strong></p>
<p><strong>(London)</strong></p></td>
<td><p> </p>
<p>(Dev, PreProd, Prod)</p></td>
<td><p><strong>✅</strong></p></td>
<td><strong>       ✅</strong></td>
<td><strong>    ✅</strong></td>
<td><p><strong>✅</strong></p></td>
<td><p><strong>✅</strong></p></td>
<td><p><strong>✅</strong></p></td>
<td><p><strong>✅</strong></p></td>
<td><p><strong>✅</strong></p></td>
<td><p><strong>✅</strong></p></td>
</tr>
<tr>
<td><p><strong>UK West</strong></p>
<p><strong>(Cardiff)</strong></p></td>
<td><p> </p>
<p>(Dev, PreProd, Prod)</p></td>
<td><p><strong>✅</strong></p></td>
<td><strong>      ✅</strong></td>
<td><strong>     ✅</strong></td>
<td><p><strong>✅</strong></p></td>
<td><p><strong>  </strong></p>
<p><strong> ✅UKW</strong></p>
<p><strong>     UKS</strong></p>
<p><strong> </strong></p></td>
<td><p><strong>✅</strong></p></td>
<td><p><strong>✅</strong></p></td>
<td><p><strong>✅</strong></p></td>
<td><strong>       ✅</strong></td>
</tr>
<tr>
<td><p><strong>North Europe</strong></p>
<p><strong>(Ireland)</strong></p></td>
<td><p> </p>
<p>(Dev, PreProd, Prod)</p></td>
<td><p><strong>✅</strong></p></td>
<td><strong>      ✅</strong></td>
<td><strong>     ✅</strong></td>
<td><p><strong>✅</strong></p></td>
<td><p><strong>✅UKS</strong></p></td>
<td><p><strong>✅</strong></p></td>
<td><p><strong>✅</strong></p></td>
<td><p><strong>✅</strong></p></td>
<td><strong>    ✅</strong></td>
</tr>
<tr>
<td><strong>German West Central (Frankfurt)</strong></td>
<td><p> </p>
<p>(Dev, PreProd, Prod)</p></td>
<td><p><strong>✅</strong></p></td>
<td><p><strong> ✅</strong></p></td>
<td><strong>✅</strong></td>
<td><strong>✅</strong></td>
<td><p><strong>✅UKS</strong></p></td>
<td><p><strong>✅</strong></p></td>
<td><p><strong>✅</strong></p></td>
<td><strong>✅ Delivered 1st Oct 2025</strong></td>
<td><strong>✅ Delivered 1st Oct 2025</strong></td>
</tr>
<tr>
<td><p><strong>East US</strong></p>
<p><strong>(Virginia)</strong></p></td>
<td><p> </p>
<p>(Dev, PreProd, Prod)</p></td>
<td><p><strong>✅</strong></p></td>
<td><strong>      ✅</strong></td>
<td><strong>     ✅</strong></td>
<td><strong>       ✅</strong></td>
<td><p><strong>✅UKS</strong></p></td>
<td><p><strong>✅</strong></p></td>
<td><p><strong>✅</strong></p></td>
<td><p><strong>✅</strong></p></td>
<td><p><strong>✅</strong></p></td>
</tr>
<tr>
<td><p><strong>Central US</strong></p>
<p><strong>(Iowa)</strong></p></td>
<td><p> </p>
<p>(Dev, PreProd, Prod)</p></td>
<td><p><strong>✅</strong></p></td>
<td><strong>      ✅</strong></td>
<td><strong>     ✅</strong></td>
<td><p><strong>✅</strong></p></td>
<td><p><strong>✅UKS</strong></p></td>
<td><p><strong>✅</strong></p></td>
<td><p><strong>✅</strong></p></td>
<td><p><strong>✅</strong></p></td>
<td><p> </p>
<p><strong>✅</strong></p></td>
</tr>
<tr>
<td><p><strong>East US 2</strong></p>
<p><strong>(Virginia)</strong></p></td>
<td><p> </p>
<p>(Dev, PreProd, Prod)</p></td>
<td><p><strong>✅</strong></p></td>
<td><strong>      ✅</strong></td>
<td><strong>     ✅</strong></td>
<td><p><strong>✅</strong></p></td>
<td><p><strong>✅UKS</strong></p></td>
<td><p><strong>✅</strong></p></td>
<td><p> </p>
<p><strong>✅</strong></p></td>
<td><p><strong>✅</strong></p></td>
<td><p><strong> ✅</strong></p></td>
</tr>
<tr>
<td><p><strong>South-East Asia</strong></p></td>
<td><p> </p>
<p>(Dev, PreProd, Prod)</p></td>
<td><p><strong>✅</strong></p></td>
<td><strong>      ✅</strong></td>
<td><strong>     ✅</strong></td>
<td><p><strong>✅</strong></p></td>
<td><p><strong>✅UKS</strong></p></td>
<td><p><strong>✅</strong></p></td>
<td><p> </p>
<p><strong>✅</strong></p></td>
<td><p><strong>✅</strong></p></td>
<td><strong>       ✅</strong></td>
</tr>
<tr>
<td><p><strong>East Asia</strong></p>
<p><strong>(Hong Kong)</strong></p></td>
<td><p> </p>
<p>(Dev, PreProd, Prod)</p></td>
<td><p><strong>✅</strong></p></td>
<td><strong>      ✅</strong></td>
<td><strong>     ✅</strong></td>
<td><p><strong>✅</strong></p></td>
<td><p><strong>✅UKS</strong></p></td>
<td><p><strong>✅</strong></p></td>
<td><p> </p>
<p><strong>✅</strong></p>
<p> </p></td>
<td><p><strong>✅</strong></p></td>
<td><strong>     ✅</strong></td>
</tr>
<tr>
<td><p><strong>Japan East</strong></p>
<p><strong>(Tokyo)</strong></p></td>
<td><p> </p>
<p>(Dev, PreProd, Prod)</p></td>
<td><p><strong>✅</strong></p></td>
<td><strong>     ✅</strong></td>
<td><strong>      TBC</strong></td>
<td><p><strong>✅</strong></p></td>
<td><p><strong>✅UKS</strong></p></td>
<td><p><strong>✅</strong></p></td>
<td><p><strong>✅ UKS</strong></p></td>
<td><strong>   ✅ </strong></td>
<td><strong>     ✅</strong></td>
</tr>
</tbody>
</table>

 

 

 

 

**Segment 2 **

 

<table>
<colgroup>
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
</colgroup>
<thead>
<tr>
<th>Region</th>
<th>Env(s) in scope</th>
<th>Approvals (FRF, CTEF &amp; CAF) </th>
<th>Network Ready</th>
<th><p>Datadog Ready </p>
<p>(Per Region)</p></th>
<th>Dev Ready</th>
<th>Dev ZPA Ready</th>
<th>PreProd  Ready</th>
<th>PreProd ZPA Ready</th>
<th>Prod Ready</th>
<th>Prod ZPA Ready</th>
</tr>
</thead>
<tbody>
<tr>
<td><p><strong>UK South</strong></p>
<p><strong>(London)</strong></p></td>
<td><p> </p>
<p>(Dev, PreProd, Prod)</p></td>
<td><p><strong>✅</strong></p></td>
<td><strong>      ✅</strong></td>
<td><strong>       ✅</strong></td>
<td><p><strong>✅</strong></p></td>
<td><p><strong>✅</strong></p></td>
<td><p><strong>✅</strong></p></td>
<td><p><strong>✅</strong></p></td>
<td><p><strong>✅</strong></p></td>
<td><p><strong>✅</strong></p></td>
</tr>
<tr>
<td><p><strong>Central US</strong></p>
<p><strong>(Iowa)</strong></p></td>
<td><p> </p>
<p>(Dev, PreProd, Prod)</p></td>
<td><p><strong>✅</strong></p></td>
<td><strong>      ✅</strong></td>
<td><p> </p>
<p>       <strong>✅</strong>                  </p></td>
<td><p><strong>✅</strong></p></td>
<td><p><strong>UKS</strong></p></td>
<td><p><strong>✅</strong></p></td>
<td><p><strong>✅</strong></p></td>
<td><p><strong>✅</strong></p></td>
<td><p><strong>✅</strong></p></td>
</tr>
<tr>
<td><p><strong>East US 2</strong></p>
<p><strong>(Virginia)</strong></p></td>
<td><p> </p>
<p>(Dev, PreProd, Prod)</p></td>
<td><p><strong>✅</strong></p></td>
<td><strong>     ✅</strong></td>
<td><strong>      ✅</strong></td>
<td><p><strong>✅</strong></p></td>
<td><p><strong>UKS</strong></p></td>
<td><p><strong>✅</strong></p></td>
<td><p> </p>
<p><strong>✅</strong></p></td>
<td><p><strong>✅</strong></p></td>
<td><p><strong>✅</strong></p></td>
</tr>
<tr>
<td><strong>German West Central (Frankfurt)</strong></td>
<td>(Dev, PreProd, Prod)</td>
<td><strong>      ✅</strong></td>
<td><p><strong>   ✅</strong></p></td>
<td><strong>  ✅</strong></td>
<td><strong>✅</strong></td>
<td><p><strong>✅UKS</strong></p></td>
<td><strong>✅</strong></td>
<td><p><strong>✅</strong></p></td>
<td><strong>✅ Delivered 1st Oct 2025</strong></td>
<td><strong>✅ Delivered 1st Oct 2025</strong></td>
</tr>
<tr>
<td><p><strong>South-East Asia</strong></p>
<p><strong>(Singapore)</strong></p></td>
<td>(Dev, PreProd, Prod)</td>
<td><strong>TBC</strong></td>
<td><strong>TBC</strong></td>
<td><strong>TBC</strong></td>
<td><strong>TBC</strong></td>
<td><strong>TBC</strong></td>
<td><strong>TBC</strong></td>
<td><strong>TBC</strong></td>
<td><strong>TBC</strong></td>
<td><strong>TBC</strong></td>
</tr>
</tbody>
</table>

 

 

 

 

**Segment 3 (Shared Internet Egress)**

 

<table>
<colgroup>
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
</colgroup>
<thead>
<tr>
<th><strong>Region</strong></th>
<th><strong>Env(s) in scope</strong></th>
<th><strong>Approvals (FRF, CTEF &amp; CAF) </strong></th>
<th><strong>Network Ready</strong></th>
<th><p><strong>Datadog Ready </strong></p>
<p><strong>(Per Region)</strong></p></th>
<th><strong>Dev Ready</strong></th>
<th><strong>Dev ZPA Ready</strong></th>
<th><strong>PreProd  Ready</strong></th>
<th><strong>PreProd ZPA Ready</strong></th>
<th><strong>Prod Ready</strong></th>
<th><strong>Prod ZPA Ready</strong></th>
</tr>
</thead>
<tbody>
<tr>
<td><strong>TBC</strong></td>
<td><strong>     TBC</strong></td>
<td><p><strong>  TBC</strong></p></td>
<td><strong>       TBC</strong></td>
<td><p><strong> TBC</strong></p></td>
<td><p><strong> TBC</strong></p></td>
<td><p><strong> TBC</strong></p></td>
<td><p><strong> TBC</strong></p></td>
<td><p><strong> TBC</strong></p></td>
<td><p><strong> TBC</strong></p></td>
<td><strong>      TBC</strong></td>
</tr>
</tbody>
</table>

 

 

 

 

**Segment 4 (Delivery Direct)**

 

<table>
<colgroup>
<col style="width: 8%" />
<col style="width: 8%" />
<col style="width: 8%" />
<col style="width: 8%" />
<col style="width: 8%" />
<col style="width: 8%" />
<col style="width: 8%" />
<col style="width: 8%" />
<col style="width: 8%" />
<col style="width: 8%" />
<col style="width: 8%" />
<col style="width: 8%" />
</colgroup>
<thead>
<tr>
<th>Region</th>
<th><strong>E</strong>nv(s) in scope</th>
<th>Approvals (FRF, CTEF &amp; CAF) </th>
<th>Network Ready</th>
<th><p>Datadog Ready </p>
<p>(Per Region)</p></th>
<th>Dev Ready</th>
<th>Dev ZPA Ready</th>
<th>PreProd  Ready</th>
<th>PreProd ZPA Ready</th>
<th>Prod Ready</th>
<th>Prod ZPA Ready</th>
<th>Final Readiness</th>
</tr>
</thead>
<tbody>
<tr>
<td><p><strong>UK South</strong></p>
<p><strong>(London)</strong></p></td>
<td>(Prod)</td>
<td><strong>        ✅</strong></td>
<td><strong>   ✅</strong></td>
<td><p><strong>         ✅</strong></p></td>
<td><p><strong>  🚫</strong></p></td>
<td><p><strong>🚫</strong></p></td>
<td><p><strong>🚫</strong></p></td>
<td><p><strong> 🚫</strong></p></td>
<td><p><strong>✅</strong></p></td>
<td><p><strong>❌</strong></p></td>
<td><strong>   ✅</strong></td>
</tr>
<tr>
<td><p><strong>East US 2</strong></p>
<p><strong>(Virginia)</strong></p></td>
<td>(Prod)</td>
<td><strong>        ✅</strong></td>
<td><strong>   ✅</strong></td>
<td><p><strong>         ✅</strong></p></td>
<td><p><strong>  🚫</strong></p></td>
<td><p><strong>🚫</strong></p></td>
<td><p><strong>🚫</strong></p></td>
<td><p><strong> 🚫</strong></p></td>
<td><p><strong>✅</strong></p></td>
<td><p> </p>
<p><strong>❌</strong></p></td>
<td><strong>   ✅</strong></td>
</tr>
<tr>
<td><p><strong>Central US</strong></p>
<p><strong>(Iowa)</strong></p></td>
<td>(Prod)</td>
<td><strong>       ✅</strong></td>
<td><strong>   ✅</strong></td>
<td><p><strong>         ✅</strong></p></td>
<td><p><strong> 🚫</strong></p></td>
<td><p><strong>🚫</strong></p></td>
<td><p><strong>🚫</strong></p></td>
<td><p><strong> 🚫</strong></p></td>
<td><p><strong>✅</strong></p></td>
<td><p><strong>❌</strong></p></td>
<td><strong>   ✅</strong></td>
</tr>
<tr>
<td><p><strong>North Europe</strong></p>
<p><strong>(Ireland)</strong></p></td>
<td>(Prod)</td>
<td><strong>      ✅</strong></td>
<td><strong>   ✅</strong></td>
<td><p><strong>         ✅</strong></p></td>
<td><p><strong> 🚫</strong></p></td>
<td><p><strong>🚫</strong></p></td>
<td><p><strong>🚫</strong></p></td>
<td><p><strong>🚫</strong></p></td>
<td><p><strong>✅</strong></p></td>
<td><p><strong>❌</strong></p></td>
<td><strong>   ✅</strong></td>
</tr>
<tr>
<td><strong>German West Central (Frankfurt)</strong></td>
<td>(Prod)</td>
<td><strong>      ✅</strong></td>
<td><strong>ETA: 14th October</strong></td>
<td><p><strong>      TBC</strong></p></td>
<td><p><strong>🚫</strong></p></td>
<td><p><strong>🚫</strong></p></td>
<td><p><strong>🚫</strong></p></td>
<td><p><strong>🚫</strong></p></td>
<td><strong>✅ Delivered 1st Oct 2025</strong></td>
<td><p><strong>❌</strong></p></td>
<td><strong> ✅ Delivered 1st Oct 2025</strong></td>
</tr>
<tr>
<td><strong>Japan East (Tokyo)</strong></td>
<td>(Prod)</td>
<td><strong>      ✅</strong></td>
<td><strong> ✅</strong></td>
<td><p><strong>      TBC</strong></p></td>
<td><p><strong> 🚫</strong></p></td>
<td><p><strong>🚫</strong></p></td>
<td><p><strong>🚫</strong></p></td>
<td><p><strong>🚫</strong></p></td>
<td><p><strong>✅</strong></p></td>
<td><p><strong>❌</strong></p></td>
<td><strong>  ✅</strong></td>
</tr>
<tr>
<td><strong>East Asia (Hong Kong)</strong></td>
<td>(Prod)</td>
<td><strong>✅</strong></td>
<td><strong>✅</strong></td>
<td><p><strong>       TBC</strong></p></td>
<td><p><strong> 🚫</strong></p></td>
<td><p><strong>🚫</strong></p></td>
<td><p><strong>🚫</strong></p></td>
<td><p><strong>🚫</strong></p></td>
<td><p><strong>✅</strong></p></td>
<td><p><strong>❌</strong></p></td>
<td><strong>   ✅</strong></td>
</tr>
<tr>
<td><p><strong>South-East Asia</strong></p>
<p><strong>(Singapore)</strong></p></td>
<td>(Prod)</td>
<td><strong>     ✅</strong></td>
<td><strong>    ✅</strong></td>
<td><strong>       ✅</strong></td>
<td><strong>    🚫</strong></td>
<td><strong>    🚫</strong></td>
<td><strong>    🚫</strong></td>
<td><strong>    🚫</strong></td>
<td><strong>      ✅</strong></td>
<td><strong>      ❌</strong></td>
<td><strong>✅</strong></td>
</tr>
</tbody>
</table>

 

 

 

 

**Segment 5 (Backup)**

 

<table>
<colgroup>
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
</colgroup>
<thead>
<tr>
<th><strong>Region</strong></th>
<th><strong>Env(s) in scope</strong></th>
<th><strong>Approvals (FRF, CTEF &amp; CAF) </strong></th>
<th><strong>Network Ready</strong></th>
<th><p><strong>Datadog Ready </strong></p>
<p><strong>(Per Region)</strong></p></th>
<th><strong>Dev Ready</strong></th>
<th><strong>Dev ZPA Ready</strong></th>
<th><strong>PreProd  Ready</strong></th>
<th><strong>PreProd ZPA Ready</strong></th>
<th><strong>Prod Ready</strong></th>
<th><strong>Prod ZPA Ready</strong></th>
</tr>
</thead>
<tbody>
<tr>
<td><strong>TBC</strong></td>
<td><strong>     TBC</strong></td>
<td><p><strong>  TBC</strong></p></td>
<td><strong>       TBC</strong></td>
<td><p><strong> TBC</strong></p></td>
<td><p><strong> TBC</strong></p></td>
<td><p><strong> TBC</strong></p></td>
<td><p><strong> TBC</strong></p></td>
<td><p><strong> TBC</strong></p></td>
<td><p><strong> TBC</strong></p></td>
<td><strong>      TBC</strong></td>
</tr>
</tbody>
</table>

 

 

 

 

**Segment 6 (Live - Live)**

 

<table>
<colgroup>
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
</colgroup>
<thead>
<tr>
<th><strong>Region</strong></th>
<th><strong>Env(s) in scope</strong></th>
<th><strong>Approvals (FRF, CTEF &amp; CAF) </strong></th>
<th><strong>Network Ready</strong></th>
<th><p><strong>Datadog Ready </strong></p>
<p><strong>(Per Region)</strong></p></th>
<th><strong>Dev Ready</strong></th>
<th><strong>Dev ZPA Ready</strong></th>
<th><strong>PreProd  Ready</strong></th>
<th><strong>PreProd ZPA Ready</strong></th>
<th><strong>Prod Ready</strong></th>
<th><strong>Prod ZPA Ready</strong></th>
</tr>
</thead>
<tbody>
<tr>
<td><p><strong>East US 2</strong></p>
<p><strong>(Virginia)</strong></p></td>
<td>(Dev, PreProd, Prod)</td>
<td><strong> Q1-   early Q2</strong></td>
<td><strong>       TBC</strong></td>
<td><p><strong> ✅</strong></p></td>
<td><p><strong> Q3</strong></p></td>
<td><strong> Q3</strong></td>
<td><strong> Q3</strong></td>
<td><strong> Q3</strong></td>
<td><p><strong> TBC</strong></p></td>
<td><strong>      TBC</strong></td>
</tr>
<tr>
<td><p><strong>Central US</strong></p>
<p><strong>(Iowa)</strong></p></td>
<td>(Dev, PreProd, Prod)</td>
<td><strong>    Q1-   early Q2</strong></td>
<td><strong>       TBC</strong></td>
<td><strong>       ✅</strong></td>
<td><p><strong> Q3</strong></p></td>
<td><p><strong> Q3</strong></p></td>
<td><p><strong> Q3</strong></p></td>
<td><p><strong> Q3</strong></p></td>
<td><p><strong> TBC</strong></p></td>
<td><p><strong> TBC</strong></p></td>
</tr>
</tbody>
</table>

 

 

 

 

**Segment 7 (Highly-Regulated)**

 

<table>
<colgroup>
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
</colgroup>
<thead>
<tr>
<th>Region</th>
<th>Env(s) in scope</th>
<th>Approvals (FRF, CTEF &amp; CAF) </th>
<th>Network Ready</th>
<th><p>Datadog Ready </p>
<p>(Per Region)</p></th>
<th>Dev Ready</th>
<th>Dev ZPA Ready</th>
<th>PreProd  Ready</th>
<th>PreProd ZPA Ready</th>
<th>Prod Ready</th>
<th>Prod ZPA Ready</th>
</tr>
</thead>
<tbody>
<tr>
<td><p><strong>UK South</strong></p>
<p><strong>(London)</strong></p></td>
<td>(PreProd, Prod)</td>
<td><p><strong> Sent for approvals </strong></p></td>
<td><strong>       TBC</strong></td>
<td><p><strong>✅</strong></p></td>
<td><p><strong>🚫</strong></p></td>
<td><p><strong>🚫</strong></p></td>
<td><p><strong>TBC</strong></p></td>
<td><p><strong>TBC</strong></p></td>
<td><p><strong>TBC</strong></p></td>
<td><strong>   TBC</strong></td>
</tr>
<tr>
<td><p><strong>North Europe</strong></p>
<p><strong>(Ireland)</strong></p></td>
<td>(PreProd, Prod)</td>
<td><strong>Sent for approvals </strong></td>
<td><strong>       TBC</strong></td>
<td><strong>        ✅</strong></td>
<td><p><strong>🚫</strong></p></td>
<td><p><strong>🚫</strong></p></td>
<td><p><strong>TBC</strong></p></td>
<td><p><strong>TBC</strong></p></td>
<td><p><strong>TBC</strong></p></td>
<td><p><strong>TBC</strong></p></td>
</tr>
</tbody>
</table>

 

 

 

 

**Segment 8 (Customer SaaS)**

 

<table>
<colgroup>
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 9%" />
</colgroup>
<thead>
<tr>
<th><strong>Region</strong></th>
<th><strong>Env(s) in scope</strong></th>
<th><strong>Approvals (FRF, CTEF &amp; CAF) </strong></th>
<th><strong>Network Ready</strong></th>
<th><p><strong>Datadog Ready </strong></p>
<p><strong>(Per Region)</strong></p></th>
<th><strong>Dev Ready</strong></th>
<th><strong>Dev ZPA Ready</strong></th>
<th><strong>PreProd  Ready</strong></th>
<th><strong>PreProd ZPA Ready</strong></th>
<th><strong>Prod Ready</strong></th>
<th><strong>Prod ZPA Ready</strong></th>
</tr>
</thead>
<tbody>
<tr>
<td><strong>TBC</strong></td>
<td><strong>     TBC</strong></td>
<td><p><strong>  TBC</strong></p></td>
<td><strong>       TBC</strong></td>
<td><p><strong> TBC</strong></p></td>
<td><p><strong> TBC</strong></p></td>
<td><p><strong> TBC</strong></p></td>
<td><p><strong> TBC</strong></p></td>
<td><p><strong> TBC</strong></p></td>
<td><p><strong> TBC</strong></p></td>
<td><strong>      TBC</strong></td>
</tr>
</tbody>
</table>

 

***Regional Inflations are driven by customer demands via the new CPDM (Cloud Platform Demand Management)*** [***link here***](/sites/CloudCentral/SitePages/Platform-Demand-Management.aspx?xsdata=MDV8MDJ8fGY1NDFkNGM4ZjQxYTRiZTRmNmY2MDhkY2RjYTU3MTE2fDI4N2U5ZjBlOTFlYzRjZjBiN2E0YzYzODk4MDcyMTgxfDB8MHw2Mzg2Mjc4NTAzMDQ4MTI3OTB8VW5rbm93bnxWR1ZoYlhOVFpXTjFjbWwwZVZObGNuWnBZMlY4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazkwYUdWeUlpd2lWMVFpT2pFeGZRPT18MXxMMk5vWVhSekx6RTVPbTFsWlhScGJtZGZUVEpPYkU0eVNUTmFhbXQwV1hwQ2FFNURNREJhYWxsNVRGUnJORTFYU1hSWmJVMHlUMVJKTVZwdFJUSk9SR2MwUUhSb2NtVmhaQzUyTWk5dFpYTnpZV2RsY3k4eE56STNNVGc0TWpJNU5UUTV8ZjJlZmQwZjI1MzA4NDJjNmY2ZjYwOGRjZGNhNTcxMTZ8ZjQ5MTlhNTgyZWE5NDBmOTk5ZTU4NDIzZTM2MThlNTQ%3D&sdata=R0FGTUF3Z00ycFNHdjhBZ25yTDlqN1VRYldmZE1oQnp5dCtRK0hySUhEcz0%3D&ovuser=287e9f0e-91ec-4cf0-b7a4-c63898072181%2cjames.complin%40lseg.com&OR=Teams-HL&CT=1727258219213&clickparams=eyJBcHBOYW1lIjoiVGVhbXMtRGVza3RvcCIsIkFwcFZlcnNpb24iOiI1MC8yNDA4MTcwMDQxOSIsIkhhc0ZlZGVyYXRlZFVzZXIiOmZhbHNlfQ%3D%3D)***.***

**Raise a new demand for a region or segment** ** [***here***](https://form.asana.com/?k=N0ziXWfodjXdxq9zP4TNdA&d=315915426134094)

** **

**\*\******Approvals*** **→ FRF, CTEF & CAF approvals for Regions /Segments**

 

**✅ Done**

**❌ Not in Scope for delivery until a demand is raised**

**🟨 ZPA connector available but Cross region connectivity is unavailable due to reflex changes pending/Failing**

**🔜 Strategic solution planned for delivery soon**

**🚫 Not required**

 

 

 

<table>
<colgroup>
<col style="width: 12%" />
<col style="width: 12%" />
<col style="width: 12%" />
<col style="width: 12%" />
<col style="width: 12%" />
<col style="width: 12%" />
<col style="width: 12%" />
<col style="width: 12%" />
</colgroup>
<thead>
<tr>
<th><p>Region</p></th>
<th><p>Location</p></th>
<th><p>Segment</p></th>
<th><p>Region Approval</p></th>
<th><p> Inflation Approval</p></th>
<th><p>LMSP1</p></th>
<th><p>LSEG SaaS</p></th>
<th><p>LMSP0</p></th>
</tr>
</thead>
<tbody>
<tr>
<td><strong>UK South</strong></td>
<td><p>London</p></td>
<td><p> only internet egress</p></td>
<td><p>✅</p></td>
<td><p>✅</p></td>
<td><p>❌</p></td>
<td><p>❌</p></td>
<td><p>✅</p>
<p>ZPA not available</p></td>
</tr>
<tr>
<td><strong>East US 2</strong></td>
<td><p>Virginia</p></td>
<td><p>only internet egress</p></td>
<td><p>✅</p></td>
<td><p>✅</p></td>
<td><p>✅</p></td>
<td><p>✅</p></td>
<td><p>❌</p></td>
</tr>
</tbody>
</table>

## Requesting Additional Regions (regions not in the list above)

If your requirements indicate a **need for regions, or network segment not shown** in the above list please raise a Foundation Demand Request using this form [FM: Intake Demand Form \[v0.5\] - Form by Asana](https://form.asana.com/?k=KEYxarEQ6mcSOdBkXBSNIA&d=315915426134094). This will trigger the demand triage process and an architect is assigned to assess the request.

 

If/when agreement is reached to proceed the proposal for new region\new network segment for existing region will proceed through architecture governance and once this is complete and approved, regional hub build activity will be scheduled.  
  
Please note that new region inflations need collaboration amongst multiple teams: Cloud Azure Engineering, Cloud SRE, Networking, Security, etc. Inflating a new region takes between 4 to 6 weeks in a best-case scenario, without considering the backlog of work these team have, so we recommend raising this request well in advance.

## Tips and Tricks for Choosing an Azure Region

**Network latency**

Network latency is the main factor when choosing a primary Azure region for the app team. <span class="fontColorRed">**Each team must review the network latency carefully for each application/scenario**</span>. Some general information about round-trip latency between locations can be found here:

- [Azure network round-trip latency statistics \| Microsoft Learn](https://learn.microsoft.com/en-us/azure/networking/azure-network-latency?tabs=Europe%2cCentralEurope)
- [Ping time between Dublin and Frankfurt - WonderNetwork](https://wondernetwork.com/pings/Dublin/Frankfurt)

**Pricing per regions**

Each Azure Region has its own pricing level for each Azure Services (Azure SKU). These prices can be various for different services and may change over the time. For example, the difference between East US 2 and Japan East regions is about 58%. 

<span class="fontColorRed">**The price must always be checked separately!**</span>

On this pageSupported Regions in LSEG.comRequest a new Region for Azure<a href="/sites/CloudCentral" data-sp-prop-name="baseUrl"></a><a href="/sites/CloudCentral/SitePages/LMP-Azure-Regions.aspx#supported-regions-in-lseg.com" data-sp-prop-name="items[0].sourceItem.url"></a><a href="/sites/CloudCentral/SitePages/LMP-Azure-Regions.aspx#requesting-additional-regions-%28regions-not-in-the-list-above%29" data-sp-prop-name="items[1].sourceItem.url"></a>

***If you have any questions, please reach out to** <span class="fontColorThemePrimary">**CPE Azure Release Team \<CPEAzureReleaseTeam@lseg.com\>**</span>*

Useful LinksAzure - Requesting an additional Region for an existing subscription<a href="/sites/CloudCentral" data-sp-prop-name="baseUrl"></a><a href="/sites/CloudCentral/SitePages/Requesting-an-additional-region-for-an-existing-subscription.aspx" data-sp-prop-name="items[0].sourceItem.url"></a>Have a question? Ask us on StackAsk the Cloud community using the 'lmp-azure' tag in Stack OverflowFind what you are looking for? Please provide feedback<a href="/sites/CloudCentral" data-sp-prop-name="baseUrl"></a><a href="https://lseg.stackenterprise.co/users/login?returnurl=https://lseg.stackenterprise.co/" data-sp-prop-name="items[0].sourceItem.url"></a><a href="https://forms.microsoft.com/Pages/ResponsePage.aspx?id=Dp9-KOyR8Ey3pMY4mAchgYp9CRjyYppFsaTYdwLXKwtUOEg0RUE0MUdFTUJBUzdLV1NKQTVJQVA4Qy4u" data-sp-prop-name="items[1].sourceItem.url"></a>Return to New to LSEG Cloud<a href="/sites/CloudCentral/SitePages/New-to-LSEG-Cloud-Platform---Start-Here-old.aspx" data-sp-prop-name="linkUrl"></a>
