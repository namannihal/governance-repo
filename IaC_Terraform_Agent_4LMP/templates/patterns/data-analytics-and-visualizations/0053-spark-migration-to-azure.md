---
id: LMP-PAT-0053
type: Technology Selection Pattern
status: superseded
superseded_by: LMP-PAT-0080
approved_by:
  - LMP Migration Architecture Approval
valid_from: 2024-12-17
developer_productivity_hrs: 5
date: 2024-11-15
tags:
  - Data Analytics & Visualizations
tech_capabilities:
  - Platform / Data / Data Analytics & Visualizations
---

# Spark migration to Azure

## Compatibility

This advice pertains to the choice of options to migrate and orchestrate Spark Jobs in Microsoft Azure.

## Recommended Target

Azure Data Bricks, Microsoft Fabric, Azure Data Factory.

## Decision Tree Diagram

![Decision tree](./img/0053-spark-decision-tree.png)

## Notable Differences

|    |                      | Azure Data Bricks                                                                                                                                                                                                                                        | Microsoft Fabric (Fabric is available in LMSP1 and LSEG SaaS but not LSEG.com at the time of writing)                                                                                                         | Azure Data Factory                                                                                                                                                                                                                                                                        |
|----|----------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 🟡 | **Cost**             | Pricing is based on DataBricks Units (DBUs), which combine compute and storage costs.<br><br>Spot VMs can help reduce costs.                                                                                                                             | Pay as you go go and reserved pricing available(which is cheaper). <br><br> Price would vary based on SKU and Capacity Units (CU). <br><br> There would be separate price for OneLake storage and networking. | Pay as you go model based on pipeline activities, data movement and data volume.ADF is generally cost-effective for straightforward ETL tasks, but may become expensive for complex use cases.                                                                                            |
| 🟡 | **Scalability**      | High scalability for big data. <br><br> Supports autoscaling of clusters.                                                                                                                                                                                | Scalable for data integration, analytics and business Intelligence.  <br><br> As of writing only P SKU s have auto scaling feature.                                                                           | Scales well for orchestrating pipelines across data sources.                                                                                                                                                                                                                              |
| 🟢 | **Ease of Use**      | Relies on code in notebooks. <br>Collaborative notebooks and streamlined work flows for data scientists and engineers.                                                                                                                                   | Integrated experience with modern data factory features.<br><br> Low code experience for the engineers.                                                                                                       | Easy to orchestrate with a drag and drop interface.                                                                                                                                                                                                                                       |
| 🟢 | **Integration**      | Integrates with other Azure services like Azure Data Lake, Synapse Analytics, Azure Machine learning etc.                                                                                                                                                | Integrates with a wide range for Microsoft services and third party tools.                                                                                                                                    | Seamless integration with other Azure Services with 'Activities'.                                                                                                                                                                                                                         |
| 🟡 | **Language Support** | Python<br>Scala<br>SQL<br>R                                                                                                                                                                                                                              | Python<br>Scala<br>SQL<br>R                                                                                                                                                                                   | No code.                                                                                                                                                                                                                                                                                  |
| 🟡 | **Performance**      | Optimized for high-performance data analytics and machine learning.<br><br>Built on top of latest Apache spark engine with DBX Runtime around which provides high performance.                                                                           | Optimized for high-performance data operations and analytics.                                                                                                                                                 | Efficient for ETL tasks and data movements.                                                                                                                                                                                                                                               |
| 🟢 | **Orchestration**    | Workflows can be used for orchestrations.                                                                                                                                                                                                                | Orchestrates spark jobs within a broader analytics and BI framework.                                                                                                                                          | Built for data pipeline orchestration. <br><br> Supports orchestration of spark jobs via DataBricks / Synapse / HDInsight integrations. <br><br> Visual drag and drop interface for orchestration.                                                                                        |
| 🟢 | **Spark Version**    | Spark Version 3.5.0                                                                                                                                                                                                                                      | Spark 3.5.0                                                                                                                                                                                                   | -                                                                                                                                                                                                                                                                                         |
| 🟡 | **Best Use cases**   | If Team is already working on DataBricks on prem or another cloud provider, Azure DataBricks can be used since team is already knows it and has less or zero learning curve. <br><br> Complex data engineering, machine learning and big data analytics. | Unified data analytics and BI use cases. <br><br> Best for all in one data platform, with low code.                                                                                                           | ETL, data integration and pipeline orchestration.There is an option named - DataFlows used for data transformations which runs spark under the hood. This will be a drag and drop experience. (For migrating existing spark jobs in code - would need to connect to DataBricks / Synapse. |

## Considerations

For a unified data experience with business intelligence clubbed with low code experience for data workflows
Microsoft Fabric would be a good choice along with machine learning integrations. The new feature of OneLake
could help getting data from on prem, multi cloud vendors on to a same data lake for further analytics.
**Note: Microsoft Fabric is still not available in Greenfield, Fabric is available in LMSP1 and LSEG SaaS**
**but not LSEG.com at the time of writing. Hence this document would recommend to consult with Foundation,**
**further in case if the decision goes to the use of Fabric.**

For any high complexity transformations and efficient spark job processing Azure DataBricks can be leveraged especially
if there are existing clusters, and it can give more control as well compared to others. If the current team is well
versed with DataBricks On premises or any other cloud, Azure DataBricks would be a great option to look for.
Azure DataBricks also has use cases for data scientists and machine learning with latest Apache spark engine and
DBX runtime.

It is to be noted that the Data Flows in Azure DataFactory uses on demand spark compute behind the scenes which is
managed by Azure. It can only be useful for simple transformations which ADF has support for. If there are simple
jobs where customer wanted low code experience this would be a good tool to look for.Other than that it is advised
to use ADF for Data Ingestion and orchestration tool.

- **Alternative Technology**: As per the general LMP approach, general strategy is to prefer Azure native technology
  where possible and where appropriate to the use case. The referenced guidance covers these scenarios in depth.
  If alternatives are needed for specific architectural challenges, they would be treated as exceptional.
  As and when exceptions crop up, and where merited, they will be added to this pattern.

## Further Reading

- [Azure DataBricks Clear Listing](https://gitlab.dx1.lseg.com/app/app-51285/cloud-security-controls/azure-clear-listing/-/blob/main/azure/services/Microsoft.Databricks/workspaces/v1.0.0/markdown/serviceControls.md?ref_type=heads)
- [Azure Data Factory Clear Listing](https://gitlab.dx1.lseg.com/app/app-51285/cloud-security-controls/azure-clear-listing/-/blob/main/azure/services/Microsoft.DataFactory/factories/v1.1.0/markdown/serviceControls.md?ref_type=heads)
- [Microsoft Fabric Clear Listing](https://gitlab.dx1.lseg.com/app/app-51285/cloud-security-controls/azure-clear-listing/-/blob/main/azure/services/Microsoft.Fabric/capacities/markdown/serviceControls.md?ref_type=heads)

## References

[DataBricks-SpotVMS](https://techcommunity.microsoft.com/t5/analytics-on-azure-blog/azure-databricks-and-azure-spot-vms-save-cost-by-leveraging/ba-p/2374187)

[Fabric Capacity Billing](https://learn.microsoft.com/en-gb/azure/cost-management-billing/reservations/fabric-capacity)

[Fabric Features](https://learn.microsoft.com/en-us/fabric/enterprise/fabric-features)

[Azure Data Factory](https://learn.microsoft.com/en-us/fabric/data-factory/)

