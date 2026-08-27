<span class="md-content__button md-icon md-status--published" href="#" title="Status: Published"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE4LjUgMmgtMTNDMy42IDIgMiAzLjYgMiA1LjV2MTNDMiAyMC40IDMuNiAyMiA1LjUgMjJIMTZsNi02VjUuNUMyMiAzLjYgMjAuNCAyIDE4LjUgMk0yMCAxNWgtMS41Yy0xLjkgMC0zLjUgMS42LTMuNSAzLjVWMjBINS44Yy0xIDAtMS44LS44LTEuOC0xLjhWNS44QzQgNC44IDQuOCA0IDUuOCA0aDEyLjVjMSAwIDEuOC44IDEuOCAxLjhWMTVtLTQuOS02LjggMS41IDEuNS02IDYtMy41LTMuNSAxLjUtMS41IDIgMnoiIC8+PC9zdmc+) </span> <span class="md-content__button md-icon .md-status--published" title="Valid from 2024-10-16"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE5IDE5SDVWOGgxNG0wLTVoLTFWMWgtMnYySDhWMUg2djJINWEyIDIgMCAwIDAtMiAydjE0YTIgMiAwIDAgMCAyIDJoMTRhMiAyIDAgMCAwIDItMlY1YTIgMiAwIDAgMC0yLTJtLTIuNDcgOC4wNkwxNS40NyAxMGwtNC44OCA0Ljg4LTIuMTItMi4xMi0xLjA2IDEuMDZMMTAuNTkgMTd6IiAvPjwvc3ZnPg==) </span> <span class="md-content__button md-icon actions-date" title="Published on 2024-10-10">![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTkgMTB2Mkg3di0yem00IDB2MmgtMnYtMnptNCAwdjJoLTJ2LTJ6bTItN2EyIDIgMCAwIDEgMiAydjE0YTIgMiAwIDAgMS0yIDJINWEyIDIgMCAwIDEtMi0yVjVhMiAyIDAgMCAxIDItMmgxVjFoMnYyaDhWMWgydjJ6bTAgMTZWOEg1djExek05IDE0djJIN3YtMnptNCAwdjJoLTJ2LTJ6bTQgMHYyaC0ydi0yeiIgLz48L3N2Zz4=)</span> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/edit/main/docs/patterns/data-management/0036-daas-consumption-pattern.md" class="md-content__button md-icon" title="Edit this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTEwIDIwSDZWNGg3djVoNXYzLjFsMi0yVjhsLTYtNkg2Yy0xLjEgMC0yIC45LTIgMnYxNmMwIDEuMS45IDIgMiAyaDR6bTEwLjItN2MuMSAwIC4zLjEuNC4ybDEuMyAxLjNjLjIuMi4yLjYgMCAuOGwtMSAxLTIuMS0yLjEgMS0xYy4xLS4xLjItLjIuNC0uMm0wIDMuOUwxNC4xIDIzSDEydi0yLjFsNi4xLTYuMXoiIC8+PC9zdmc+" /></a> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/blob/main/docs/patterns/data-management/0036-daas-consumption-pattern.md" class="md-content__button md-icon" title="View source of this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE3IDE4Yy41NiAwIDEgLjQ0IDEgMXMtLjQ0IDEtMSAxLTEtLjQ0LTEtMSAuNDQtMSAxLTFtMC0zYy0yLjczIDAtNS4wNiAxLjY2LTYgNCAuOTQgMi4zNCAzLjI3IDQgNiA0czUuMDYtMS42NiA2LTRjLS45NC0yLjM0LTMuMjctNC02LTRtMCA2LjVhMi41IDIuNSAwIDAgMS0yLjUtMi41IDIuNSAyLjUgMCAwIDEgMi41LTIuNSAyLjUgMi41IDAgMCAxIDIuNSAyLjUgMi41IDIuNSAwIDAgMS0yLjUgMi41TTkuMjcgMjBINlY0aDd2NWg1djQuMDdjLjcuMDggMS4zNi4yNSAyIC40OVY4bC02LTZINmEyIDIgMCAwIDAtMiAydjE2YTIgMiAwIDAgMCAyIDJoNC41YTguMiA4LjIgMCAwIDEtMS4yMy0yIiAvPjwvc3ZnPg==" /></a>

Document Metadata

|  |  |
|----|----|
| Identifier | **`LMP-PAT-0036`** |
| Type | **Functional Design Pattern** |
| Status | **Published** |
| Approvals | <span class="md-tag">LMP Migration Architecture Approval</span> |
| Published on | **October 10, 2024** |
| Valid From | **October 16, 2024** |
| Authors | <span class="md-source-file__fact"> </span> |
| Tags | <span class="md-tag">Data Management</span> |
| Technology Capabilities | <span class="md-tag">Platform / Data / Data Management</span> |

# Data-as-a-Service Consumption Pattern<a href="#data-as-a-service-consumption-pattern" class="headerlink" title="Permanent link">¶</a>

## Introduction<a href="#introduction" class="headerlink" title="Permanent link">¶</a>

Data-as-a-Service (DaaS) represents the strategic approach for distributing non-real time data both internally within Data and Analytics as well as externally to feeds customers. Internally, it will eventually replace the use of SDIs to replicate data and the use of CCC as a cross content query capability for a wide variety of internal use cases. The initial focus of Release 1 of DaaS has been on customer consumption patterns, and while we want to re-use the same capabilities internally and externally (i.e. "eating our own dog food"), we recognise that there are some limitations that may restrict their usefulness.

This pattern provides guidance and approved designs for teams to consume data from the DaaS platform. It reflects the current state of maturity immediately post Release 1. In some cases these patterns are dependent on additional implementation work post Release 1.

## Scope<a href="#scope" class="headerlink" title="Permanent link">¶</a>

This pattern is applicable to Internal products and applications needing:

- to query data within DaaS
- to replicate data from DaaS into their own data stores
- to access data from Microsoft Fabric

The scope of the pattern includes:

- definition of available consumption mechanisms and the types of use case it supports
- outline of pros and cons of the different mechanisms
- a statement on whether the consumption mechanism is approved for internal use
- summary of any required implementation work to make the mechanisms approved

## Pattern Definition<a href="#pattern-definition" class="headerlink" title="Permanent link">¶</a>

The following consumption patterns are available for use:

### 1. Customer SQL Endpoint<a href="#1-customer-sql-endpoint" class="headerlink" title="Permanent link">¶</a>

Create consumer specific workspace with permissioned views configured via SQL End Point. Additional “Internal Products” defined in PRM and provisioned via “non-commercial” workflows.

#### Pros<a href="#pros" class="headerlink" title="Permanent link">¶</a>

- PRM based access control is enforced
- Allows query access to any available data
- Provides resource isolation across consumers
- Eating our own dog food

#### Cons<a href="#cons" class="headerlink" title="Permanent link">¶</a>

- Requires additional product and segment definitions
- Does not support access to “change data feed”
- Could result in over provisioning of capacities
- No Spark access to data
- AAA Provisioning flows need to be built

#### Recommendation<a href="#recommendation" class="headerlink" title="Permanent link">¶</a>

This pattern is approved for use but currently requires manual provisioning of the consumer workspace and service principal identity immediately post Release 1.

### 2. Customer Feed Files<a href="#2-customer-feed-files" class="headerlink" title="Permanent link">¶</a>

Leverage existing Bulk capabilities to generate “product” feed files. Internal products and segments may need to be defined within PRM. AAA accounts are needed by consumers to access the feed files.

#### Pros<a href="#pros_1" class="headerlink" title="Permanent link">¶</a>

- Additional “Internal Products” defined in PRM and provisioned via “non-commercial” workflows
- PRM based access control is enforced
- Supports replication of data and access to changes
- Eating our own dog food

#### Cons<a href="#cons_1" class="headerlink" title="Permanent link">¶</a>

- Requires additional product and segment definitions
- Schedules may delay data availability
- CSV file formats are problematic to use due to weak data typing
- AAA Provisioning flows need to be built

#### Recommendation<a href="#recommendation_1" class="headerlink" title="Permanent link">¶</a>

It is recommended that internal consumers hold off using the product feed files until a strongly typed format (e.g. Parquet) of feed files is introduced. Such a format could also be the basis of other distribution mechanisms such as Customer Data Shares (see 5 below).

### 3. Shared Distribution SQL Endpoint<a href="#3-shared-distribution-sql-endpoint" class="headerlink" title="Permanent link">¶</a>

The recent support within Fabric of three part naming allows all LSEG content to be brought together into a single workspace in a well organised manner. This eliminates the need for having multiple duplicate shortcuts of the same data within different workspaces as has been necessary during the development of Release 1.

This consumption mechanism requires some work to create a central distribution workspace. The data from the existing distribution workspaces (CompanyData. Classifications and PricingAndReferenceData) must be shortcut into corresponding lakehouses and schemas as shown in Figure 1.

![Core Distribution Configuration](0036-daas-consumption-pattern.assets/image-001.png)

Figure 1 - Required Configuration of Core Distribution Workspace

The SQL end point of this workspace should be made available to internal consumers, and can be made available for all internal users using their lseg.com credentials. This SQL end point should also be used for applications such as PRM to access data, and should (over time) become the point from which any additional downstream shortcuts are established.

Duplicate shortcuts - notably Value Domains - within the upstream distribution workspaces should eventually be removed.

#### Pros<a href="#pros_2" class="headerlink" title="Permanent link">¶</a>

- Allows query across all data in the platform
- A single shared capacity is more cost-effective for ad-hoc usage
- Can support all internal users – e.g. business users and other use cases e.g. PRM
- Could support with internal credentials
- Removes ambiguity about which shortcut copy should be referenced e.g. in PRM definitions
- Allows clean up of shortcut duplication

#### Cons<a href="#cons_2" class="headerlink" title="Permanent link">¶</a>

- By-passes PRM based access control – all or nothing
- Risk of capacity resource starvation for production use cases
- Does not support access to “change data feed”
- No Spark access to data

#### Recommendation<a href="#recommendation_2" class="headerlink" title="Permanent link">¶</a>

This is the recommended consumption mechanisms for ad-hoc query use cases across the business and for relatively infrequent production access. Implementation of the Core Distribution Workspace should be prioritised as soon as possible.

### 4. Ad-hoc Shortcuts<a href="#4-ad-hoc-shortcuts" class="headerlink" title="Permanent link">¶</a>

Create shortcuts as required from distribution data sources into consumer workspaces.

#### Pros<a href="#pros_3" class="headerlink" title="Permanent link">¶</a>

- Supports Spark access
- Supports Change Data Feed
- Provides (compute) resource isolation for consumers

#### Cons<a href="#cons_3" class="headerlink" title="Permanent link">¶</a>

- By-passes PRM based access control – on shortcut provisioning
- Tight coupling of consumers to core delta tables without clear tracking of dependencies
- Difficult to manage and support
- Not supported by access group definitions which would allow write-access by default
- May run in to shortcut limits

#### Recommendation<a href="#recommendation_3" class="headerlink" title="Permanent link">¶</a>

This approach is not approved as an internal use pattern due to likely proliferation of tightly coupled consumers. This will make any changes to any upstream processing pipelines extremely risky, and reduce the velocity of platform development.

### 5. Customer Data Share<a href="#5-customer-data-share" class="headerlink" title="Permanent link">¶</a>

While a customer data share was originally discussed for Release 1, this was subsequently de-scoped, in part due to uncertainty on whether underlying "One Security" capabilities would support the enforcement of permissions, or whether the permissioned data would need to be materialised for each customer or product.

Distributing data to customers via "data shares" is still an attractive direction in a variety of different cloud technologies, and so progressing such a solution for internal use cases helps lay the groundwork for a customer facing solution, while allowing some of the more complex permissioning use cases to be deferred.

An initial internal release would automate the creation of read-only shortcuts from the defined distribution points ( the Core Distribution Workspace described above), and, in the future, support the permissions filtering of the underlying data in a similar way to the bulk feed files are currently generated, although using a delta/parquet output format.

#### Pros<a href="#pros_4" class="headerlink" title="Permanent link">¶</a>

- Supports Spark access
- Supports Change Data Feed
- Provides (compute) resource isolation for consumers
- Drives forward customer data share capability
- PRM based access control is enforced (if included in initial scope)

#### Cons<a href="#cons_4" class="headerlink" title="Permanent link">¶</a>

- Additional development work required to achieve
- Need to materialise various permissions profiles (in the absence of a one security based solution)

#### Recommendation<a href="#recommendation_4" class="headerlink" title="Permanent link">¶</a>

This consumption approach is recommended over Ad Hoc shortcuts described in 4. The implementation of required capabilities - in particular APIs to manage and control the shortcuts, and basic permissions filtering - should be prioritised post Release 1.

<span class="md-source-file__fact"> <span class="md-icon" title="Last update"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIxIDEzLjFjLS4xIDAtLjMuMS0uNC4ybC0xIDEgMi4xIDIuMSAxLTFjLjItLjIuMi0uNiAwLS44bC0xLjMtMS4zYy0uMS0uMS0uMi0uMi0uNC0uMm0tMS45IDEuOC02LjEgNlYyM2gyLjFsNi4xLTYuMXpNMTIuNSA3djUuMmw0IDIuNC0xIDFMMTEgMTNWN3pNMTEgMjEuOWMtNS4xLS41LTktNC44LTktOS45QzIgNi41IDYuNSAyIDEyIDJjNS4zIDAgOS42IDQuMSAxMCA5LjMtLjMtLjEtLjYtLjItMS0uMnMtLjcuMS0xIC4yQzE5LjYgNy4yIDE2LjIgNCAxMiA0Yy00LjQgMC04IDMuNi04IDggMCA0LjEgMy4xIDcuNSA3LjEgNy45bC0uMS4yeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="May 30, 2025 16:15:49 UTC">May 30, 2025</span> </span> <span class="md-source-file__fact"> <span class="md-icon" title="Created"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE0LjQ3IDE1LjA4IDExIDEzVjdoMS41djUuMjVsMy4wOCAxLjgzYy0uNDEuMjgtLjc5LjYyLTEuMTEgMW0tMS4zOSA0Ljg0Yy0uMzYuMDUtLjcxLjA4LTEuMDguMDgtNC40MiAwLTgtMy41OC04LThzMy41OC04IDgtOCA4IDMuNTggOCA4YzAgLjM3LS4wMy43Mi0uMDggMS4wOC42OS4xIDEuMzMuMzIgMS45Mi42NC4xLS41Ni4xNi0xLjEzLjE2LTEuNzIgMC01LjUtNC41LTEwLTEwLTEwUzIgNi41IDIgMTJzNC40NyAxMCAxMCAxMGMuNTkgMCAxLjE2LS4wNiAxLjcyLS4xNi0uMzItLjU5LS41NC0xLjIzLS42NC0xLjkyTTE4IDE1djNoLTN2MmgzdjNoMnYtM2gzdi0yaC0zdi0zeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="October 11, 2024 09:59:27 UTC">October 11, 2024</span> </span>

<a href="../0029-daas-publishing/" class="md-footer__link md-footer__link--prev" aria-label="Previous: Data-as-a-Service Publishing Pattern"></a>

<div class="md-footer__button md-icon">

![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIwIDExdjJIOGw1LjUgNS41LTEuNDIgMS40Mkw0LjE2IDEybDcuOTItNy45MkwxMy41IDUuNSA4IDExeiIgLz48L3N2Zz4=)

</div>

<div class="md-footer__title">

<span class="md-footer__direction"> Previous </span>

<div class="md-ellipsis">

Data-as-a-Service Publishing Pattern

</div>

</div>

<a href="../0044-architecture-selection-for-large-volume-file-migration/" class="md-footer__link md-footer__link--next" aria-label="Next: Architectural Selection for Large Volume File Migration from On-Premises to Azure"></a>

<div class="md-footer__title">

<span class="md-footer__direction"> Next </span>

<div class="md-ellipsis">

Architectural Selection for Large Volume File Migration from On-Premises to Azure

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
