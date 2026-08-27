---
name: generate-cpf-schemas
description: "Regenerate the CPF JSON schema catalog from CPF module index.md files. USE FOR: regenerate CPF schemas, update CPF catalog, refresh module schemas, run Generate-CpfSchemas, update cpf-schemas folder, new CPF module added, CPF module updated, rebuild schema catalog, cpf-schemas out of date, module version changed, add new CPF module to catalog. DO NOT USE FOR: generating IaC code (use /generate-iac-scaffolding), extracting a SAD document (use /extract-sad-to-markdown), looking up a CPF module (ask @cpf-genie or read cpf-schemas/)."
argument-hint: "Optional: -CpfRoot path if CPF source is outside the repo"
---

# Generate CPF Schemas

Runs `scripts/Generate-CpfSchemas.ps1` to parse every CPF module's `index.md` and rebuild the
JSON schema files in `templates/cpf-schemas/`. These schemas are the source of truth the agent
reads during `/map-cpf-modules` to identify module inputs, outputs, and source URLs.

Re-run this skill whenever:
- A new CPF module is added to the library
- A CPF module's version, inputs, or outputs change
- The `templates/cpf-schemas/` folder is missing or stale

## When to Use

- User says "regenerate CPF schemas", "update the catalog", "CPF module was updated", "refresh schemas"
- `/map-cpf-modules` produces incorrect or outdated module information
- A new CPF module folder has been added under `templates/cpf/`
- `_catalog.json` is missing from `templates/cpf-schemas/`

## Prerequisites

- **PowerShell 7+** (`pwsh`)

Verify:
```powershell
pwsh --version   # needs 7.0+
```

## Inputs

| Source | Default location | Notes |
|---|---|---|
| CPF module folders | `<toolkit-repo>/templates/cpf/` | Each sub-folder must contain `index.md` |
| Output dir | `<toolkit-repo>/templates/cpf-schemas/` | Created automatically if it doesn't exist |

## Procedure

### 1. Check the CPF source folder

Confirm the CPF module folders exist:

```
<toolkit-repo>/templates/cpf/
├── cpf-azure-prdsvc-keyvault/
│   └── index.md
├── cpf-azure-prdsvc-storageaccount/
│   └── index.md
└── ...
```

If `templates/cpf/` is empty or missing, the CPF source files need to be placed there before running.
Ask the user:
> "`templates/cpf/` appears to be empty. Please copy the CPF module folders there and try again."

### 2. Run the schema generator

**Default** — paths auto-resolved relative to the script; run from anywhere:

```powershell
pwsh scripts/Generate-CpfSchemas.ps1
```

**Override CPF source** (if CPF files live outside the repo, e.g. a shared TaaS drive):

```powershell
pwsh scripts/Generate-CpfSchemas.ps1 `
  -CpfRoot   "D:\TaaS-Share\Templates\cpf" `
  -OutputDir ".\templates\cpf-schemas"
```

**All parameters:**

| Parameter | Description | Default |
|---|---|---|
| `-CpfRoot` | Folder containing CPF module sub-folders (each with `index.md`) | `<toolkit-repo>/templates/cpf/` |
| `-OutputDir` | Folder where JSON schema files are written | `<toolkit-repo>/templates/cpf-schemas/` |

### 3. Monitor progress

The script prints one line per module processed:

```
[1/252] Processing: cpf-azure-prdsvc-keyvault
[2/252] Processing: cpf-azure-prdsvc-storageaccount
...
Done. Generated schemas in: templates\cpf-schemas
Total modules: 252 | Processed: 252 | Errors: 0
Catalog written: templates\cpf-schemas\_catalog.json
Version map written: templates\cpf-schemas\_version-map.json
```

If errors appear at the end, report them to the user with the affected module names.

### 4. Verify outputs

After a successful run the output directory should contain:

```
templates/cpf-schemas/
├── _catalog.json            ← master index (total_modules, list of all cpf_id entries)
├── _version-map.json        ← flat cpf_id → { version, pinned_source } lookup
├── cpf-azure-prdsvc-keyvault.json
├── cpf-azure-prdsvc-storageaccount.json
└── ...                      ← one .json per module
```

Spot-check a schema to confirm it has populated inputs:

```powershell
Get-Content templates\cpf-schemas\cpf-azure-prdsvc-keyvault.json | ConvertFrom-Json | Select-Object cpf_id, module_name, latest_tag
```

### 5. Handle common errors

| Symptom | Cause | Fix |
|---|---|---|
| `SKIP (no index.md): <folder>` | Module folder exists but has no `index.md` | Add `index.md` for that module or remove the empty folder |
| `Error processing <module>: ...` | Malformed `index.md` (encoding, truncated file) | Open the `index.md` and check for encoding issues |
| `inputs.required` is empty in a schema | `index.md` uses an unexpected table format | Inspect the raw markdown table headings in that module's `index.md` |
| Script exits immediately, no output | PowerShell < 7 or `pwsh` not on PATH | Install PowerShell 7+ from https://aka.ms/powershell |

### 6. Confirm and report

Tell the user how many schemas were generated and whether any errors occurred:

> "CPF schema catalog regenerated: **252 modules** processed, **0 errors**.
> `_catalog.json` and `_version-map.json` updated in `templates/cpf-schemas/`.
> You can now re-run `/map-cpf-modules` to pick up the latest module definitions."

## Output Reference

| File | Purpose | Consumed by |
|---|---|---|
| `templates/cpf-schemas/_catalog.json` | Master index — list of all modules with `cpf_id`, `module_type`, `latest_tag` | `/map-cpf-modules` agent, `cpf-genie` extension |
| `templates/cpf-schemas/_version-map.json` | Flat version lookup for quick `cpf_id → version` mapping | Downstream tooling, pipeline version checks |
| `templates/cpf-schemas/cpf-azure-*.json` | Full schema per module — inputs, outputs, source URL, usage example | `/map-cpf-modules`, `/generate-iac-scaffolding` |
