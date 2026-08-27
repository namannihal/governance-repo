---
id: LMP-PAT-0025
status: published
approved_by:
  - LMP Migration Architecture Approval
type: Technology Selection Pattern
date: 2024-06-03
valid_from: 2024-06-03
developer_productivity_hrs: 5
tags:
  - Virtual Compute & Containers
tech_capabilities:
  - Infrastructure / Compute / Virtual Compute & Containers
---

# Operating System

## Introduction

As part of the migration and modernisation of applications to Azure, upgrades to the more recent updated versions of
operating systems or transition to different operating systems may be required. The purpose of this document is to
provide guidance on potential Operating system targets and considerations.

The diagram below represents a high level flow of the decision process, and subsequent considerations.

## Decision Tree Diagram

![OS Migration Pathway](img/0025-os-process.png)

Note: Refer to the Greenfield Golden Image repository for the latest available images

## Supportability Considerations

Considerations for operating system selections should always aim to achieve the latest supported operating system
considering;

- Available licencing within LSEG
- Operating systems supported for use in LSEG LMP Greenfield, both for major, and minor build versions. Images must not
  be older than 90 days, and the images within Greenfield are periodically updated in the image gallery.
- Operating systems supported by the ISV or Application Developer for Commercially off the Shelf (COTS) applications
- Operating systems supported by custom-built applications (consider framework versions, libraries, integrations, etc.)
- Available Greenfield golden images, versus Azure Endorsed marketplace images, or the need for custom images

The current available golden images for use can be reviewed
at [LMP Greenfields Golden Images][lmp-golden-images]

The diagram flow provides options for Operating system versions and editions that are the more recent Azure endorsed
options, where golden images are not created for versions but are needed contact <lm-foundation-squad4@lseg.com> to
request image creation, or custom image options. A subset of the options are available as golden images, if for any
reason a latest golden image version is not suitable, custom versions would need to be considered and discussed with
LSEG LMP Architecture, Cyber security and foundations teams.

Further information on Azure endorsed and partner images for Linux can be read
at [Azure Linux Distibutions][azure-linux-distributions]

## Migration Considerations

- Operating system upgrade, or conversion will required at a minimum Application Installation launch Tests to ensure the
  application is compliant and executable on updated OS versions, as well as the golden image extensions and agents that
  are required in LMP Greenfield (such as Qualys, Crowdstrike, and DataDog)
- Operating system upgrades and conversions will require additional time and effort to ensure no breaking changes are
  introduced, this should be covered as part of functional testing, and applications that are re-deployed through the
  CI/CD process.
- Operating system conversion (i.e Solaris to Linux) will require additional effort to ensure required code changes are
  incorporated, and integrations to other systems are validated.
- Operating System conversions may impact the treatment strategy initially assigned to an application or workloads, for
  example an application that is allocated to a 'rehost' treatment, may need to be considered for a 're-platform' or '
  refactor' treatment depending on the nature of the change required, and complexity, and effort to implement the
  change.

## Operating System Emulation Considerations

Operating system emulation is possible for operating systems that are not natively endorsed or supported on Azure. In
rare cases it may be required to support emulation, the following considerations should be reflected on before deciding
on emulations;

- Emulation is possible through the use of 3rd party solutions such
  as [SkyTap][skytap] or [Stromasys Charon SSP][stromasys-charon-ssp] or [stromasys-charon-par][stromasys-charon-par]].
- Emulation solutions may result in additional costs, management and operational considerations, as well as skills sets
  and technical capabilities that application teams may not have currently.
- Emulation can be considered for legacy or end of life scenarios where the cost to invest in acquiring updated versions
  of software, or investing in time to refactor the code base is not feasible. The trade off, and cost benefit analysis
  should be carried out.

[lmp-golden-images]: https://lsegroup.sharepoint.com/sites/CloudCentral/SitePages/LMP-Azure-Golden-Images.aspx?xsdata=MDV8MDF8bGF4bWlzYW5AbWljcm9zb2Z0LmNvbXxhNTVjYzAzMzg0NGY0OGYwMzAwMzA4ZGJlNDgwNDUzMHw3MmY5ODhiZjg2ZjE0MWFmOTFhYjJkN2NkMDExZGI0N3wxfDB8NjM4MzU1MDExOTA0NDMzNTI3fFVua25vd258VFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wPXwzMDAwfHx8&sdata=alhQWi9NQnZQL0poUEVRUFp6QTJlakxBYldUOGl5d2tJMnFIUEx4QlJrQT0%3d&OR=Teams-HL&CT=1716875286484&clickparams=eyJBcHBOYW1lIjoiVGVhbXMtRGVza3RvcCIsIkFwcFZlcnNpb24iOiIyNy8yNDA1MDUwMTYwMSIsIkhhc0ZlZGVyYXRlZFVzZXIiOmZhbHNlfQ%3D%3D

[azure-linux-distributions]: https://learn.microsoft.com/en-us/azure/virtual-machines/linux/endorsed-distros

[skytap]: https://azure.microsoft.com/en-us/blog/accelerate-your-cloud-strategy-with-skytap-on-azure/

[stromasys-charon-ssp]: https://learn.microsoft.com/en-us/azure/architecture/solution-ideas/articles/solaris-azure

[stromasys-charon-par]: https://learn.microsoft.com/en-us/azure/architecture/example-scenario/mainframe/hp-ux-stromasys-charon-par

