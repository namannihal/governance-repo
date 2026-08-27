<span class="md-content__button md-icon md-status--published" href="#" title="Status: Published"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE4LjUgMmgtMTNDMy42IDIgMiAzLjYgMiA1LjV2MTNDMiAyMC40IDMuNiAyMiA1LjUgMjJIMTZsNi02VjUuNUMyMiAzLjYgMjAuNCAyIDE4LjUgMk0yMCAxNWgtMS41Yy0xLjkgMC0zLjUgMS42LTMuNSAzLjVWMjBINS44Yy0xIDAtMS44LS44LTEuOC0xLjhWNS44QzQgNC44IDQuOCA0IDUuOCA0aDEyLjVjMSAwIDEuOC44IDEuOCAxLjhWMTVtLTQuOS02LjggMS41IDEuNS02IDYtMy41LTMuNSAxLjUtMS41IDIgMnoiIC8+PC9zdmc+) </span> <span class="md-content__button md-icon .md-status--published" title="Valid from 2024-05-25"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE5IDE5SDVWOGgxNG0wLTVoLTFWMWgtMnYySDhWMUg2djJINWEyIDIgMCAwIDAtMiAydjE0YTIgMiAwIDAgMCAyIDJoMTRhMiAyIDAgMCAwIDItMlY1YTIgMiAwIDAgMC0yLTJtLTIuNDcgOC4wNkwxNS40NyAxMGwtNC44OCA0Ljg4LTIuMTItMi4xMi0xLjA2IDEuMDZMMTAuNTkgMTd6IiAvPjwvc3ZnPg==) </span> <span class="md-content__button md-icon actions-date" title="Published on 2024-03-04">![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTkgMTB2Mkg3di0yem00IDB2MmgtMnYtMnptNCAwdjJoLTJ2LTJ6bTItN2EyIDIgMCAwIDEgMiAydjE0YTIgMiAwIDAgMS0yIDJINWEyIDIgMCAwIDEtMi0yVjVhMiAyIDAgMCAxIDItMmgxVjFoMnYyaDhWMWgydjJ6bTAgMTZWOEg1djExek05IDE0djJIN3YtMnptNCAwdjJoLTJ2LTJ6bTQgMHYyaC0ydi0yeiIgLz48L3N2Zz4=)</span> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/edit/main/docs/adrs/development-tools-and-sdks/0002-jdk-distribution.md" class="md-content__button md-icon" title="Edit this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTEwIDIwSDZWNGg3djVoNXYzLjFsMi0yVjhsLTYtNkg2Yy0xLjEgMC0yIC45LTIgMnYxNmMwIDEuMS45IDIgMiAyaDR6bTEwLjItN2MuMSAwIC4zLjEuNC4ybDEuMyAxLjNjLjIuMi4yLjYgMCAuOGwtMSAxLTIuMS0yLjEgMS0xYy4xLS4xLjItLjIuNC0uMm0wIDMuOUwxNC4xIDIzSDEydi0yLjFsNi4xLTYuMXoiIC8+PC9zdmc+" /></a> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/blob/main/docs/adrs/development-tools-and-sdks/0002-jdk-distribution.md" class="md-content__button md-icon" title="View source of this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE3IDE4Yy41NiAwIDEgLjQ0IDEgMXMtLjQ0IDEtMSAxLTEtLjQ0LTEtMSAuNDQtMSAxLTFtMC0zYy0yLjczIDAtNS4wNiAxLjY2LTYgNCAuOTQgMi4zNCAzLjI3IDQgNiA0czUuMDYtMS42NiA2LTRjLS45NC0yLjM0LTMuMjctNC02LTRtMCA2LjVhMi41IDIuNSAwIDAgMS0yLjUtMi41IDIuNSAyLjUgMCAwIDEgMi41LTIuNSAyLjUgMi41IDAgMCAxIDIuNSAyLjUgMi41IDIuNSAwIDAgMS0yLjUgMi41TTkuMjcgMjBINlY0aDd2NWg1djQuMDdjLjcuMDggMS4zNi4yNSAyIC40OVY4bC02LTZINmEyIDIgMCAwIDAtMiAydjE2YTIgMiAwIDAgMCAyIDJoNC41YTguMiA4LjIgMCAwIDEtMS4yMy0yIiAvPjwvc3ZnPg==" /></a>

Document Metadata

|  |  |
|----|----|
| Identifier | **`LMP-ADR-0002`** |
| Type | **ADR** |
| Status | **Published** |
| Approvals | <span class="md-tag">LMP Migration Architecture Approval</span> |
| Published on | **March 04, 2024** |
| Valid From | **May 25, 2024** |
| Authors | <span class="md-source-file__fact"> </span> |
| Tags | <span class="md-tag">Development Tools & SDKs</span> |
| Technology Capabilities | <span class="md-tag">Delivery / Development / Design & Development / Development Tools & SDKs</span> |

# Use Microsoft OpenJDK as preferred JVM distribution<a href="#use-microsoft-openjdk-as-preferred-jvm-distribution" class="headerlink" title="Permanent link">¶</a>

## Context and Problem Statement<a href="#context-and-problem-statement" class="headerlink" title="Permanent link">¶</a>

Applications written in Java, or in a language targeting the Java Virtual Machine require both a build-time (Java Development Kit / JDK) and a run-time software component (Java Runtime Environment / JRE).

Both the Java language and the virtual machine are an open specification, and there are many different *distributions* of the JDK (which also contains a JRE).

Oracle owns the copyright of Java, and distributes a JDK called "Oracle OpenJDK" under the [GNU General Public License (GPLv2+CPE)](https://openjdk.org/legal/gplv2+ce.html). Other organisations (including Microsoft, AWS and IBM) create their own distributions based on the OpenJDK.

Oracle also releases their own distribution called "Oracle JDK" under a different license. Some organisations (including Oracle) also provide paid-for support specifically for users of their distributions. Most distributions of OracleJDK provide broadly similar functionality. In theory, applications for the JVM should run identically on any compliant JRE, although there may be variations in performance and some bugs (which may or may not have been back-ported by the distributor).

Both the language and runtime are also versioned, with the base OpenJDK having a new major version being released roughly every 6 months. Every 4 versions is considered a more "stable" or "Long Term Support" (LTS) version by many distributors, which usually means that effort is made to backport fixes to these versions for a more prolonged period of time. Many distributors will support an LTS version for around 5 years, whereas intermediate versions may not be supported for any longer than they are the latest version.

LSEG needs an approach towards recommending one or more distributions of JDK/JRE for use by applications looking to deploy applications on the JVM.

## Decision Drivers<a href="#decision-drivers" class="headerlink" title="Permanent link">¶</a>

- Does the given distribution come with commercial support?
- How long does the distributor support their LTS releases?
- What's the risk of that distributor not maintaining quality of releases?

## Considered Options<a href="#considered-options" class="headerlink" title="Permanent link">¶</a>

- [Oracle Java SE](https://www.oracle.com/uk/java/technologies/java-se-glance.html)
- [Oracle Open JDK](https://jdk.java.net/)
- [AWS Corretto](https://docs.aws.amazon.com/corretto/)
- [Azul JDK](https://www.azul.com/products/core/)
- [Microsoft OpenJDK](https://www.microsoft.com/openjdk)
- [Eclipse Temurin](https://adoptium.net/en-GB/temurin/releases/)

## Decision Outcome<a href="#decision-outcome" class="headerlink" title="Permanent link">¶</a>

Chosen option: "Microsoft OpenJDK", because:

- No hard organisational requirement for group-wide commercial support for JVM. Groups that need it may wish to choose a different distribution.
- Commercial support *is* available from Microsoft for workloads on Azure
- Part of the Eclipse Adoptium group as a strategic member, so long-term commitment to OpenJDK
- Long term strategic partnership with Microsoft, so established channels can be used to drive influence
- Good packaging options + support for both Windows, Linux and containerised.

If Microsoft OpenJDK is unavailable for some reason, the second choice is "Eclipse Temurin".

### Consequences<a href="#consequences" class="headerlink" title="Permanent link">¶</a>

- Good, because standard implementation of OpenJDK
- Good, because wide range of build targets and packaging options
- Good, because commercial support is available on Azure
- Neutral, because support not available on non-Azure platforms

### Confirmation<a href="#confirmation" class="headerlink" title="Permanent link">¶</a>

Adoption can be measured by examining both the use of the JDK base container image across application source, as well as integration of the packaging into the LSEG golden OS images.

## Pros and Cons of the Options<a href="#pros-and-cons-of-the-options" class="headerlink" title="Permanent link">¶</a>

### Oracle Java SE<a href="#oracle-java-se" class="headerlink" title="Permanent link">¶</a>

- Good, because latest version produced and supported by Oracle, Java owner. High-quality releases with strong focus on performance and bug-fixes.
- Bad, because only the latest version is available to be used without an explicit license from Oracle. Would need to be very proactive about keeping production and non-prod workloads always on the latest release to avoid license issues.

### Oracle OpenJDK<a href="#oracle-openjdk" class="headerlink" title="Permanent link">¶</a>

- Good, because canonical OpenJDK release, licensed under GPL+CPE.
- Bad, because no specific commercial support available for any deployment context

### AWS Corretto<a href="#aws-corretto" class="headerlink" title="Permanent link">¶</a>

- Good, because OpenJDK distribution
- Good, because distributed by AWS with whom we have a strategic partnership
- Good, because commercial support available within the context of our existing support agreement for workloads on AWS
- Bad, because support not available on non-AWS

### Eclipse Temurin<a href="#eclipse-temurin" class="headerlink" title="Permanent link">¶</a>

- Good, because OpenJDK distribution created by Adoptium committee, which contains many [large backing organisations](https://adoptium.net/en-GB/members/) ( including Alibaba, Azul, Bloomberg, Canonical, Google, Huawei, IBM, Microsoft, Red Hat).
- Good, because commercial support available from a [range of suppliers](https://adoptium.net/en-GB/temurin/commercial-support/), including Azul, RedHat & IBM.
- Neutral, because we have no existing support agreement from these providers, so this would be at extra cost

### Azul JDK<a href="#azul-jdk" class="headerlink" title="Permanent link">¶</a>

- Good, because offers both an OpenJDK build with multiple support tiers
- Good, because also offers ['Prime'](https://www.azul.com/products/prime/), an enhanced version of OpenJDK with specific performance features and optimisations. Paid license required for non-dev.
- Neutral, because we have no existing commercial arrangement. Limited benefit of taking their OpenJDK build without support.

## More Information<a href="#more-information" class="headerlink" title="Permanent link">¶</a>

### Considerations<a href="#considerations" class="headerlink" title="Permanent link">¶</a>

- For LMP, the Microsoft OpenJDK build is suggested as the default, given the combination of a standard OpenJDK build with the option of specific support for Azure-based workloads.
- Other JDK distributions may be considered if they provide specific features / benefits for an application's requirements (e.g. Azul Prime). However, this commercial arrangement + support would need to be arranged specifically for that application.
- For the wider organisation, we may revisit this if we enter a wider EA that gives us blanket commercial support over *all* JVM workloads. This may cause us to re-visit and move towards the Eclipse Temurin option.
- The above point may also apply specifically to Oracle, and use of Oracle Java SE. There's still a concern about lock-in however - the advantage of OpenJDK is that support is available from a number of different suppliers and is only optionally required.

<span class="md-source-file__fact"> <span class="md-icon" title="Last update"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIxIDEzLjFjLS4xIDAtLjMuMS0uNC4ybC0xIDEgMi4xIDIuMSAxLTFjLjItLjIuMi0uNiAwLS44bC0xLjMtMS4zYy0uMS0uMS0uMi0uMi0uNC0uMm0tMS45IDEuOC02LjEgNlYyM2gyLjFsNi4xLTYuMXpNMTIuNSA3djUuMmw0IDIuNC0xIDFMMTEgMTNWN3pNMTEgMjEuOWMtNS4xLS41LTktNC44LTktOS45QzIgNi41IDYuNSAyIDEyIDJjNS4zIDAgOS42IDQuMSAxMCA5LjMtLjMtLjEtLjYtLjItMS0uMnMtLjcuMS0xIC4yQzE5LjYgNy4yIDE2LjIgNCAxMiA0Yy00LjQgMC04IDMuNi04IDggMCA0LjEgMy4xIDcuNSA3LjEgNy45bC0uMS4yeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="December 10, 2024 10:03:44 UTC">December 10, 2024</span> </span> <span class="md-source-file__fact"> <span class="md-icon" title="Created"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE0LjQ3IDE1LjA4IDExIDEzVjdoMS41djUuMjVsMy4wOCAxLjgzYy0uNDEuMjgtLjc5LjYyLTEuMTEgMW0tMS4zOSA0Ljg0Yy0uMzYuMDUtLjcxLjA4LTEuMDguMDgtNC40MiAwLTgtMy41OC04LThzMy41OC04IDgtOCA4IDMuNTggOCA4YzAgLjM3LS4wMy43Mi0uMDggMS4wOC42OS4xIDEuMzMuMzIgMS45Mi42NC4xLS41Ni4xNi0xLjEzLjE2LTEuNzIgMC01LjUtNC41LTEwLTEwLTEwUzIgNi41IDIgMTJzNC40NyAxMCAxMCAxMGMuNTkgMCAxLjE2LS4wNiAxLjcyLS4xNi0uMzItLjU5LS41NC0xLjIzLS42NC0xLjkyTTE4IDE1djNoLTN2MmgzdjNoMnYtM2gzdi0yaC0zdi0zeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="April 19, 2024 11:02:20 UTC">April 19, 2024</span> </span>

<a href="../../deployment-and-administration/0016-use-dxone-shared-runners-to-deploy-to-environments/" class="md-footer__link md-footer__link--prev" aria-label="Previous: Use DXOne Shared Runners to Deploy to Environments"></a>

<div class="md-footer__button md-icon">

![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIwIDExdjJIOGw1LjUgNS41LTEuNDIgMS40Mkw0LjE2IDEybDcuOTItNy45MkwxMy41IDUuNSA4IDExeiIgLz48L3N2Zz4=)

</div>

<div class="md-footer__title">

<span class="md-footer__direction"> Previous </span>

<div class="md-ellipsis">

Use DXOne Shared Runners to Deploy to Environments

</div>

</div>

<a href="../../event-management/0003-use-datadog-for-application-and-resource-monitoring/" class="md-footer__link md-footer__link--next" aria-label="Next: Use Datadog SaaS for Application &amp;amp; Resource monitoring"></a>

<div class="md-footer__title">

<span class="md-footer__direction"> Next </span>

<div class="md-ellipsis">

Use Datadog SaaS for Application & Resource monitoring

</div>

</div>

<div class="md-footer__button md-icon">

![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTQgMTF2MmgxMmwtNS41IDUuNSAxLjQyIDEuNDJMMTkuODQgMTJsLTcuOTItNy45MkwxMC41IDUuNSAxNiAxMXoiIC8+PC9zdmc+)

</div>

<div class="md-footer-meta md-typeset">

<div class="md-footer-meta__inner md-grid">

<div class="md-copyright">

Made with <a href="https://squidfunk.github.io/mkdocs-material/" target="_blank" rel="noopener">Material for MkDocs</a>

</div>

</div>

</div>

<div class="md-dialog" md-component="dialog">

<div class="md-dialog__inner md-typeset">

</div>

</div>
