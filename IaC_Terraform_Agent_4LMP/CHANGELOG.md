# Changelog

All notable changes for `IaC_Terraform_Agent_4LMP` are tracked in this file.

## 1.1.0 - 2026-07-09

- Added `model` frontmatter to every prompt with role-appropriate recommendations and token optimization:
  - Design/orchestration (deep reasoning, long context, vision): `analyse-sad`, `map-cpf-modules` → Claude Opus 4.6 primary, Sonnet 4.6 fallback.
  - Planning/analysis sub-agents: `map-cpf-module-selection`, `map-cpf-lz-boundaries`, `map-cpf-migration-diff`, `map-cpf-dag-builder`, `map-cpf-plan-writer` → Claude Sonnet 4.6 primary, Opus 4.6 fallback.
  - Structured schema extraction: `map-cpf-schema-{networking,foundation,compute,data,ingress}` → Claude Sonnet 4.6 primary, GPT-5.3-Codex fallback.
  - Execution / Terraform code generation: `generate-iac-scaffolding` (+ `-multirepo`, `-microstack`) → Claude Sonnet 4.6 primary, GPT-5.3-Codex fallback (Opus 4.6 as 3rd fallback on the router only).
- Added a mandatory **CPF coverage validation gate** (`map-cpf-modules` Step 4c) that verifies every planned module maps to a real CPF schema in `templates/cpf-schemas/_catalog.json` before the DAG builder and plan writer run. Blocks plan generation on any coverage gap so the plan is deployable by construction.
- Added a `coverage_report` key to the `module-manifest.json` contract and a precondition guard in `map-cpf-plan-writer` that refuses to write `module-plan.md` for an unvalidated/uncovered manifest.
- Version bumps: `map-cpf-modules` 2.0.0 → 2.1.0 (minor: coverage gate), `map-cpf-plan-writer` 1.0.0 → 1.1.0 (minor: coverage precondition). All other prompts 1.0.0 → 1.0.1 (patch: model frontmatter only).
- Defines git tag usage for this release as `IaC_Terraform_Agent_4LMP/1.1.0`.
- Applies to all prompts under `.github/prompts/`:
  - `analyse-sad.prompt.md` (1.0.1)
  - `map-cpf-modules.prompt.md` (2.1.0)
  - `map-cpf-module-selection.prompt.md` (1.0.1)
  - `map-cpf-lz-boundaries.prompt.md` (1.0.1)
  - `map-cpf-migration-diff.prompt.md` (1.0.1)
  - `map-cpf-dag-builder.prompt.md` (1.0.1)
  - `map-cpf-plan-writer.prompt.md` (1.1.0)
  - `map-cpf-schema-networking.prompt.md` (1.0.1)
  - `map-cpf-schema-foundation.prompt.md` (1.0.1)
  - `map-cpf-schema-compute.prompt.md` (1.0.1)
  - `map-cpf-schema-data.prompt.md` (1.0.1)
  - `map-cpf-schema-ingress.prompt.md` (1.0.1)
  - `generate-iac-scaffolding.prompt.md` (1.0.1)
  - `generate-iac-scaffolding-multirepo.prompt.md` (1.0.1)
  - `generate-iac-scaffolding-microstack.prompt.md` (1.0.1)

## 1.0.0 - 2026-06-01

- Added `version` frontmatter to the IaC prompt artifacts.
- Standardized release tracking at the toolkit level instead of inline changelog sections.
- Defined git tag usage for this toolkit as `IaC_Terraform_Agent_4LMP/1.0.0`.
- Applies to:
  - `.github/prompts/analyse-sad.prompt.md`
  - `.github/prompts/map-cpf-modules.prompt.md`
  - `.github/prompts/generate-iac-scaffolding.prompt.md`
  - `.github/prompts/generate-iac-scaffolding-multirepo.prompt.md`
  - `.github/prompts/generate-iac-scaffolding-microstack.prompt.md`