---
id: LMP-PAT-0002
type: Technology Selection Pattern
status: published
approved_by:
  - LMP Migration Architecture Approval
valid_from: 2024-06-08
developer_productivity_hrs: 5
date: 2024-03-15
tags:
  - Virtual Compute & Containers
tech_capabilities:
  - Infrastructure / Compute / Virtual Compute & Containers
---

# Container hosting to Azure

## Compatibility

This advice relates to applications running in a containerised environment, e.g. AWS ECS, AWS EKS, Anthos, Docker etc.

## Recommended Target

The primary recommendation is that containerised applications should look at Azure Kubernetes Service (AKS) and Azure
Container Applications (ACA) as default deployment options

## Authoritative references

| Reference Type | Reference                              | Relevance to guidance | Comments |
|----------------|----------------------------------------|-----------------------|----------|
| Strategy       | Containerization Platform Strategy[^1] |                       |          |

## Decision Tree Diagram

![Containers Decision Tree](img/0002-container-decision-flow.jpg)

## Notable Differences

|                               | ECS on Fargate                                                                                                                   | ECS on EC2                                                                                                                                                | EKS on Fargate                                                                                            | EKS on EC2                                                                             | Anthos on AWS                                                                                              | Anthos on Azure                                                                                            | AKS                                                                                                                                                                             | ACA                                                                                                                                                                        |
|-------------------------------|----------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Cost**                      | [Pay per vCPU per hour and per GB RAM per hour][fargate-pricing]                                                                 | Pay per EC2 instance                                                                                                                                      | [Pay per vCPU per hour and per GB RAM per hour][fargate-pricing]                                          | Pay per EC2 instance                                                                   | [Pay Anthos license per-vCPU][anthos-pricing]<br />Pay for EC2 instances                                   | Pay Anthos License per vCPU<br />Pay per VM                                                                | [Per-cluster fee (depends on Standard/Premium) + pay for instance nodes][aks-pricing]                                                                                           | [Consumption plan: pay per vCPU-second and per GiB-second, and per million requests<br />Dedicated plan: flat rate per hour, then per vCPU-hour and GiB-hour][aca-pricing] |
| **Memory**                    | [512MiB - 128GB][fargate-tasks-cpu-memory]                                                                                       | Most EC2 instance types available                                                                                                                         | [512MiB - 128GB][fargate-tasks-cpu-memory]                                                                | Most instance types available                                                          | [Specific EC2 instance types supported][anthos-on-aws]                                                     | [Specific EC2 instance types supported][anthos-on-aws]                                                     | Most Azure instance types supported                                                                                                                                             | [8-880GiB][aca-memory]                                                                                                                                                     |
| **Scaling**                   | Serverless: application controls number of tasks / auto-scaling parameters                                                       | Can scale up to cluster size, cluster can be resized by application team if necessary                                                                     | Serverless: application controls number of tasks / auto-scaling parameters                                | Can scale up to cluster size, more node or node pools can be added to cluster          | [Can scale up cluster size by adding nodes / node pools][anthos-scaling]. K8s scaling primitives available | [Can scale up cluster size by adding nodes / node pools][anthos-scaling]. K8s scaling primitives available | [K8s scaling primitives available for apps, nodes can be added manually or automatically][aks-scaling]. Can optionally burst nodes into ACI via virutal kubelet.                | Serverless: application controls number of tasks / auto-scaling parameters                                                                                                 |
| **Storage**                   | [20GiB - 200GiB ephemeral storage][fargate-ephemeral-storage]<br />[EBS or EFS volumes][fargate-data-volumes]                    | [20GiB - 200GiB ephemeral storage][fargate-ephemeral-storage]<br />[EBS or EFS volumes][fargate-data-volumes]                                             | [AWS EBS, EFS, FSx or S3][eks-storage]                                                                    | [AWS EBS, EFS, FSx or S3][eks-storage]                                                 | [AWS storage volumes available via K8s CSI][anthos-storage]                                                | [AWS storage volumes available via K8s CSI][anthos-storage]                                                | [AKS CSI driver available to provision AKS persistence storage][aks-storage]<br />[Azure Container Storage][azure-container-storage] also available for more rapid provisioning | [Container-scoped storage, or Azure Files for more durable storage][aca-storage]                                                                                           |
| **Operating Systems**         | [Linux or Windows][ecs-os]                                                                                                       | [Linux or Windows][ecs-os]                                                                                                                                | [Linux][eks-windows]                                                                                      | [Linux needed for control-plane, but Windows nodes available to be added][eks-windows] | [Linux (derived from Ubuntu)][anthos-os]                                                                   | [Linux (derived from Ubuntu)][anthos-os]                                                                   | [Linux or Windows][aks-os]                                                                                                                                                      | [Linux only][aca-os]                                                                                                                                                       |
| **Management**                | Serverless: task and resource-pool health managed by AWS<br />Less control over troubleshooting / observability of the platform. | Application & Ops team need to manage health of tasks and the underlying resources<br >More control over troubleshooting / observability of the platform. | Serverless: resource-pool managed by AWS. K8s API exposed to application. AWS can manage cluster upgrades | EC2 instances managed by application team. AWS can manage cluster upgrades.            | Anthos team manages EC2 instances and cluster. K8s API exposed to application                              | Anthos team manages EC2 instances and cluster. K8s API exposed to application                              | Azure manages OS & cluster upgrades. K8s API exposed to application                                                                                                             | Azure manages underlying resources                                                                                                                                         |
| **Extensibility**             | Limited. Containers can have sidecars                                                                                            | Limited. Containers can have sidecars                                                                                                                     | K8s API, so supports most K8s addons                                                                      | K8s API, so supports most K8s addons                                                   | [Anthos Control Plane options][anthos-options]                                                             | [Anthos Control Plane options][anthos-options]                                                             | [AKS add-ons][aks-addons] include managed Nginx, Keda, Open Service Mesh, Virutal Nodes                                                                                         | Limited. Containers can have sidecars                                                                                                                                      |
| **Underlying Infrastructure** | No control                                                                                                                       | Custom nodes                                                                                                                                              | Limited control                                                                                           | Custom nodes                                                                           | Limited control                                                                                            | Limited control                                                                                            | Limited control                                                                                                                                                                 | Limited control                                                                                                                                                            |
| **Monitoring Agents**         | None or limited integration (sidecars)                                                                                           | Agents installed on node image                                                                                                                            | Agents installed as daemonsets                                                                            | Agents installed on node image or as daemonsets                                        | Agents installed on node image or as daemonsets                                                            | Agents installed on node image or as daemonsets                                                            | Agents installed as daemonsets                                                                                                                                                  | None or limited integration (sidecars)                                                                                                                                     |
| **Security**                  | Limited                                                                                                                          | Limited                                                                                                                                                   | Security Policies, Admission Controller, RBAC                                                             | Security Policies, Admission Controller, RBAC                                          | Security Policies, Admission Controller, RBAC                                                              | Security Policies, Admission Controller, RBAC                                                              | Security Policies, Admission Controller, RBAC                                                                                                                                   | Limited                                                                                                                                                                    |
| **Patching Lifecycle**        | Managed by provider                                                                                                              | Managed by end-user                                                                                                                                       | [Managed by provider][eks-fargate-upgrades]                                                               | Managed by end-user                                                                    | [Managed by LSEG central Anthos team][anthos-aws-patching]                                                 | [Managed by LSEG central Anthos team][anthos-azure-patching]                                               | [Managed by provider, can be automated or manually done by end-user][aks-upgrades]                                                                                              | Managed by provider                                                                                                                                                        |

[fargate-pricing]: https://aws.amazon.com/fargate/pricing/

[fargate-tasks-cpu-memory]: https://docs.aws.amazon.com/AmazonECS/latest/developerguide/fargate-tasks-services.html#fargate-tasks-size

[fargate-ephemeral-storage]: https://docs.aws.amazon.com/AmazonECS/latest/developerguide/fargate-task-storage.html

[fargate-data-volumes]: https://docs.aws.amazon.com/AmazonECS/latest/developerguide/using_data_volumes.html

[ecs-os]: https://docs.aws.amazon.com/AmazonECS/latest/developerguide/create-capacity.html

[eks-storage]: https://docs.aws.amazon.com/eks/latest/userguide/storage.html

[eks-windows]: https://docs.aws.amazon.com/eks/latest/userguide/windows-support.html

[anthos-pricing]: https://cloud.google.com/kubernetes-engine/pricing

[anthos-on-aws]: https://cloud.google.com/anthos/clusters/docs/multi-cloud/aws/reference/supported-instance-types

[anthos-scaling]: https://cloud.google.com/anthos/clusters/docs/bare-metal/latest/how-to/add-remove-node-pools

[anthos-storage]: https://cloud.google.com/anthos/clusters/docs/bare-metal/latest/installing/install-csi-driver

[anthos-os]: https://cloud.google.com/anthos/clusters/docs/multi-cloud/aws/reference/os-details

[aks-pricing]: https://azure.microsoft.com/en-us/pricing/calculator/?service=kubernetes-service

[aks-scaling]: https://learn.microsoft.com/en-us/azure/aks/concepts-scale

[aks-storage]: https://learn.microsoft.com/en-us/azure/aks/azure-disk-csi

[azure-container-storage]: https://learn.microsoft.com/en-us/azure/storage/container-storage/container-storage-introduction

[aks-os]: https://learn.microsoft.com/en-us/azure/aks/windows-faq?tabs=azure-cli

[aca-storage]: https://learn.microsoft.com/en-us/azure/container-apps/storage-mounts?pivots=azure-cli

[aca-os]: https://learn.microsoft.com/en-us/azure/container-apps/containers

[aca-memory]: https://learn.microsoft.com/en-us/azure/container-apps/workload-profiles-overview

[aca-pricing]: https://azure.microsoft.com/en-us/pricing/details/container-apps/#pricing

[anthos-options]: https://cloud.google.com/service-mesh/docs/unified-install/options/all-install-options

[aks-addons]: https://learn.microsoft.com/en-us/azure/aks/integrations#available-add-ons

[eks-fargate-upgrades]: https://docs.aws.amazon.com/eks/latest/userguide/fargate-pod-patching.html

[anthos-aws-patching]: https://cloud.google.com/anthos/docs/concepts/gke-shared-responsibility#multi-cloud

[anthos-azure-patching]: https://cloud.google.com/anthos/docs/concepts/gke-shared-responsibility#gke-on-azure

[aks-upgrades]: https://learn.microsoft.com/en-us/azure/architecture/operator-guides/aks/aks-upgrade-practices

## Considerations

- **Kubernetes API**: Some applications take full advantage of the fact that they're deployed on a _Kubernetes_
  platform and take advantage of the Kubernetes API. AKS and GKE-on-Azure both proved a platform that provides a
  Kubernetes API, whereas ACA (whilst it might be Kubernetes underneath) does not expose a Kubernetes API.
- **Management**: ACA and GKE-on-Azure both provide a very managed service, removing the need for significant amounts of
  expertise for managing the cluster / infrastructure. The trade-off here is the higher-level of control that comes with
  a more complex product, such as AKS.
- **Processor Architecture**: Some platforms only support `amd64`. If `arm64` architecture is required, that steers more
  towards something like AKS where that is supported.
- **Mixed resource workloads**: AKS allows a single cluster to contain a heterogenous mix of resource types and shapes
  by allowing different node pools to form part of the same cluster. Each node pool can define a different type / size
  of node with different features (e.g. GPU, CPU arch, memory/CPU ratio). For applications consisting of multiple
  components with different resource requirements, being able to co-locate these components in the same cluster may be
  useful.
- **Cloud agility**: Some applications operate in a regulatory context where the risk of not being able to efficiently
  do a "cloud exit" has a higher priority. For these types of applications, GKE-on-Azure has a number of advantages, as
  the same product can be deployed in other hosting environments, so effectively enables some de-coupling of the
  application from the hosting provider.

## Alternatives

(Describe scenarios where alternate technologies/patterns should be considered.)

- **Google Kubernetes Engine (Anthos) on Azure**: Google's managed service that allows creation and operation of a
  Kuberenetes cluster running on Azure VMs, but managed and orchestrated by Google's Anthos control plane.

## Anti-Patterns

- **Docker on VMs**: A very simplistic approach to running containers is to simply deploy them on top of a VM that's
  running a docker-compatible daemon (`dockerd`, `containerd.io` etc.) It's a simple model, but lacks many of the
  features that AKS and ACA can provide around fault-tolerance, resiliency and scalability.
- **Docker Compose**: widely used by developers to concisely define a series of related containers / volumes / networks
  that can be stood up / torn down quickly in a local environment. Very useful for testing, but not suitable for
  production services due to the lack of management, monitoring and scaling features.
- **Azure Container Instances**: ACI is an Azure product that offers a fairly primitive capability of being able to
  create a single instance of a container image. It seems attractive, but there's no networking, load balancing, scaling
  or other management features that would make this useful for running a production workload, so should generally be
  avoided.

## Further Reading

- [Azure Kuberenetes Service](https://azure.microsoft.com/en-gb/products/kubernetes-service)
- [Azure Container Apps](https://azure.microsoft.com/en-gb/products/container-apps)
- [Cloud Product Framework: Azure Kubernetes Service](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-kubernetescluster)
- [Cloud Product Framework: Azure Container App](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-containerapp)

[^1]: <https://lsegroup.sharepoint.com/:w:/r/teams/CloudDevOpsArchitectureOrganisation/Shared%20Documents/Strategies/Container%20Strategy/Containerisation%20Platform%20Strategy.docx>

