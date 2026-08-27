# Merge Request Standards

It might be tempting to get into the practice of commiting directly to a main or other key branches due to tight deadlines or the desire to move fast with changes, however this practice will lead to preventable issues occurring later in the process that are much more costly to resolve.
 
When working in a team, peer review processes should be standardised in order to prevent costly issues occuring downstream. Continuous integration of smaller changes along with continuous collaboration with team members helps uphold standards and spot potential issues.
 
To enforce certain standards for merge requests to ensure compliance, a solid foundation would be:
 
- Every commit to main/develop branch should be made through a merge request. Direct commits to these branches should be blocked
- Have at least two required approvers for merge requests
- The self approval/committer approvals should not be enabled
- Votes/approvals should be reset if new changes are pushed and included in the merge request
- CI pipeline should be required to run succesfully before a merge request can be completed and the changes merged into the branch

## Approval Rules 

Merge Request (MR) approval rules in GitLab allow you to define specific criteria that must be met before a merge request can be merged into a protected branch. These rules help ensure that code changes undergo proper review and testing, improving code quality and collaboration within your development process.


### Steps to Create Merge Request Approval Rules

Follow these steps to set up approval rules for Merge Requests in GitLab:

1. **Navigate to the Project:**
   - Open the GitLab project where you want to set up MR approval rules.

2. **Go to Project Settings:**
   - Click on the **Settings** icon in the project's sidebar and select **Merge requests**.
   - In the main section called **Merge requests**:
      - In **Merge method** sub-section, select "Merge commit" (*Every merge creates a merge commit*).
      - In **Merge options** sub-section, select *Show link to create or view a merge request when pushing from the command line* and *Enable "Delete source branch" option by default*.
      - In **Squash commits when merging** sub-section, select *Require* so Squashing is always performed.
      - In **Merge checks** sub-section, select *All threads must be resolved* and *Status checks must succeed*
   - In the **Merge request approvals** section: 
      - **Approval rules**: Define approval rules and settings to ensure separation of duties for new merge requests. In the row *All eligible users*:
         - Target branch: *All branches*
         - Approvals required: set it to *2*
         - If you want to specify/add specific users or groups required to approve, you can do it by clicking in **Add approval rule** button and then define a *Rule name*, *Target branch*, *Approvals required: 2* and then in the *Add approver* section you'll be able to search for the specific users or groups.

      - **Approval settings**: Define how approval rules are applied to merge requests. Check the following options:
         - *Prevent approval by author*
         - *Prevent editing approval rules in merge requests*
         - **When a commit is added**:
            - *Remove all approvals*
   - Click **Save changes**.


3. **Testing the Approval Rules:**
   - Create a new Merge Request targeting a protected branch.
   - Observe the approval section in the MR. Approvers can review the changes and provide their approvals if the criteria are met.

### Benefits of Approval Rules

Using Merge Request approval rules offers several benefits to your development workflow:
- **Code Quality:** Ensures that code changes are reviewed and approved by qualified individuals before being merged.
- **Accountability:** Defines a clear process for code review and accountability within the team.
- **Collaboration:** Promotes collaboration among team members by requiring discussions and approvals before merging.
- **Customizability:** Allows you to tailor approval rules to match your team's workflows and requirements.

### Importance of Code Review

Code reviews are a critical step in maintaining code quality, identifying bugs, improving readability, and ensuring consistency within the codebase. By requiring at least two reviewers for each MR, we promote collaboration, knowledge sharing, and thorough evaluation of code changes before they are merged into the main branch.

### Merge Request Changelist limits 

While most strategies enable small and frequent integrations to the main branch, which is also the core requirement for enabling **Continuous Integration**, projects may struggle to find and maintain the balance by themselves. Whether it is user oversight or a planning error, "big bang" Merge Requests with many code changes can happen.

A "Big Bang" or "Mega" merge is not ideal as it is very likely to introduce some of the following:
- Increase in difficulty for thorough code reviews
- Higher chance of introducing bugs.
- Increase in merge conflicts.
- Slower integration process.

By adopting the practice of limiting the changelist size that a Merge Request can introduce, a team can ensure that:
- The code changes are **easier to review**
- **Fewer merge conflicts**
- The **CI process is more reliable**

Changelist size is based on two metrics:
- Number of files touched
- Lines of code changes

**How to implement**
1. Identify a threshold for the CL size.
    - Leverage past reviewer experience, perform a past MR size analysis
2. Define your size criteria 
    - For example, maximum 500 lines across 10 files. 
3. Define your tolerance level 
    - Are merges that do not meet the criteria automatically rejected or just flagged for investigation?
4. Define exceptions 
    - There are instances in which a MR is expected to be bigger than the threshold; if they are defined in advance, they are much easier to handle during review
5. Communicate with the team and start enforcing the limitation during Code Review sessions.

**Recommendation**: It is important to note that thresholds are expected to change as teams gain first-hand experience with this practice, therefore start by setting generous thresholds and to be more tolerant of outstanding Merge Requests. The practice can then be periodically reviewed and adjusted.

**References**
- Google's changelist practices: https://google.github.io/eng-practices/review/developer/small-cls.html

## Conclusion

By following the steps outlined above, you can create and configure Merge Request approval rules in GitLab, enhancing your code review and collaboration practices. These rules help maintain code quality, prevent unauthorized changes, and ensure that only well-reviewed and approved code is merged into protected branches.

If you want to know more about **Merge request approval rules** please visit https://docs.gitlab.com/ee/user/project/merge_requests/approvals/rules.html .
