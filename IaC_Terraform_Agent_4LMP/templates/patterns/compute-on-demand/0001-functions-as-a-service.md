---
id: LMP-PAT-0001
type: Technology Selection Pattern
status: published
approved_by:
  - LMP Migration Architecture Approval
valid_from: 2024-06-08
developer_productivity_hrs: 5
date: 2024-03-05
tags:
  - Compute on Demand
tech_capabilities:
  - Infrastructure / Compute / Compute on Demand
---

# AWS Lambda to Azure Functions

## Compatibility

Advice pertains to Azure Functions Runtime version 4.x.

## Recommended Target

Azure Functions is a serverless compute service that allows you to run event-triggered code without having to explicitly
provision or manage infrastructure.

It supports multiple programming languages, including C#, JavaScript, Python, and PowerShell, making it possible to port
many, but not all, Lambda use cases.

Azure Functions integrates well with other Azure services such as Azure Storage, Azure Event Hubs, and Azure Cosmos DB
via declarative bindings – a slightly different programming model to AWS Lambda.

## Decision Tree Diagram

![Decision tree](img/0001-decision-tree.png)

## Notable Differences

|    |                                                               | AWS Lambda                                                                      | Azure Functions                                                                                                                |
|----|---------------------------------------------------------------|---------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------|
| 🟢 | **Cost**<br>(non-provisioned Lamba vs Azure Consumption Plan) | By GB-s <br><br>By fixed storage allocation <br><br> By fixed memory allocation | By GB-s<br><br>Storage Account charged separately<br><br>By varying memory allocation                                          |
| 🔴 | **Cost**<br>(Premium Plan)                                    |                                                                                 | Premium Plan required for virtual network integration, extended timeouts, warm instances, longer timeouts, more memory.        |
| 🟢 | **Memory**                                                    | 128MB – 10GB[^1]                                                                | 1.5 GB+[^2]                                                                                                                    |
| 🟢 | **Timeouts**                                                  | 3 sec – 15 mins                                                                 | 5 mins – unlimited <br> - 230 sec max for http triggers[^4]                                                                    |
| 🔴 | **Concurrency**                                               | Instance per request[^5]                                                        | Multiple invocations per instance[^6]                                                                                          |
| 🟡 | **Scaling**                                                   | By request                                                                      | By host                                                                                                                        |
| 🟢 | **Runtimes**                                                  |                                                                                 | No Golang or Ruby                                                                                                              |
| 🟢 | **Storage**                                                   | Ephemeral 512MB – 10GB[^7]                                                      | Storage Account mandatory                                                                                                      |
| 🟡 | **Programming Model**                                         | Handlers passed context and event                                               | Trigger (e.g queue, timer, http)<br><br>Declarative, extensible input/output bindings (e.g. to Blob Storage, Cosmos, etc.)[^8] |
| 🟢 | **Operating Systems**                                         | Linux                                                                           | Windows or Linux                                                                                                               |
| 🟢 | **Deployment**                                                | Decouple via Layers                                                             | Decouple via Azure Files                                                                                                       |

## Considerations

- **Language Compatibility**: Unlike AWS Lambda, Azure Functions does not have out of the box support for Ruby or Go. It
  is possible to engineer a solution
  with [custom handlers](https://learn.microsoft.com/en-us/azure/azure-functions/functions-custom-handlers), but
  consider whether this is the right alternative for your team. Whilst the effort involved to create a custom handler
  might be relatively low - similar to implementing an API handler in the given language outside of Functions - there
  are, according to the documentation, trade-offs to consider including the potential for increased cold starts.
- **Orchestration**: Azure Functions
  offers [Durable Functions](https://learn.microsoft.com/en-us/azure/azure-functions/durable/durable-functions-overview?tabs=in-process%2Cnodejs-v3%2Cv1-model&pivots=csharp)
  as a code-first solution for stateful functions. See also the designer-first,
  integration-rich [Azure Logic Apps](https://learn.microsoft.com/en-us/azure/azure-functions/functions-compare-logic-apps-ms-flow-webjobs?toc=%2Fazure%2Fazure-functions%2Fdurable%2Ftoc.json)
  for workflow orchestration.
- **Concurrency**: the Lambda concurrency model is different, With an instance per request being created, plus the (
  premium) option for provisioned concurrency, throughput is arguably more predictable/stable. In Azure Functions, where
  execution is on shared compute, it is possible that instances may compete for resources. This may become even more
  apparent with languages like Python that have naturally single threaded runtimes. In these scenarios, consider
  increasing the number of workers and, ideally, refactoring to use asynchronous code.

## Alternatives

- **Kubernetes Event Driven Autoscaling ("KEDA")**[^10] can be used to scale pods, including Azure Function containers,
  on general-purpose Kubernetes clusters including those with specific node pools (such as GPUs). KEDA **moved to the
  CNCF 'Graduated' maturity level** on August 22, 2023.
- **Knative**, a CNCF-hosted Kubernetes-based serverless platform, was accepted to CNCF on March 2, 2022 at the **'
  Incubating'** maturity level.
- **OpenFaaS** provides a similar ability to run scale-to-zero functions on Kubernetes. They offer enterprise support
  and commercial pricing.

## Further Reading

- Microsoft’s [Azure Functions documentation](https://learn.microsoft.com/en-us/azure/azure-functions/)
- [Cloud Product Framework: Linux Function App](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-linuxfunctionapp)
- [Cloud Product Framework: Windows Function App](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-windowsfunctionapp)

[^1]: <https://docs.aws.amazon.com/lambda/latest/dg/configuration-function-common.html#configuration-memory-console>

[^2]: <https://learn.microsoft.com/en-us/azure/azure-functions/functions-scale#service-limits>

[^4]: <https://learn.microsoft.com/en-us/azure/azure-functions/functions-versions?tabs=isolated-process%2Cv4&pivots=programming-language-python#timeout>

[^5]: <https://docs.aws.amazon.com/lambda/latest/dg/lambda-concurrency.html>

[^6]: <https://learn.microsoft.com/en-us/azure/azure-functions/functions-concurrency>

[^7]: <https://docs.aws.amazon.com/lambda/latest/dg/configuration-function-common.html#configuration-ephemeral-storage>

[^8]: <https://docs.aws.amazon.com/lambda/latest/dg/foundation-progmodel.html>

[^10]: <https://keda.sh>]

