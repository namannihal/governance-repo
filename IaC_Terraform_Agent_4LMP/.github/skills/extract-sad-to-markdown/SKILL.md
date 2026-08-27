---
name: extract-sad-to-markdown
description: "Convert a SAD .docx file to structured Markdown with embedded images and CPF module analysis. USE FOR: extract SAD, convert SAD to markdown, process SAD document, analyse SAD file, run Extract-SadToMarkdown, sad to md, parse SAD docx, extract architecture document, convert design doc to markdown, pre-process SAD before map-cpf-modules. DO NOT USE FOR: generating IaC code (use /generate-iac-scaffolding), mapping CPF modules (use /map-cpf-modules), regenerating CPF schemas (use /generate-cpf-schemas)."
argument-hint: "Optional flags: --arch <folder-with-docx>  --out <output-folder>"
---

# Extract SAD to Markdown

Converts an application Solution Architecture Document (SAD) `.docx` file into structured Markdown.
The output includes all document content, extracted diagrams, and a CPF Module Analysis section that
cross-references detected Azure services against the `templates/cpf-schemas/` catalog.

This is **Step 0** of the IaC scaffolding workflow — run it before `/analyse-sad` if the SAD
is still in `.docx` format.

## When to Use

- User has a SAD `.docx` and wants to run `/analyse-sad` but the file hasn't been converted yet
- User says "extract the SAD", "convert SAD to markdown", "process the SAD document", "run the SAD extractor"
- The `arch/` folder has no `sad-analysis.md` yet
- User wants to refresh the Markdown after the SAD is updated

## Prerequisites

```bash
pip install python-docx
```

Verify Python is available:
```bash
python --version   # needs 3.9+
```

## Inputs

| Source | Location | Notes |
|---|---|---|
| SAD `.docx` | `../arch/` (sibling folder next to app repo) | Drop any `.docx` here — script auto-discovers the first one |
| CPF schemas | `<toolkit-repo>/templates/cpf-schemas/` | Already present; no action needed |

## Procedure

### 1. Locate the SAD file

Check whether the SAD is already in place. The `arch/` folder is a **sibling** to the app repo
(i.e. `../arch` relative to the app repo root), matching the `.code-workspace` convention:

```
<workspace-parent>/
├── <app-repo>/          ← IaC code lives here (run the script from here)
├── arch/                ← ../arch — drop the SAD .docx here
│   └── <AppName>-SAD-v<version>.docx   ← expected location
└── IaC_Terraform_Agent_4LMP/  ← toolkit
```

If not found, ask the user:
> "I can't find a SAD `.docx` in `../arch/` (sibling folder next to your app repo). Please place your SAD file there, or provide the full path with `--sad`."

### 2. Run the extractor

Run from the **app repo root** (the script resolves all paths automatically):

```bash
# Default — SAD in ../arch/, output to ../arch/
python ../IaC_Terraform_Agent_4LMP/scripts/Extract-SadToMarkdown.py
```

To use a **custom input folder** (where the `.docx` lives):
```bash
python ../IaC_Terraform_Agent_4LMP/scripts/Extract-SadToMarkdown.py \
  --sad path/to/MyApp-SAD-v1.0.docx
```

To write outputs to a **custom output folder**:
```bash
python ../IaC_Terraform_Agent_4LMP/scripts/Extract-SadToMarkdown.py \
  --sad path/to/MyApp-SAD-v1.0.docx \
  --out path/to/output/sad-analysis.md
```

Additional flags:

| Flag | Effect |
|---|---|
| `--sad <path>` | Path to the SAD `.docx` (overrides auto-discovery) |
| `--out <path>` | Output `.md` file path (default: `../arch/sad-analysis.md`) |
| `--no-images` | Skip image extraction (faster, no `images/` folder created) |
| `--no-analysis` | Skip CPF module detection at end of output |
| `--schemas <path>` | Override schemas dir (default: `templates/cpf-schemas/`) |

### 3. Verify outputs

After a successful run, these files exist in the `../arch/` folder (sibling to the app repo):

```
<workspace-parent>/
├── <app-repo>/           ← IaC code (untouched)
└── arch/                 ← ../arch relative to app repo
    ├── sad-analysis.md          ← full Markdown document
    ├── sad-analysis-images.json ← figure index (machine-readable)
    └── images/
        ├── fig-001.png          ← embedded diagrams (one file per figure)
        └── ...
```

Confirm the run completed by checking the last few lines of console output — they report:
- Lines in document
- Images extracted (embedded + external LucidChart links)
- Azure services detected and their matched CPF modules

### 4. Handle errors

| Error message | Cause | Fix |
|---|---|---|
| `ERROR: python-docx is not installed` | Missing dependency | `pip install python-docx` |
| `ERROR: No SAD .docx file specified and none found automatically` | No `.docx` in `../arch/` | Place `.docx` there or use `--sad` |
| `ERROR: SAD file not found: <path>` | Path supplied via `--sad` doesn't exist | Check the path and re-run |
| Script runs but output is mostly empty | SAD uses non-standard styles | Review the raw `.docx` heading styles |

### 5. Hand off to the agent

Once `arch/sad-analysis.md` exists, tell the user:

> "Extraction complete. You can now run `/analyse-sad` in GitHub Copilot Chat to generate the structured requirements brief."

## Output Reference

| File | Purpose | Consumed by |
|---|---|---|
| `arch/sad-analysis.md` | Full Markdown of the SAD + CPF analysis | `/analyse-sad` agent prompt |
| `arch/sad-analysis-images.json` | JSON index of all figures (type, path, alt text) | Agent context during analysis |
| `arch/images/fig-NNN.*` | Extracted diagram images | Referenced inline in the Markdown |
