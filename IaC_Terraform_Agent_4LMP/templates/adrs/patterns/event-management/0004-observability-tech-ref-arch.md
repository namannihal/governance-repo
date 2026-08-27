<a href="https://app.pages.dx1.lseg.com/app-51723/migration-patterns/mig-pat-source-to-target/LMP-PAT-0079" class="md-content__button md-icon md-status--superseded" title="Status: Superseded by LMP-PAT-0079"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIxLjUgMTQuNSAxNiAyMGwtNS41LTUuNSAxLjQxLTEuNDFMMTUgMTYuMTdWMTAuNUMxNSA4IDEzIDYgMTAuNSA2SDRWNGg2LjVhNi41IDYuNSAwIDAgMSA2LjUgNi41djUuNjdsMy4wOS0zLjA5eiIgLz48L3N2Zz4=" /></a> <span class="md-content__button md-icon md-status--superseded" title="Valid between 2024-06-08 and 2026-01-29">![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE5IDE5SDVWOGgxNG0wLTVoLTFWMWgtMnYySDhWMUg2djJINWEyIDIgMCAwIDAtMiAydjE0YTIgMiAwIDAgMCAyIDJoMTRhMiAyIDAgMCAwIDItMlY1YTIgMiAwIDAgMC0yLTJNOS4zMSAxN2wyLjQ0LTIuNDRMMTQuMTkgMTdsMS4wNi0xLjA2LTIuNDQtMi40NCAyLjQ0LTIuNDRMMTQuMTkgMTBsLTIuNDQgMi40NEw5LjMxIDEwbC0xLjA2IDEuMDYgMi40NCAyLjQ0LTIuNDQgMi40NHoiIC8+PC9zdmc+)</span> <span class="md-content__button md-icon actions-date" title="Published on 2024-04-09">![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTkgMTB2Mkg3di0yem00IDB2MmgtMnYtMnptNCAwdjJoLTJ2LTJ6bTItN2EyIDIgMCAwIDEgMiAydjE0YTIgMiAwIDAgMS0yIDJINWEyIDIgMCAwIDEtMi0yVjVhMiAyIDAgMCAxIDItMmgxVjFoMnYyaDhWMWgydjJ6bTAgMTZWOEg1djExek05IDE0djJIN3YtMnptNCAwdjJoLTJ2LTJ6bTQgMHYyaC0ydi0yeiIgLz48L3N2Zz4=)</span> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/edit/main/docs/patterns/event-management/0004-observability-tech-ref-arch.md" class="md-content__button md-icon" title="Edit this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTEwIDIwSDZWNGg3djVoNXYzLjFsMi0yVjhsLTYtNkg2Yy0xLjEgMC0yIC45LTIgMnYxNmMwIDEuMS45IDIgMiAyaDR6bTEwLjItN2MuMSAwIC4zLjEuNC4ybDEuMyAxLjNjLjIuMi4yLjYgMCAuOGwtMSAxLTIuMS0yLjEgMS0xYy4xLS4xLjItLjIuNC0uMm0wIDMuOUwxNC4xIDIzSDEydi0yLjFsNi4xLTYuMXoiIC8+PC9zdmc+" /></a> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/blob/main/docs/patterns/event-management/0004-observability-tech-ref-arch.md" class="md-content__button md-icon" title="View source of this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE3IDE4Yy41NiAwIDEgLjQ0IDEgMXMtLjQ0IDEtMSAxLTEtLjQ0LTEtMSAuNDQtMSAxLTFtMC0zYy0yLjczIDAtNS4wNiAxLjY2LTYgNCAuOTQgMi4zNCAzLjI3IDQgNiA0czUuMDYtMS42NiA2LTRjLS45NC0yLjM0LTMuMjctNC02LTRtMCA2LjVhMi41IDIuNSAwIDAgMS0yLjUtMi41IDIuNSAyLjUgMCAwIDEgMi41LTIuNSAyLjUgMi41IDAgMCAxIDIuNSAyLjUgMi41IDIuNSAwIDAgMS0yLjUgMi41TTkuMjcgMjBINlY0aDd2NWg1djQuMDdjLjcuMDggMS4zNi4yNSAyIC40OVY4bC02LTZINmEyIDIgMCAwIDAtMiAydjE2YTIgMiAwIDAgMCAyIDJoNC41YTguMiA4LjIgMCAwIDEtMS4yMy0yIiAvPjwvc3ZnPg==" /></a>

Document Metadata

|  |  |
|----|----|
| Identifier | **`LMP-PAT-0004`** |
| Type | **Technical Design Pattern** |
| Status | **Superseded** |
| Approvals | <span class="md-tag">LMP Migration Architecture Approval</span> |
| Governance Reference | **[]()** |
| Pattern Source Repo | []() |
| Published on | **April 09, 2024** |
| Valid From | **June 08, 2024** |
| Valid To | **January 29, 2026** |
| Superseded By | **[LMP-PAT-0079](https://app.pages.dx1.lseg.com/app-51723/migration-patterns/mig-pat-source-to-target/LMP-PAT-0079)** |
| Authors | <span class="md-source-file__fact"> </span> |
| Tags | <span class="md-tag">Event Management</span><span class="md-tag">Application Support</span> |
| Technology Capabilities | <span class="md-tag">Delivery / Operations / Event Management</span><span class="md-tag">Delivery / Operations / IT Service Management / Application Monitoring</span> |

# Datadog Integration for Azure Services (Technical Design Pattern)<a href="#datadog-integration-for-azure-services-technical-design-pattern" class="headerlink" title="Permanent link">¶</a>

## Relevant ADRs<a href="#relevant-adrs" class="headerlink" title="Permanent link">¶</a>

- [LMP-ADR-0003: Use Datadog SaaS for Application & Resource monitoring in LMP Greenfield](../../../adrs/event-management/0003-use-datadog-for-application-and-resource-monitoring/)
- [LMP-ADR-0004: Choose OpenTelemetry for Application Telemetry over Proprietary Libraries](../../../adrs/event-management/0004-choose-open-telemetry-for-application-telemetry-over-proprietary-libraries/)

## Principles<a href="#principles" class="headerlink" title="Permanent link">¶</a>

- Datadog as a single sink for all application and infrastructure telemetry, to enable cross-application and service correlation
- BigPanda is automation and incident management platform that drives decisions on actions based on events received from Datadog. Actions include escalate to human, execute automated remediation script etc. Data should flow from Datadog through to BigPanda only if there's an event or alarm condition that requires either a manual or automated intervention.
- Applications not coupled to either Datadog or BigPanda, abstraction used to allow future architectural agility

## Virtual Machines<a href="#virtual-machines" class="headerlink" title="Permanent link">¶</a>

- Datadog agent running as a process on the VM, configured to scrape the system log / journald and any app-specific log file locations. Also configured to listen to OpenTelemetry Line Protocol (OTLP) messages over HTTP via a local TCP socket.
- Log events from application can flow either to system log (if emitted via stdout/stderr streams or console) or directly to one or more application-specific log files.
- Metrics and traces from the application flow to the Datadog agent via OTLP
- Datadog agent scrapes detailed metrics from the host
- Platform-based host metrics (coarse-grained) collected via Azure Monitor and the Datadog Azure integration

![Tech Reference for VM](0004-observability-tech-ref-arch.assets/image-001.png)

Further reading:

- [Datadog Agent configuration on bare-metal / VMs](https://docs.datadoghq.com/agent/configuration/agent-configuration-files/?tab=agentv6v7)
- [Microsoft Azure VM](https://docs.datadoghq.com/integrations/azure_vm/)

## Kubernetes<a href="#kubernetes" class="headerlink" title="Permanent link">¶</a>

- Datadog agent deployed as a Daemonset, with one pod per node, and configured to listen to OTLP events over HTTP
- Agent is configured to collect both node and container logs and forward
- Log events from application flow to the node via the container logs mechanism
- Metrics and traces from the application flow to the Datadog agent via OTLP
- Agent pulls cluster metrics from the kubernetes metrics server
- Agent pulls cluster details from the kubernetes API
- Platform-based host metrics (coarse-grained) collected via Azure Monitor and the Datadog Azure integration

![Tech Reference for K8s](0004-observability-tech-ref-arch.assets/image-001.png)

Further reading:

- [Datadog Agent installation on Kubernetes](https://docs.datadoghq.com/containers/kubernetes/)
- [Monitoring Kubernetes performance metrics](https://www.datadoghq.com/blog/monitoring-kubernetes-performance-metrics/)

## Azure Container Applications (ACA)<a href="#azure-container-applications-aca" class="headerlink" title="Permanent link">¶</a>

- Datadog serverless-init wrapper process wraps the application process without the application needing to explicitly depend on Datadog libraries.
- Serverless-init receives and forwards logs from the application
- Serverless-init is also an agent process, so can receive metrics and trace events via OTLP
- Agent can pull platform detailed metrics and forward to Datadog

![Tech Reference for ACA](0004-observability-tech-ref-arch.assets/image-001.png)

Further reading:

- [Azure Container Apps](https://docs.datadoghq.com/serverless/azure_container_apps/)

## Azure Functions<a href="#azure-functions" class="headerlink" title="Permanent link">¶</a>

- Logs and metrics collected from the Azure functions app and forwarded to an Azure Event Hub
- Datadog forwarder function app configured to read from eventhub and forward to Datadog
- Datadog can parse metrics from log lines using the "log-based metric" functionality
- Traces not natively supported

![Tech Reference for Azure Function](0004-observability-tech-ref-arch.assets/image-001.png)

Further reading:

- [Datadog Generate Metrics from Ingested Logs](https://docs.datadoghq.com/logs/log_configuration/logs_to_metrics/)
- [Datadog Azure Functions Integration](https://docs.datadoghq.com/integrations/azure_functions/)

<span class="md-source-file__fact"> <span class="md-icon" title="Last update"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIxIDEzLjFjLS4xIDAtLjMuMS0uNC4ybC0xIDEgMi4xIDIuMSAxLTFjLjItLjIuMi0uNiAwLS44bC0xLjMtMS4zYy0uMS0uMS0uMi0uMi0uNC0uMm0tMS45IDEuOC02LjEgNlYyM2gyLjFsNi4xLTYuMXpNMTIuNSA3djUuMmw0IDIuNC0xIDFMMTEgMTNWN3pNMTEgMjEuOWMtNS4xLS41LTktNC44LTktOS45QzIgNi41IDYuNSAyIDEyIDJjNS4zIDAgOS42IDQuMSAxMCA5LjMtLjMtLjEtLjYtLjItMS0uMnMtLjcuMS0xIC4yQzE5LjYgNy4yIDE2LjIgNCAxMiA0Yy00LjQgMC04IDMuNi04IDggMCA0LjEgMy4xIDcuNSA3LjEgNy45bC0uMS4yeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="May 11, 2026 13:10:33 UTC">May 11, 2026</span> </span> <span class="md-source-file__fact"> <span class="md-icon" title="Created"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE0LjQ3IDE1LjA4IDExIDEzVjdoMS41djUuMjVsMy4wOCAxLjgzYy0uNDEuMjgtLjc5LjYyLTEuMTEgMW0tMS4zOSA0Ljg0Yy0uMzYuMDUtLjcxLjA4LTEuMDguMDgtNC40MiAwLTgtMy41OC04LThzMy41OC04IDgtOCA4IDMuNTggOCA4YzAgLjM3LS4wMy43Mi0uMDggMS4wOC42OS4xIDEuMzMuMzIgMS45Mi42NC4xLS41Ni4xNi0xLjEzLjE2LTEuNzIgMC01LjUtNC41LTEwLTEwLTEwUzIgNi41IDIgMTJzNC40NyAxMCAxMCAxMGMuNTkgMCAxLjE2LS4wNiAxLjcyLS4xNi0uMzItLjU5LS41NC0xLjIzLS42NC0xLjkyTTE4IDE1djNoLTN2MmgzdjNoMnYtM2gzdi0yaC0zdi0zeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="May 1, 2024 08:26:27 UTC">May 1, 2024</span> </span>

<a href="../0003-func-ref-arch-observability/" class="md-footer__link md-footer__link--prev" aria-label="Previous: Observability (Functional Design Pattern)"></a>

<div class="md-footer__button md-icon">

![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIwIDExdjJIOGw1LjUgNS41LTEuNDIgMS40Mkw0LjE2IDEybDcuOTItNy45MkwxMy41IDUuNSA4IDExeiIgLz48L3N2Zz4=)

</div>

<div class="md-footer__title">

<span class="md-footer__direction"> Previous </span>

<div class="md-ellipsis">

Observability (Functional Design Pattern)

</div>

</div>

<a href="../0038-app-immutable-audit-logging/" class="md-footer__link md-footer__link--next" aria-label="Next: Application Immutable Audit Logging (Functional Design Pattern)"></a>

<div class="md-footer__title">

<span class="md-footer__direction"> Next </span>

<div class="md-ellipsis">

Application Immutable Audit Logging (Functional Design Pattern)

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
