# Documentation Practices

Documentation plays an important role in collaboration and productivity. In a DevSecOps and Agile culture, we must also uphold the principle of *working software over comprehensive documentation*. What this means is that a documentation:
- Should always **bring value**
- Provide **just enough information**
- Be in **continuous improvement**

Teams should not confuse documentation for just a Confluence space in which they dump product information. In reality, documentation also refers to:
- Comments in code
- [Commit messages](/docs/conventions/COMMIT_CONVENTION.md) 
- [Merge Request descriptions](/docs/repository_management/MERGE_REQUEST_TEMPLATES.md)
- `README.md` files

### Common Pitfalls
- **Unclear Scope** 
    - Without a clear, specific purpose, documentation often expands with unnecessary information. This makes it harder to use, thus **diminishing its value**
- **Not integrated into the SDLC** 
    - Lack of documentation-oriented practices in the Software Development Lifecycle (SDLC) can result in unreliable documentation
- **Lack of Accountability** 
    - Documentation is a team effort. Without clearly defined accountability, the *bystander effect* can occur, again leading to unreliable documentation
- **Security as an Afterthought** 
    - Many teams include sensitive information in their documentation due to convenience or due to a lack of awareness. Examples include: 
        - Exposing API keys in scripts or services
        - Revealing internal network structure

### Guiding Principles
1. **Set the scope** 
    - Before creating a document, identify the target audience, how and why the document will help
2. **Prioritize *in-repo* documentation** 
    - READMEs and other markdown files should be self-sufficient in explaing the content and usage of a repository, so that effort on external documentation is reduced
    - An additional advantage is that documentation is subjected to the same access control rules as the rest of the repository
    - This does not mean that external documentation is unnecessary, but should only exist **to complement** whats already inside the repository
3. **Treat it as a living entity** 
    - Documentation should change the same way the product does. This approach aligns with the process of **Continuous Improvement**:
    - Define periodic documentation review sessions and encourage feedback
    - Adopt a *document as you go* mindset, add documentation to an User Story's Definition of Done. For code, this can be enforced at Merge Request level by making it part of the review checklist. See: [MR Templates](/docs/repository_management/MERGE_REQUEST_TEMPLATES.md).
4. **Automation/Dynamic Content** 
    - Be automation ready by opting for tooling that can automate or enables automation
    - Wherever possible, opt for dynamic content instead of static assets. Example:
        - Using [mermaid](https://mermaid.js.org/intro/) to create diagrams instead of inserting a static image in a markdown makes the diagram far easier to update
5. **Keep security in mind** 
    - Use placeholders to substitute sensitive information such as API keys
    - Implement access control mechanisms on the documentation

### In-repo Documentation
All source code repositories should contain documentation specific to it. 

Gitlab offers two ways to do this in a source controlled fashion:
- Repository [Wiki](https://docs.gitlab.com/ee/user/project/wiki/) - inside the project, but in a **separate repository**
- Markdown rendering - inside the project's, with the rest of the source code

#### Content suggestions

In terms of information, a good in-repo documentation should include:
1. **Introduction**
    - Purpose of repository
    - Software stack
    - Code structure
2. **Onboarding**
    - How to clone the repo
    - How to build/test/deploy
    - Requirements
3. **Contribution Guide**
    - How to contribute
    - Code of Conduct

It is recommended to follow a documentation style guide to ensure consistency. See [Gitlab Style Guide](https://docs.gitlab.com/ee/development/documentation/styleguide/)

**Examples**

- Kubernetes [README.md](https://github.com/kubernetes/kubernetes?tab=readme-ov-file)
- Gitlab [Contribution Guide](https://gitlab.com/gitlab-org/gitlab/-/blob/master/CONTRIBUTING.md?ref_type=heads)
- Global Compliance Framework (GCF) [USERGUIDE.md](https://gitlab.dx1.lseg.com/ci/stable/compliance/global-compliance-framework/-/blob/main/USERGUIDE.md)


### Automating Documentation

Well selected tooling can help reduce the overhead of documentation management via automation.

Some areas that can be partially or fully automated are:
- [API Documentation](/docs/documentation/API_DOCUMENTATION.md)
- [Release Notes/Changelogs](/docs/documentation/CHANGELOGS.md)
