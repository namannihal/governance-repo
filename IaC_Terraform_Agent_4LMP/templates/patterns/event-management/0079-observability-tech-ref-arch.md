---
id: LMP-PAT-0079
type: Technical Design Pattern
status: published
approved_by:
  - LMP Migration Architecture Approval
date: 2026-04-14
valid_from: 2026-04-14
developer_productivity_hrs: 4
tags:
  - Event Management
  - Application Support
tech_capabilities:
  - Delivery / Operations / Event Management
  - Delivery / Operations / IT Service Management / Application Monitoring
---

# Datadog Integration for Azure Services (Technical Design Pattern)

## Relevant ADRs

- [LMP-ADR-0003: Use Datadog SaaS for Application & Resource monitoring in LMP Greenfield][adr-0003]
- [LMP-ADR-0004: Choose OpenTelemetry for Application Telemetry over Proprietary Libraries][adr-0004]

## Principles

- Datadog as a single sink for all application and infrastructure telemetry, to enable cross-application and service
  correlation
- BigPanda is automation and incident management platform that drives decisions on actions based on events received from
  Datadog. Actions include escalate to human, execute automated remediation script etc. Data should flow from Datadog
  through to BigPanda only if there's an event or alarm condition that requires either a manual or automated
  intervention.
- Applications not coupled to either Datadog or BigPanda, abstraction used to allow future architectural agility

## Virtual Machines

- Datadog agent running as a process on the VM, configured to scrape the system log / journald and any app-specific log
  file locations. Also configured to listen to OpenTelemetry Line Protocol (OTLP) messages over HTTP via a local TCP
  socket.
- Log events from application can flow either to system log (if emitted via stdout/stderr streams or console) or
  directly to one or more application-specific log files.
- Metrics and traces from the application flow to the Datadog agent via OTLP
- Datadog agent scrapes detailed metrics from the host
- Platform-based host metrics (coarse-grained) collected via Azure Monitor and the Datadog Azure integration

![Tech Reference for VM][img-vm]

Further reading:

- [Datadog Agent configuration on bare-metal / VMs][dd-agent-config]
- [Microsoft Azure VM][azure-vm-integration]

## Kubernetes

- Datadog agent deployed as a Daemonset, with one pod per node, and configured to listen to OTLP events over HTTP
- Agent is configured to collect both node and container logs and forward
- Log events from application flow to the node via the container logs mechanism
- Metrics and traces from the application flow to the Datadog agent via OTLP
- Agent pulls cluster metrics from the kubernetes metrics server
- Agent pulls cluster details from the kubernetes API
- Platform-based host metrics (coarse-grained) collected via Azure Monitor and the Datadog Azure integration

![Tech Reference for K8s][img-k8s]

Further reading:

- [Datadog Agent installation on Kubernetes][dd-k8s-install]
- [Monitoring Kubernetes performance metrics][k8s-perf-metrics]

## Azure Container Applications (ACA)

### Recommended Approach: Azure Managed OpenTelemetry Agent

**When to use:**

- Applications already using OTEL SDKs
- All new applications (REQUIRED)
- Considering the 'LMP-ADR-0004: Choose OpenTelemetry for Application Telemetry over Proprietary Libraries' mentioned
  in 'Relevant ADRs' section above, assuming the application is already leveraging OTEL SDKs this would be the preferred
  option, considering cost and management.
- Azure Container Apps provides a **managed OpenTelemetry agent** at the Container Apps Environment level, provisioned
  and managed by Microsoft at no additional compute cost.
- Configuration is done at the **application container environment level** (not per container app), and all apps in the
  environment automatically benefit from the telemetry routing.
- Application code must be instrumented with OpenTelemetry SDK to emit telemetry data over OTLP; the managed agent
  handles routing to destinations.
- Application should configure the SDK to use the values injected into the environment variables by the platform for the
  OTLP endpoint. These are at `CONTAINERAPP_OTEL_TRACING_GRPC_ENDPOINT`, `CONTAINERAPP_OTEL_METRIC_GRPC_ENDPOINT` and
  `CONTAINERAPP_OTEL_LOGGING_GRPC_ENDPOINT`. Only GRPC protocol is currently supported by the platform, so ensure SDK is
  configured to use gRPC OTLP exporter with the provided endpoint.
- To tag telemetry on datadog with the required side, set the OTLP resource attributes in the application code using the
  OpenTelemetry SDK, for example:
    - `datadog.container.tag.mnd-applicationid` = application ID
    - `env` = environment (e.g., production, staging)
    - `version` = application version
- Configuration requires Datadog site URL (e.g., `datadoghq.eu`) and API key (recommended to store in Azure Key Vault).
- The native `azurerm` provider does at the point of writing this document does not support the OpenTelemetry
  configuration for Azure Container Apps Environments. Hence can use the **AzAPI provider**.

### Alternative Approaches

**Note**: Only consider these alternatives approaches when the above recommended approach has been validated
and cannot be used:

**Diagnostic Settings** - Use ONLY when application cannot be instrumented

- In this approach Logs and Metrics are collected sent to Event Hub through diagnostic settings.
- Datadog Forwarder function forwards logs from Event Hub to Datadog.
- The eventhub + forwarder function is already setup as part of platform which is deployed by Policy in LMP,
  if not via SRE to enable.
- Only works for logs, can be latency between log generation and availability in Datadog (a few seconds to minutes), not
  suitable for real-time monitoring or alerting.

**Sidecar Container** - AVOID unless if you requires custom log file access as last resort for any legacy applications.

- Datadog Agent runs as sidecar container which shares the volume with application where log files are written.
- Datadog Agent tails the logs files and send logs,metrics and traces to Datadog
- Platform metrics are sent to Datadog using Diagnostic Settings through Event Hub.
- This should only be considered in case if application is not OTEL instrumented, since it runs as additional container
  in the pod which costs and more complex to setup and extra management overhead.

![Tech Reference for ACA][img-aca-diag]
![Tech Reference for ACA][img-aca-sidecar]

### Comparison Table – Datadog Integration Approaches for ACA

| Feature / Aspect                  | Azure Managed OTEL Agent                                                                                | Datadog Agent (sidecar)                                        | Azure Diagnostic Settings                                                |
|-----------------------------------|---------------------------------------------------------------------------------------------------------|----------------------------------------------------------------|--------------------------------------------------------------------------|
| **Configuration Level**           | Container Apps Environment (all apps)                                                                   | Per container app                                              | Per resource (app or environment)                                        |
| **Where it runs**                 | Azure platform (Microsoft-managed)                                                                      | Separate container in same ACA environment                     | Azure platform level (no Datadog container)                              |
| **Setup complexity**              | Low (environment-level ARM/CLI config)                                                                  | High (configure sidecar container, volumes, env vars)          | Low (just configure in Azure Portal/CLI)                                 |
| **Requires code instrumentation** | Yes (OpenTelemetry SDK)                                                                                 | Optional (Agent can collect logs without instrumentation)      | No                                                                       |
| **Log types captured**            | App logs via OTLP from instrumented code                                                                | App logs from stdout/stderr, plus integrations (syslog, files) | ACA platform logs (AppConsole, SystemLogs, HTTPLogs, FunctionAppLogs)    |
| **Real-time streaming**           | Yes                                                                                                     | Yes                                                            | Near real-time (a few seconds/minutes delay possible)                    |
| **Traces/APM support**            | Yes (full support)                                                                                      | Yes (full APM)                                                 | No                                                                       |
| **Metrics support**               | Yes (full support for Datadog)                                                                          | App-level & integration checks                                 | Metrics sent via Diagnostic Settings go to Monitor, not Datadog directly |
| **Infrastructure visibility**     | No                                                                                                      | Limited in ACA (no node metrics)                               | Azure Monitor platform metrics (if enabled)                              |
| **Access to custom log files**    | No (OTLP only)                                                                                          | Yes (Agent can tail files if mounted)                          | No                                                                       |
| **Compute cost**                  | No additional cost (Microsoft-managed)                                                                  | Additional container (vCPU/memory costs)                       | Event Hub + Forwarder Function costs                                     |
| **Azure dependency**              | Medium (environment-level config)                                                                       | Minimal                                                        | Heavy (requires Azure Monitor + Event Hub pipeline)                      |
| **Best suited for**               | Multiple apps in same environment needing centralized telemetry routing without container modifications | Full Datadog features for app logs, custom metrics, traces     | Centralized platform log collection without container changes            |

Further reading:

- [Azure Container Apps][dd-aca]
- [Azure OpenTelemetry Agents][azure-otel-agents]

## Azure Functions

Azure Functions Datadog setup done in two ways:

Using Diagnostic Settings:

- Logs and metrics from the Azure Function App are collected and forwarded to an Azure Event Hub via Diagnostic
  Settings.
- A Datadog forwarder Function App reads from the Event Hub and sends data to Datadog.
- Datadog can extract metrics from log lines using its log-based metrics feature.
- Traces can be captured by enabling Application Insights during Function App creation.

Direct Logging to Datadog:

- Logs can be sent directly to Datadog using the HTTP Intake API, bypassing Diagnostic Settings and Event Hub entirely.
- Platform metrics are sent to Datadog using Diagnostic Settings through Event Hub.

![Tech Reference for Azure Function][img-func-intake]
![Tech Reference for Azure Function][img-func-diag]

Further reading:

- [Datadog Generate Metrics from Ingested Logs][dd-logs-to-metrics]
- [Datadog Azure Functions Integration][dd-azure-functions]

## Azure Web App Service

Application logs for Azure Web App Service Can be ingested into Datadog using following methods:

Diagnostic Settings:

- Logs and metrics from the Azure Function App are collected and forwarded to an Azure Event Hub via Diagnostic
  Settings.
- A Datadog forwarder Function App reads from the Event Hub and sends data to Datadog.

Datadog Intake API:

- Application logs are directly send to Datadog Intake API (<https://http-intake.logs.datadoghq.eu/v1/input>) using
  Serilog sink
- Platform metrics are sent to Datadog using Diagnostic Settings through Event Hub.

![Tech Reference for Web AppService][img-webapp-diag]
![Tech Reference for Web AppService][img-webapp-intake]

<!-- Reference links -->

[adr-0003]: ../../adrs/event-management/0003-use-datadog-for-application-and-resource-monitoring.md
[adr-0004]: ../../adrs/event-management/0004-choose-open-telemetry-for-application-telemetry-over-proprietary-libraries.md
[dd-agent-config]: https://docs.datadoghq.com/agent/configuration/agent-configuration-files/?tab=agentv6v7
[azure-vm-integration]: https://docs.datadoghq.com/integrations/azure_vm/
[dd-k8s-install]: https://docs.datadoghq.com/containers/kubernetes/
[k8s-perf-metrics]: https://www.datadoghq.com/blog/monitoring-kubernetes-performance-metrics/
[dd-aca]: https://docs.datadoghq.com/serverless/azure_container_apps/
[azure-otel-agents]: https://learn.microsoft.com/en-us/azure/container-apps/opentelemetry-agents
[dd-logs-to-metrics]: https://docs.datadoghq.com/logs/log_configuration/logs_to_metrics/
[dd-azure-functions]: https://docs.datadoghq.com/integrations/azure_functions/
[img-vm]: img/0079-observability-tech-ref-arch-VM.png
[img-k8s]: img/0079-observability-tech-ref-arch-K8s.png
[img-aca-diag]: img/0079-observability-tech-ref-arch-ACADiagnosticSettings.png
[img-aca-sidecar]: img/0079-observability-tech-ref-arch-ACASidecar.png
[img-func-intake]: img/0079-observability-tech-ref-arch-AzureFunctionIntake.png
[img-func-diag]: img/0079-observability-tech-ref-arch-AzureFunctionDiagnosticSettings.png
[img-webapp-diag]: img/0079-observability-tech-ref-arch-AzureWebappServiceDiagnostics.png
[img-webapp-intake]: img/0079-observability-tech-ref-arch-AzureWebAppDatadogIntake.png

