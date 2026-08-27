<!--
  Sync Impact Report
  ===================
  Version change: 1.5.0 → 1.6.0
  Modified principles: None (all 10 principles unchanged)
  Added sections: None
  Removed sections: None
  Changes:
    - Added "Environment isolation" constraint to Global Constraints
      table: every Azure resource instance MUST be independently
      provisioned per environment (DEV, QA, PPE, PROD). No infra
      shared across environments. Source: SCF-SEC-04, LMP-ADR-0006,
      LMP-ADR-0012. Constraint was present in SourceDocs lineage
      (v1.1.2) but missing from authoritative lineage (v1.5.0).
    - Corrected Patterns Library count from "78 published" to
      "80 patterns (70 published)" across Preamble, Principle VIII,
      Source Document Appendix, and Source Framework Versions table.
      Derived from Inputs/content.md inventory: 70 Published, 5 Draft,
      5 Superseded = 80 total.
    - Fixed duplicate HTML comment closure artifact in file header.
  Templates requiring updates:
    - .specify/templates/plan-template.md — ✅ no update needed
    - .specify/templates/spec-template.md — ✅ no update needed
    - .specify/templates/tasks-template.md — ✅ no update needed
  Follow-up TODOs: None
  Previous Sync Impact Reports:
  ---
  v1.5.0 (2026-04-09): Added Migration Design Requirements subsection.
    Cutover patterns, migration validation, rollback strategy.
  v1.4.0 (2026-04-09): Added Resiliency Architecture subsection
    (AZ hierarchy, Tier mapping, recovery patterns, 6 mandatory
    resiliency design rules). Updated Reliability Standards.
  v1.3.0 (2026-04-09): Added CPF Module & Pattern Selection Process
    subsection. Extended Principle II with CPF-first design obligation
    and demand request rule.
  v1.2.0 (2026-04-09): Added Migration Treatment (R-Type) Rules
    section. R-Type sourced from Discovery Report, not SAD. Container
    Adoption Rule added.
  v1.1.1 (2026-03-25): Added SMCF-OPS-10 (License Management) to
    Operational & Reliability Expectations table.
  v1.1.0 (2026-03-25): Added Change Management & Versioning section
    (separated from Governance) and Source Document Appendix.
  v1.0.0 (2026-03-25): Initial creation from 9 source frameworks.
    10 principles, 5 additional sections, glossary.
-->
# LSEG LMP Constitution
## Preamble
**Purpose**: This Constitution is the single, authoritative governance
artifact for the LSEG Migration Programme (LMP). It codifies the
non-negotiable principles, boundaries, and constraints that apply to
every application, service, and team migrating workloads to Azure
under the LSEG-Microsoft Partnership.
**Scope**: All LMP Landing Zone workloads — production, pre-production,
and sandbox — across every Azure subscription, resource group, and
pipeline within the programme. This includes infrastructure,
application code, CI/CD pipelines, operational runbooks, and
third-party integrations.
**Authority**: This Constitution supersedes team-specific practices
where conflicts arise. It is derived from and normalizes the following
authoritative source frameworks:
- **SCF** — Security Control Framework (v6, WIP)
- **CSMC** — Cloud Service Management Control Framework (v4)
- **MEC** — Cyber Minimum Entry Criteria (v3.2.0.2)
- **CPF** — Cloud Product Framework (Terraform modules + clearlisting)
- **ADRs** — LMP Architecture Decision Records (LMP-ADR-0001–0025)
- **DevSecOps Checklist** — CI/CD, repository, and security standards
- **Patterns Library** — 80 architecture patterns (70 published)
- **API Strategy** — Gateway selection and routing rules
- **Azure Guidance** — Region, networking, and operational rules
## Core Principles
### I. Security-First (NON-NEGOTIABLE)
Security controls from the SCF, MEC, and CPF clearlisting MUST be
implemented before any workload enters production. Security is not a
phase — it is embedded in every design, deployment, and operational
decision.
- ALL 30 MEC controls MUST be satisfied before production go-live.
- SCF Foundation Controls MUST be implemented for every Landing Zone
  workload; Standard and Landing Zone tier controls MUST be applied
  per the workload's data classification.
- Security posture (Defender for Cloud secure score) MUST be reviewed
  weekly (SMCF-SEC-02).
- Penetration testing MUST be conducted annually (SMCF-SEC-04).
### II. Approved Services Only (NON-NEGOTIABLE)
Only CPF clear-listed Azure services may be provisioned in LMP
Landing Zones (SMCF-GOV-06). The `azure-clear-listing-main` repository
is the authoritative clearing registry.
- Every Azure resource type MUST have a corresponding CPF clearlist
  entry with approved use-cases and mandatory security controls.
- **Design MUST start with CPF**: before proposing any Azure service,
  architects MUST check CPF module and Patterns Library availability and
  follow the CPF Module & Pattern Selection Process (see Architecture &
  Integration Rules).
- When a required CPF module or pattern does not yet exist, a **CPF demand
  request** MUST be raised and the SAD MUST document both the target design
  and the best CPF-available interim alternative.
- New service requests MUST follow the CPF inner-source governance
  lifecycle.
- Exceptions MUST be formally justified, documented, and approved
  through the governance process.
### III. Infrastructure as Code (NON-NEGOTIABLE)
All infrastructure MUST be provisioned via CPF Terraform modules
(SCF-RES-01, SMCF-GOV-09). Manual Azure Portal changes in production
are prohibited.
- Teams MUST use `cpf-azure-prdsvc-*`, `cpf-azure-prdsvcpat-*`, or
  `cpf-azure-prdapppat-*` modules for all resource provisioning.
- Terraform state MUST be stored remotely in Azure Blob Storage with
  state locking and encryption enabled.
- All IaC MUST be version-controlled in DXOne GitLab repositories.
- SMCF-GOV-09 mandates review at each deployment.
### IV. Identity & Least Privilege
All access MUST follow the least-privilege principle, managed through
the LSEG-approved centralized Identity Provider (Microsoft Entra ID).
- MFA MUST be enforced for all user accounts regardless of device or
  network location (SCF-IAM-01).
- Conditional Access restrictions are mandatory (SCF-IAM-01-08).
- RBAC MUST be applied to all resources; roles reviewed annually
  (SCF-IAM-02).
- Privileged Access Management MUST follow SCF-IAM-06.
- Access entitlements MUST be integrated with SailPoint; certification
  reviews MUST occur monthly (SMCF-SEC-05).
- Service/robotic accounts SHOULD use modern auth (programmatic keys,
  time-limited tokens) — NOT passwords.
### V. Secrets Management
All persisted secrets MUST be stored in Azure Key Vault (MEC6.1,
SCF-IAM-04). No secrets in code, configuration files, environment
variables, or pipeline logs.
- Secret rotation MUST be automated where possible; all systems MUST
  be capable of rotating credentials within 5 minutes of a GSOC
  request (MEC12.2).
- Vault access (control + data plane) MUST be governed with
  least-privilege RBAC (SCF-IAM-06).
- Soft-delete and purge protection MUST be enabled on all Key Vaults.
- Vault access MUST be logged, monitored, and forwarded to SIEM.
- Weekly monitoring for unsafe secret storage is mandatory
  (SMCF-SEC-03).
### VI. Encryption Everywhere
All data MUST be encrypted in transit and at rest without exception.
- **In transit**: TLS 1.2+ MUST be used for all communications;
  cipher suites per the LSEG Cryptography Standard (SCF-DATA-01).
- **At rest**: Storage encryption MUST be applied to at least one
  layer for ALL data classifications including Public (SCF-DATA-02).
- Encryption key management MUST follow SCF-DATA-03; Customer-Managed
  Keys (CMK) where mandated by CPF clearlist controls.
- SSL/TLS certificate lifecycle MUST be actively managed.
### VII. Observability by Default
Every service MUST emit structured telemetry to the approved
observability and security monitoring platforms from day one.
- **Operational observability**: Datadog is the strategic destination
  for metrics, logs, and traces (LMP-ADR-0003).
- **Telemetry standard**: OpenTelemetry MUST be used as the
  vendor-neutral instrumentation standard (LMP-ADR-0004).
- **SIEM feed**: Security event data MUST be collected and forwarded
  to the LSEG SIEM (SCF-SEC-03) — this is a separate, mandatory
  requirement from Datadog.
- **Mandatory SIEM feeds**: DDoS metrics, identity risk data, WAF
  logs, DNS logs, web access logs.
- **Audit logging**: Platform audit logs (SCF-AUD-01) and resource
  audit logs for Highly Restricted data (SCF-AUD-02) MUST be
  captured, tamper-proof, immutable, and retained per the LSEG Data
  Retention Standard.
- **No PII in logs** — pseudonymization, encryption, or hashing is
  required if PII is present.
- Azure immutable blob storage MUST be used for audit log archival
  (LMP-ADR-0011).
### VIII. Architecture Governance
All architecture decisions MUST be documented, reviewed, and aligned
with the LMP Patterns Library and published ADRs. No ad-hoc
technology introductions.
- Technology selection MUST reference existing ADRs; rejected
  alternatives documented in ADRs MUST NOT be re-proposed without
  new evidence.
- Service designs MUST follow published LMP architecture patterns
  where applicable (80 patterns across 19 domains).
- New patterns MUST be submitted through the governance process
  (SMCF-GOV-07).
- BCDR plans MUST be documented, tested annually, and re-validated
  after significant changes (SMCF-OPS-06); RTO/RPO/SLA MUST be
  defined per application.
### IX. DevSecOps Discipline
All software delivery MUST follow the DevSecOps Checklist standards
for CI/CD, repository management, and release processes.
- **Branch protection**: Direct commits to main are prohibited;
  minimum 2 approvers on merge requests; no self-approval.
- **CI gate**: All pipelines MUST pass before merge.
- **Deployment**: DXOne GitLab shared runners for CI/CD
  (LMP-ADR-0016); protected environments with deployment approvals.
- **Artifact management**: Artifacts published to Enterprise
  Artifactory; GPG signing required; SemVer tagging mandatory.
- **Commit convention**: Conventional Commits standard (`feat`, `fix`,
  `docs`, `style`, `refactor`, `test`, `chore`).
- **Versioning**: Semantic Versioning (MAJOR.MINOR.PATCH).
- **DORA metrics target** (SMCF-OPS-08): deployment frequency
  1/day–1/week; change failure rate 0–15%; time to restore <1 day.
### X. Cost Governance
All Azure resources MUST be tagged, budgeted, and cost-optimized per
the CSMC FinOps controls.
- Cost hierarchy and tagging MUST comply with SMCF-FIN-01 and
  SMCF-GOV-03; tags applied at deployment, reviewed quarterly.
- Cost reports MUST be reviewed monthly (SMCF-FIN-02); budgets set
  and monitored with threshold alerts (SMCF-FIN-03).
- Cost optimization opportunities MUST be reviewed monthly
  (SMCF-FIN-04).
- Dedicated per-application APIM instances are prohibited due to cost
  (~$3k/month/region/unit); domain-level shared APIM instances are
  mandatory (API Strategy).
## Global Constraints
These constraints apply to every workload regardless of domain,
team, or data classification.
| Constraint | Rule | Source |
|------------|------|--------|
| Azure regions | Only LMP-approved regions per network segment (Segments 1–8) | Azure Guidance |
| Subscription model | One subscription per application family per environment; quarantine exceptions per LMP-ADR-0012 | LMP-ADR-0006, LMP-ADR-0012 |
| JDK distribution | Microsoft Build of OpenJDK for all Java workloads | LMP-ADR-0002 |
| Front-end framework | React (Silverlight replacement) | LMP-ADR-0007 |
| Kubernetes ingress | Ingress-Nginx as the required ingress controller | LMP-ADR-0008 |
| Service mesh | Istio ONLY when a general-purpose mesh is required (not default) | LMP-ADR-0009 |
| Email service | Mimecast (central LSEG service) | LMP-ADR-0001 |
| CDC / streaming | Oracle GoldenGate for low-latency CDC with transactional consistency | LMP-ADR-0018 |
| VM images | LSEG Golden Images only for Batch compute and container hosts | Azure Guidance |
| Network topology | Hub-spoke VNet architecture with Azure Firewall per spoke for CGNAT-to-RFC-1918 SNAT | LMP-ADR-0005 |
| Production resource locks | Azure resource locks (CanNotDelete) MUST be applied; audited via Azure Policy | SMCF-OPS-07 |
| CMDB integration | All resources registered in CMDB; reviewed at each asset change | SMCF-GOV-04 |
| Naming convention | DX1 lowercase, hyphens, no leading numbers/symbols | DevSecOps Checklist |
| Environment isolation | Every Azure resource instance (Storage Account, Cosmos DB account, Key Vault, Service Bus namespace, Batch account, Function App, VNet, etc.) MUST be independently provisioned per environment (DEV, QA, PPE, PROD). No infrastructure resource may be shared across environments. Environment-specific naming follows `{env}-{region}-taas-{resource}` convention. | SCF-SEC-04, LMP-ADR-0006, LMP-ADR-0012 |
| Azure Policy compliance | Reviewed weekly | SMCF-GOV-10 |
## Architecture & Integration Rules
### CPF Module & Pattern Selection Process
Every solution design (SAD, spec, or IaC plan) MUST follow this process
**before** proposing any Azure service or architecture component:
#### Step 1 — Check CPF module availability
Query the CPF catalogue (`cpf-schemas/_catalog.json` or `@cpf-genie`) to
confirm whether a certified Terraform module exists for every Azure service
required by the proposed solution.
#### Step 2 — Check Patterns Library availability
Verify whether a published LMP architecture pattern (LMP-PAT-XXXX) covers
the required service interaction, topology, or integration. Patterns are
in `templates/patterns/` across 19 domains.
#### Step 3 — For each required service or component, apply one of the following outcomes:
| Situation | Required Action |
|-----------|----------------|
| CPF module **and** pattern available | Use them. No deviation required. |
| CPF module available, no pattern | Use the module; note the gap in the SAD's Bill of Services. |
| No CPF module, pattern available as reference | **Raise a CPF demand request** for the missing module via the inner-source governance lifecycle. The SAD MUST document the target design using the pattern as the reference and include the demand request reference. Evaluate and document a CPF-available interim alternative in the SAD. |
| No CPF module, no pattern | **Raise a CPF demand request** AND a pattern governance request (SMCF-GOV-07). The SAD MUST state the target design, reference both requests, and document the best available CPF-based alternative for interim delivery. |
#### Step 4 — Document in the SAD
For every service gap identified in Steps 1–3, the SAD Bill of Services
MUST include:
- **Target design** — the best architectural solution regardless of current
  CPF availability.
- **CPF demand request reference** — the ticket/reference for the requested
  module or pattern (format: `[CPF-DEMAND-XXXX]`).
- **Interim alternative** — the best solution achievable using only the
  currently available CPF modules and patterns, with any trade-offs noted.
- **Blocked / unblocked status** — whether the SAD can proceed to IaC
  delivery using the interim alternative, or whether the demand request
  must be fulfilled first.
> **Example:** A proposed solution requires Azure AI Foundry
> (`cpf-azure-prdsvc-aifoundry`). If this module is not yet published in
> the CPF catalogue, the SAD MUST: (1) retain Azure AI Foundry as the
> target design, (2) raise a CPF demand request and record its reference,
> (3) document whether an alternative (e.g., Azure OpenAI via an existing
> CPF module) can satisfy the requirement in the interim, and (4) mark the
> AI Foundry component as "Pending CPF module — demand request
> [CPF-DEMAND-XXXX]" in the IaC scaffolding plan.
### API Gateway Selection
| Consumer Type | Gateway | Justification |
|---------------|---------|---------------|
| Internal APIs (all domains) | Azure APIM Premium (shared domain-level) | Default for all LMP migrations |
| External / customer-facing APIs (D&A) | Kong Central Customer API GW | Historical bake-off selection (2021); strategic for DI & Analytics |
| External APIs (non-D&A domains) | Azure APIM Premium | Default unless Kong justified |
- Per-application dedicated APIM instances are prohibited.
- RDP API Gateway migration: internal → shared APIM; external → Kong
  Central Customer API GW.
### Network & Connectivity
- Private Endpoints MUST be used for all PaaS service connectivity.
- Private DNS resolution per LMP-PAT-0023.
- Outbound internet connectivity per LMP-PAT-0021.
- ZScaler Private Access for internal access (LMP-PAT-0026).
- Long-lived TCP sessions (FIX protocol, RTMDS) MUST follow the
  Long-Running TCP Guidance for Azure load balancer, firewall, and
  timeout configuration.
- Legacy dependency retirement: Tornado SOAP proxy (LMP-ADR-0013),
  Eikon Reverse Proxy (LMP-ADR-0015), and on-premise Elasticsearch
  (LMP-ADR-0014) MUST be replaced with Azure-native services.
### Compute & Container Standards
- AKS with Private Endpoint pattern (cpf-azure-prdsvcpat-aks-private)
  is the default for **containerized workloads** (i.e., source application
  already runs on containers). For non-container source applications, see
  the Container Adoption Rule in **Migration Treatment (R-Type) Rules**.
- Azure Functions for serverless compute (Linux or Windows patterns).
- VM workloads MUST use CPF VM service patterns with LSEG Golden
  Images; Defender for Containers enabled on all ACR instances.
- OS patching: VMs monthly, AKS clusters quarterly (SMCF-OPS-09).
### Database & Data Services
- Relational database selection per LMP-PAT-0077 (current version).
- PostgreSQL Flexible Server, SQL Managed Instance, MySQL Flexible
  Server, Cosmos DB, and Oracle on VM all have published CPF patterns.
- Data-as-a-Service patterns MUST be followed for data publishing
  (LMP-PAT-0029) and consumption (LMP-PAT-0036).
- Oracle Exadata/RAC → Azure Oracle on VM migration per LMP-PAT-0069.
### Resiliency Architecture
#### Azure Infrastructure Hierarchy
Azure infrastructure is organized into three nested scopes:
| Scope | Definition |
|-------|-----------|
| **Geography** | A large geographic area (e.g., a country) containing one or more Regions. Defines data-residency boundaries. |
| **Region** | An Azure footprint area containing one or more Availability Zones with specific latency and infrastructure resiliency guarantees between zones. |
| **Availability Zone (AZ)** | One or more datacentre facilities within a Region with independent power, network, and cooling. The primary unit of intra-region resiliency. |
Some Regions have a **paired region** in the same Geography, enabling
platform-level in-geography DR (e.g., geo-redundant storage replication,
Azure Site Recovery pairing). Paired regions are an Azure platform feature —
they are **not** the default multi-region DR approach for applications.
#### LSEG Business Criticality Tiers
| Tier | Description | RTO | RPO |
|------|-------------|-----|-----|
| **1** | Survivability | 0–2 hours | Near Zero |
| **2** | High Impact | 2–8 hours | Near Zero |
| **3** | Medium Impact | 8–24 hours | Near Zero |
| **4** | Low Impact | < 5 days | < 24 hours |
| **5** | Insignificant Impact | > 5 days | > 24 hours |
The Tier is defined in the SAD and drives all resiliency design decisions.
#### Tier-to-Deployment-Model Mapping
| Tier | Multiple Geographies | Multiple Regions | Multiple AZs |
|------|:-------------------:|:----------------:|:------------:|
| 1 | Should | **Must** | **Must** |
| 2 | Could | Should | **Must** |
| 3 | Could | Could | **Must** |
| 4 | Should Not | Should Not | Could |
| 5 | Should Not | Should Not | Could |
> **Design-first rule:** apply the most local scope of redundancy first.
> Availability Zones MUST be used before considering multi-region.
> Multi-region MUST be used before considering multi-geography.
Additional application-specific factors (data residency, latency, regulatory)
may override or supplement the Tier mapping and MUST be documented in the SAD.
#### Recovery Patterns
| Pattern | Description | Relevant Tiers |
|---------|-------------|:--------------:|
| **Active/Active** | Multiple instances running across Geographies, Regions, or AZs simultaneously. Live-live service from all locations. | 1, 2 |
| **Active/Passive** | Multiple instances distributed across Geographies, Regions, or AZs. Live service from one with automatic failover to secondary. | 1, 2, 3 |
| **Warm Standby** | Single primary instance running; minimum-viable secondary instance warm in another Region or AZ; manual failover. | 2, 3, 4 |
| **Pilot Light** | Single primary instance running; only critical components (e.g., storage) replicated to a secondary Region or AZ. | 3, 4, 5 |
Highly transactional applications (DBoRs, trading systems) with strong atomic
commit requirements typically prefer Active/Passive. Stateless caches or
globally distributed query stores with latency targets across regions
typically benefit from Active/Active.
#### Mandatory Resiliency Design Rules
1. **Availability Zones first (mandatory):** All Azure services that support
   zone-redundancy MUST be deployed as zone-redundant by default. Single-zone
   or non-zonal deployments require explicit justification in the SAD.
2. **Multi-region when Tier demands it:** Multi-region deployment MUST be
   applied for Tiers 1–2 (Must/Should). For Tiers 3–5 it is optional and
   must be justified by the application's RTO/RPO requirements, not by default.
3. **Paired regions only when strictly required:** Paired-region deployment
   MUST only be used when:
   - Azure platform services mandatorily use paired regions (e.g., geo-redundant
     storage GRS/GZRS replication, Azure Site Recovery default pairing), OR
   - Explicit data-residency or regulatory requirements mandate in-geography DR.
   Paired regions MUST NOT be chosen as the default multi-region strategy in
   place of a rationally selected secondary region. Where a non-paired region
   better meets latency, capacity, or cost requirements, it is preferred.
4. **Non-paired multi-region is acceptable** for Active/Active scenarios where
   geographic load balancing or latency targets drive region selection. The
   rationale MUST be documented in the SAD.
5. **Recovery pattern selection:** The recovery pattern (Active/Active,
   Active/Passive, Warm Standby, Pilot Light) MUST be selected based on the
   application Tier and documented in the SAD alongside the RTO/RPO targets.
6. **Zone-redundant SKUs:** Where CPF modules expose a `zone_redundant` or
   `availability_zones` parameter, it MUST be enabled for all Tier 1–3
   workloads. Tier 4–5 workloads SHOULD enable it where cost permits.
## Migration Treatment (R-Type) Rules
### Migration-First Design Principle (NON-NEGOTIABLE)
The primary driver of every LMP solution design is **migration**, not
modernization. Designs MUST preserve the application's existing operational
model unless there is a documented SAD commitment or an R-Type treatment that
explicitly requires architectural change. Proposing a new technology,
architecture layer, or deployment model (e.g., containers, microservices,
event-driven patterns) that did not exist in the source environment requires
explicit justification aligned to the R-Type constraints below.
### R-Type Treatment Definitions
The R-Type is determined during the **Discovery phase** and documented in the
**Discovery Report** (ADO Application Discovery & Assessment report). It is
then recorded in LeanIX as a tag (`Cloud Strategy 7Rs`) and referenced in the
SAD. The SAD does **not** define the R-Type — it inherits it from the Discovery
Report. All design proposals MUST stay within the boundaries of the R-Type
established in the Discovery Report.
| R-Type | Definition | Permissible Scope |
|--------|-----------|-------------------|
| **Rehost** | Migrate to Azure IaaS with no architectural changes. Infrastructure relocation only. | None — preserve current design. Simple/medium DBs may move to homogeneous PaaS (no code refactoring). Complex DBs remain on IaaS. |
| **Replatform** | Migrate to Azure with minimal architectural changes. Modernize underlying components without redesigning the application. | OS, DB engine, and application framework version upgrades to highest supported version. Direct-equivalent managed service adoption (Kafka → Event Hubs, JMS → Service Bus). Migration of existing non-Kubernetes containers (EKS, Rancher) to AKS. |
| **Refactor** | Code and configuration changes for cloud compatibility. Core application logic and overall structure remain intact. No new architectural components or features. | OS conversion, DB engine conversion to PaaS, adoption of Azure Managed PaaS services and/or containers, automated recovery and scaling. Messaging redesign where substantial code change is required to leverage cloud-native capabilities. |
| **Rearchitect** | Fundamentally redesign the application architecture to optimize for cloud. Significant structural changes beyond code tweaks. No new business features — focus is structural modernization and cloud compatibility only. | Microservices decomposition, new auth/authz frameworks (OAuth2), integration layer redesign, component migration to a modern language. |
### Container Adoption Rule
**Applications that do not currently run on containers MUST NOT be proposed
for containerization (AKS) unless the assigned R-Type is Refactor or
Rearchitect AND a documented business case demonstrates significant benefit in
at least two of the following dimensions:**
- **Cost**: Quantified TCO reduction ≥ 20% over 3 years vs. the
  non-containerized Azure alternative.
- **Reliability**: Measurable improvement in SLA/RTO/RPO that cannot be
  achieved via zonal-redundant PaaS or VM Scale Sets.
- **Scalability**: Application requires elastic horizontal scaling beyond what
  Azure Functions, App Service, or VM Scale Sets can provide.
Where containerization is proposed for a non-container source application, a
formal ADR deviation request MUST be raised and approved by architecture
governance before inclusion in the SAD or IaC scaffolding.
For **Rehost** and **Replatform** treatments, containerization of a
non-container source workload is **prohibited** without architecture governance
approval.
### Treatment-Aligned Design Rules
The following rules govern the generation of specs, plans, and IaC for each
R-Type treatment.
#### Rehost
- IaaS VM CPF patterns are the default compute target.
- PaaS compute (Functions, App Service, AKS) MUST NOT be proposed as primary
  hosting.
- Homogeneous PaaS DB migration (same engine) is permitted for simple/medium
  complexity; complex DBs remain on IaaS.
- No OS conversion; no framework version uplift beyond what Azure requires
  for the migration.
- Uplift scope: security baseline, IaC deployment pipelines, observability,
  PAM, HA/DR, workload right-sizing.
#### Replatform
- IaaS VM remains the default compute unless the source already uses
  containers (EKS/Rancher → AKS is permitted).
- OS, DB engine, and application framework MUST be upgraded to the highest
  supported version if the current version is out of general support.
- Direct-equivalent managed service adoption is permitted with minimal code
  change (Kafka → Event Hubs; JMS → Service Bus; Hadoop/Spark → HDInsight).
- Uplift scope: all Rehost items PLUS OS/DB/framework version upgrades and
  managed service adoption.
#### Refactor
- PaaS (Azure Functions, App Service) and containerization (AKS) are
  permitted compute targets — subject to the Container Adoption Rule above.
- DB engine conversion to an Azure PaaS equivalent is permitted.
- OS conversion is permitted where required for PaaS or container hosting.
- Automated recovery and scaling MUST be implemented.
- Messaging redesign is permitted when substantial code change is required
  to adopt cloud-native capabilities.
- Uplift scope: all Replatform items PLUS application architecture changes,
  automated scaling.
#### Rearchitect
- New architectural components, microservices decomposition, and framework
  replacement are in scope.
- New auth/authz frameworks (e.g., OAuth2) are in scope.
- Integration layer redesign and new interaction patterns are in scope.
- No new business features — any business feature additions MUST be flagged
  as out of scope and tracked separately in ADO.
- Uplift scope: all Refactor items PLUS structural modernization, source code
  overhaul.
### Treatment Uplift Scope Reference
| Uplift Activity | Rehost | Replatform | Refactor | Rearchitect |
|----------------|:------:|:----------:|:--------:|:-----------:|
| Security baseline (Foundation + MEC) | ✅ | ✅ | ✅ | ✅ |
| Privileged Access Management | ✅ | ✅ | ✅ | ✅ |
| IaC deployment pipelines | ✅ | ✅ | ✅ | ✅ |
| Observability (Datadog / BigPanda) | ✅ | ✅ | ✅ | ✅ |
| HA / DR | ✅ | ✅ | ✅ | ✅ |
| Workload right-sizing | ✅ | ✅ | ✅ | ✅ |
| OS version upgrade | — | ✅ | ✅ | ✅ |
| DB engine version upgrade | — | ✅ | ✅ | ✅ |
| Application framework upgrade | — | ✅ | ✅ | ✅ |
| Managed service adoption (direct equivalent) | — | ✅ | ✅ | ✅ |
| OS conversion | — | — | ✅ | ✅ |
| DB engine conversion (different engine → PaaS) | — | — | ✅ | ✅ |
| Application architecture change | — | — | ✅ | ✅ |
| Containerization (non-container source) | ❌ | ❌ | ⚠️ | ⚠️ |
| Automated recovery & scaling | — | — | ✅ | ✅ |
| Microservices decomposition | — | — | — | ✅ |
| Auth framework replacement (OAuth2) | — | — | — | ✅ |
| Source code structural overhaul | — | — | — | ✅ |
⚠️ Permitted only with documented business case (≥2 of: cost/reliability/scalability) and architecture governance approval.
### Migration Design Requirements
Every application migration SAD and spec MUST include explicit design decisions
for cutover strategy, migration validation, and rollback. These are
**architectural commitments** that shape IaC, pipeline design, and go-live
readiness criteria — not operational runbook items deferred to execution.
#### Cutover Pattern Selection
| Pattern | Description | RPO Suitability | Permitted R-Types |
|---------|-------------|:---------------:|:-----------------:|
| **Full Load** | All data copied in a single migration run; source decommissioned after validation sign-off. | Tier 4–5 (RPO > migration window acceptable) | All R-Types |
| **Full Load + Cutover Delta** | Full baseline copy, followed by a targeted sync of changes accrued since baseline capture, minimizing the go-live data gap. | Tier 2–3 (near-zero RPO required; window must be short) | All R-Types |
| **CDC Continuous Replication** | Live replication via Change Data Capture (Oracle GoldenGate, Azure DMS ongoing) until cutover is confirmed; near-zero data loss. | Tier 1–2 (near-zero RPO mandatory) | Refactor, Rearchitect only |
Cutover pattern selection MUST align with the application Tier's RPO
requirement (see Resiliency Architecture — LSEG Business Criticality Tiers)
and MUST be documented in the SAD.
All migration data transfers MUST use private network connectivity
(ExpressRoute, Site-to-Site VPN, or Private Endpoint) or TLS 1.2+
encrypted channels. Unencrypted migration channels are prohibited.
#### Migration Validation (Required in Design)
The SAD MUST define the validation approach — not defer it to execution.
Required design elements:
1. **Pre-migration baseline** — measurable source-state snapshot (row counts,
   checksums, data-volume metrics) captured before migration begins. Defines
   the acceptance target for post-migration verification.
2. **Post-migration validation** — the method and acceptance criteria for
   confirming data completeness and integrity at the target. MUST reference
   the baseline.
3. **Functional smoke test** — at least one application-level test that
   exercises migrated data end-to-end to confirm the target service is
   operational before cutover is declared successful.
4. **Validation sign-off owner** — the application team lead is the named
   sign-off owner. Source decommissioning MUST NOT begin until sign-off
   is formally confirmed.
For Tier 1–2 applications, validation steps 1–3 MUST be automated and
executed as pipeline stages with results published as artefacts.
#### Rollback Strategy (Required in Design)
Every migration design MUST include a rollback strategy as a first-class
design element. The SAD MUST specify:
- **Rollback trigger** — the condition or failure threshold that initiates
  rollback (e.g., validation failure rate, functional smoke test failure,
  SLA breach during cutover window).
- **Rollback method** — how the source environment is restored to service
  (e.g., re-enable source database, revert DNS, replay from backup).
- **Rollback RTO** — the time required to restore source service. MUST be
  within the application's Tier RTO (see Resiliency Architecture).
- **Data divergence handling** — how data written to the target during a
  failed cutover window is reconciled, discarded, or merged back to source.
For Tier 1–2 migrations, the rollback strategy MUST keep the source
environment live and fully operational in parallel with the target until
validation sign-off is confirmed. Source decommissioning is a separate,
post-sign-off activity and MUST NOT be conflated with cutover.
## Security & Compliance Requirements
### Pre-Production Gate (MEC)
Every application MUST pass all 30 MEC controls before production
entry. Key gate items:
| MEC Control | Requirement |
|-------------|-------------|
| MEC-V3_2-1 | WAF deployed for internet-facing services |
| MEC-V3_2-2 | Trust boundaries and network segmentation |
| MEC-V3_2-3 | CrowdStrike anti-malware agent deployed |
| MEC-V3_2-4 | Qualys vulnerability scanning enabled |
| MEC-V3_2-14 | TLS encryption in transit |
| MEC-V3_2-19 | Workforce SSO authentication |
| MEC-V3_2-21 | SailPoint access certification |
| MEC-V3_2-22 | Privileged Access Management |
| MEC-V3_2-25 | Encryption at rest |
| MEC-V3_2-28 | SIEM log collection |
| MEC-V3_2-29 | GSOC alert registration |
| MEC-V3_2-30 | Penetration testing completed |
### SCF Control Tiers
| Tier | Applicability |
|------|---------------|
| **Foundation** | Mandatory for ALL production Landing Zone workloads (SCF-IAM-01 through SCF-RES-01) |
| **Standard** | Required for workloads handling restricted data (SCF-IAM-06, SCF-SEC-01/02, SCF-NETW-02/03/04) |
| **Landing Zone** | Required for all Landing Zone workloads (SCF-TVM-01, SCF-DATA-01/02/03) |
| **Sandbox** | Required for sandbox environments (SCF-SBX-01/02/03) |
| **Advanced** | For workloads with elevated risk profiles |
### CPF Security Controls
Every Azure service provisioned MUST comply with the CPF clearlist
mandatory controls (`azure-clear-listing-main`) including:
- Mandatory SKU selections
- Private Endpoint requirements
- Customer-Managed Key (CMK) requirements where specified
- Managed Identity requirements
- Diagnostic log forwarding requirements
## Data Governance Rules
- Data classification MUST be applied to all data stores (MEC-V3_2-26).
- Highly Restricted data stores MUST have resource audit logs enabled
  (SCF-AUD-02).
- Data Backup MUST be implemented per MEC-V3_2-27; Recovery Services
  Vault or Data Protection Backup Vault via CPF modules.
- Data retention MUST comply with the LSEG Data Retention Standard.
- Content segmentation and entitlements MUST follow LMP-PAT-0052.
- SFTP file transfer MUST follow the Secure File Transfer pattern
  (LMP-PAT-0049).
- No PII in logs, metrics, or telemetry; pseudonymize or hash where
  PII is unavoidable.
## Operational & Reliability Expectations
### Mandatory Run Obligations
| Obligation | Frequency | CSMC Control |
|------------|-----------|--------------|
| Review access logs | Daily | SMCF-SEC-05 |
| Review Azure Monitor alerts | Daily | SMCF-OPS-03 |
| Review Azure Policy compliance | Weekly | SMCF-GOV-10 |
| Monitor Defender for Cloud secure score | Weekly | SMCF-SEC-02 |
| Monitor for unsafe secret storage | Weekly | SMCF-SEC-03 |
| Conduct access certification reviews | Monthly | SMCF-SEC-05 |
| Review cost reports and budgets | Monthly | SMCF-FIN-02/03 |
| Apply critical/security OS patches (VMs) | Monthly | SMCF-OPS-09 |
| Review cost optimization opportunities | Monthly | SMCF-FIN-04 |
| Review tagging compliance | Quarterly | SMCF-GOV-03 |
| Review regulatory compliance posture | Quarterly | SMCF-OPS-04 |
| Patch AKS clusters | Quarterly | SMCF-OPS-09 |
| Review license inventory | Quarterly | SMCF-OPS-10 |
| Test BCDR plan | Annually | SMCF-OPS-06 |
| Conduct penetration testing | Annually | SMCF-SEC-04 |
### Incident Management
- Cloud incidents MUST follow the standard incident management process
  with post-incident reviews (SMCF-OPS-01).
- Security incidents MUST engage GSOC; post-incident reviews are
  mandatory (SMCF-SEC-01).
- All systems MUST be capable of credential rotation within 5 minutes
  of a GSOC request.
### Reliability Standards
- BCDR plan MUST define RTO, RPO, and SLA per application.
- Resiliency design MUST follow the Tier-to-Deployment-Model Mapping and
  Mandatory Resiliency Design Rules in **Resiliency Architecture** (see
  Architecture & Integration Rules). AZs first; multi-region when Tier
  demands it; paired regions only when strictly required.
- Regional failover designs per LMP-PAT-0031; Azure Site Recovery
  per LMP-PAT-0063.
- Capacity reservations for critical workloads per LMP-ADR-0025.
- CSP roadmap MUST be reviewed quarterly (SMCF-OPS-05).
## Team Responsibilities & Decision Boundaries
### RACI Model (CSMC)
| Activity | Foundation/Platform Team | Application/DevOps Team |
|----------|--------------------------|------------------------|
| Landing Zone provisioning | **Build** | Validate alignment |
| Security baseline (Azure Policy) | **Build** | Comply |
| Datadog/BigPanda onboarding | Shared (LMP-ADR-0010) | Shared (LMP-ADR-0010) |
| Access reviews and certification | Support | **Run** (monthly) |
| Secret rotation programme | Support | **Run** |
| Cost reporting and optimization | Support | **Run** (monthly) |
| BCDR plan and test execution | Support | **Run** (annually) |
| Penetration testing | Support | **Run** (annually, via approved supplier) |
| Incident response | Escalation | **Run** (GSOC engagement) |
| Vulnerability remediation | Support | **Run** (per LSEG Vulnerability Standard) |
### Decision Boundaries
- **Platform team** owns: Landing Zone design, network topology,
  Azure Policy, CPF module lifecycle, clearlist approvals.
- **Application teams** own: Application architecture (within approved
  patterns), data models, business logic, CI/CD pipelines, operational
  runbooks, and all CSMC run obligations.
- **Architecture governance** owns: ADR approvals, pattern reviews,
  exception requests, and constitution amendments.
- Technology selection beyond approved ADRs MUST be escalated to
  architecture governance for a new ADR.
## Change Management & Versioning
This section governs how the Constitution itself evolves,
how architectural changes are tracked, and how version control
is applied across the programme.
### Constitution Amendment Procedure
1. Propose amendment via a merge request to this file with rationale.
2. Architecture governance reviews the proposal.
3. Approved changes are merged; constitution version incremented per
   Semantic Versioning (MAJOR for principle removals/redefinitions,
   MINOR for additions/expansions, PATCH for clarifications).
4. Affected teams are notified; migration plan provided for breaking
   changes.
5. Dependent templates (plan, spec, tasks) are reviewed for sync.
### Constitution Versioning Policy
- This Constitution follows Semantic Versioning: MAJOR.MINOR.PATCH.
- Every amendment MUST update both the version number and the
  Last Amended date.
- The Sync Impact Report (HTML comment at top of file) MUST be
  updated with each amendment.
- Previous Sync Impact Reports MUST be preserved in the comment
  block for audit trail.
### Architecture Decision Versioning
- ADRs are immutable once published; superseded ADRs are marked
  as such with a link to the replacement.
- Patterns follow the same lifecycle: Published → Superseded (with
  replacement reference) or Draft → Published.
- CPF modules follow SemVer; `azure-clear-listing-main` CHANGELOG
  tracks all clearlist changes (v0.1.0 → current).
### Release & Deployment Versioning
- All application releases MUST use Semantic Versioning.
- Conventional Commits MUST be used for automated changelog
  generation.
- Git tags MUST be applied per the DevSecOps tagging convention.
- Artifact promotion follows DEV → QA → PPE → PROD with gates
  at each stage.
## Governance
This Constitution supersedes team-specific practices where conflicts
arise. All merge requests, architecture reviews, and design documents
MUST verify compliance with this Constitution.
### Compliance Review
- All feature specs, implementation plans, and task lists MUST
  reference this Constitution at the "Constitution Check" gate.
- Non-compliance MUST be documented as a deviation with explicit
  justification and governance approval.
- Azure Policy compliance (SMCF-GOV-10) serves as automated
  runtime enforcement of infrastructure-level constitution rules.
### Adaptability
This Constitution is designed to evolve with the programme:
- Core principles (I–X) represent stable, long-term commitments.
  Changing a core principle requires MAJOR version increment and
  programme-wide impact assessment.
- Global constraints, architecture rules, and operational tables
  are updated as new ADRs are published, patterns are added, or
  framework versions change. These require MINOR version increments.
- Glossary terms and editorial corrections require PATCH increments.
- Source frameworks (SCF, CSMC, MEC, CPF) are versioned independently;
  when a source framework publishes a new version, this Constitution
  MUST be reviewed for alignment within 30 days.
## Glossary of Normalized Terms
| Term | Definition |
|------|-----------|
| **ADR** | Architecture Decision Record — documented rationale for a technology or design choice (LMP-ADR-XXXX) |
| **CPF** | Cloud Product Framework — the approved Terraform module catalogue and Azure service clearlisting process |
| **Clearlist** | The CPF-approved registry of Azure services with mandatory security controls |
| **CSMC** | Cloud Service Management Control Framework — operational run-task controls (SMCF-*) |
| **DXOne** | LSEG's GitLab-based CI/CD platform |
| **GSOC** | Global Security Operations Centre — security incident response team |
| **Landing Zone** | An Azure subscription environment conforming to LSEG Foundation standards |
| **LMP** | LSEG Migration Programme — the programme migrating workloads to Azure |
| **MEC** | Cyber Minimum Entry Criteria — the 30-control pre-production security gate |
| **Pattern** | A published LMP architecture pattern (LMP-PAT-XXXX) |
| **SailPoint** | Identity governance platform for access certification |
| **SCF** | Security Control Framework — threat-driven security control objectives (SCF-*) |
| **SIEM** | Security Information and Event Management — centralized security log analysis |
| **Spoke** | An application-specific Azure VNet in the hub-spoke network topology |
## Source Document Appendix
Traceability cross-reference mapping each constitution section to its
authoritative source documents.
| Constitution Section | Source Document(s) | Location |
|---------------------|--------------------|---------|
| **I. Security-First** | SCF v6 (Chapters 5–6), MEC v3.2.0.2, CSMC v4 (Sec. 11 SMCF-SEC-*) | `Inputs/SCF/`, `Inputs/MEC/`, `Inputs/CSMC/` |
| **II. Approved Services Only** | CPF Clearlisting, SMCF-GOV-06 | `Inputs/azure-clear-listing-main/`, `Inputs/CSMC/` |
| **III. Infrastructure as Code** | SCF-RES-01, SMCF-GOV-09, DevSecOps IaC guide | `Inputs/SCF/`, `Inputs/CSMC/`, `Inputs/DevSecOps-Checklist/iac/` |
| **IV. Identity & Least Privilege** | SCF-IAM-01 through IAM-06, SMCF-SEC-05, MEC 6.3–6.5, 10.1 | `Inputs/SCF/`, `Inputs/CSMC/`, `Inputs/MEC/` |
| **V. Secrets Management** | SCF-IAM-04, SMCF-SEC-03, MEC 6.1, MEC 12.2 | `Inputs/SCF/`, `Inputs/CSMC/`, `Inputs/MEC/` |
| **VI. Encryption Everywhere** | SCF-DATA-01 through DATA-03, MEC-V3_2-14, MEC-V3_2-25 | `Inputs/SCF/`, `Inputs/MEC/` |
| **VII. Observability by Default** | LMP-ADR-0003, LMP-ADR-0004, LMP-ADR-0010, LMP-ADR-0011, SCF-AUD-01/02, SCF-SEC-03 | `Inputs/ADRS/event-management/`, `Inputs/SCF/` |
| **VIII. Architecture Governance** | ADRs (LMP-ADR-0001–0025), Patterns Library (80 patterns), SMCF-GOV-07, SMCF-OPS-06 | `Inputs/ADRS/`, `Inputs/patterns/`, `Inputs/CSMC/` |
| **IX. DevSecOps Discipline** | DevSecOps Checklist (all sections), LMP-ADR-0016, SMCF-OPS-08 | `Inputs/DevSecOps-Checklist/`, `Inputs/ADRS/deployment-and-administration/`, `Inputs/CSMC/` |
| **X. Cost Governance** | SMCF-FIN-01 through FIN-04, SMCF-GOV-03, API Strategy slides 10–13/33 | `Inputs/CSMC/`, `Inputs/API Strategy/` |
| **Global Constraints** | Azure Guidance (Regions, Networking), LMP-ADR-0001 through 0018, DevSecOps naming | `Inputs/Azure Guidance And Rules/`, `Inputs/ADRS/`, `Inputs/DevSecOps-Checklist/conventions/` |
| **Architecture & Integration Rules** | API Strategy (slides 3–40), Patterns Library (network, databases, service-delivery), CPF modules | `Inputs/API Strategy/`, `Inputs/patterns/`, `Inputs/cpf/` |
| **Migration Treatment (R-Type) Rules** | LSEG R-Type Treatment Definitions (Rehost/Replatform/Refactor/Rearchitect guidance), LMP ADRs | LSEG Migration Programme governance documentation |
| **Security & Compliance Requirements** | MEC v3.2.0.2 (30 controls), SCF v6 (Chapter 5 tiers), CPF clearlist controls | `Inputs/MEC/`, `Inputs/SCF/`, `Inputs/azure-clear-listing-main/` |
| **Data Governance Rules** | SCF-AUD-02, MEC-V3_2-26/27, LMP-PAT-0049/0052, LSEG Data Retention Standard | `Inputs/SCF/`, `Inputs/MEC/`, `Inputs/patterns/data-management/` |
| **Operational & Reliability Expectations** | CSMC v4 (Sections 9–12), LMP-PAT-0031/0063, LMP-ADR-0025 | `Inputs/CSMC/`, `Inputs/patterns/business-continuity-disaster-recovery/`, `Inputs/ADRS/infrastructure/` |
| **Team Responsibilities** | CSMC v4 RACI (Build/Run), LMP-ADR-0010 (Datadog/BigPanda RACI) | `Inputs/CSMC/`, `Inputs/ADRS/event-management/` |
| **Change Management & Versioning** | DevSecOps Checklist (conventions, artifact management), CPF CHANGELOG | `Inputs/DevSecOps-Checklist/conventions/`, `Inputs/azure-clear-listing-main/CHANGELOG.md` |
| **Glossary** | All source documents (normalized terminology) | All `Inputs/` subfolders |
### Source Framework Versions
| Framework | Version | Date | Location |
|-----------|---------|------|---------|
| SCF | v6 (WIP) | 2026-03-19 | `Inputs/SCF/Security Control Framework - WIP-v6-20260319_140103.md` |
| CSMC | v4 | 2026-03-19 | `Inputs/CSMC/Cloud-Service-Management-Control-Framework Controls [ADO Wiki Import]-v4-20260319_135733.md` |
| MEC | v3.2.0.2 | 2024-09 | `Inputs/MEC/CyberMinimumEntryCriteria-v3_2_0_2-FINAL.xlsx` |
| CPF Clearlist | v1.1.1 | See CHANGELOG | `Inputs/azure-clear-listing-main/CHANGELOG.md` |
| ADRs | LMP-ADR-0001–0025 | 2023-11 to 2025-08 | `Inputs/ADRS/` (11 subfolders) |
| DevSecOps Checklist | Current | N/A | `Inputs/DevSecOps-Checklist/` (9 subfolders) |
| Patterns Library | 80 patterns (70 Published) | 2024-05 to 2025+ | `Inputs/patterns/` (19 subfolders) |
| API Strategy | v0.3 | Q1 2024 | `Inputs/API Strategy/D&A API Strategy - LMP SIAs & Migrations.pptx` |
| Azure Guidance | Current | N/A | `Inputs/Azure Guidance And Rules/` (6 pages) |
**Version**: 1.6.0 | **Ratified**: 2026-03-25 | **Last Amended**: 2026-04-14