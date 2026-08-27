# Merge Request Templates

Merge Request **descriptions** should always be used to summarize the changelist and motivation behind it. 

**Description Templates** are just Markdown(.md) files that can standardize the format of the MR description. A project can have more than one template, depending on the nature of the merge.

While enforcing templates may introduce a slight overhead to raising and reviewing MRs, especially in a team that is not used to having to pay much attention to the MR description, there are far more benefits to be gained from a collaborative standpoint:
- All MRs have a **consistent, predictible structure**
- **Reviewers** have an easier time understanding the scope of the MR
- **Developers** have an easier time to confirm that all expectations are met and that sufficient information is provided
- Helps ensure **quality standards** for Merge Requests by enabling "checklist" mechanisms


**Template Example**
```md
## Merge Request Title

### 1. Description
Provide a short description and motivation behind the changes:

- What does this MR do?
- Why was this MR created?

### 2. Related Work Items
Link and reference related work items (JIRA, ADO, GitLab Issues):

- Closes #[issue_number]
- Relates to #[issue_number]

### 3. Impact/Risk
Explain the impact and risks associated with the changes:

- Is the change backwards compatible?
- Are there any breaking changes expected?

### 4. Testing Instructions
If applicable, provide testing instructions to help testing teams or other developers understand how to test MR changes:

1. Step 1 to test the feature
2. Step 2 to verify the bug fix
3. Step 3 to validate documentation updates

### 5. Clean MR Checklist
MR evaluation criteria in a checklist format; useful for both the implementer and reviewer to confirm if all expectations are met:

- [x] Code changes clean?
- [x] Documentation updated?
- [ ] Linked to work item?
- [ ] Unit tests created?
- [ ] MR size acceptable?
- [ ] Commit messages follow standard?

### 6. Support Contacts
List teams/people that can be contacted if support is needed with the MR:

- @contact1
- @contact2
```
**Other Examples**
- https://gitlab.com/gitlab-org/gitlab/-/blob/master/.gitlab/merge_request_templates/Default.md?ref_type=heads
- https://github.com/avelino/awesome-go/blob/main/.github/PULL_REQUEST_TEMPLATE.md

**How to implement** 
- Refer to Gitlab [documentation](https://docs.gitlab.com/ee/user/project/description_templates.html) for implementation specifics.
