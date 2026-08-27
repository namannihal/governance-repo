# Platform Guides — Index

> **Agent usage:** These are LSEG CloudCentral/SharePoint page exports covering networking,
> regions, fast-path subscriptions, onboarding, and long-running TCP guidance. They contain
> factual platform information that informs SAD analysis and IaC design decisions.
> The raw HTML in the `index.md` files is noisy — use the summaries below rather than
> loading the files directly.

---

## Azure Networking

**Folder:** `SitePagesLMP-Azure-Networking/`

**Key facts for IaC:**
- Hub-and-spoke topology ("Tornado"): one Azure Firewall per spoke subscription
- Non-routable VNet uses CGNAT range (`100.x.x.x/17` per region — see region table)
- Routable VNet is `/23`; subnets pre-created by platform: Bastion, AGW, Workload, FW
- All outbound internet traffic is SNAT'd through the spoke-level Azure Firewall
- Private DNS zones for PaaS services are managed by platform Azure Policy (DINE)
- App teams allocate subnets only within the non-routable `/17` VNet

**Related ADR:** LMP-ADR-0005 (Azure Firewall), LMP-ADR-0013 (Tornado topology)  
**Related Pattern:** LMP-PAT-0021 (outbound), LMP-PAT-0023 (DNS), LMP-PAT-0026 (ZPA)

---

## Azure Regions

**Folder:** `SitePagesLMP-Azure-Regions/`

### Network Segments

> **Key rule:** One subscription can only be linked to **one segment**. If connectivity to
> two segments is required, two separate subscriptions are needed.

| Segment | Short name | Description | Typical use |
|---------|-----------|-------------|-------------|
| **Segment 1** | hRft | Connected to the Refinitiv WAN (SIGMA/SDNET). Covers ~90% of migrating apps. Onward reach to Refinitiv DCs, brownfield AWS/Azure, on-prem DBORs. | Most app migrations from Refinitiv heritage |
| **Segment 2** | hLSEG | Connected to the LSEG WAN (CNF). Covers ~10% of apps. Onward reach to LSEG DCs, brownfield AWS/Azure. | Apps from LSEG heritage systems |
| **Segment 3** | Internet (Shared Egress) | Centralised egress via shared firewall pod. No reach-back to on-prem. Criteria applies. | Small apps with internet-only connectivity needs |
| **Segment 4** | Delivery Direct | Customer Connectivity Hub — private WAN for ~3,000 customers. Bolt-on to Seg 1 or Seg 2. Guaranteed SLAs, leased lines. | Apps published to the Delivery Direct / Refinitiv customer network |
| **Segment 5** | Backup | Dedicated high-bandwidth ExpressRoute, logically separated. For on-prem ↔ cloud backups only. **Not for migration traffic or standard app backup.** | Bulk backup between on-prem and Azure |
| **Segment 6** | Live-Live | Real-time data feeds with dual-path (RED + BLUE) resilience. Packets sent on two paths simultaneously; first arrival wins. Extreme SLA requirements. | Real-time market data / ultra-low-latency workloads |
| **Segment 7** | Highly Regulated | Technically identical to Seg 1/2 but with stricter change control, longer change windows, and potentially different governance/RBAC. | Regulated financial workloads requiring extra controls |
| **Segment 8** | LSEG SaaS | Separate tenant for the LMP/Microsoft Co-Innovation partnership. Restricted app sharing. | Strategic LMP/Microsoft partnership workloads only |

### Approved Regions, Non-Routable CIDRs & Segment Availability

> **IaC rule:** Subnet CIDRs **must** be carved from the region's `/17` non-routable block.
> Never use RFC-1918 (`10.x`, `172.x`, `192.168.x`) for non-routable subnet CIDRs.

| Region | Azure Location | Non-Routable `/17` | Seg 1 (hRft) | Seg 2 (hLSEG) | Seg 3 (Internet) | Seg 4 (Delivery Direct) | Seg 6 (Live-Live) | Seg 7 (Highly Regulated) |
|--------|---------------|--------------------|:---:|:---:|:---:|:---:|:---:|:---:|
| UK South | `uksouth` | `100.64.0.0/17` | ✅ Dev/PPR/PRD | ✅ Dev/PPR/PRD | TBC | ✅ PRD only | — | ✅ PPR/PRD (approvals in progress) |
| UK West | `ukwest` | `100.65.0.0/17` | ✅ Dev/PPR/PRD | — | — | — | — | — |
| North Europe | `northeurope` | `100.66.0.0/17` | ✅ Dev/PPR/PRD | — | — | ✅ PRD only | — | ✅ PPR/PRD (approvals in progress) |
| West Europe | `westeurope` | `100.67.0.0/17` | — | — | — | — | — | — |
| East US | `eastus` | `100.68.0.0/17` | ✅ Dev/PPR/PRD | — | — | — | — | — |
| Central US | `centralus` | `100.69.0.0/17` | ✅ Dev/PPR/PRD | ✅ Dev/PPR/PRD | TBC | ✅ PRD only | 🔜 Q3 | — |
| South East Asia | `southeastasia` | `100.70.0.0/17` | ✅ Dev/PPR/PRD | TBC | — | ✅ PRD only | — | — |
| East Asia | `eastasia` | `100.71.0.0/17` | ✅ Dev/PPR/PRD | — | — | ✅ PRD only | — | — |
| East US 2 | `eastus2` | `100.72.0.0/17` | ✅ Dev/PPR/PRD | ✅ Dev/PPR/PRD | TBC | ✅ PRD only | 🔜 Q3 | — |
| Japan East | `japaneast` | `100.73.0.0/17` | ✅ Dev/PPR/PRD | — | — | ✅ PRD only | — | — |
| Germany West Central | `germanywestcentral` | `100.74.0.0/17` | ✅ Dev/PPR/PRD (Oct 2025) | ✅ Dev/PPR/PRD (Oct 2025) | — | ✅ PRD only (Oct 2025) | — | — |

> **Segments 5 (Backup) and 8 (Customer SaaS):** Region availability TBC — raise a Foundation
> Demand Request to request a region or segment not listed above.

### ZPA (Zscaler Private Access) — Developer Connectivity

ZPA replaces the need for a Bastion/jump host for developer access in non-prod environments.

- **ZPA Spoke-to-Application Spoke** (same-region, lowest latency): East US 2, UK South, South-East Asia
- **SDNet/Hub-to-Hub** (cross-region ZPA): all other approved regions
- ZPA is **not required in app IaC** — it is platform-managed infrastructure

### Region Readiness Criteria

A region is considered **Ready** when:
- Network infrastructure is provisioned and peered
- ZPA and Datadog tooling are integrated
- FRF, CTEF & CAF governance approvals are granted

> To request a new region or segment not listed, raise a Foundation Demand Request via the
> CPDM (Cloud Platform Demand Management) process.

---

## Fast-Path Subscriptions

**Folder:** `SitePagesFastPath-Subscriptions/`

**Key facts for IaC:**
- Fast-path subscriptions are shared, pre-configured subscriptions for rapid onboarding
- Landing Zone resources are pre-provisioned — app teams only provision app-layer resources
- Resource Groups, VNets, DNS zones, and Firewall are all pre-created
- App teams receive: Application RG, platform RG names, VNet names as inputs to IaC

---

## Golden Pages / Page Restructuring

**Folder:** `SitePagesGolden-Pages--Page-Restructuring/`

Reference documentation for LSEG platform golden pages — navigation/portal guidance only.
Not directly relevant to IaC generation.

---

## Additional Application Onboarding (Existing Subscriptions)

**Folder:** `SitePagesLMP-Azure---Additional-Application-Onboarding-to-existing-Subscriptions/`

**Key facts for IaC:**
- When onboarding a new app to an **existing subscription**, the platform team creates
  a new Application Resource Group but reuses the existing VNets and DNS infrastructure
- App team provides: `app_id`, `org_id`, desired environment names to the platform team
- IaC is otherwise identical to a greenfield onboarding

---

## Long-Running TCP Guidance

**Folder:** `SitePagesLong-running-TCP-Guidance/`

**Key facts for IaC:**
- Azure Load Balancer and Azure Firewall have a 4-minute TCP idle timeout by default
- For long-running TCP connections (e.g. database connections, WebSockets): configure
  TCP keepalive at the application level
- For Functions/App Service connecting to databases: set connection pool keepalive
- For AKS: configure node-level `net.ipv4.tcp_keepalive_time` via DaemonSet
- **IaC impact:** No Terraform configuration needed; this is an application-level concern.
  Include a note in the generated `README.md` when PostgreSQL or Redis is in the module plan.
