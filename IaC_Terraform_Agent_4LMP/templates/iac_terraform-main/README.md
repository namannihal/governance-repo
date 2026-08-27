# iac_terraform

This repository contains the Infrastructure-as-Code (IaC) pipeline configuration for DXOne (GitLab). The pipeline includes various IaC stage gates for linting, security checks, and formatting. These stages ensure that the IaC code adheres to best practices and security standards before deployment.

## Getting Started - Availability of Automatic Merge Request 

Once IaC project scaffolding is completed for your DXOne group, you should see an open merge request created as part of the initialization of the project (repository) in your DXOne group. Please click that open MR and get it approved from default approvers. If you want to add additional approvers, navigate to project **settings** > **Merge request approvals** > Edit **mr_approvers** > Add **Users** > Click on **Update approval rule**

## Overview of the DXOne (GitLab) pipeline

This IaC DXOne (GitLab) pipeline contains stages such as iac-gates, approve, deploy, destroy and unlock.

The **iac-gates** is used to thoroughly validate the terraform manifests and secure before deployment to any environment.

The **approve** is to control who is 'Allowed to deploy' and approvers for the pipeline. Approvers and allowed to deploy can vary across environments. By default, approval is not required for the development environment, but it can be overridden if needed. 

The **deploy** stage retrieves secrets from the Hashicorp vault and makes them available to deploy the Azure resources on the target Azure subscription. Please note that secrets are retrieved according to the environment specified.

The **destroy** stage retrieves secrets from the Hashicorp vault and makes them available to destroy the Azure resources on the target Azure subscription. Please note that secrets are retrieved according to the environment specified.

The **unlock** stage retrieves secrets from the Hashicorp vault and makes them available to unlock the Terraform state file if it is stuck in a locked state. It ensures that subsequent Terraform operations can proceed without being blocked by an existing lock. Please note that secrets are retrieved according to the environment specified.

## Pipeline Stages and Jobs

### IaC Stage Gates
The IaC stage gates are responsible for validating the IaC code. The gates included are:

* tflint-gate: Lints Terraform code for best practices and potential errors.
* tfsec-gate: Scans Terraform code for security issues.
* tffmt-gate: Checks Terraform code formatting.
* kics-gate: Scans Terraform code for vulnerabilities using KICS.
* checkov-gate: Scans Terraform code for policy compliance using Checkov.

Each gate has a set of default threshold values that determine the maximum number of allowable issues before the pipeline fails. These thresholds can be overridden using pipeline variables.

**Kindly note that iac-gates jobs will run as part of MR pipeline. It won't run from the branch pipeline.**

![IaC-Stage-Gates-MR-Pipeline-Jobs](docs/img/IaC-Stage-Gates-MR-Pipeline.PNG)

### Deployment Stages
The deployment stages include deploy-dev, deploy-ppr, and deploy-prod for deploying the infrastructure to different environments: development, pre-production, and production, respectively.

**Kindly note that deploy (terraform) jobs will run once changes are merged into main branch. It won't run from the MR pipeline as it intended to run only from the branch (main) pipeline.**

![Deployment-Pipeline-Jobs](docs/img/Deployment-Pipeline.PNG)

## Variables and Overrides

### IaC Gate Variables

Each IaC gate job can have its threshold limits overridden by defining specific variables in the pipeline. Below are the variables and their default values:

* tflint-gate:

    * `TFLINT_MAX_FINDINGS`: Maximum allowable lint findings (default: 0)

* tfsec-gate:
    * `TFSEC_MAX_CRITICAL`: Maximum allowable critical issues (default: 0)
    * `TFSEC_MAX_HIGH`: Maximum allowable high issues (default: 5)
    * `TFSEC_MAX_MEDIUM`: Maximum allowable medium issues (default: 10)

* tffmt-gate: No configurable variables for this gate.

* kics-gate:
    * `KICS_MAX_CRITICAL`: Maximum allowable critical issues (default: 0)
    * `KICS_MAX_HIGH`: Maximum allowable high issues (default: 5)
    * `KICS_MAX_MEDIUM`: Maximum allowable medium issues (default: 10)

* checkov-gate:
    * `CHECKOV_MAX_ISSUES`: Maximum allowable issues (default: 0)

### Deployment Variables

The deployment jobs use specific variables to configure the environment settings. These variables include:

* `ENV`: The target environment (e.g., dev, ppr, prod)
* `LSEG_PPE_VAULT / LSEG_PROD_VAULT`: Enables the use of vault for storing secrets (true/false)
* `TF_CORE_DEPLOYMENT_RUNNER_TAGS`: Tags for DXOne (GitLab) Private Runner to use for the deployment on different environment subscriptions, modify the TF_CORE_DEPLOYMENT_RUNNER_TAGS variable in the respective deployment job.
* `AZURE_ACCOUNT`: The Azure subscription name for the environment
* `TF_CORE_STATE_BACKEND_AZURE_RESOURCE_GROUP`: Resource group for the Terraform state backend
* `TF_CORE_STATE_BACKEND_AZURE_STORAGE_ACCOUNT`: Storage account for Terraform state

**Optional:**
* `HashiCorpVaultKvPath`: Path to the static secrets in HashiCorp Vault (required for static secrets)
* `HashiCorpVaultRole`: Roles in Vault can be associated with specific policies that define what secrets and actions the role has access to (required for static secrets)
* `HashiCorpVaultMount`: This variable specifies the mount path in HashiCorp Vault where the secrets are stored. In Vault, secrets engines are mounted at specific paths, and this variable indicates which mount point to use (required for static secrets)

## **Updating variables on .gitlab-ci.yml file** (**Mandatory**)

Below are the iac-gates variables that you can override the default value provided in the .gitlab-ci.yml to bypass the failure that you observe it in the pipeline execution for your terraform code. Please note that whole intention of integrating this iac-gates to your IaC pipeline for the purpose of thoroughly validating the terraform code and secure it before deployment to any environment. So, please fix it when you see issues in your terraform code instead of overriding the default values to proceed with the deployment.

* `TFLINT_MAX_FINDINGS`
* `TFSEC_MAX_CRITICAL`
* `TFSEC_MAX_HIGH`
* `TFSEC_MAX_MEDIUM`
* `KICS_MAX_CRITICAL`
* `KICS_MAX_HIGH`
* `KICS_MAX_MEDIUM`
* `CHECKOV_MAX_ISSUES`

Below are the deployment variables that are required for the deployment on the target Azure subscription (environment-specific).

* `TF_CORE_DEPLOYMENT_RUNNER_TAGS`
* `AZURE_ACCOUNT`
* `TF_CORE_STATE_BACKEND_AZURE_RESOURCE_GROUP`
* `TF_CORE_STATE_BACKEND_AZURE_STORAGE_ACCOUNT`

## **Updating variables on .gitlab-ci.yml file** (**Optional**)

Below is the variable that need to be updated when you are going to retrieve the static secrets from HashiCorp Vault
* `HashiCorpVaultKvPath`

## **Updating variables on variables.yml file** (**Optional**)

Below are the variables that need to be updated when you are going to retrieve the static secrets from HashiCorp Vault
* `HashiCorpVaultRole`
* `HashiCorpVaultMount`

## **Updating terraform variables on tfvars file** (**Mandatory**)

Variables used by terraform resources is controlled by tfvars file in the path `terraform/environments/env-name.tfvars`

## For Terraform state 

Environments are controlled by jobs. Every deployment environment has one job. By default dev, ppr and prod jobs are available, you can have additional jobs for your environments.

    * `TFSEC_MAX_CRITICAL`: Maximum allowable critical issues (default: 0)
    * `TFSEC_MAX_HIGH`: Maximum allowable high issues (default: 5)
    * `TFSEC_MAX_MEDIUM`: Maximum allowable medium issues (default: 10)

* tffmt-gate: No configurable variables for this gate.

* kics-gate:

    * `KICS_MAX_CRITICAL`: Maximum allowable critical issues (default: 0)
    * `KICS_MAX_HIGH`: Maximum allowable high issues (default: 5)
    * `KICS_MAX_MEDIUM`: Maximum allowable medium issues (default: 10)

* checkov-gate:

    * `CHECKOV_MAX_ISSUES`: Maximum allowable issues (default: 0)

### Deployment Variables

The deployment jobs use specific variables to configure the environment settings. These variables include:

* `ENV`: The target environment (e.g., dev, ppr, prod)
* `LSEG_PPE_VAULT / LSEG_PROD_VAULT`: Enables the use of vault for storing secrets (true/false)
* `TF_CORE_DEPLOYMENT_RUNNER_TAGS`: Tags for DXOne (GitLab) Private Runner to use for the deployment on different environment subscriptions, modify the TF_CORE_DEPLOYMENT_RUNNER_TAGS variable in the respective deployment job.
* `AZURE_ACCOUNT`: The Azure subscription name for the environment
* `TF_CORE_STATE_BACKEND_AZURE_RESOURCE_GROUP`: Resource group for the Terraform state backend
* `TF_CORE_STATE_BACKEND_AZURE_STORAGE_ACCOUNT`: Storage account for Terraform state

**Optional:**
* `HashiCorpVaultKvPath`: Path to the static secrets in HashiCorp Vault (required for static secrets)
* `HashiCorpVaultRole`: Roles in Vault can be associated with specific policies that define what secrets and actions the role has access to (required for static secrets)
* `HashiCorpVaultMount`: This variable specifies the mount path in HashiCorp Vault where the secrets are stored. In Vault, secrets engines are mounted at specific paths, and this variable indicates which mount point to use (required for static secrets)

## **Updating variables on .gitlab-ci.yml file** (**Mandatory**)

Below are the iac-gates variables that you can override the default value provided in the .gitlab-ci.yml to bypass the failure that you observe it in the pipeline execution for your terraform code. Please note that whole intention of integrating this iac-gates to your IaC pipeline for the purpose of thoroughly validating the terraform code and secure it before deployment to any environment. So, please fix it when you see issues in your terraform code instead of overriding the default values to proceed with the deployment.

* `TFLINT_MAX_FINDINGS`
* `TFSEC_MAX_CRITICAL`
* `TFSEC_MAX_HIGH`
* `TFSEC_MAX_MEDIUM`
* `KICS_MAX_CRITICAL`
* `KICS_MAX_HIGH`
* `KICS_MAX_MEDIUM`
* `CHECKOV_MAX_ISSUES`

Below are the deployment variables that are required for the deployment on the target Azure subscription (environment-specific).

* `TF_CORE_DEPLOYMENT_RUNNER_TAGS`
* `AZURE_ACCOUNT`
* `TF_CORE_STATE_BACKEND_AZURE_RESOURCE_GROUP`
* `TF_CORE_STATE_BACKEND_AZURE_STORAGE_ACCOUNT`

## **Updating variables on .gitlab-ci.yml file** (**Optional**)

Below is the variable that need to be updated when you are going to retrieve the static secrets from HashiCorp Vault
* `HashiCorpVaultKvPath`

## **Updating variables on variables.yml file** (**Optional**)

Below are the variables that need to be updated when you are going to retrieve the static secrets from HashiCorp Vault
* `HashiCorpVaultRole`
* `HashiCorpVaultMount`

## **Updating terraform variables on tfvars file** (**Mandatory**)

Variables used by terraform resources is controlled by tfvars file in the path `terraform/environments/env-name.tfvars`

## For Terraform state 

Environments are controlled by jobs. Every deployment environment has one job. By default dev, ppr and prod jobs are available, you can have additional jobs for your environments.

## Handling deployment environments 

### To create a static environment in the UI:

* On the left sidebar, select Search or go to and find your project.
* Select Deployments > Environments.
* Select Create a New environment.
* Complete the fields.
* Select Save.

### Protecting environments

**Prerequisites**:

When granting the Allowed to deploy permission to a group or subgroup, the user configuring the protected environment must be a direct member of the group or subgroup to be added. Otherwise, the group or subgroup does not show up in the dropdown list.

### To protect an environment:

On the left sidebar, select Search or go to and find your project.

* Select Settings > CI/CD.
* Expand Protected environments.
* Select Protect an environment.
* From the Environment list, select the environment you want to protect.
* In the Allowed to deploy list, select the role, users, or groups you want to give deploy access to. There are two roles to choose from:

    * Maintainers: Allows access to all of the project’s users with the Maintainer role.
    * Developers: Allows access to all of the project’s users with the Maintainer and Developer role.

* You can only select groups that are already invited to the project.
* Users must have at least the Developer role to appear in the Allowed to deploy list.
* In the Approvers list, select the role, users, or groups you want to give deploy access to. There are two roles to choose from:

    * Maintainers: Allows access to all of the project’s users with the Maintainer role.
    * Developers: Allows access to all of the project’s users with the Maintainer and Developer role.

* You can only select groups that are already invited to the project.
* Users must have at least the Developer role to appear in the Approvers list.
* In the Approval rules section: Ensure that this number is less than or equal to the number of members in the rule.
* Select Protect. The protected environment now appears in the list of protected environments.

 




