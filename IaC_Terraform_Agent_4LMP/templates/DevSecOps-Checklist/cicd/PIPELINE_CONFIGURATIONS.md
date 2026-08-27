# .gitlab-ci.yaml (GitLab Pipelines) and Best Practices

## Table of Contents
- [Introduction](#introduction)
- [What are GitLab Pipelines?](#what-are-gitlab-pipelines)
- [Defining a GitLab Pipeline](#defining-a-gitlab-pipeline)
- [Purpose of `.gitlab-ci.yml`](#purpose-of-gitlab-ciyml)
- [Pipeline Types](#pipeline-types)
  - [Basic Multi-stage Pipelines](#basic-pipelines-single-multi-stage-pipelines)
  - [Parent-Child Pipeline](#parent-child-pipeline-downstream-in-same-project)
  - [Multi-project Pipeline](#multi-project-pipelines-downstream-in-other-project)
- [Best Practices for Creating GitLab Pipelines](#best-practices-for-creating-gitlab-pipelines)
  - [Organize Your `.gitlab-ci.yml` File](#organize-your-gitlab-ciyml-file)
  - [Avoid Code Spaghetti](#avoid-code-spaghetti)
  - [Git Tags and Project Includes](#git-tags-and-project-includes)
- [`.gitlab-ci.yml` example](#example)
- [Conclusion](#conclusion)

## Introduction

GitLab Pipelines are a crucial part of modern software development. They help automate and streamline the process of building, testing, and deploying your code, making development more efficient and reliable. This guide is designed to explain what GitLab Pipelines are, how they are defined, the importance of the `.gitlab-ci.yml` file, and best practices to follow when creating pipelines.

## What are GitLab Pipelines?

GitLab Pipelines are a set of automated actions that are triggered whenever changes are made to your code repository. These actions include building your code, running tests, and deploying your application. Pipelines help ensure that your software is always in a working state and can be delivered to users with confidence.

## Defining a GitLab Pipeline

A GitLab Pipeline is defined using a configuration file called `.gitlab-ci.yml`. This file contains instructions on what should happen when specific events occur, such as code pushes, merge requests, or tags.

## Purpose of `.gitlab-ci.yml`

The `.gitlab-ci.yml` file serves several important purposes:

1. **Pipeline Configuration**: It defines the structure and behavior of your pipeline. This includes specifying which jobs to run, their dependencies, and the order in which they should execute.

2. **Automation**: It automates the process of building, testing, and deploying your code. This automation reduces the risk of human error and ensures consistency across your development and deployment process.

3. **Scalability**: It allows you to easily scale your development process as your project grows. You can add new jobs and stages to accommodate additional features or requirements.

4. **Version Control**: The `.gitlab-ci.yml` file is version-controlled, making it easy to track changes to your pipeline configuration over time.

## Pipeline Types
See [Types of Pipelines in GitLab](https://docs.gitlab.com/ee/ci/pipelines/)
 
Here we will talk about three fundamental pipeline structures/topologies, and when to chose each option:
- Basic pipelines
- Parent-child pipelines
- Multi-project pipelines
 
### Basic Pipelines (Single multi-stage pipelines)
Individual pipelines defined for each service/microservice broken into multiple stages.
 
See: [GitLab Docs: Basic pipelines](https://docs.gitlab.com/ee/ci/pipelines/pipeline_architectures.html#basic-pipelines)
 
**When to use:**
- Best for microservice architectures or smaller monolithic applications where the code within the repository represents a logical application/service that can be built, tested, and deployed independently.
 
**Pros:**
- Isolates changes to individual services, easier to manage microservice deployments and smaller monolithic repostiories.
 
**Cons:**
- Can lead to pipeline sprawl if used for larger applications, harder to manage dependencies between services as things scale.
 
### Parent-Child Pipeline (Downstream in same project)
A parent-child pipeline is one that is broken into multiple files kept within the same repository. It uses the main gitlab-ci.yml file as an entry point, which in turn calls other yml files to take encapsulate individual pipeline behaviour into separate files. This is useful when having a single large pipeline file is not feasible, such as in the case of monorepos, where you may want to split out pipeline files based on components, or app/infra.
 
See: [Downstream Pipelines](DOWNSTREAM_PIPELINES.md)
 
**When to use:**
- When using a single gitlab-ci.yml file is not feasible due to size and complexity of your repository (E.g. in the case of monorepos)
- When you want individual pipelines for different logical parts of your repository, E.g. different app components, or app/infra.
 
**Pros:**
- Offers modularity, splitting otherwise large monolithic pipelines into smaller, more manageable chunks aimed at specific tasks or stages
- Improved scalability and support for collaboration by breaking out key components/functions into separate files
- Offers improved maintainability and reusability
- Parallel execution - Can run child pipelines in parallel with other child pipelines, reducing overall time needed to complete your CI/CD process
 
**Cons:**
- Complexity can be increased when dealing with a large number of files, making it harder to manage the end-to-end workflow
- Requires additional design and overhead to ensure correct configuration and orchestration of stages
 
### Multi-Project Pipelines (Downstream in other project)
A Multi-project pipeline is one that triggers pipelines stored in other repositories/projects. They are similar in concept to Parent-child pipelines, with the key difference being the scope - cross-project (Multi-project) vs local, within the same project (Parent-child).
 
Multi-project pipelines are ideal for scenarios where your application spans multiple projects/repositories. For example, if you have a polyrepo (multi repo) application, where components are divided into multiple repositories, but you want to have a single repository & pipeline for orchestrating the deployment of those components as a whole. In this case, you could have a single orchestration project with the parent pipeline, which would orchestrate the execution of child pipelines stored within each component repository. In this example, you may want to first trigger a shared infrastructure pipeline, then your individual component infrastructure pipelines, then your application pipelines (for example).
 
This provides granularity too, in that if I also want to be able to support smaller, more continuous deployments of individual components, such as if I just want to update the front end of one of my app components and nothing else, I can do so by triggering just the relevant repository pipeline.
 
See: [Downstream Pipelines](DOWNSTREAM_PIPELINES.md)
 
**When to use:**
- When you have a polyrepo (multi repo) structure, where your application is split across multiple repositories in a microservice architecture
- When you want to de-couple your deployment orchestration from your main app repositories, simulating the workflow of a monorepo (single repo)
- When you want to align and deploy multiple repositories/components as part of a single versioned release
- When you have a shared pipeline in a separate project/repository
 
**Pros:**
- Allows for cross-repository orchestration and coordination of workflows, ideal for organised deployments of microservices and supports use of shared libraries
- Provides centralised control over deployments of individual components, supporting single versioned releases of all components
- Ensures consistency and order of deployment when working with multiple components and complex applications
- Supports scalability of applications, decoupling individual components from the overall deployment process
- Provides clear visibility of deployment processes and order
 
**Cons:**
- Increased complexity due to the need to manage multiple CI/CD files across multiple repositories, typically resulting in complex workflows
- Configuration overhead is typically a factor due to the need to carefully manage triggers, variables and dependency order between multiple repository pipelines
- Trigger/resource costs due to triggering of multiple individual CI pipelines, there is also a potential for increased latency between thr triggering of each pipeline
- Complex dependency/order management risk is introduced due to the need to carefully consider and implement proper ordering of individual components during deployments


## Best Practices for Creating GitLab Pipelines

### Organize Your `.gitlab-ci.yml` File

   - **Use Comments**: Add comments to your configuration file to explain the purpose of each section and job. This helps others understand your pipeline logic.

   - **Logical Stages**: Organize your pipeline into logical stages, such as "build," "test," and "deploy." This makes it easier to understand the flow of your pipeline.

   - **Use Includes**: If your application require many project and variables, the `.gitlab-ci.yml` file can become very large and difficult to read and maintain. In this case we suggest to remove this large blocks from your main pipeline and create includes for your variables, project includs
   es and include them in your configuration. This promotes code reusability and reduces duplication.

   - **CI Folder**: Create a dedicated `ci` folder within your repository to store the includes we mentioned above and common scripts, keeping your repository clean and organized.

   - **TEMPLATES Folder**: In the repository, create a `templates` folder. The `templates` is designed to store gitlab templates which  refer to predefined configuration files or settings that can be used as a starting point for various aspects of a GitLab project, including CI/CD pipelines, issue boards, merge request descriptions, and more. These templates help standardize and simplify the setup and configuration of different project elements. To know more about some common types of templates in GitLab, please refer to the [TEMPLATES_REF.md](./TEMPLATES_REF.md)

   - **SCRIPTS Folder**: In the repository, create a `scripts` folder. The `scripts` folder in the root directory typically serves the purpose of containing various powershell, python, bash, shell or any other language scripts that are relevant to the project. The scripts folder may contain automation scripts that help with various tasks related to the project. These scripts can be used to automate deployment, testing, data processing, or any other repetitive tasks.

   Note: It's important to note that the specific purpose and content of the `scripts` folder and (any other folder) should be documented within the project's documentation or README file. Developers working on the project can refer to this documentation to understand the role and usage of the scripts in the scripts folder.



### Avoid Code Spaghetti

   - **Keep It Simple**: Keep your pipeline configuration simple and focused. Avoid creating overly complex logic that is hard to maintain.

   - **Modularization**: Use includes to break down your configuration into smaller, manageable parts. Avoid including large blocks of variables or scripts in a single file.

   - **Use Conditionals Wisely**: Be cautious when using conditions (`when`) in your jobs. Use them only when necessary to prevent a convoluted pipeline logic.

### Git Tags and Project Includes
Whenever is possible, when including other projects in your `.gitlab-ci.yml` file use the latest git tags provide in the projecs using the `ref:` keyworkd. This will make your pipeline secure againt breaking changes and making sure you are using the latest version of the project code.


   - **Project Includes**: Leverage includes in your `.gitlab-ci.yml` file to conditionally load configuration files based on Git tags. Use the `ref:` keywork to point to git tags instead of branches.

   Example:

   ```yaml
    include:
    - project: ci/stable/security/vault/vault-integrator
        ref: 2.0.14 # this included project points to a git tag
        file:
        - 'templates/vault-integrator.yml'   
   ```

## Example

This is an example on how an easy to main (and to read) `.gitlab-cy.yml` look like:

```yaml
default:
  tags: [Linux, Medium, Refinitiv]

stages:
  - dev

include:
    - local: 'ci/includes.yml'
    - local: 'ci/variables.yml'

# linux-azure-vm-runner

echo-dev:
  stage: dev
  script:
    - echo "Hello World dev!"
    - echo "This is a variable defined in ci/variables.yml included!"
```


## Conclusion

GitLab Pipelines are a powerful tool for automating and managing your software development process. By following best practices and organizing your `.gitlab-ci.yml` file effectively, you can create robust and maintainable pipelines that ensure the quality and reliability of your software. Remember to use comments, modularization, and Git tags to keep your pipeline logic clear and efficient.

For more detailed technical guidance, consult the GitLab documentation and seek help from your development team or DevOps experts.
