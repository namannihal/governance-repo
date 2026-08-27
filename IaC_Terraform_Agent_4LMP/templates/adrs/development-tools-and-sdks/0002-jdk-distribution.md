---
id: LMP-ADR-0002
type: ADR
status: published
approved_by:
  - LMP Migration Architecture Approval
date: 2024-03-04
valid_from: 2024-05-25
tags:
  - Development Tools & SDKs
tech_capabilities:
  - Delivery / Development / Design & Development / Development Tools & SDKs
---

# Use Microsoft OpenJDK as preferred JVM distribution

## Context and Problem Statement

Applications written in Java, or in a language targeting the Java Virtual Machine require both a build-time (Java
Development Kit / JDK) and a run-time software component (Java Runtime Environment / JRE).

Both the Java language and the virtual machine are an open specification, and there are many different _distributions_
of the JDK (which also contains a JRE).

Oracle owns the copyright of Java, and distributes a JDK called "Oracle OpenJDK" under
the [GNU General Public License (GPLv2+CPE)][gpl-cpe]. Other organisations (including Microsoft, AWS and IBM) create
their own distributions based on the OpenJDK.

Oracle also releases their own distribution called "Oracle JDK" under a different license. Some organisations (including
Oracle) also provide paid-for support specifically for users of their distributions. Most distributions of OracleJDK
provide broadly similar functionality. In theory, applications for the JVM should run identically on any compliant JRE,
although there may be variations in performance and some bugs (which may or may not have been back-ported by the
distributor).

Both the language and runtime are also versioned, with the base OpenJDK having a new major version being released
roughly every 6 months. Every 4 versions is considered a more "stable" or "Long Term Support" (LTS) version by many
distributors, which usually means that effort is made to backport fixes to these versions for a more prolonged period of
time. Many distributors will support an LTS version for around 5 years, whereas intermediate versions may not be
supported for any longer than they are the latest version.

LSEG needs an approach towards recommending one or more distributions of JDK/JRE for use by applications looking to
deploy applications on the JVM.

[gpl-cpe]: https://openjdk.org/legal/gplv2+ce.html

## Decision Drivers

- Does the given distribution come with commercial support?
- How long does the distributor support their LTS releases?
- What's the risk of that distributor not maintaining quality of releases?

## Considered Options

- [Oracle Java SE](https://www.oracle.com/uk/java/technologies/java-se-glance.html)
- [Oracle Open JDK](https://jdk.java.net/)
- [AWS Corretto](https://docs.aws.amazon.com/corretto/)
- [Azul JDK](https://www.azul.com/products/core/)
- [Microsoft OpenJDK](https://www.microsoft.com/openjdk)
- [Eclipse Temurin](https://adoptium.net/en-GB/temurin/releases/)

## Decision Outcome

Chosen option: "Microsoft OpenJDK", because:

- No hard organisational requirement for group-wide commercial support for JVM. Groups that need it may wish to choose a
  different distribution.
- Commercial support _is_ available from Microsoft for workloads on Azure
- Part of the Eclipse Adoptium group as a strategic member, so long-term commitment to OpenJDK
- Long term strategic partnership with Microsoft, so established channels can be used to drive influence
- Good packaging options + support for both Windows, Linux and containerised.

If Microsoft OpenJDK is unavailable for some reason, the second choice is "Eclipse Temurin".

### Consequences

- Good, because standard implementation of OpenJDK
- Good, because wide range of build targets and packaging options
- Good, because commercial support is available on Azure
- Neutral, because support not available on non-Azure platforms

### Confirmation

Adoption can be measured by examining both the use of the JDK base container image across application source, as well as
integration of the packaging into the LSEG golden OS images.

## Pros and Cons of the Options

### Oracle Java SE

- Good, because latest version produced and supported by Oracle, Java owner. High-quality releases with strong focus on
  performance and bug-fixes.
- Bad, because only the latest version is available to be used without an explicit license from Oracle. Would need to be
  very proactive about keeping production and non-prod workloads always on the latest release to avoid license issues.

### Oracle OpenJDK

- Good, because canonical OpenJDK release, licensed under GPL+CPE.
- Bad, because no specific commercial support available for any deployment context

### AWS Corretto

- Good, because OpenJDK distribution
- Good, because distributed by AWS with whom we have a strategic partnership
- Good, because commercial support available within the context of our existing support agreement for workloads on AWS
- Bad, because support not available on non-AWS

### Eclipse Temurin

- Good, because OpenJDK distribution created by Adoptium committee, which contains
  many [large backing organisations][temurin-members] (
  including Alibaba, Azul, Bloomberg, Canonical, Google, Huawei, IBM, Microsoft, Red Hat).
- Good, because commercial support available from a [range of suppliers][temurin-support], including Azul, RedHat & IBM.
- Neutral, because we have no existing support agreement from these providers, so this would be at extra cost

[temurin-members]: https://adoptium.net/en-GB/members/

[temurin-support]: https://adoptium.net/en-GB/temurin/commercial-support/

### Azul JDK

- Good, because offers both an OpenJDK build with multiple support tiers
- Good, because also offers ['Prime'][azul-prime], an enhanced version of OpenJDK with specific performance features and
  optimisations. Paid license required for non-dev.
- Neutral, because we have no existing commercial arrangement. Limited benefit of taking their OpenJDK build without
  support.

[azul-prime]: https://www.azul.com/products/prime/

## More Information

### Considerations

- For LMP, the Microsoft OpenJDK build is suggested as the default, given the combination of a standard OpenJDK build
  with the option of specific support for Azure-based workloads.
- Other JDK distributions may be considered if they provide specific features / benefits for an application's
  requirements (e.g. Azul Prime). However, this commercial arrangement + support would need to be arranged specifically
  for that application.
- For the wider organisation, we may revisit this if we enter a wider EA that gives us blanket commercial support over
  _all_ JVM workloads. This may cause us to re-visit and move towards the Eclipse Temurin option.
- The above point may also apply specifically to Oracle, and use of Oracle Java SE. There's still a concern about
  lock-in however - the advantage of OpenJDK is that support is available from a number of different suppliers and is
  only optionally required.

