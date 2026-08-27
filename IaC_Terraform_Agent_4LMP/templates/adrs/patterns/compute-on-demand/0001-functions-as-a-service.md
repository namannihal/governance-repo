<span class="md-content__button md-icon md-status--published" href="#" title="Status: Published"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE4LjUgMmgtMTNDMy42IDIgMiAzLjYgMiA1LjV2MTNDMiAyMC40IDMuNiAyMiA1LjUgMjJIMTZsNi02VjUuNUMyMiAzLjYgMjAuNCAyIDE4LjUgMk0yMCAxNWgtMS41Yy0xLjkgMC0zLjUgMS42LTMuNSAzLjVWMjBINS44Yy0xIDAtMS44LS44LTEuOC0xLjhWNS44QzQgNC44IDQuOCA0IDUuOCA0aDEyLjVjMSAwIDEuOC44IDEuOCAxLjhWMTVtLTQuOS02LjggMS41IDEuNS02IDYtMy41LTMuNSAxLjUtMS41IDIgMnoiIC8+PC9zdmc+) </span> <span class="md-content__button md-icon .md-status--published" title="Valid from 2024-06-08"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE5IDE5SDVWOGgxNG0wLTVoLTFWMWgtMnYySDhWMUg2djJINWEyIDIgMCAwIDAtMiAydjE0YTIgMiAwIDAgMCAyIDJoMTRhMiAyIDAgMCAwIDItMlY1YTIgMiAwIDAgMC0yLTJtLTIuNDcgOC4wNkwxNS40NyAxMGwtNC44OCA0Ljg4LTIuMTItMi4xMi0xLjA2IDEuMDZMMTAuNTkgMTd6IiAvPjwvc3ZnPg==) </span> <span class="md-content__button md-icon actions-date" title="Published on 2024-03-05">![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTkgMTB2Mkg3di0yem00IDB2MmgtMnYtMnptNCAwdjJoLTJ2LTJ6bTItN2EyIDIgMCAwIDEgMiAydjE0YTIgMiAwIDAgMS0yIDJINWEyIDIgMCAwIDEtMi0yVjVhMiAyIDAgMCAxIDItMmgxVjFoMnYyaDhWMWgydjJ6bTAgMTZWOEg1djExek05IDE0djJIN3YtMnptNCAwdjJoLTJ2LTJ6bTQgMHYyaC0ydi0yeiIgLz48L3N2Zz4=)</span> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/edit/main/docs/patterns/compute-on-demand/0001-functions-as-a-service.md" class="md-content__button md-icon" title="Edit this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTEwIDIwSDZWNGg3djVoNXYzLjFsMi0yVjhsLTYtNkg2Yy0xLjEgMC0yIC45LTIgMnYxNmMwIDEuMS45IDIgMiAyaDR6bTEwLjItN2MuMSAwIC4zLjEuNC4ybDEuMyAxLjNjLjIuMi4yLjYgMCAuOGwtMSAxLTIuMS0yLjEgMS0xYy4xLS4xLjItLjIuNC0uMm0wIDMuOUwxNC4xIDIzSDEydi0yLjFsNi4xLTYuMXoiIC8+PC9zdmc+" /></a> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/blob/main/docs/patterns/compute-on-demand/0001-functions-as-a-service.md" class="md-content__button md-icon" title="View source of this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE3IDE4Yy41NiAwIDEgLjQ0IDEgMXMtLjQ0IDEtMSAxLTEtLjQ0LTEtMSAuNDQtMSAxLTFtMC0zYy0yLjczIDAtNS4wNiAxLjY2LTYgNCAuOTQgMi4zNCAzLjI3IDQgNiA0czUuMDYtMS42NiA2LTRjLS45NC0yLjM0LTMuMjctNC02LTRtMCA2LjVhMi41IDIuNSAwIDAgMS0yLjUtMi41IDIuNSAyLjUgMCAwIDEgMi41LTIuNSAyLjUgMi41IDAgMCAxIDIuNSAyLjUgMi41IDIuNSAwIDAgMS0yLjUgMi41TTkuMjcgMjBINlY0aDd2NWg1djQuMDdjLjcuMDggMS4zNi4yNSAyIC40OVY4bC02LTZINmEyIDIgMCAwIDAtMiAydjE2YTIgMiAwIDAgMCAyIDJoNC41YTguMiA4LjIgMCAwIDEtMS4yMy0yIiAvPjwvc3ZnPg==" /></a>

Document Metadata

|  |  |
|----|----|
| Identifier | **`LMP-PAT-0001`** |
| Type | **Technology Selection Pattern** |
| Status | **Published** |
| Approvals | <span class="md-tag">LMP Migration Architecture Approval</span> |
| Published on | **March 05, 2024** |
| Valid From | **June 08, 2024** |
| Authors | <span class="md-source-file__fact"> </span> |
| Tags | <span class="md-tag">Compute on Demand</span> |
| Technology Capabilities | <span class="md-tag">Infrastructure / Compute / Compute on Demand</span> |

# AWS Lambda to Azure Functions<a href="#aws-lambda-to-azure-functions" class="headerlink" title="Permanent link">¶</a>

## Compatibility<a href="#compatibility" class="headerlink" title="Permanent link">¶</a>

Advice pertains to Azure Functions Runtime version 4.x.

## Recommended Target<a href="#recommended-target" class="headerlink" title="Permanent link">¶</a>

Azure Functions is a serverless compute service that allows you to run event-triggered code without having to explicitly provision or manage infrastructure.

It supports multiple programming languages, including C#, JavaScript, Python, and PowerShell, making it possible to port many, but not all, Lambda use cases.

Azure Functions integrates well with other Azure services such as Azure Storage, Azure Event Hubs, and Azure Cosmos DB via declarative bindings – a slightly different programming model to AWS Lambda.

## Decision Tree Diagram<a href="#decision-tree-diagram" class="headerlink" title="Permanent link">¶</a>

![Decision tree](0001-functions-as-a-service.assets/image-001.png)

## Notable Differences<a href="#notable-differences" class="headerlink" title="Permanent link">¶</a>

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 25%" />
<col style="width: 25%" />
<col style="width: 25%" />
</colgroup>
<thead>
<tr>
<th></th>
<th></th>
<th>AWS Lambda</th>
<th>Azure Functions</th>
</tr>
</thead>
<tbody>
<tr>
<td>🟢</td>
<td><strong>Cost</strong><br />
(non-provisioned Lamba vs Azure Consumption Plan)</td>
<td>By GB-s<br />
<br />
By fixed storage allocation<br />
<br />
By fixed memory allocation</td>
<td>By GB-s<br />
<br />
Storage Account charged separately<br />
<br />
By varying memory allocation</td>
</tr>
<tr>
<td>🔴</td>
<td><strong>Cost</strong><br />
(Premium Plan)</td>
<td></td>
<td>Premium Plan required for virtual network integration, extended timeouts, warm instances, longer timeouts, more memory.</td>
</tr>
<tr>
<td>🟢</td>
<td><strong>Memory</strong></td>
<td>128MB – 10GB<sup><a href="#fn:1" class="footnote-ref">2</a></sup></td>
<td>1.5 GB+<sup><a href="#fn:2" class="footnote-ref">3</a></sup></td>
</tr>
<tr>
<td>🟢</td>
<td><strong>Timeouts</strong></td>
<td>3 sec – 15 mins</td>
<td>5 mins – unlimited<br />
- 230 sec max for http triggers<sup><a href="#fn:4" class="footnote-ref">4</a></sup></td>
</tr>
<tr>
<td>🔴</td>
<td><strong>Concurrency</strong></td>
<td>Instance per request<sup><a href="#fn:5" class="footnote-ref">5</a></sup></td>
<td>Multiple invocations per instance<sup><a href="#fn:6" class="footnote-ref">6</a></sup></td>
</tr>
<tr>
<td>🟡</td>
<td><strong>Scaling</strong></td>
<td>By request</td>
<td>By host</td>
</tr>
<tr>
<td>🟢</td>
<td><strong>Runtimes</strong></td>
<td></td>
<td>No Golang or Ruby</td>
</tr>
<tr>
<td>🟢</td>
<td><strong>Storage</strong></td>
<td>Ephemeral 512MB – 10GB<sup><a href="#fn:7" class="footnote-ref">7</a></sup></td>
<td>Storage Account mandatory</td>
</tr>
<tr>
<td>🟡</td>
<td><strong>Programming Model</strong></td>
<td>Handlers passed context and event</td>
<td>Trigger (e.g queue, timer, http)<br />
<br />
Declarative, extensible input/output bindings (e.g. to Blob Storage, Cosmos, etc.)<sup><a href="#fn:8" class="footnote-ref">8</a></sup></td>
</tr>
<tr>
<td>🟢</td>
<td><strong>Operating Systems</strong></td>
<td>Linux</td>
<td>Windows or Linux</td>
</tr>
<tr>
<td>🟢</td>
<td><strong>Deployment</strong></td>
<td>Decouple via Layers</td>
<td>Decouple via Azure Files</td>
</tr>
</tbody>
</table>

## Considerations<a href="#considerations" class="headerlink" title="Permanent link">¶</a>

- **Language Compatibility**: Unlike AWS Lambda, Azure Functions does not have out of the box support for Ruby or Go. It is possible to engineer a solution with [custom handlers](https://learn.microsoft.com/en-us/azure/azure-functions/functions-custom-handlers), but consider whether this is the right alternative for your team. Whilst the effort involved to create a custom handler might be relatively low - similar to implementing an API handler in the given language outside of Functions - there are, according to the documentation, trade-offs to consider including the potential for increased cold starts.
- **Orchestration**: Azure Functions offers [Durable Functions](https://learn.microsoft.com/en-us/azure/azure-functions/durable/durable-functions-overview?tabs=in-process%2Cnodejs-v3%2Cv1-model&pivots=csharp) as a code-first solution for stateful functions. See also the designer-first, integration-rich [Azure Logic Apps](https://learn.microsoft.com/en-us/azure/azure-functions/functions-compare-logic-apps-ms-flow-webjobs?toc=%2Fazure%2Fazure-functions%2Fdurable%2Ftoc.json) for workflow orchestration.
- **Concurrency**: the Lambda concurrency model is different, With an instance per request being created, plus the ( premium) option for provisioned concurrency, throughput is arguably more predictable/stable. In Azure Functions, where execution is on shared compute, it is possible that instances may compete for resources. This may become even more apparent with languages like Python that have naturally single threaded runtimes. In these scenarios, consider increasing the number of workers and, ideally, refactoring to use asynchronous code.

## Alternatives<a href="#alternatives" class="headerlink" title="Permanent link">¶</a>

- **Kubernetes Event Driven Autoscaling ("KEDA")**<sup><a href="#fn:10" class="footnote-ref">1</a></sup> can be used to scale pods, including Azure Function containers, on general-purpose Kubernetes clusters including those with specific node pools (such as GPUs). KEDA **moved to the CNCF 'Graduated' maturity level** on August 22, 2023.
- **Knative**, a CNCF-hosted Kubernetes-based serverless platform, was accepted to CNCF on March 2, 2022 at the **' Incubating'** maturity level.
- **OpenFaaS** provides a similar ability to run scale-to-zero functions on Kubernetes. They offer enterprise support and commercial pricing.

## Further Reading<a href="#further-reading" class="headerlink" title="Permanent link">¶</a>

- Microsoft’s [Azure Functions documentation](https://learn.microsoft.com/en-us/azure/azure-functions/)
- [Cloud Product Framework: Linux Function App](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-linuxfunctionapp)
- [Cloud Product Framework: Windows Function App](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-windowsfunctionapp)

<div class="footnote">

------------------------------------------------------------------------

1.  <div id="fn:10">

    <https://keda.sh>\] <a href="#fnref:10" class="footnote-backref" title="Jump back to footnote 1 in the text">↩︎</a>

    </div>

2.  <div id="fn:1">

    <https://docs.aws.amazon.com/lambda/latest/dg/configuration-function-common.html#configuration-memory-console> <a href="#fnref:1" class="footnote-backref" title="Jump back to footnote 2 in the text">↩︎</a>

    </div>

3.  <div id="fn:2">

    <https://learn.microsoft.com/en-us/azure/azure-functions/functions-scale#service-limits> <a href="#fnref:2" class="footnote-backref" title="Jump back to footnote 3 in the text">↩︎</a>

    </div>

4.  <div id="fn:4">

    <https://learn.microsoft.com/en-us/azure/azure-functions/functions-versions?tabs=isolated-process%2Cv4&pivots=programming-language-python#timeout> <a href="#fnref:4" class="footnote-backref" title="Jump back to footnote 4 in the text">↩︎</a>

    </div>

5.  <div id="fn:5">

    <https://docs.aws.amazon.com/lambda/latest/dg/lambda-concurrency.html> <a href="#fnref:5" class="footnote-backref" title="Jump back to footnote 5 in the text">↩︎</a>

    </div>

6.  <div id="fn:6">

    <https://learn.microsoft.com/en-us/azure/azure-functions/functions-concurrency> <a href="#fnref:6" class="footnote-backref" title="Jump back to footnote 6 in the text">↩︎</a>

    </div>

7.  <div id="fn:7">

    <https://docs.aws.amazon.com/lambda/latest/dg/configuration-function-common.html#configuration-ephemeral-storage> <a href="#fnref:7" class="footnote-backref" title="Jump back to footnote 7 in the text">↩︎</a>

    </div>

8.  <div id="fn:8">

    <https://docs.aws.amazon.com/lambda/latest/dg/foundation-progmodel.html> <a href="#fnref:8" class="footnote-backref" title="Jump back to footnote 8 in the text">↩︎</a>

    </div>

</div>

<span class="md-source-file__fact"> <span class="md-icon" title="Last update"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIxIDEzLjFjLS4xIDAtLjMuMS0uNC4ybC0xIDEgMi4xIDIuMSAxLTFjLjItLjIuMi0uNiAwLS44bC0xLjMtMS4zYy0uMS0uMS0uMi0uMi0uNC0uMm0tMS45IDEuOC02LjEgNlYyM2gyLjFsNi4xLTYuMXpNMTIuNSA3djUuMmw0IDIuNC0xIDFMMTEgMTNWN3pNMTEgMjEuOWMtNS4xLS41LTktNC44LTktOS45QzIgNi41IDYuNSAyIDEyIDJjNS4zIDAgOS42IDQuMSAxMCA5LjMtLjMtLjEtLjYtLjItMS0uMnMtLjcuMS0xIC4yQzE5LjYgNy4yIDE2LjIgNCAxMiA0Yy00LjQgMC04IDMuNi04IDggMCA0LjEgMy4xIDcuNSA3LjEgNy45bC0uMS4yeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="May 30, 2025 16:15:49 UTC">May 30, 2025</span> </span> <span class="md-source-file__fact"> <span class="md-icon" title="Created"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE0LjQ3IDE1LjA4IDExIDEzVjdoMS41djUuMjVsMy4wOCAxLjgzYy0uNDEuMjgtLjc5LjYyLTEuMTEgMW0tMS4zOSA0Ljg0Yy0uMzYuMDUtLjcxLjA4LTEuMDguMDgtNC40MiAwLTgtMy41OC04LThzMy41OC04IDgtOCA4IDMuNTggOCA4YzAgLjM3LS4wMy43Mi0uMDggMS4wOC42OS4xIDEuMzMuMzIgMS45Mi42NC4xLS41Ni4xNi0xLjEzLjE2LTEuNzIgMC01LjUtNC41LTEwLTEwLTEwUzIgNi41IDIgMTJzNC40NyAxMCAxMCAxMGMuNTkgMCAxLjE2LS4wNiAxLjcyLS4xNi0uMzItLjU5LS41NC0xLjIzLS42NC0xLjkyTTE4IDE1djNoLTN2MmgzdjNoMnYtM2gzdi0yaC0zdi0zeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="March 5, 2024 18:10:33 UTC">March 5, 2024</span> </span>

<a href="../../communication/0037-mimecast-tech-ref-arch/" class="md-footer__link md-footer__link--prev" aria-label="Previous: Mimecast Technical Architecture"></a>

<div class="md-footer__button md-icon">

![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIwIDExdjJIOGw1LjUgNS41LTEuNDIgMS40Mkw0LjE2IDEybDcuOTItNy45MkwxMy41IDUuNSA4IDExeiIgLz48L3N2Zz4=)

</div>

<div class="md-footer__title">

<span class="md-footer__direction"> Previous </span>

<div class="md-ellipsis">

Mimecast Technical Architecture

</div>

</div>

<a href="../0056-functions-service-pattern/" class="md-footer__link md-footer__link--next" aria-label="Next: Azure Functions Service Pattern"></a>

<div class="md-footer__title">

<span class="md-footer__direction"> Next </span>

<div class="md-ellipsis">

Azure Functions Service Pattern

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
