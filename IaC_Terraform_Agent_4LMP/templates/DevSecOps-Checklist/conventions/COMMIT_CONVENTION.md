# Commit Convention

This guide provides guidelines for commit convention in DX1 GitLab. 

It is recommended to follow the Conventional Commits standards for writing commit messages. These standards help to create consistent and descriptive commit messages, which can be helpful for team collaboration. You can learn more about Conventional Commits [here](https://www.conventionalcommits.org/).


Conventional Commits is a commit message convention that helps create consistent and descriptive commit messages, making it easier to understand the purpose and impact of each commit. The convention follows a specific format:

```
<type>[optional scope]: <description>

[optional body]

[optional footer]
```

#### Type

The `type` field specifies the nature of the commit and can be one of the following:

- `feat`: A new feature or enhancement.
- `fix`: A bug fix.
- `docs`: Documentation-related changes.
- `style`: Code style/formatting changes (no production code changes).
- `refactor`: Code refactoring without adding new features or fixing bugs.
- `test`: Adding or modifying tests.
- `chore`: Other changes that do not modify production code or test files (e.g., build scripts, tooling changes).

#### Optional Scope

The `optional scope` field can be used to specify the scope of the commit, such as the affected module, component, or feature.

#### Description

The `description` field is a brief summary of the changes made in the commit. It should be written in the imperative mood, starting with a verb. The description can also contain the link for an specific ticket or issue from litlab. Ex:
   ```
   feat: Implement user authentication as required in  https://gitlab.dx1.lseg.com/dx1-community/dx1-enablement-management/-/issues/554
   ```


#### Optional Body

The `optional body` field provides additional information about the commit. It can include more details about the changes, the reasoning behind them, and any other relevant context.

#### Optional Footer

The `optional footer` field is used for providing any additional information, such as references to related issues or breaking changes.

##### Examples of Conventional Commits:

1. Adding a new feature:
   ```
   feat: Implement user authentication https://gitlab.dx1.lseg.com/dx1-community/dx1-enablement-management/-/issues/554

   Adds a new feature for user authentication using JWT tokens.
   ```
   The example above includes the issue link so gitlab automatically links it to the issue commets.
   
2. Fixing a bug:
   ```
   fix: Resolve null pointer exception

   Fixes a bug that caused a null pointer exception when accessing a certain endpoint.
   ```
   
3. Documenting changes:
   ```
   docs: Update API documentation

   Updates the API documentation with additional endpoints and examples.
   ```
   
4. Code style/formatting changes:
   ```
   style: Format code using Prettier

   Applies Prettier to format the entire codebase consistently.
   ```
   
5. Refactoring code:
   ```
   refactor: Simplify data validation logic

   Refactors the data validation logic to improve code readability and maintainability.
   ```

## Enforcing Conventional Commits

### For each commit

GitLab does allow a REGEX push rule to be provided in the **Repository settings** for each commit.
This can be a little overbearing, especially when squash commits are leveraged during the merge request process.

```
^(build|chore|ci|docs|feat|fix|perf|refactor|revert|style|test)(\(.*\))?: .*$
```

### For Merge Requests

In addition to using conventional commits for every single commit, it's a common practice to use the convention for Merge Request titles. This is because the default GitLab `Squash commit message template` is the title of the MR.

To enforce this in your pipeline you can use this code snippet. It uses REGEX to fail the job if the title does not meet the standard.

```yaml
default:
  tags: [LSEG] #Standard Shared Runner - select as appropriate for your project.

stages:
  - dx1-standards

# REF:https://gitlab.dx1.lseg.com/ci/stable/standards-and-best-practices/-/blob/main/docs/COMMIT_CONVENTION.md
mr-title-convention:
  stage: dx1-standards
  rules:
    - if: $CI_PIPELINE_SOURCE == "merge_request_event"
  script:
    - echo "Verifying that MR Title is written as per conventional commit."
    - echo "CI_MERGE_REQUEST_TITLE = $CI_MERGE_REQUEST_TITLE"
    - |-
        REGEX="^(build|chore|ci|docs|feat|fix|perf|refactor|revert|style|test)(\(.*\))?: .*$"
        if [[ "$CI_MERGE_REQUEST_TITLE" =~ $REGEX ]]; then echo "MR Title Matches Conventional Commit Standards"; else echo "MR Title does not match Conventional Commit Standards" && exit 1; fi

```
