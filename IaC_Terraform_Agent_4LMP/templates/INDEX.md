# Templates — Master Index

> **For GitHub Copilot agents:** This is the navigation entry point for all shared
> knowledge in the `templates/` folder. Load **this file** first when you need to
> discover what reference material is available. Then load only the specific index
> or file you need — do not bulk-load individual files speculatively.
>
> **Loading strategy (GitHub Copilot best practice):**
> 1. Read this master index to understand what exists
> 2. Load the relevant category index (e.g. `adrs/INDEX.md`)
> 3. Load individual files only when the user requests full details

---

## Index Map

| Area | What it contains | Index file | When to use |
|------|-----------------|-----------|-------------|
| **ADRs** | 18 approved Architecture Decision Records across network, compute, monitoring, data | [adrs/INDEX.md](adrs/INDEX.md) | SAD analysis, IaC generation, technology selection |
| **Patterns** | 70+ LSEG LMP migration patterns: service topology, connectivity, DR, compute | [patterns/INDEX.md](patterns/INDEX.md) | SAD analysis, CPF module mapping, IaC design |
| **CPF Schemas** | 252 JSON schemas for CPF Terraform modules (auto-generated) | [cpf-schemas/_catalog.json](cpf-schemas/_catalog.json) | CPF module mapping (`/map-cpf-modules`) |
| **DevSecOps Checklist** | Security, CI/CD, IaC, repo management, conventions | [DevSecOps-Checklist/INDEX.md](DevSecOps-Checklist/INDEX.md) | IaC generation review, SAD analysis security check |
| **Platform Guides** | Networking topology, Azure regions, subscription onboarding, TCP guidance | [PLATFORM-GUIDES-INDEX.md](PLATFORM-GUIDES-INDEX.md) | Networking decisions, region selection, subnet CIDR planning |
| **Infrastructure Main** | Canonical Terraform project layout (reference implementation) | [infrastructure-main/](infrastructure-main/) | IaC scaffolding generation |
| **IaC Terraform Main** | Additional IaC reference examples | [iac_terraform-main/](iac_terraform-main/) | IaC scaffolding generation |
| **SAD Template** | Blank SAD template (reference only — NOT the app's actual SAD) | `LMP Migration SAD (v3.3) .docx` | SAD analysis orientation only |

---

## Area Summaries

### ADRs (`adrs/`)
18 Architecture Decision Records covering:
- **Network:** Azure Firewall for NAT/filtering (ADR-0005), reverse proxy = App Gateway (ADR-0015)
- **Monitoring:** Datadog mandatory (ADR-0003), OpenTelemetry for tracing (ADR-0004)
- **Compute:** DX1 shared runners mandatory (ADR-0016), capacity reservations for Tier-1 (ADR-0025)
- **Data:** Oracle GoldenGate for CDC (ADR-0018)
- **Platform:** Subscription tenancy model (ADR-0012)

→ **Quick rule:** All ADR rules are summarised in [adrs/INDEX.md](adrs/INDEX.md) — no need to open individual files.

### Patterns (`patterns/`)
70+ patterns across 19 categories. Key patterns for IaC work:
- **Functions:** LMP-PAT-0001 (Lambda→Functions), LMP-PAT-0056 (Functions service pattern)
- **Databases:** LMP-PAT-0014 (PostgreSQL), LMP-PAT-0015 (Redis), LMP-PAT-0010 (Oracle on VM)
- **Containers:** LMP-PAT-0018 (AKS), LMP-PAT-0058 (AKS+Redis+PostgreSQL full stack)
- **Networking:** LMP-PAT-0023 (private DNS), LMP-PAT-0026 (ZPA non-prod access)
- **BCDR:** LMP-PAT-0031 (region failover), LMP-PAT-0063 (ASR)
- **Messaging:** LMP-PAT-0099 (messaging decision matrix, current reference)

→ **Pattern-to-CPF module map** is in [patterns/INDEX.md](patterns/INDEX.md).

### CPF Schemas (`cpf-schemas/`)
252 JSON schemas — one per CPF Terraform module. Structure:
```
cpf-schemas/
├── _catalog.json                    ← master index: module name → source URL → schema file
└── cpf-azure-<type>-<name>.json    ← per-module: required_inputs, optional_inputs, outputs
```
`_catalog.json` is the **only file** you need to load first. Then load the specific `cpf-azure-*.json` for a module's full input list.

### DevSecOps Checklist (`DevSecOps-Checklist/`)
9 categories of DevSecOps rules. **IaC-impacting categories (load during generation):**
- `iac/TERRAFORM_STATE_MANAGEMENT.md` — state management best practices
- `security/SECURITY_PRACTICES.md` — secret management, SCF, Cyber MEC
- `cicd/PIPELINE_CONFIGURATIONS.md` — GitLab CI patterns

→ **Condensed evaluation checklist** in [DevSecOps-Checklist/INDEX.md](DevSecOps-Checklist/INDEX.md).

### Platform Guides (`SitePages*/`)
Raw SharePoint page exports. Contain important platform facts but noisy HTML.
→ **Use the summaries in [PLATFORM-GUIDES-INDEX.md](PLATFORM-GUIDES-INDEX.md) — do not load raw SitePages files.**

---

## Agent Decision Flow

```
User request
     │
     ├─ "analyse SAD"          → Load: adrs/INDEX.md + patterns/INDEX.md
     │                                 (identify applicable ADRs and patterns)
     │                                 + DevSecOps-Checklist/INDEX.md (security check)
     │
     ├─ "map CPF modules"      → Load: cpf-schemas/_catalog.json
     │                                 (then specific cpf-azure-*.json per service)
     │                                 + patterns/INDEX.md (pattern-to-module map)
     │
     ├─ "generate IaC"         → Load: infrastructure-main/ (canonical layout)
     │                                 + DevSecOps-Checklist/INDEX.md (mandatory pre-flight)
     │                                 + adrs/INDEX.md (quick-reference rules)
     │
     └─ "networking/regions"   → Load: PLATFORM-GUIDES-INDEX.md
```
