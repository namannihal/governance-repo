---
id: LMP-ADR-0016
type: ADR
status: published
date: 2025-07-02
valid_from: 2026-06-03
approved_by:
  - "LMP Migration Architecture Approval"
tags:
  - Deployment & Administration
tech_capabilities:
  - Delivery / Operations / Deployment & Administration
---

# Use DXOne Shared Runners to Deploy to Environments

## Context and Problem Statement

To enable automated deployments of applications to the LMP environment, the standard approach is to use a CI/CD build
pipeline running on DXOne Gitlab.

[LMP-PAT-0032: Patterns for Infra-as-Code and Code Rollback][lmp-pat-0032], specifies that applications should be
deployed in an automated fashion using Infrastructure as Code (IaC) methods, such as Terraform. Deployments can then be
executed as a Gitlab CI/CD pipeline job.

Gitlab CI/CD pipelines require a 'runner' in order to execute. A gitlab runner is a process running on a machine with
connectivity back to Gitlab that simply executes the jobs defined in a pipeline.. The DXOne team run a fleet of these
runners, which are known as DXOne Shared Runners. These runners are available to all applications, and are fully
managed / supported by DXOne.

Applications that need to run terraform (or other IaC) jobs to deploy to environments will typically need connectivity
to the Azure control plane in order to provision resources. This control plane is available via the internet, and can be
connected to from the DXOne Shared Runners (this is a similar model to how LSEG deploys to Azure Brownfield and AWS
today).

Access to the deployed resource data plane _may_ be required during deployment, depending on the use-case or resource
being deployed. Azure PaaS offerings such as Azure Blob Storage or Azure Key Vault host their data plane on a similarly
accessible API to the control plane. Per
the [SCF-NETW-01 Control inbound connectivity to CSP public endpoints][scf-netw-01], access to the control and data
planes for these specific resources should be (where possible restricted) to private endpoints and LSEG networks:

> SCF-NETW-01-02: Use private endpoints and IP-based firewalls to establish least possible connectivity and reduce the
> attack surface of public Azure Services like Azure Storage and Azure Cosmos DB.

Common scenarios this applies to include:

- Pulling/pushing terraform state from/to Azure Blob Storage
- Pushing secrets into Azure Key Vault (mastered in DXOne Vault)
- Pushing OCI artifacts to Azure Container Registry (ACR) (mastered in DXOne Artifactory).

Other resources that are deployed, such as Azure Virtual Machines or Azure Kubernetes Service (AKS), the data-plane is
only accessible by default to the subnet that the resource is deployed to (e.g. SSH or the K8s management API). An
application that needs to connect to these endpoints as part of a deployment will need to ensure that the runner
executing their deployment can route and connect through to these endpoints. This could either be achieved by:

1. Hosting a private endpoint for the resource in the routable network and raising an AppConn request to allow the
   shared runner to access it.
2. Making use of other Azure PaaS capabilities such
   as [Azure Bastion][azure-bastion] ([clearlisted here][bastion-clearlist]) to connect to the
   resource.
3. Deploying a bring-your-own-runner (BYOR) in the same network as the resource, which can then connect to the data
   plane.

It's worth noting that teams that choose to deploy their own runners (BYOR) will still need to use the DXOne Shared
Runners in order to actually deploy & provision these BYOR instances using the DXOne-supplied templates.

## Decision Drivers

These applications would needed to be monitored, especially for the following technology and application areas:

- Complexity
- Cost
- Application Environment Risk
- Deployment / Provisioning Methodologies
- Overall Engineering Strategy

## Considered Options

- DXOne Shared Runners
- Bring Your Own Runners (BYOR)

## Decision Outcome

Chosen option: DXOne Shared Runners, because

- It aligns with the LSEG & DXOne strategy for build/deployment.
- It reduces risk and complexity for the application owners, as they do not need to manage their own runners.
- It reduces cost and complexity of deployed infrastructure.
- Having a critical mass of applications using the same platform for deployment will drive better support and issue
  visibility, making the platform more robust and reliable in the long term.
- It encourages more cloud-native deployment practices, where environments can be provisioned and changed entirely via
  the Azure Control-plane.

This last point is particularly important. One of the goals of LMP is to modernize the way in which we build and deploy
applications. Encouraging practices such as:

- Deploying virtual machines on pre-baked base images, rather than mutating / provisioning a live resource
- Using application init-containers / startup processes to manage database schemas, rather than trying to manage the
  schema from a deployment pipeline
- Using tools such as Argo or Flux to manage the deployment of resources in a Kubernetes cluster, rather than connecting
  directly to the cluster and running kubectl commands

helps improve the reliability of these deployments, as well as limiting the connectivity surface of these sensitive
endpoints.

### Consequences

- Good, because it lowers complexity
- Good, because it lowers cost
- Good, because it lowers operational risk of the application's environment
- Good, because it encourages more cloud-native deployment practices
- Bad, because there is currently a lack of flexibility of available runner SKUs available.

### Confirmation

Adoption can be measured by examining the percentage of applications needing to deploy their own runners to their
environments.

## Pros and Cons of the Options

### Bring Your Own Runners (BYOR)

- Good, because flexible options for runner SKUs (CPU, memory, architecture, etc.)
- Bad, because it pushes the management responsibility of build infrastructure to the application teams.
- Bad, because it increases overall complexity of the estate.
- Bad, because it increases the overall cost of the estate.

## More Information

This may be revisited as more SKUs become available in the DXOne Shared Runners platform.

[lmp-pat-0032]: ../../patterns/development-platform/0032-managing-iac-and-package-rollback.md

[scf-netw-01]: https://confluence.refinitiv.com/spaces/PSAR/pages/1105922403/SCF-NETW-01+Control+inbound+connectivity+to+CSP+public+endpoints

[azure-bastion]: https://learn.microsoft.com/en-us/azure/bastion/bastion-overview

[bastion-clearlist]: https://gitlab.dx1.lseg.com/app/app-51285/cloud-security-controls/azure-clear-listing/-/blob/main/azure/services/Microsoft.Network/bastionHosts/v2.0.1/markdown/serviceControls.md

