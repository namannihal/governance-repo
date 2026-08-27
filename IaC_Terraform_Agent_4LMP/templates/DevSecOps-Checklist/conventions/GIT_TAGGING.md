# Git Tags: A Simple Guide

- [What Are Git Tags?](#what-are-git-tags)
- [Why Do We Use Git Tags?](#why-do-we-use-git-tags)
  - [1. Clarity and Organization](#1-clarity-and-organization)
  - [2. Easy Reference](#2-easy-reference)
  - [3. Semantic Versioning (Semver) Connection](#3-semantic-versioning-semver-connection)
- [Best Practices for Git Tags](#best-practices-for-git-tags)
- [Creating Git Tags](#creating-git-tags)
  - [Using Command Line](#using-command-line)
  - [Using GitLab UI](#using-gitlab-ui)
- [Benefits of Using Git Tags with Semantic Versioning](#benefits-of-using-git-tags-with-semantic-versioning)
- [Tagger](#tagger)

## What Are Git Tags?

Think of Git tags as bookmarks or labels for specific points in your project's history. These points often represent important milestones or versions of your software. Tags are like snapshots that allow you to easily reference a particular state of your project at any time.

## Why Do We Use Git Tags?

### 1. Clarity and Organization

Tags help you keep track of significant moments in your project's development, such as releases or major updates. They provide clarity by giving meaningful names to specific commits.

### 2. Easy Reference

With tags, you can quickly jump to a specific version of your project. This makes it easy to find and work with older versions, compare them, or even go back in time to fix issues.

### 3. Semantic Versioning (Semver) Connection

Git tags often align with semantic versioning (semver) principles. Semver is a versioning scheme that uses three numbers (e.g., 1.2.3) to convey meaning:

- Major version: Significant changes, likely to require adjustments.
- Minor version: New features or enhancements that are backward-compatible.
- Patch version: Bug fixes or small updates that are backward-compatible.

By using Git tags with semver, you can clearly communicate what has changed and how significant the changes are in each version.

## Best Practices for Git Tags

1. **Use Meaningful Names**: Choose descriptive names for your tags. A common convention is to use the semver format (e.g., "v1.0.0") to make it clear which version a tag represents.

2. **Create Tags for Releases**: Tags are commonly used for marking stable release points. When you release a new version of your software, create a tag to match the version number.

3. **Keep Tags Consistent**: Once you create a tag, avoid modifying it. Tags should be immutable to ensure consistency.

4. **Use Annotated Tags**: When creating tags, consider using annotated tags. Annotated tags include additional information like a message, making them more informative.

## Creating Git Tags

### Using Command Line

1. Open your terminal or command prompt.
2. Navigate to your Git repository's directory.
3. To create a new annotated tag for version 1.0.0, run the following command:

   ```
   git tag -a v1.0.0 -m "Version 1.0.0 release"
   ```

   Replace "v1.0.0" with your desired tag name and provide a meaningful message.

4. To push the tag to the remote repository (like GitLab), use:

   ```
   git push origin v1.0.0
   ```

### Using GitLab UI

1. Go to your project's GitLab repository.
2. Navigate to the "Repository" section on the left sidebar.
3. Click "Tags."
4. Click the "New tag" button.
5. Enter the tag name (e.g., "v1.0.0") and optional release notes.
6. Click "Create tag."

## Benefits of Using Git Tags with Semantic Versioning

If you are intested to know more about Semantic Versioning, please read our [VERSIONING_CONVENTION.md](/docs/conventions/VERSIONING_CONVENTION.md) or [Semantic Versioning website](https://semver.org/).

- **Clear Versioning**: With Git tags following semver, everyone understands the significance of each version.

- **Predictable Updates**: Users can anticipate how updates might affect their systems based on version numbers.

- **Easy Rollbacks**: In case of issues, you can easily roll back to a previous version using tags.

- **Documentation**: Tags serve as a form of documentation, making it easier to track changes over time.

In summary, Git tags are a valuable tool for managing your project's history, marking important milestones, and aligning with semantic versioning principles. By following best practices and using tags wisely, you can keep your development process organized and easily communicate changes to your team and users.

## Tagger
To help other teams, we created an automated templated that includes jobs to automatically create tags; [Tagger](https://gitlab.dx1.lseg.com/ci/stable/release-tools/tagger), how we call it, just need to be include in the pipeline `.gitlab-ci.yml` and requires you to add a `release` stage, so you can decide when the git tags will be generated.


For more informations about tagger, please vistit https://gitlab.dx1.lseg.com/ci/stable/release-tools/tagger.
