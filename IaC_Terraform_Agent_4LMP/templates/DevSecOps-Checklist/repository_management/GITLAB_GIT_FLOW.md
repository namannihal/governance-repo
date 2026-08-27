# Git Flow Examples

Gitflow is a branching model for Git, a popular version control system used in software development. It was introduced by Vincent Driessen in a blog post in 2010 and has since become a widely adopted workflow for managing Git repositories, particularly in projects with multiple developers and complex release cycles.

The Gitflow model defines a strict branching model that facilitates parallel development, release management, and feature development. It essentially involves the following main branches:

## Gitlab Sample
On Gitlab, gitflow can be achieve combining `rules: ` and `extends:` to run job only when certain criteria is match.

Sample: you can see the example below or look at [this `gitlab-ci-gitflow.yml` file](../../.gitlab-ci-gitflow.yml).

```yaml
.release-rules:
  rules:
    - if: $CI_COMMIT_BRANCH =~ /^release*/ # jobs that extends this rule will only execute if are release/* branches

.feature-rules:
  rules:
    - if: $CI_COMMIT_BRANCH =~ /^feature*/ # jobs that extends this rule will only execute if are feature/* branches

.dev-rules:
  rules:
    - if: $CI_COMMIT_BRANCH =~ /^develop*/ || $CI_COMMIT_BRANCH =~ /^dev*/ # jobs that extends this rule will only execute if are develop/* or dev/* branches

.master-rules:
  rules:
    - if: $CI_COMMIT_BRANCH == "master" || $CI_COMMIT_BRANCH == "main" # jobs that extends this rule will only execute if are master or main branches

.tag-rules:
  rules:
    - if: $CI_COMMIT_TAG # jobs that extends this rule will only execute when a git tag is created

.merge-request-rules:
  rules:
    - if: $CI_PIPELINE_SOURCE == "merge_request_event"  # jobs that extends this rule will only execute when a merge request is created


stages:
  - dev
  - feature
  - master
  - release
  - deploy
  - merge-request
  - tags

dev-script:
  stage: dev
  script: 
    - echo "⚙️⚙️🛠️⚒️🪛 do something only if it is a dev branch ✅✅"
  extends: [.dev-rules]

feature-script:
  stage: feature
  script: 
    - echo "⚙️⚙️🛠️⚒️🪛 do something only if it is a feature branch ✅✅"
  extends: [.feature-rules]

master-script:
  stage: master
  script: 
    - echo "⚙️⚙️🛠️⚒️🪛 do something only if it is a master branch ✅✅"
  extends: [.master-rules]

release-script:
  stage: release
  script: 
    - echo "⚙️⚙️🛠️⚒️🪛 do something only if it is a release branch ✅✅"
  extends: [.release-rules]

merge-request-script:
  stage: merge-request
  script: 
    - echo "⚙️⚙️🛠️⚒️🪛 do something only if it is a Merge Request initialized pipeline ✅✅"
  extends: [.merge-request-rules]

tag-script:
  stage: tags
  script: 
    - echo "⚙️⚙️🛠️⚒️🪛 do something only if the user create a tag ✅✅"
  extends: [.tag-rules]

```


1. **master/main:** The master branch represents the official, production-ready codebase. It should only contain code that is thoroughly tested and deemed stable for release. Master is ONLY to be used for production deploys and releases. 

2. **Develop:** The develop branch serves as a staging area for integrating and testing new features. Developers work on feature branches based off the develop branch.

In addition to these main branches, Gitflow introduces several supporting branches:

3. **Feature branches:** Feature branches are created off the develop branch and are used for developing new features. Once a feature is complete, it is merged back into the develop branch.

4. **Release branches:** Release branches are created when the development on the develop branch has reached a point where a new release is imminent. It allows for final testing, bug fixing, and preparing the release. Once the release is ready, the changes from the release branch are merged into both the master and develop branches, and the release branch is then deleted.

5. **Hotfix branches:** Hotfix branches are created to quickly address critical issues in the production code. These branches are created off the master branch, fixes are made, and then merged back into both master and develop branches. 

The Gitflow workflow provides a structured approach to managing code changes and releases, helping teams to collaborate effectively and manage the software development lifecycle in a systematic manner.
