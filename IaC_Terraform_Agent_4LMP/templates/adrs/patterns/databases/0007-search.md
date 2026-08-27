<span class="md-content__button md-icon md-status--published" href="#" title="Status: Published"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE4LjUgMmgtMTNDMy42IDIgMiAzLjYgMiA1LjV2MTNDMiAyMC40IDMuNiAyMiA1LjUgMjJIMTZsNi02VjUuNUMyMiAzLjYgMjAuNCAyIDE4LjUgMk0yMCAxNWgtMS41Yy0xLjkgMC0zLjUgMS42LTMuNSAzLjVWMjBINS44Yy0xIDAtMS44LS44LTEuOC0xLjhWNS44QzQgNC44IDQuOCA0IDUuOCA0aDEyLjVjMSAwIDEuOC44IDEuOCAxLjhWMTVtLTQuOS02LjggMS41IDEuNS02IDYtMy41LTMuNSAxLjUtMS41IDIgMnoiIC8+PC9zdmc+) </span> <span class="md-content__button md-icon .md-status--published" title="Valid from 2024-06-08"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE5IDE5SDVWOGgxNG0wLTVoLTFWMWgtMnYySDhWMUg2djJINWEyIDIgMCAwIDAtMiAydjE0YTIgMiAwIDAgMCAyIDJoMTRhMiAyIDAgMCAwIDItMlY1YTIgMiAwIDAgMC0yLTJtLTIuNDcgOC4wNkwxNS40NyAxMGwtNC44OCA0Ljg4LTIuMTItMi4xMi0xLjA2IDEuMDZMMTAuNTkgMTd6IiAvPjwvc3ZnPg==) </span> <span class="md-content__button md-icon actions-date" title="Published on 2024-05-13">![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTkgMTB2Mkg3di0yem00IDB2MmgtMnYtMnptNCAwdjJoLTJ2LTJ6bTItN2EyIDIgMCAwIDEgMiAydjE0YTIgMiAwIDAgMS0yIDJINWEyIDIgMCAwIDEtMi0yVjVhMiAyIDAgMCAxIDItMmgxVjFoMnYyaDhWMWgydjJ6bTAgMTZWOEg1djExek05IDE0djJIN3YtMnptNCAwdjJoLTJ2LTJ6bTQgMHYyaC0ydi0yeiIgLz48L3N2Zz4=)</span> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/edit/main/docs/patterns/databases/0007-search.md" class="md-content__button md-icon" title="Edit this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTEwIDIwSDZWNGg3djVoNXYzLjFsMi0yVjhsLTYtNkg2Yy0xLjEgMC0yIC45LTIgMnYxNmMwIDEuMS45IDIgMiAyaDR6bTEwLjItN2MuMSAwIC4zLjEuNC4ybDEuMyAxLjNjLjIuMi4yLjYgMCAuOGwtMSAxLTIuMS0yLjEgMS0xYy4xLS4xLjItLjIuNC0uMm0wIDMuOUwxNC4xIDIzSDEydi0yLjFsNi4xLTYuMXoiIC8+PC9zdmc+" /></a> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/blob/main/docs/patterns/databases/0007-search.md" class="md-content__button md-icon" title="View source of this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE3IDE4Yy41NiAwIDEgLjQ0IDEgMXMtLjQ0IDEtMSAxLTEtLjQ0LTEtMSAuNDQtMSAxLTFtMC0zYy0yLjczIDAtNS4wNiAxLjY2LTYgNCAuOTQgMi4zNCAzLjI3IDQgNiA0czUuMDYtMS42NiA2LTRjLS45NC0yLjM0LTMuMjctNC02LTRtMCA2LjVhMi41IDIuNSAwIDAgMS0yLjUtMi41IDIuNSAyLjUgMCAwIDEgMi41LTIuNSAyLjUgMi41IDAgMCAxIDIuNSAyLjUgMi41IDIuNSAwIDAgMS0yLjUgMi41TTkuMjcgMjBINlY0aDd2NWg1djQuMDdjLjcuMDggMS4zNi4yNSAyIC40OVY4bC02LTZINmEyIDIgMCAwIDAtMiAydjE2YTIgMiAwIDAgMCAyIDJoNC41YTguMiA4LjIgMCAwIDEtMS4yMy0yIiAvPjwvc3ZnPg==" /></a>

Document Metadata

|  |  |
|----|----|
| Identifier | **`LMP-PAT-0007`** |
| Type | **Technology Selection Pattern** |
| Status | **Published** |
| Approvals | <span class="md-tag">LMP Migration Architecture Approval</span> |
| Published on | **May 13, 2024** |
| Valid From | **June 08, 2024** |
| Authors | <span class="md-source-file__fact"> </span> |
| Tags | <span class="md-tag">Search</span> |
| Technology Capabilities | <span class="md-tag">Platform / Application / Search</span> |

# Full-Text Document Indexing and Search<a href="#full-text-document-indexing-and-search" class="headerlink" title="Permanent link">¶</a>

## Compatibility<a href="#compatibility" class="headerlink" title="Permanent link">¶</a>

Apps migrating to Azure under LMP have a variety of use cases for data search and indexing.

Telemetry analytics is one of the most common, but some application may also have Apache Lucene-style text (or vector) search requirements. This pattern covers both.

It does not cover security use cases (e.g. SIEM).

## Recommended Target<a href="#recommended-target" class="headerlink" title="Permanent link">¶</a>

- For telemetry analytics, where strategic tooling is unsuitable, Azure Data Explorer is an Azure-native equivalent
- For full text or vector search<sup><a href="#fn:10" class="footnote-ref">1</a><a href="#fn:11" class="footnote-ref">2</a></sup> use cases (e.g. for semantic similarity), Azure AI Search is an Azure-native equivalent that is suitable for many use cases
- For applications that cannot adopt new technology, Elasticsearch is available in either managed or self-managed guises, but - at the time of writing - work will be required to adopt the managed Elasticsearch offering

## Decision Tree Diagram<a href="#decision-tree-diagram" class="headerlink" title="Permanent link">¶</a>

![Decision tree](0007-search.assets/image-001.png)

## Notable Differences<a href="#notable-differences" class="headerlink" title="Permanent link">¶</a>

<table>
<colgroup>
<col style="width: 20%" />
<col style="width: 20%" />
<col style="width: 20%" />
<col style="width: 20%" />
<col style="width: 20%" />
</colgroup>
<thead>
<tr>
<th>Considerations</th>
<th>Elastic Search (Managed)</th>
<th>Elastic Search (Unmanaged)</th>
<th>Azure AI Search</th>
<th>Azure Data Explorer</th>
</tr>
</thead>
<tbody>
<tr>
<td>Typical Use Case</td>
<td>Flexible product that covers a variety of Observability, Security and Search use cases.</td>
<td>See Elastic Search (managed)</td>
<td>PaaS that helps developers create their own text/vector search solutions.<br />
<br />
Supports integrated chunking and vectorization and sophisticated vector, text and hybrid search queries.<br />
<br />
Provides an index on top of an un-indexed data store (such as a database or object storage)</td>
<td>Fully managed data analytics service for real-time analysis on large volumes of data streaming from applications, websites, IoT devices, and more</td>
</tr>
<tr>
<td>Client Experience</td>
<td>Elastic APIs (REST or SDK)</td>
<td>See Elastic Search (managed)</td>
<td>Azure AI Search APIs (REST or SDK)</td>
<td>KQL</td>
</tr>
<tr>
<td>Integrations</td>
<td>Many including Azure services, Kubernetes, message queues, databases <sup><a href="#fn:5" class="footnote-ref">6</a></sup><br />
<br />
SDKs for Java, JavaScript, .NET, Python and others</td>
<td>See Elastic Search (managed)</td>
<td>SDKs for .NET, Python, JavaScript</td>
<td>Many e.g. Logstash, Open Telemetry, Azure Functions, Power Apps, JDBC/ODBC, Apache Spark, Kusto Explorer, Jupyter</td>
</tr>
<tr>
<td>Data ingestion</td>
<td>Via Elastic Integrations, Beats, Elastic Agent, Logstash.</td>
<td>See Elastic Search (managed)</td>
<td>Native indexing of Cosmos, SQL DB, Blob Storage, SQL Server on VMs.<br />
<br />
Native support for Office, PDF, PNG, JSON, HTML, XML, RTF</td>
<td>Native support for ApacheAvro, Avro, CSV, JSON, MultiJSON, ORC, Parquet, PSV, RAW, SCsv, SOHsv, TSV, TSVE, TXT, W3CLOGFILE</td>
</tr>
<tr>
<td>Tiers</td>
<td>Offered as e.g. "Elastic Observability" or "Elastic Search"<br />
<br />
Standard, Gold, Platinum, Enterprise<sup><a href="#fn:4" class="footnote-ref">7</a></sup></td>
<td>N/A</td>
<td>Basic (shared infra), Standard (dedicated), Storage Optimized (greater storage, bandwidth and memory)</td>
<td>Production and Dev/Test</td>
</tr>
<tr>
<td>Deployment model</td>
<td>Elasticsearch Service is offered as a managed service via Azure Marketplace, including OS updates/patches, OS hardening, in-flight encryption, built-in resiliency, etc.<br />
<br />
Offered as Search, Observability and Security variants.</td>
<td>Virtual Machines or Kubernetes<sup><a href="#fn:9" class="footnote-ref">8</a></sup></td>
<td>Charged by Search Unit ("SU") which is a function of no. replicas and no. partitions<sup><a href="#fn:1" class="footnote-ref">9</a></sup></td>
<td>By cluster and database(s)</td>
</tr>
<tr>
<td>Pricing</td>
<td>Example $622/month<sup><a href="#fn:2" class="footnote-ref">10</a></sup>: 105GB hot storage over 3 zones, 800GB warm over 2 zones, 1 zone Kibana (the minimum), 1 zone integration server (the minimum)</td>
<td>N/A</td>
<td>Non-linear, difficult to estimate. Examples:<br />
<br />
1 x "Standard S1" unit per month $245<br />
1 x "Standard S2" unit per month $980</td>
<td>By data ingested, retained. Capacity reservations available.<br />
<br />
Example $500: 100GB/day, 7 day hot retention, 4.5M read/writes, 1 year reservation, 2 x Engine instances and 2 x Data Management instances</td>
</tr>
<tr>
<td>Security, Licensing &amp; Legal</td>
<td>Likely to be considered as material outsourcing for regulated products. Vendor security assessment required followed by Procurement.</td>
<td>N/A</td>
<td>N/A</td>
<td>N/A</td>
</tr>
<tr>
<td>Scaling</td>
<td>Based on preset Azure VM SKUs</td>
<td>N/A</td>
<td>Manual, can take up to an hour</td>
<td>Vertical or Horizontal (automatic by e.g. CPU, cache/ingestion utilization)</td>
</tr>
<tr>
<td>Region availability</td>
<td>Some regions unavailable, e.g. UK West, Canada East<sup><a href="#fn:3" class="footnote-ref">11</a></sup></td>
<td>N/A</td>
<td>Some features not available in UK West and Canada East</td>
<td>Wide availability</td>
</tr>
<tr>
<td>SLA</td>
<td>Appears to be limited to support ticket response times.<br />
<br />
Presumably also limited by underlying Azure infrastructure.</td>
<td>N/A</td>
<td>10% service credit for error rate &gt;= 99.9%</td>
<td>10% service credit for uptime &lt;= 99.9%</td>
</tr>
</tbody>
</table>

## Considerations<a href="#considerations" class="headerlink" title="Permanent link">¶</a>

- **Managed/Self-Managed trade-off**: There are clear benefits to adoption of a managed service: many architectural and operational concerns are taken care<sup><a href="#fn:6" class="footnote-ref">3</a></sup>, but there are concerns in that (a) data will be held in a third-party Subscription and (b) there are known limitations<sup><a href="#fn:7" class="footnote-ref">4</a></sup> that may necessitate a self-managed instance. Before we adopt it, these concerns must be addressed.

## Alternatives<a href="#alternatives" class="headerlink" title="Permanent link">¶</a>

- **Serverless Elastic Cloud**: *"[Serverless instances](https://docs.elastic.co/serverless) are fully-managed, autoscaled, and automatically upgraded by Elastic"*. They are currently in Preview.
- **OpenSearch**: *"[OpenSearch](https://github.com/opensearch-project) is a community-driven, Apache 2.0-licensed open source search and analytics suite"*. The software started in 2021 as a fork of Elasticsearch and Kibana, with development led by AWS<sup><a href="#fn:8" class="footnote-ref">5</a></sup>. Whilst available as [AWS OpenSearch](https://aws.amazon.com/opensearch-service/), there is no native Azure Service, and nor is there a compelling marketplace option.

## Further Reading<a href="#further-reading" class="headerlink" title="Permanent link">¶</a>

- [AWS CloudSearch](https://aws.amazon.com/cloudsearch/): A *"simple and cost-effective to set up, manage, and scale a search solution for your website or application"*
- [Azure Data Explorer documentation](https://learn.microsoft.com/en-us/azure/data-explorer/)
- [Azure AI Search documentation](https://learn.microsoft.com/en-us/azure/search/)
- [Elastic on Microsoft Azure documentation](https://www.elastic.co/guide/en/cloud/current/ec-azure-marketplace-native.html)
- [Superlinked Vector DB Comparison](https://superlinked.com/vector-db-comparison)
- [Microsoft Sponsored comparison of BigQuery, Snowflake and ADX](https://gigaom.com/report/log-data-analytics-testing/)

<div class="footnote">

------------------------------------------------------------------------

1.  <div id="fn:10">

    [Wikipedia: Vector Databases](https://en.wikipedia.org/wiki/Vector_database) <a href="#fnref:10" class="footnote-backref" title="Jump back to footnote 1 in the text">↩︎</a>

    </div>

2.  <div id="fn:11">

    [Vectors in Azure AI Search](https://learn.microsoft.com/en-us/azure/search/vector-search-overview) <a href="#fnref:11" class="footnote-backref" title="Jump back to footnote 2 in the text">↩︎</a>

    </div>

3.  <div id="fn:6">

    [Elastic: Our Shared Responsibility](https://www.elastic.co/cloud/shared-responsibility) <a href="#fnref:6" class="footnote-backref" title="Jump back to footnote 3 in the text">↩︎</a>

    </div>

4.  <div id="fn:7">

    [Elastic Cloud Limitations](https://www.elastic.co/guide/en/cloud/current/ec-restrictions.html) <a href="#fnref:7" class="footnote-backref" title="Jump back to footnote 4 in the text">↩︎</a>

    </div>

5.  <div id="fn:8">

    [OpenSearch](https://en.wikipedia.org/wiki/OpenSearch_(software)) <a href="#fnref:8" class="footnote-backref" title="Jump back to footnote 5 in the text">↩︎</a>

    </div>

6.  <div id="fn:5">

    [Elastic integrations](https://www.elastic.co/integrations/data-integrations) <a href="#fnref:5" class="footnote-backref" title="Jump back to footnote 6 in the text">↩︎</a>

    </div>

7.  <div id="fn:4">

    [Elastic Pricing Tiers](https://www.elastic.co/pricing) <a href="#fnref:4" class="footnote-backref" title="Jump back to footnote 7 in the text">↩︎</a>

    </div>

8.  <div id="fn:9">

    [Running Elastic Cloud on Kubernetes from Azure Kubernetes Service](https://www.elastic.co/blog/how-to-run-elastic-cloud-on-kubernetes-from-azure-kubernetes-service) <a href="#fnref:9" class="footnote-backref" title="Jump back to footnote 8 in the text">↩︎</a>

    </div>

9.  <div id="fn:1">

    [Azure AI Search Capacity Planning](https://learn.microsoft.com/en-us/azure/search/search-capacity-planning#partition-and-replica-combinations) <a href="#fnref:1" class="footnote-backref" title="Jump back to footnote 9 in the text">↩︎</a>

    </div>

10. <div id="fn:2">

    [Elastic Pricing Calculator](https://cloud.elastic.co/pricing) <a href="#fnref:2" class="footnote-backref" title="Jump back to footnote 10 in the text">↩︎</a>

    </div>

11. <div id="fn:3">

    [Elastic Region Availability](https://www.elastic.co/guide/en/cloud/current/ec-reference-regions.html) <a href="#fnref:3" class="footnote-backref" title="Jump back to footnote 11 in the text">↩︎</a>

    </div>

</div>

<span class="md-source-file__fact"> <span class="md-icon" title="Last update"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIxIDEzLjFjLS4xIDAtLjMuMS0uNC4ybC0xIDEgMi4xIDIuMSAxLTFjLjItLjIuMi0uNiAwLS44bC0xLjMtMS4zYy0uMS0uMS0uMi0uMi0uNC0uMm0tMS45IDEuOC02LjEgNlYyM2gyLjFsNi4xLTYuMXpNMTIuNSA3djUuMmw0IDIuNC0xIDFMMTEgMTNWN3pNMTEgMjEuOWMtNS4xLS41LTktNC44LTktOS45QzIgNi41IDYuNSAyIDEyIDJjNS4zIDAgOS42IDQuMSAxMCA5LjMtLjMtLjEtLjYtLjItMS0uMnMtLjcuMS0xIC4yQzE5LjYgNy4yIDE2LjIgNCAxMiA0Yy00LjQgMC04IDMuNi04IDggMCA0LjEgMy4xIDcuNSA3LjEgNy45bC0uMS4yeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="May 30, 2025 16:15:49 UTC">May 30, 2025</span> </span> <span class="md-source-file__fact"> <span class="md-icon" title="Created"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE0LjQ3IDE1LjA4IDExIDEzVjdoMS41djUuMjVsMy4wOCAxLjgzYy0uNDEuMjgtLjc5LjYyLTEuMTEgMW0tMS4zOSA0Ljg0Yy0uMzYuMDUtLjcxLjA4LTEuMDguMDgtNC40MiAwLTgtMy41OC04LThzMy41OC04IDgtOCA4IDMuNTggOCA4YzAgLjM3LS4wMy43Mi0uMDggMS4wOC42OS4xIDEuMzMuMzIgMS45Mi42NC4xLS41Ni4xNi0xLjEzLjE2LTEuNzIgMC01LjUtNC41LTEwLTEwLTEwUzIgNi41IDIgMTJzNC40NyAxMCAxMCAxMGMuNTkgMCAxLjE2LS4wNiAxLjcyLS4xNi0uMzItLjU5LS41NC0xLjIzLS42NC0xLjkyTTE4IDE1djNoLTN2MmgzdjNoMnYtM2gzdi0yaC0zdi0zeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="May 28, 2024 11:59:40 UTC">May 28, 2024</span> </span>

<a href="../0005-relational-databases/" class="md-footer__link md-footer__link--prev" aria-label="Previous: Azure Relational Database Selection"></a>

<div class="md-footer__button md-icon">

![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIwIDExdjJIOGw1LjUgNS41LTEuNDIgMS40Mkw0LjE2IDEybDcuOTItNy45MkwxMy41IDUuNSA4IDExeiIgLz48L3N2Zz4=)

</div>

<div class="md-footer__title">

<span class="md-footer__direction"> Previous </span>

<div class="md-ellipsis">

Azure Relational Database Selection

</div>

</div>

<a href="../0008-document-databases/" class="md-footer__link md-footer__link--next" aria-label="Next: Document Databases"></a>

<div class="md-footer__title">

<span class="md-footer__direction"> Next </span>

<div class="md-ellipsis">

Document Databases

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
