# Naming Convention

This guide provides guidelines for naming conventions in DX1 GitLab. 

By following these naming conventions you can maintain a clean, organized, and standardized development environment within DX1. 

Happy coding! 

## Table of Contents
1. [General Naming Convention](#1-general-naming-convention)
1. [Naming Convention for Repository Names](#2-naming-convention-for-repository-names)
2. [Naming Convention for GitLab-CI Stage Names](#3-naming-convention-for-gitlab-ci-stage-names)
3. [Naming Convention for GitLab-CI Job Names](#4-naming-convention-for-gitlab-ci-job-names)
4. [Include Files Name Convention](#5-include-files-name-convention)

## 1. General Naming Convention

- Use hyphens (`-`) or underscores (`_`) instead of spaces
- Use lowercase characters only
- Do not start with a number or a special character


## 2. Naming Convention for Repository Names

When creating a DX1 repository, follow the [general naming convention](#1-general-naming-convention) with one exception:
- strict use of hyphens(`-`) instead of spaces

Example of valid ✅ repository names:
- `dx1-sample-repo` ✅
- `my-awesome-project` ✅
- `project-123` ✅

Example of NOT valid ❌ repository names:
- `dx1 sample repo` ❌
- `dx1_sample_repo` ❌
- `Dx1-Sample-Repo` ❌
- `DX1-SAMPLE-REPO` ❌
- `my_awesome-project` ❌
- `3 project-123` ❌
- `5_project-456` ❌
- `7-project-789` ❌
- `@_project-901` ❌

### Patterns
No pattern is mandatory as long as it respects the naming convention. Below are convention compliant examples that teams can use:
- `<project_name>-<component>`: `chatbot-backend` 
- `<organization_name>-<service>`: `lseg-authenticator`

## 3. Naming Convention for GitLab-CI Stage Names

When creating a pipeline using GitLab-CI in DX1, follow these naming conventions for stage names:
- Use lowercase letters only.
- Use hyphens (`-`) or undescores (`_`) instead of spaces.
- Stage names must not start with numbers or any special characters.
- Do not use underscores or capital letters or camel case.

Example of valid ✅ stage names:
- `build` ✅ 
- `test` ✅ 
- `deploy-to-staging` ✅ 
- `production-deploy` ✅ 
- `production_deploy` ✅ 

Example of NOT valid ❌ stage names:
- `dx1 sample stage` ❌
- `dx1_sample_stage` ❌
- `Dx1-Sample-Stage` ❌
- `4x1_sample_stage` ❌
- `$-Sample-Stage` ❌
- `MY-SAMPLE-STAGE` ❌

## 4. Naming Convention for GitLab-CI Job Names

When creating a pipeline using GitLab-CI in DX1, follow these naming conventions for job names:
- Use lowercase letters only.
- Use hyphens (`-`) or undescores (`_`) instead of spaces.
- Job names can start with numbers if the numbers are used to indicate the order the job runs (e.g., 0 is the first job to run, 1 is the second, etc.).
- Job names can't start with any special characters.
- Do not use underscores or capital letters or camel case.

Example of valid ✅ job names:
- `build-artifacts` ✅ 
- `0-setup-environment` ✅ 
- `1-run-tests` ✅ 
- `2-deploy-to-staging` ✅ 
- `2_deploy_to_staging` ✅ 

Example of NOT valid  ❌ job names:
- `build artifacts` ❌ 
- `0 setup-environment` ❌ 
- `-run-tests`  ❌ 
- `@-deploy-to-staging`  ❌ 
- `Camel-Case-Job-Name`  ❌ 
- `UPPER-CASE-JOB-NAME`  ❌ 
- `Camel_Underscore-Job-Name`  ❌ 
- `Camel_Underscore_Job_Name`  ❌ 

## 5. Include Files Name Convention

When creating templates to be included by other GitLab pipelines, adhere to the following conventions:
- Use lowercase letters only.
- Use hyphens (`-`) instead of spaces.
- Include files need to reside in a folder called `templates`.
- Avoid starting with numbers or special characters.
- Do not use underscores or capital letters or camel case.

Example of valid ✅ include file names:
- `templates/my-template.yml` ✅ 
- `templates/pipeline-config.yaml` ✅ 
- `templates/build-script.sh` ✅ 

Example of NON valid ❌ include file names:
- `templates/0my-template.yml`  ❌  
- `templates/3pipeline_config.yaml` ❌ 
- `templates/Build-Script.sh`  ❌ 
- `TEMPLATES/BUILD-SCRIPT.SH`  ❌ 
- `templates/@Build-Script.sh`  ❌ 
- `TEMPLATES/BUILD_SCRIPT.SH`  ❌ 
- `TEMPLATES/my-template.yml`  ❌


## 6. Git Branches
A good branch naming strategy allows the team to understand the purpose and ownership of each branch in the repository. This is best implemented together with a [branching strategy](BRANCHING_STRATEGIES.md).

**Examples**
- [Microsoft](https://microsoft.github.io/code-with-engineering-playbook/source-control/naming-branches/): 
  - pattern: `<user alias>/[feature/bug/hotfix]/<work item ID>_<title>`
    - example: *dickinson/feature/271_add_more_cowbell*
- [AWS](https://docs.aws.amazon.com/prescriptive-guidance/latest/choosing-git-branch-approach/branches-in-a-gitflow-strategy.html): 
  - pattern: `[feature/sandbox/bug/hotfix]/<story number>_<developer initials>_<descriptor>`
    - example: *feature/123456_MS_Implement_Feature_A*
  - pattern: `release/v{major}.{minor}`
    - example: *release/v1.0*


## 7. Merge Requests
1. Leverage the [commit style convention](COMMIT_CONVENTION.md) `<type>[optional scope]: <description>`
    - Example: *fix(auth-service): Add missing controller validation*
2. Include organizational and product data such as DBOR and Squad, Product Name, version
    - Example: *Hydration Blizzard <ProductName> v2: Add params file*
