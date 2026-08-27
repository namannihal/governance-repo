# 🚀 Deployment Safety in GitLab
 
To ensure the safe delivery of code to production and other critical environments, it's essential to understand and implement [GitLab Deployment Safety practices](https://docs.gitlab.com/ee/ci/environments/deployment_safety.html). This guide outlines key features and patterns to help you safeguard your environments effectively.
 
Before proceeding, please also review:  
👉 [Patterns for Managing Segregation of Duties via GitLab](https://app.pages.dx1.lseg.com/app-51723/migration-patterns/mig-pat-source-to-target/patterns/development-platform/0035-segregation-of-duties/)
 
---
 
## 🔐 Protected Environments
 
Use [protected environments](https://docs.gitlab.com/ee/ci/environments/protected_environments.html) to limit who can deploy to specific environments, such as `production`. Once configured. only authorized users or CI/CD roles can perform deployments, helping prevent accidental or unauthorized changes.
 
- You can restrict deployments to specific roles (e.g., **Maintainers**) or users.
- This is especially useful for high-risk environments like **production**.
 
📘 [How to implement protected environments in GitLab.](https://docs.gitlab.com/ee/ci/environments/protected_environments.html#:~:text=By%20default%2C%20a%20protected%20environment...)
 
---
 
## ✅ Deployment Approvals
 
GitLab allows you to [require approvals](https://docs.gitlab.com/ee/ci/environments/deployment_approvals.html) for deployments to certain environments.
 
- Approvers must manually approve deployment jobs in the pipeline.
- While effective, **do not rely solely** on this mechanism—users with appropriate access can alter pipeline configurations (e.g., `gitlab-ci.yml`).
 
---
 
## 🔒 Protected Branches & Approval Policies
 
To reduce the risk of unauthorized or unreviewed changes being merged, use:
 
- **Protected branches** to prevent direct pushes.
- **Merge request approval rules** to require peer reviews before code is merged.
 
These controls support a strong validation process.
 
📄 [Learn more about branch protection.](/docs/repository_management/BRANCH_PROTECTION.md)
 
> ⚠️ **Note:** Maintainers can change these settings. Avoid relying on them as the **only** security mechanism for critical environments.
 
---
 
## 🧱 Using Separate Projects to Harden Deployment Pipelines
 ### 🔒 Use a Separate Project to Secure Deployment Configuration
 
If your application requires tight controls around who can change deployment steps and configuration, as well as execute deployment steps, consider isolating your CI/CD configuration in a **dedicated project** with restricted access.
 
This approach offers several advantages:
 
- **Protect the `gitlab-ci.yml` file** and shared templates from unauthorized changes
- **Restrict deployment permissions** to a smaller group of trusted users
- **Improve separation of duties** between development and operations
- **Enhance auditability** by clearly defining who can trigger deployments
 
You can use **multi-project pipelines** to link your secure deployment project to your main development repository. This setup keeps your pipeline logic isolated from your application code, reducing the risk of accidental or malicious changes.
 
📘 [Learn more about using a separate project for deployments and protecting `.gitlab-ci.yml`](https://docs.gitlab.com/ee/ci/environments/deployment_safety.html#separate-project-for-deployments)

⚠️ **Warning:** For this approach to be effective, you must carefully configure access controls on the project. If you're using group-based role assignments, be aware that members of those groups may still have permission to modify this project.

 
## 🔑 Secret Management
 
Never store secrets (e.g., tokens, passwords, API keys) in your Git repository.
 
Instead, follow best practices using:
 
- GitLab CI/CD **Variables**
- Secret management tools integrated via GitLab
 
📄 [Read the Secret Management Guidelines](/docs/security/SECURITY_PRACTICES.md#secret-management)
 
---
 
## ✅ Summary Checklist
 
| Practice                         | Description                                                  |
|----------------------------------|--------------------------------------------------------------|
| ✅ Protect Environments           | Restrict who can deploy to critical targets like `prod`      |
| ✅ Require Deployment Approvals   | Add manual approval steps to sensitive pipelines             |
| ✅ Protect Branches               | Prevent unreviewed code from being merged                    |
| ✅ Separate CI Config Repos       | Isolate `.gitlab-ci.yml` in a locked-down repo               |
| ✅ Manage Secrets Properly        | Never store secrets in your repo—use secure variables        |
 
---
 
Let us know if you need help applying these practices in your project or pipeline setup!