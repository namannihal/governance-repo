# Crosslinking Issues from Commit Messages

Every time you mention an issue in your commit message, you’re creating a relationship between the two stages of the development workflow: the issue itself and the first commit related to that issue.

To successfuly crosslink issues from your commit messages, you NEED add the full URL to the issue:

```bash
# replace <projectname> with your project name
# replace <xxx> with your issue #
git commit -m "this is my commit message. Related to https://gitlab.com/dx1-community/<projectname>/-/issues/<xxx>"
```

Crosslinking issues in GitLab from commit messages is important for several reasons:

1. **Traceability and Context:** When you link a commit to an issue or a merge request (MR) using references in your commit message (e.g., "Closes #123" or "Fixes !456"), it creates a traceable connection between the code changes and the relevant issue or MR. This helps team members quickly understand why certain code changes were made and what problem they were addressing.

2. **Change History:** Crosslinking provides a historical record of the changes made to resolve a specific issue or implement a feature. This can be useful for future reference, code reviews, and discussions, especially when looking back at why certain decisions were made.

3. **Automated Workflow:** Many version control systems, including GitLab, offer integration with issue tracking systems. When you crosslink issues and MRs using specific keywords, GitLab can automatically close the linked issue when the MR is merged, or it can provide status updates based on the MR's progress.

4. **Collaboration and Communication:** Crosslinking encourages collaboration by fostering better communication between developers, QA, and stakeholders. It helps clarify the relationship between code changes and the tasks they are associated with.

5. **Code Review:** During code reviews, crosslinked issues provide reviewers with additional context. They can easily reference the original issue or MR and evaluate whether the changes address the intended problem.

6. **Release Management:** By crosslinking code changes to issues and MRs, release managers can more effectively plan and track the inclusion of specific features or bug fixes in upcoming releases.

7. **Project Management:** Crosslinking enables better project management by allowing project managers and team leads to track progress, identify bottlenecks, and ensure that tasks are being completed as intended.

8. **Documentation and Training:** The crosslinking practice aids in documenting the development process and can be helpful for new team members who want to understand the rationale behind previous code changes.

9. **Visibility and Transparency:** When crosslinked, the connections between issues, MRs, and commits are visible to the entire team. This transparency helps to maintain a shared understanding of the project's progress.

10. **Accountability:** By linking code changes to specific issues, it's easier to attribute work to specific team members, promoting accountability within the development process.

In summary, crosslinking issues in GitLab from commit messages enhances collaboration, context, and traceability, making it easier to manage projects, track progress, and maintain a well-documented development history.

### ⚠️ Attention 
In DXOne, the Issues project and the development project are not in the same group so crosslink methods like #XXX or GL-XXX will NOT work.
