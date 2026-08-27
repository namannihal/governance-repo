---
id: LMP-PAT-0010
type: Technology Selection Pattern
status: published
approved_by:
  - LMP Migration Architecture Approval
date: 2024-06-03
valid_from: 2024-06-03
developer_productivity_hrs: 5
tags:
  - Database
tech_capabilities:
  - Platform / Data / Database / Relational (SQL) Database
---

# Use of Oracle on Cloud

## Compatibility

This pattern summarises the decisions outlined by *Database Strategy Update: Update to Oracle Guidance*[^1]:

> "While transitioning from Oracle is technically desirable, it is becoming clear that one-size “like for like”
> migration
> to alternative database engines is not an effective approach. If we can reduce commercial complexity and cost of
> migrating and running Oracle in public cloud, we should not eliminate the option of migrating Oracle to Cloud"

## Recommended Target

- Multi-tenant Oracle@Azure
- Dedicated Oracle@Azure
- Oracle on VMs or bare metal

## Decision Tree Diagram

![Decision tree](./img/0010-oracle-decision-tree.png)

[//]: # (## Notable Differences)

## Considerations

- For Oracle Database@Azure, the minimum purchase is a ‘Quarter Rack’. Requirements are gathered by Oracle and
  passed on to Microsoft for provisioning. The ability to expand the infrastructure horizontally and vertically
  (storage, compute, extra rack, etc.) when required is quick but not immediate (hours) and requires a discussion with
  Oracle to provision. In that sense, this is not a ‘true PaaS’, but it is close enough.
- Multi-tenant instances would therefore be more cost-effective, but opportunities to share are limited by regional
  availability (at the time of writing, East US, Germany West Central, UK South, France Central, with other regions "
  coming soon")[^2]
- Unless the workload will be decommissioned before 30 Apr 2026, it should be upgraded to Oracle 23c to maintain
  long term support and avoid extended support charges

## Alternatives

- For non-Oracle databases, see [Azure Database Selection](./0005-relational-databases.md)
- In situations where Database@Azure is unavailable or unsuitable, consider the following:

![Alternative Decision Tree](./img/0010-oracle-alternative-decision-tree.png)

[^1]: [Database Strategy: Update to Oracle Guidance](https://lsegroup.sharepoint.com/:w:/r/teams/TechnologyStrategy-Private/Shared%20Documents/Private/2024/Oracle%20Strategy/Q1%202024%20Database%20Strategy%20Update%20-%20v0.6.docx?d=wce03b502f7784d0fba545bc29d9bcc57&csf=1&web=1&e=eLvRf1&isSPOFile=1)
[^2]: [Oracle Database@Azure](https://www.oracle.com/cloud/azure/oracle-database-at-azure/)

