---
id: LMP-PAT-0038
type: Functional Design Pattern
status: draft
date: 2024-09-18
tags:
  - Event Management
tech_capabilities:
  - Delivery / Operations / Event Management
  - Delivery / Operations / IT Service Management / Application Monitoring
---

# Application Immutable Audit Logging (Functional Design Pattern)

## Context and Problem

In order to provide untampered evidence to auditors when required, there are regulations,
business requirements, and LSEG policies which may require certain types of application
log to be kept in immutable ways (aka WORM state - Write Once, Read Many), in addition to Observability and Monitoring
requirements.

Logs, traces and metrics are known as the 3 pillars of Observability. Audit logs are
a subset of the Logs pillar of Observability,
and they can be generated from both infrastructure level and the application level,
with the latter being more concerned
with the events generated from end-user activities or application business logics
and broadly split between those are required by SIEM (Security Information
and Event Management) requirements,
and those are not of SIEM concerns (e.g. business transaction history,
change logs etc.). They should be sent to different log destinations according
to relavant Guidelines, ADRs and Patterns:
![Application Log Categories and Log Destinations:](img/0038-app-immutable-audit-logging-log-categories.png)

The aim of this pattern is to:

1. Demistify the difference and potential overlaps among Observability, SIEM
   and Audit logging requirements.
2. Provide a reusable reference architecture to help engineering teams design
   compliant and efficient solutions for immutable application logging, in addition
   to the technology choices outlined in existing Guidelines, ADRs and Patterns, including:
    1. [LMP-ADR-0003: Use Datadog SaaS for Application & Resource monitoring][lmp-adr-0003]
    2. [LMP-ADR-0004: Choose OpenTelemetry for Application Telemetry over
       Proprietary Libraries][lmp-adr-0004]
    3. LMP-ADR-0011: Use Azure Immutable Storage for Application-level Audit Logging
    4. [SP-0024: Security Logging - Applications Log Content Guidance][sp-0024]

## Scope

1. This pattern is only applicable to Application-level audit logging
   requirements, with a focus on log event types
   that are not in-scope to SIEM guidelines.
2. This pattern is not for infrastructure level logs,
   which may or may not have immutable storage requirements.
3. This pattern does not cover the technical reference architecture of sending
   application log contents to log desitinations, which will be covered by other
   patterns e.g. [LMP-PAT-0004][lmp-pat-0004].
4. This pattern does not cover design considerations around log persistence
   and corresponding compensation or retry strategy. These should be covered by
   other dedicated design patterns or system capabilities.
5. This pattern does not cover audit log consumption or analytical use cases.

## Use Cases

1. Where there are business or regulatory requirements for the immutable storage of certain
   application-level event types that are not of security concerns, e.g. end-user
   activity logs, application transaction logs, etc..
2. Where there are both observability requirements (e.g. log correlation)
   and immutability requirements of certain event types, which means the same log
   contents need support both Observability
   needs and Auditing requirements.

## Solution

**Summary**: the pattern provides a reusable template to register audit event types,
a set of tailored Azure Immutable Storage configurations, pointers to strategic
Datadog documentations, and recommended way for log contents to be filtered
and forwarded to immutable storage. Log contents persisted in Azure Immutable
Storage can be rehydrated back into Datadog for consumption, but the details
are not covered by this pattern. Please refer to the below detailed descriptions:

1. **Record Keeping for Event Types and Destination Mapping:** Given the potentially
   overlapping application-level
   log event types that are subject to SIEM, Observability and Auditing
   requirements (hereafter is referred
   as 'logging requirement catetories'), it's a best practice to create
   and maintain a record of all log event types,
   their mapping to logging requirement categories, and their required
   retention periods. The below table can be used to capture the minimal information that
   can support both an informed solution design and efficient architecture
   governance assessments:

   | Event Type                                                                                         | Description                                                      | Event Requirement Category                                                                                         | Retention Period Requirement    |
   |----------------------------------------------------------------------------------------------------|------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------|---------------------------------|
   | *named event types as defined by the application, e.g. transaction log, XYZ resource change, etc.* | *brief description of the scope and coverage of this event type* | *one or multiple choices from **SIEM**, **Observability**, **Audit**, so to help inform required log destinations* | *x years, months, days, or N/A* |

2. **Create a dedicated Azure Storage Account with Version-level immutability (VLW) policy,
   as the destination for application audit logs:** The storage account
   should be configured as follows:

    1. **Type of Storage Account**: Standard general-purpose v2
    2. **kind:** StorageV2.
    3. **SKU:** RA-GZRS (read-access geo-zone-redundant storage),
       or ZRS (zone-redundant storage)
       if data localization or other
       constraints apply.
    4. **Access Tier:** Cold (or higher access tiers e.g. Cool or Hot, if the audit data will
       be required for access frequently)
    5. **Enable SFTP:** Set to false, as otherwise immutability policy can't be enabled.
    6. **Enable network file system (NFS) v3:** Set to false, as otherwise immutability
       policy can't be enabled.
    7. **Enable hierarchical namespace:** Set to false, as otherwise immutability
       policy can't be enabled.
    8. **Enable version-level immutability support:** Set to true, so it allows
       re-write log files with immutable version histories when needed.
       Please note, Datadog's Log Archive
       documentation ask not to set 'Immutability Policy' in the destination
       Azure storage account, but Azure's version-level
       immutabiilty policy went to Public Preview on 2021-07-29
       after the [corresponding Datadog documentation was
       created][datadog-doc-github-commit],
       and it will allow rewrite of blob objects.
    9. For other setup steps please refer to [Datadog Log Archiving to
       Azure Storage][datadog-log-archiving-azure] in Confluence.
3. **Tagging Audit Log topics with special tags:** Special tag should be
   applied to all audit log contents falls under those Event Type registered
   under the 'Audit' Event Requirement Categogry (please refer to the registration table in No.1 above),
   in order for Datadog's log pipeline
   determine which logs should be forwarded to Azure immutable storage.
   Recommendation is to use 'auditing' as the tag name. (TODO: register this
   tag name with cloud central team)
4. **Configure Datadog Log-Forwarding for Log Contents that need
   Immutable Storage:** Create and Configure Datadog's Log Archive
   log pipeilne to forward audit logs to Azure Immutable Storage:**
   Please follow [Log Forwarding (Archiving) From Datadog to Custom Destinations][datadog-log-forwarding]
   in Cloud Central's Sharepoint site.

The below diagram summarize the overall architecture of this pattern:
![0032-app-immutable-audit-logging-pattern](img/0038-app-immutable-audit-logging-pattern.png)

## Further Reading

1. [Route logs to third-party systems with Datadog Log Forwarding][datadog-route-logs-blog]
2. [Version-level write once, read many (WORM) policies for immutable blob data][azure-worm-policies]
3. [Log Forwarding (Archiving) From Datadog to Custom Destinations][datadog-log-forwarding]
4. [LMP-PAT-0004: Datadog Integration for Azure Services - Technical Design Pattern][lmp-pat-0004]
5. [Create an Azure storage account][azure-create-storage-account]
   from learn.microsoft.com.

[lmp-adr-0003]: https://app.pages.dx1.lseg.com/app-51723/migration-patterns/mig-pat-source-to-target/adrs/event-management/0003-use-datadog-for-application-and-resource-monitoring/

[lmp-adr-0004]: https://app.pages.dx1.lseg.com/app-51723/migration-patterns/mig-pat-source-to-target/adrs/event-management/0004-choose-open-telemetry-for-application-telemetry-over-proprietary-libraries/

[sp-0024]: https://confluence.refinitiv.com/display/PSAR/SP-0024+-+Security+Logging+-+Applications+Log+Content+Guidance

[lmp-pat-0004]: https://app.pages.dx1.lseg.com/app-51723/migration-patterns/mig-pat-source-to-target/patterns/event-management/0004-observability-tech-ref-arch/

[datadog-doc-github-commit]: https://github.com/DataDog/documentation/commit/f99b4edf0f47064498a9bd560442097c7548ed40

[datadog-log-archiving-azure]: https://confluence.refinitiv.com/display/PCP/Datadog+Log+Archiving+to+Azure+Storage

[datadog-log-forwarding]: https://lsegroup.sharepoint.com/sites/CloudCentral/SitePages/Strategic-Datadog-Log-Management.aspx#log-forwarding(archiving)-from-datadog-to-custom-destinations

[datadog-route-logs-blog]: https://www.datadoghq.com/blog/route-logs-with-datadog-log-forwarding/#:~:text=We%20are%20excited%20to%20announce%20that%20Log%20Pipelines%20supports%20Log

[azure-worm-policies]: https://learn.microsoft.com/en-us/azure/storage/blobs/immutable-version-level-worm-policies

[azure-create-storage-account]: https://learn.microsoft.com/en-us/azure/storage/common/storage-account-create?toc=%2Fazure%2Fstorage%2Fblobs%2Ftoc.json&bc=%2Fazure%2Fstorage%2Fblobs%2Fbreadcrumb%2Ftoc.json&tabs=azure-portal

