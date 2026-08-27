# Compliance Checklist
This checklist it intended to be used to help you review your DevOps processes and reduce risks originating from gaps in compliance.

> ✅ If most answers are **yes**, your current strategy is likely sufficient.  
> ⚠️ If you answered **no** to several, review your approach and consider scheduling a review with a DevOps SME to get guidance on how to improve.

## GitLab CI/CD
- [ ] Is GCF enabled on your repository?                                                                                 
- [ ] Is at least one protected branch configured in each repository?                                                    
- [ ] Are changes being regularly integrated into your protected branch via merge requests?                               
- [ ] Are deployments to non-development environments restricted to a main/protected branch?                             
- [ ] Are all changes to protected branches required to be made via merge requests (not direct commits)?                  
- [ ] Are Self approval/committer approvals disabled on merge requests for your repository?                              
- [ ] Are merge request approvals reset if new commits are pushed after approval?                                        
- [ ] Is the CI pipeline required to pass before merge requests can be completed on protected target branches?            
- [ ] Are pipelines logically structured (e.g., build, test, deploy)?                                                     
- [ ] Are you using semantic versioning?                                                                                  
- [ ] Are versions tagged on relevant commits within your repo?                                                          
- [ ] Do versioned builds publish a versioned artefact to Enterprise Artifactory?                                        
- [ ] Do deployments deploy versioned artifacts from Enterprise Artifactory?                                             
- [ ] Do you require artifacts be promoted through environments in order from lower to higher? (e.g. DEV, QA, PPR, PRD)?  
- [ ] Can you specify/select a specific version for deployment to an environment?                                        
- [ ] Are deployments fully automated (except for approvals)?                                                            
- [ ] Does your repository have protected environments setup?                                                             
- [ ] Is your production environment protected?                                                                          
- [ ] Are deployments approvals for protected environments restricted to only authorised users?                          
- [ ] Is there a README/deployment plan explaining the deployment process that has been agreed on by the app/ops team?   
- [ ] Can you reproduce any deployed version reliably (e.g. for hotfixing)?                                              
- [ ] Can you safely and efficiently rollback a specific environment if necessary?                                       
- [ ] Is there an automated rollback mechanism for application deployments?                                              
- [ ] Is there an automated rollback mechanism for infrastructure changes?                                               
- [ ] Does rollback preserve data integrity and security configurations?                                                 
- [ ] Are the tooling requirements for your runners documented?                                                          
- [ ] Is the setup of required tooling on your runner(s) automated?                                                       

### References
* [The `.gitlab-ci.yml` File: Writing Pipelines](./docs/cicd/PIPELINE_CONFIGURATIONS.md)
* [Downstream Pipelines](./docs/cicd/DOWNSTREAM_PIPELINES.md)
* [Deployment Strategies](./docs/cicd/DEPLOYMENT_STRATEGIES.md)
* [Deployment Safety](./docs/cicd/DEPLOYMENT_SAFETY.md)
* [Artifact Management](./docs/artifact_management/ARTIFACT_MANAGEMENT.md)
* [RBAC in Gitlab](./docs/repository_management/GITLAB_RBAC.md)
* [Versioning Convention](./docs/conventions/VERSIONING_CONVENTION.md)
* [Tagging](./docs/conventions/GIT_TAGGING.md)

## Repository Management
- [ ] Does your repository make use of GitFlow or Trunk-Based Development (including Trunk-Based with release branches)? 
- [ ] Are standard branch naming conventions followed (e.g., feature/, hotfix/, release/)?                               
- [ ] Can you stabilise a release candidate for your application safely, whilst continuing feature development?          
- [ ] Can you apply hotfixes or patches to production without introducing unwanted changes?                              
- [ ] Can you be confident that your main/protected branch is stable?                                                    
- [ ] Can your team safely and efficiently handle features, bugs, and hotfixes?                                          
- [ ] Does your team ensure there aren't any long lived & stale branches outside of protected branches?                  
- [ ] Can you safely develop new features and fix bugs for existing versions without branches becoming desynchronised?   

### References
* [Repository Hygiene](./docs/repository_management/REPOSITORY_HYGIENE.md)
* [Repository Structure](./docs/repository_management/REPOSITORY_STRUCTURE.md)
* [Branching Strategy](./docs/repository_management/BRANCHING_STRATEGIES.md)
* [GitFlow on GitLab](./docs/repository_management/GITLAB_GIT_FLOW.md)
* [Branch Protection](./docs/repository_management/BRANCH_PROTECTION.md)
* [RBAC in Gitlab](./docs/repository_management/GITLAB_RBAC.md)
* [Merge Request Standards](./docs/repository_management/MERGE_REQUESTS.md)
* [Merge Request Templates](./docs/repository_management/MERGE_REQUEST_TEMPLATES.md)
* [Naming Convention](./docs/conventions/NAMING_CONVENTION.md)
* [Commit Convention](./docs/conventions/COMMIT_CONVENTION.md)
* [Crosslinking Issues from Commit Messages](./docs/conventions/CROSSLINKING_ISSUES.md)

## Infrastructure as Code
- [ ] Are CPF modules used for all supported resources? (Mandatory)                                                   
- [ ] Are CPF modules being referenced from Enterprise Artifactory (as opposed to GitLab)? (Mandatory)                
- [ ] Is the CI/CD pipeline using the official IaC pipeline template, **terraform-core**?                             
- [ ] Are approved Terraform providers and versions enforced via required_providers and required_version?             
- [ ] Are Terraform modules used to avoid code duplication for common patterns?                                       
- [ ] Are there dedicated environment files to enable the deployment in mutiple environment of the same codebase?    
- [ ] Is it possible to test infrastructure changes in lower environments without affecting production IaC?           

### References
* [Terraform Directory Structure](./docs/iac/TERRAFORM_DIRECTORY_STRUCTURE.md)
* [Terraform State Management](./docs/iac/TERRAFORM_STATE_MANAGEMENT.md)
* [Terraform Core Pipelines](https://gitlab.dx1.lseg.com/ci/stable/iac/terraform-core)

## Security
- [ ] Are secrets managed using Hashicorp Vault or Azure Key Vault, and not hardcoded in source or pipelines?         
- [ ] Are CI/CD secrets retrieved using the official LSEG Vault-Service template?                                     
- [ ] Are container images pulled from trusted and verified registries only (ACR/Artifactory)?                        
- [ ] Are you using Enterprise Artifactory to resolve all dependecies (application and infra)?                        
- [ ] Are internal packages, artifacts, and images published to a centralized artifact store with proper versioning?

### References
* [Security Practices](./docs/security/SECURITY_PRACTICES.md)
* [GCF Security Gate](https://gitlab.dx1.lseg.com/ci/stable/compliance/security-gates-v2)
* [Security Control Framework](https://confluence.refinitiv.com/pages/viewpage.action?spaceKey=PSAR&title=Security+Control+Framework+-+WIP)