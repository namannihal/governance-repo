---
id: LMP-ADR-0010
type: ADR
status: published
approved_by:
  - LMP Migration Architecture Approval
date: 2024-05-07
valid_from: 2025-05-25
tags:
  - Event Management
tech_capabilities:
  - Delivery / Operations / Event Management
  - Delivery / Operations / IT Service Management / Application Monitoring
---

# Share Datadog & BigPanda responsibilities between Platform Engineering, Application and LMP Migration Teams

## Context and Problem Statement

As per [ADR 0003](./0003-use-datadog-for-application-and-resource-monitoring.md), Datadog and BigPanda are the Group's
default tools for observability.

To onboard to them and integrate with them during a Migration project, various tasks need to be performed via various
teams.

Clarity over responsibilities is paramount if we are to ensure efficient integration during Migration projects.

## Decision Drivers

The RACI below is driven by a need to clarify roles and responsibilities, particularly in terms of application
integration.

## Considered Options

- No alternatives considered, but the correct degree of responsibility per task was debated and agreed with each team

## Decision Outcome

| Tasks                                      |  LSEG Platform Engineering Team[^1] | Cloud Enablement Team |  LSEG Application Architects |  LSEG Application Team |  LMP Migration Execution Team |  LMP-SRE-OPS-Tech_F - Corporate Technology | MSFT Cloud Patterns Squad |
|--------------------------------------------|-------------------------------------|-----------------------|------------------------------|------------------------|-------------------------------|--------------------------------------------|---------------------------|
| Application/Datadog Onboarding             | R                                   | N/A                   | I                            | A                      | I                             |  I                                         |  N/A                      |
| Application/Datadog Integration            | N/A                                 | N/A                   | C                            | A                      | C                             | R                                          |  N/A                      |
| Application/BigPanda Integration           | N/A                                 |  C                    | C                            |  R                     | C                             |  N/A                                       |  N/A                      |
| BigPanda/Datadog Integration               | A                                   | N/A                   |  I                           | I                      | N/A                           |  N/A                                       |  I                        |
| Configure Platform Resource Metrics & Logs | R                                   | N/A                   | C                            | A                      | I                             |  N/A                                       |  I                        |
| Configure Application Metrics & Logs       | N/A                                 |  C                    | C                            | A                      | C                             |  N/A                                       |  I                        |
| Post Deployment Monitoring in Datadog      | N/A                                 |  C                    | C                            | A                      | C                             |  N/A                                       |  N/A                      |
| Default Dashboarding                       | R                                   |  C                    | C                            | A                      |  I                            |  N/A                                       |  N/A                      |
| Custom Dashboarding                        | N/A                                 |  C                    | C                            | A                      |  I                            |  N/A                                       |  C                        |
| Configure Default Event Alert              | R                                   |  C                    | C                            | A                      |  I                            |  N/A                                       |  I                        |
| Configure Custom Event Alert               | N/A                                 |  C                    | C                            | A                      | C                             |  N/A                                       |  N/A                      |

### Confirmation

The decision was validated in agreement with the individuals named in the frontmatter, above.

## More Information

Please see the following for additional support information / next steps.

### BigPanda Support

- [Unified BigPanda Integration with Strategic Datadog Platform](https://confluence.refinitiv.com/display/PCP/Unified+BigPanda+Integration+with+Strategic+Datadog+Platform)
- [LSEG BigPanda Support](https://lsegroup.sharepoint.com/sites/EnterpriseServices/SitePages/BigPanda.aspx?CT=1711459870707&OR=OWA-NT-Mail&CID=b59b4075-33af-323b-e004-0a9f023c3ee7)
- Status Page: <https://status.bigPanda.io>
- Email: <support@bigPanda.io>
- P1 Email: <support-emergency@bigPanda.io>
- P1 Phone: +1 (855) 787-0099
- Availability:
    - Monday - Friday, 7AM - 7PM (PST)
    - Not Including US Holidays

### Datadog Support

- [Datadog Support](https://lsegroup.sharepoint.com/sites/CloudCentral/SitePages/datadog-support.aspx?xsdata=MDV8MDJ8fDA3MWFhNTlkYTBkOTQ0OWViZDYzMDhkYzQ5OTEwZjQ2fDI4N2U5ZjBlOTFlYzRjZjBiN2E0YzYzODk4MDcyMTgxfDB8MHw2Mzg0NjYxMzQ1NTUxNDc2MTl8VW5rbm93bnxWR1ZoYlhOVFpXTjFjbWwwZVZObGNuWnBZMlY4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazkwYUdWeUlpd2lWMVFpT2pFeGZRPT18MXxMMk5vWVhSekx6RTVPbUkyTVdFeU5UVTJZbUpqWWpRMVkyUmhORGs0TTJZeE9EZzNabVJqWmpkalFIUm9jbVZoWkM1Mk1pOXRaWE56WVdkbGN5OHhOekV4TURFMk5qVTFNREF4fDM1ODYzNTIwM2U3YjRhMThiZDYzMDhkYzQ5OTEwZjQ2fDdiNmI0YmQ2ODNlNDQ5OTZiZjI2Yjk4Y2U5NTg0NWFj&sdata=UFdiV0twVk9rYVVvT2FhNFhiN3pXVWVWVnB1dWdKajhTOXNpNm1mSFQrVT0%3D&ovuser=287e9f0e-91ec-4cf0-b7a4-c63898072181%2Cayan.banerjee%40lseg.com&OR=Teams-HL&CT=1711460312307&clickparams=eyJBcHBOYW1lIjoiVGVhbXMtRGVza3RvcCIsIkFwcFZlcnNpb24iOiIyNy8yNDAyMjkyMDYwMiIsIkhhc0ZlZGVyYXRlZFVzZXIiOmZhbHNlfQ%3D%3D)

For any technical issue/support required for Datadog onboarding or customization,
please raise a support request using your LSEG email id (need to register first),
with DataDog here <https://help.datadoghq.com/hc/en-us> or send an email to Datadog
Support <support@datadog.zendesk.com>.

[^1]: *LSEG Platform Engineering Team* refers to the *Cloud Engineering & Architecture* group under the *Head of Cloud*

