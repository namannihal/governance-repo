# GitLab Templates

In the context of GitLab, templates refer to predefined configuration files or settings that can be used as a starting point for various aspects of a GitLab project, including CI/CD pipelines, issue boards, merge request descriptions, and more. These templates help standardize and simplify the setup and configuration of different project elements. Here are some common types of templates in GitLab:

1. **CI/CD Templates**: GitLab provides a variety of CI/CD templates that you can use to set up your pipeline configurations quickly. These templates cover different programming languages, build tools, and deployment scenarios. When creating a `.gitlab-ci.yml` file, you can start with one of these templates and customize it to suit your project's needs.

2. **Issue Templates**: Issue templates allow you to define predefined structures for creating new issues in your GitLab project. For example, you can create issue templates for bug reports, feature requests, or other types of tasks. When users create a new issue, they can select from these templates to provide structured information.

3. **Merge Request Templates**: Merge request templates provide a standardized format for creating merge requests. They help contributors provide essential information when submitting changes, such as a description of the changes, testing instructions, and related issues.

4. **Directory Templates**: GitLab allows you to define templates for specific directory structures in your repository. This can be useful for enforcing consistent project organization, especially in multi-language or multi-environment projects.

5. **Snippet Templates**: You can create predefined code snippets with templates to promote code reuse and consistency across your project. Snippet templates can include descriptions, code examples, and usage instructions.

6. **License Templates**: GitLab provides a selection of open-source software licenses that you can use as templates. When creating a new project, you can choose a license template to include the appropriate license file in your repository.

7. **Security Policy Templates**: GitLab allows you to define security policy templates to specify how security issues should be reported and handled in your project.

Using templates in GitLab simplifies project management and promotes consistency by providing predefined structures and settings. These templates are particularly useful for teams that want to follow best practices and maintain a standardized approach to various project elements.

## Example of template usage

Here's a simple example of a GitLab CI/CD template that uses a local include to include another template from your project's repository. This example assumes you have a project structure where you want to maintain a local template within a `ci` folder in your repository:

1. **Create a `.gitlab-ci.yml` file in the root of your GitLab project if you don't already have one.

2. Inside your `.gitlab-ci.yml` file, you can define a job that includes a local template like this:

```yaml
include:
  - local: '/ci/my-local-template.yml' # Path to your local template

stages:
  - build

my_job:
  script:
    - echo "This is my custom job"
```

In this example:

- We use the `include` keyword to include a local file from the `/ci` folder in your repository.
- `local: '/ci/my-local-template.yml'` specifies the path to your local template. Adjust the path according to your project's folder structure.
- The `my_job` section represents a simple CI/CD job that echoes a message. You can customize this job as needed.

3. Now, let's assume you have a file named `my-local-template.yml` inside the `/ci` folder of your repository. This file contains another job or configuration you want to reuse. Here's a simple `my-local-template.yml` example:

```yaml
my_local_job:
  script:
    - echo "This is my local template job"
```

In this example:

- `my_local_job` is a job defined within the local template, and it echoes a message.

4. When you push changes to your GitLab repository, GitLab CI/CD will automatically detect the changes in the `.gitlab-ci.yml` file and include the local template (`my-local-template.yml`) when running the pipeline.

This approach allows you to maintain reusable CI/CD configurations in local templates while keeping your main `.gitlab-ci.yml` file clean and organized. It's especially useful when you want to share common CI/CD logic across multiple projects within the same GitLab group or organization.
