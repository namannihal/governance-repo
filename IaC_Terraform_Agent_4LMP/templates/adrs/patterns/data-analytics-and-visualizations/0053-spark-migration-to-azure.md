<span class="md-content__button md-icon md-status--published" href="#" title="Status: Published"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE4LjUgMmgtMTNDMy42IDIgMiAzLjYgMiA1LjV2MTNDMiAyMC40IDMuNiAyMiA1LjUgMjJIMTZsNi02VjUuNUMyMiAzLjYgMjAuNCAyIDE4LjUgMk0yMCAxNWgtMS41Yy0xLjkgMC0zLjUgMS42LTMuNSAzLjVWMjBINS44Yy0xIDAtMS44LS44LTEuOC0xLjhWNS44QzQgNC44IDQuOCA0IDUuOCA0aDEyLjVjMSAwIDEuOC44IDEuOCAxLjhWMTVtLTQuOS02LjggMS41IDEuNS02IDYtMy41LTMuNSAxLjUtMS41IDIgMnoiIC8+PC9zdmc+) </span> <span class="md-content__button md-icon .md-status--published" title="Valid from 2024-12-17"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE5IDE5SDVWOGgxNG0wLTVoLTFWMWgtMnYySDhWMUg2djJINWEyIDIgMCAwIDAtMiAydjE0YTIgMiAwIDAgMCAyIDJoMTRhMiAyIDAgMCAwIDItMlY1YTIgMiAwIDAgMC0yLTJtLTIuNDcgOC4wNkwxNS40NyAxMGwtNC44OCA0Ljg4LTIuMTItMi4xMi0xLjA2IDEuMDZMMTAuNTkgMTd6IiAvPjwvc3ZnPg==) </span> <span class="md-content__button md-icon actions-date" title="Published on 2024-11-15">![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTkgMTB2Mkg3di0yem00IDB2MmgtMnYtMnptNCAwdjJoLTJ2LTJ6bTItN2EyIDIgMCAwIDEgMiAydjE0YTIgMiAwIDAgMS0yIDJINWEyIDIgMCAwIDEtMi0yVjVhMiAyIDAgMCAxIDItMmgxVjFoMnYyaDhWMWgydjJ6bTAgMTZWOEg1djExek05IDE0djJIN3YtMnptNCAwdjJoLTJ2LTJ6bTQgMHYyaC0ydi0yeiIgLz48L3N2Zz4=)</span> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/edit/main/docs/patterns/data-analytics-and-visualizations/0053-spark-migration-to-azure.md" class="md-content__button md-icon" title="Edit this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTEwIDIwSDZWNGg3djVoNXYzLjFsMi0yVjhsLTYtNkg2Yy0xLjEgMC0yIC45LTIgMnYxNmMwIDEuMS45IDIgMiAyaDR6bTEwLjItN2MuMSAwIC4zLjEuNC4ybDEuMyAxLjNjLjIuMi4yLjYgMCAuOGwtMSAxLTIuMS0yLjEgMS0xYy4xLS4xLjItLjIuNC0uMm0wIDMuOUwxNC4xIDIzSDEydi0yLjFsNi4xLTYuMXoiIC8+PC9zdmc+" /></a> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/blob/main/docs/patterns/data-analytics-and-visualizations/0053-spark-migration-to-azure.md" class="md-content__button md-icon" title="View source of this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE3IDE4Yy41NiAwIDEgLjQ0IDEgMXMtLjQ0IDEtMSAxLTEtLjQ0LTEtMSAuNDQtMSAxLTFtMC0zYy0yLjczIDAtNS4wNiAxLjY2LTYgNCAuOTQgMi4zNCAzLjI3IDQgNiA0czUuMDYtMS42NiA2LTRjLS45NC0yLjM0LTMuMjctNC02LTRtMCA2LjVhMi41IDIuNSAwIDAgMS0yLjUtMi41IDIuNSAyLjUgMCAwIDEgMi41LTIuNSAyLjUgMi41IDAgMCAxIDIuNSAyLjUgMi41IDIuNSAwIDAgMS0yLjUgMi41TTkuMjcgMjBINlY0aDd2NWg1djQuMDdjLjcuMDggMS4zNi4yNSAyIC40OVY4bC02LTZINmEyIDIgMCAwIDAtMiAydjE2YTIgMiAwIDAgMCAyIDJoNC41YTguMiA4LjIgMCAwIDEtMS4yMy0yIiAvPjwvc3ZnPg==" /></a>

Document Metadata

|  |  |
|----|----|
| Identifier | **`LMP-PAT-0053`** |
| Type | **Technology Selection Pattern** |
| Status | **Published** |
| Approvals | <span class="md-tag">LMP Migration Architecture Approval</span> |
| Published on | **November 15, 2024** |
| Valid From | **December 17, 2024** |
| Authors | <span class="md-source-file__fact"> </span> |
| Tags | <span class="md-tag">Data Analytics & Visualizations</span> |
| Technology Capabilities | <span class="md-tag">Platform / Data / Data Analytics & Visualizations</span> |

# Spark migration to Azure<a href="#spark-migration-to-azure" class="headerlink" title="Permanent link">¶</a>

## Compatibility<a href="#compatibility" class="headerlink" title="Permanent link">¶</a>

This advice pertains to the choice of options to migrate and orchestrate Spark Jobs in Microsoft Azure.

## Recommended Target<a href="#recommended-target" class="headerlink" title="Permanent link">¶</a>

Azure Data Bricks, Microsoft Fabric, Azure Data Factory.

## Decision Tree Diagram<a href="#decision-tree-diagram" class="headerlink" title="Permanent link">¶</a>

![Decision tree](0053-spark-migration-to-azure.assets/image-001.png)

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
<th></th>
<th></th>
<th>Azure Data Bricks</th>
<th>Microsoft Fabric (Fabric is available in LMSP1 and LSEG SaaS but not LSEG.com at the time of writing)</th>
<th>Azure Data Factory</th>
</tr>
</thead>
<tbody>
<tr>
<td>🟡</td>
<td><strong>Cost</strong></td>
<td>Pricing is based on DataBricks Units (DBUs), which combine compute and storage costs.<br />
<br />
Spot VMs can help reduce costs.</td>
<td>Pay as you go go and reserved pricing available(which is cheaper).<br />
<br />
Price would vary based on SKU and Capacity Units (CU).<br />
<br />
There would be separate price for OneLake storage and networking.</td>
<td>Pay as you go model based on pipeline activities, data movement and data volume.ADF is generally cost-effective for straightforward ETL tasks, but may become expensive for complex use cases.</td>
</tr>
<tr>
<td>🟡</td>
<td><strong>Scalability</strong></td>
<td>High scalability for big data.<br />
<br />
Supports autoscaling of clusters.</td>
<td>Scalable for data integration, analytics and business Intelligence.<br />
<br />
As of writing only P SKU s have auto scaling feature.</td>
<td>Scales well for orchestrating pipelines across data sources.</td>
</tr>
<tr>
<td>🟢</td>
<td><strong>Ease of Use</strong></td>
<td>Relies on code in notebooks.<br />
Collaborative notebooks and streamlined work flows for data scientists and engineers.</td>
<td>Integrated experience with modern data factory features.<br />
<br />
Low code experience for the engineers.</td>
<td>Easy to orchestrate with a drag and drop interface.</td>
</tr>
<tr>
<td>🟢</td>
<td><strong>Integration</strong></td>
<td>Integrates with other Azure services like Azure Data Lake, Synapse Analytics, Azure Machine learning etc.</td>
<td>Integrates with a wide range for Microsoft services and third party tools.</td>
<td>Seamless integration with other Azure Services with 'Activities'.</td>
</tr>
<tr>
<td>🟡</td>
<td><strong>Language Support</strong></td>
<td>Python<br />
Scala<br />
SQL<br />
R</td>
<td>Python<br />
Scala<br />
SQL<br />
R</td>
<td>No code.</td>
</tr>
<tr>
<td>🟡</td>
<td><strong>Performance</strong></td>
<td>Optimized for high-performance data analytics and machine learning.<br />
<br />
Built on top of latest Apache spark engine with DBX Runtime around which provides high performance.</td>
<td>Optimized for high-performance data operations and analytics.</td>
<td>Efficient for ETL tasks and data movements.</td>
</tr>
<tr>
<td>🟢</td>
<td><strong>Orchestration</strong></td>
<td>Workflows can be used for orchestrations.</td>
<td>Orchestrates spark jobs within a broader analytics and BI framework.</td>
<td>Built for data pipeline orchestration.<br />
<br />
Supports orchestration of spark jobs via DataBricks / Synapse / HDInsight integrations.<br />
<br />
Visual drag and drop interface for orchestration.</td>
</tr>
<tr>
<td>🟢</td>
<td><strong>Spark Version</strong></td>
<td>Spark Version 3.5.0</td>
<td>Spark 3.5.0</td>
<td>-</td>
</tr>
<tr>
<td>🟡</td>
<td><strong>Best Use cases</strong></td>
<td>If Team is already working on DataBricks on prem or another cloud provider, Azure DataBricks can be used since team is already knows it and has less or zero learning curve.<br />
<br />
Complex data engineering, machine learning and big data analytics.</td>
<td>Unified data analytics and BI use cases.<br />
<br />
Best for all in one data platform, with low code.</td>
<td>ETL, data integration and pipeline orchestration.There is an option named - DataFlows used for data transformations which runs spark under the hood. This will be a drag and drop experience. (For migrating existing spark jobs in code - would need to connect to DataBricks / Synapse.</td>
</tr>
</tbody>
</table>

## Considerations<a href="#considerations" class="headerlink" title="Permanent link">¶</a>

For a unified data experience with business intelligence clubbed with low code experience for data workflows Microsoft Fabric would be a good choice along with machine learning integrations. The new feature of OneLake could help getting data from on prem, multi cloud vendors on to a same data lake for further analytics. **Note: Microsoft Fabric is still not available in Greenfield, Fabric is available in LMSP1 and LSEG SaaS** **but not LSEG.com at the time of writing. Hence this document would recommend to consult with Foundation,** **further in case if the decision goes to the use of Fabric.**

For any high complexity transformations and efficient spark job processing Azure DataBricks can be leveraged especially if there are existing clusters, and it can give more control as well compared to others. If the current team is well versed with DataBricks On premises or any other cloud, Azure DataBricks would be a great option to look for. Azure DataBricks also has use cases for data scientists and machine learning with latest Apache spark engine and DBX runtime.

It is to be noted that the Data Flows in Azure DataFactory uses on demand spark compute behind the scenes which is managed by Azure. It can only be useful for simple transformations which ADF has support for. If there are simple jobs where customer wanted low code experience this would be a good tool to look for.Other than that it is advised to use ADF for Data Ingestion and orchestration tool.

- **Alternative Technology**: As per the general LMP approach, general strategy is to prefer Azure native technology where possible and where appropriate to the use case. The referenced guidance covers these scenarios in depth. If alternatives are needed for specific architectural challenges, they would be treated as exceptional. As and when exceptions crop up, and where merited, they will be added to this pattern.

## Further Reading<a href="#further-reading" class="headerlink" title="Permanent link">¶</a>

- [Azure DataBricks Clear Listing](https://gitlab.dx1.lseg.com/app/app-51285/cloud-security-controls/azure-clear-listing/-/blob/main/azure/services/Microsoft.Databricks/workspaces/v1.0.0/markdown/serviceControls.md?ref_type=heads)
- [Azure Data Factory Clear Listing](https://gitlab.dx1.lseg.com/app/app-51285/cloud-security-controls/azure-clear-listing/-/blob/main/azure/services/Microsoft.DataFactory/factories/v1.1.0/markdown/serviceControls.md?ref_type=heads)
- [Microsoft Fabric Clear Listing](https://gitlab.dx1.lseg.com/app/app-51285/cloud-security-controls/azure-clear-listing/-/blob/main/azure/services/Microsoft.Fabric/capacities/markdown/serviceControls.md?ref_type=heads)

## References<a href="#references" class="headerlink" title="Permanent link">¶</a>

[DataBricks-SpotVMS](https://techcommunity.microsoft.com/t5/analytics-on-azure-blog/azure-databricks-and-azure-spot-vms-save-cost-by-leveraging/ba-p/2374187)

[Fabric Capacity Billing](https://learn.microsoft.com/en-gb/azure/cost-management-billing/reservations/fabric-capacity)

[Fabric Features](https://learn.microsoft.com/en-us/fabric/enterprise/fabric-features)

[Azure Data Factory](https://learn.microsoft.com/en-us/fabric/data-factory/)

<span class="md-source-file__fact"> <span class="md-icon" title="Last update"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIxIDEzLjFjLS4xIDAtLjMuMS0uNC4ybC0xIDEgMi4xIDIuMSAxLTFjLjItLjIuMi0uNiAwLS44bC0xLjMtMS4zYy0uMS0uMS0uMi0uMi0uNC0uMm0tMS45IDEuOC02LjEgNlYyM2gyLjFsNi4xLTYuMXpNMTIuNSA3djUuMmw0IDIuNC0xIDFMMTEgMTNWN3pNMTEgMjEuOWMtNS4xLS41LTktNC44LTktOS45QzIgNi41IDYuNSAyIDEyIDJjNS4zIDAgOS42IDQuMSAxMCA5LjMtLjMtLjEtLjYtLjItMS0uMnMtLjcuMS0xIC4yQzE5LjYgNy4yIDE2LjIgNCAxMiA0Yy00LjQgMC04IDMuNi04IDggMCA0LjEgMy4xIDcuNSA3LjEgNy45bC0uMS4yeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="May 30, 2025 16:15:49 UTC">May 30, 2025</span> </span> <span class="md-source-file__fact"> <span class="md-icon" title="Created"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE0LjQ3IDE1LjA4IDExIDEzVjdoMS41djUuMjVsMy4wOCAxLjgzYy0uNDEuMjgtLjc5LjYyLTEuMTEgMW0tMS4zOSA0Ljg0Yy0uMzYuMDUtLjcxLjA4LTEuMDguMDgtNC40MiAwLTgtMy41OC04LThzMy41OC04IDgtOCA4IDMuNTggOCA4YzAgLjM3LS4wMy43Mi0uMDggMS4wOC42OS4xIDEuMzMuMzIgMS45Mi42NC4xLS41Ni4xNi0xLjEzLjE2LTEuNzIgMC01LjUtNC41LTEwLTEwLTEwUzIgNi41IDIgMTJzNC40NyAxMCAxMCAxMGMuNTkgMCAxLjE2LS4wNiAxLjcyLS4xNi0uMzItLjU5LS41NC0xLjIzLS42NC0xLjkyTTE4IDE1djNoLTN2MmgzdjNoMnYtM2gzdi0yaC0zdi0zeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="December 13, 2024 16:47:36 UTC">December 13, 2024</span> </span>

<a href="../0047-machine-learning-migrations/" class="md-footer__link md-footer__link--prev" aria-label="Previous: Machine learning workloads migration to Azure"></a>

<div class="md-footer__button md-icon">

![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIwIDExdjJIOGw1LjUgNS41LTEuNDIgMS40Mkw0LjE2IDEybDcuOTItNy45MkwxMy41IDUuNSA4IDExeiIgLz48L3N2Zz4=)

</div>

<div class="md-footer__title">

<span class="md-footer__direction"> Previous </span>

<div class="md-ellipsis">

Machine learning workloads migration to Azure

</div>

</div>

<a href="../0078-databricks-technical-design/" class="md-footer__link md-footer__link--next" aria-label="Next: Azure Databricks Technical Design Pattern"></a>

<div class="md-footer__title">

<span class="md-footer__direction"> Next </span>

<div class="md-ellipsis">

Azure Databricks Technical Design Pattern

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
