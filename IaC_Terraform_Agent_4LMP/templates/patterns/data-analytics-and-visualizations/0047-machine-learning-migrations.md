---
id: LMP-PAT-0047
type: Technology Selection Pattern
status: published
approved_by:
  - LMP Migration Architecture Approval
date: 2024-11-29
valid_from: 2024-12-17
developer_productivity_hrs: 5
tags:
  - Data Analytics & Visualizations
tech_capabilities:
  - Platform / Application / Decision Intelligence & Automation / Machine Learning
---

# Machine learning workloads migration to Azure

## Compatibility

This advice pertains to the choice of options to migrate machine learning workloads to Microsoft Azure.

## Recommended Target

Azure Data Bricks , Azure Machine Learning Studio

## Decision Tree Diagram

![Decision tree](img/0047-ml-decision-tree.png)

## Notable Differences

|    |                                | Azure Data Bricks                                                                                                                                                                                                             | Azure Machine Learning Studio                                                                                                                                                                                                                    |
|----|--------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 🟢 | **Cost**<br>                   | May be on a higher price side, if considering for low data sizes                                                                                                                                                              | Cost effective since there are options to choose from varied compute options                                                                                                                                                                     |
| 🟢 | **Scalability**                | Optimized Autoscaling allows clusters to scale up and down more aggressively based on the load.                                                                                                                               | Azure provides built-in autoscaling options for most of the compute options. Optimized and autoscaling single and multi-node clusters (including GPU) are available to efficiently run ML jobs.                                                  |
| 🟢 | **Ease of Use**                | Would need expertise in setting up and running. Caters mostly to professionals                                                                                                                                                | Azure ML provides better user interface that facilitates easy starting for a novice user. It has ability to cater different skillset consumers including code first (notebooks / IDEs), low-code(Auto ML) and no-code(Designer) options as well. |
| 🟢 | **Inferencing**                | Advised to use MLFLow for deploying ML models. Models can be accessed directly with couple of lines of code for bacth / streaming inference                                                                                   | On-demand inferencing across the cloud and edge for both batch and real time inferencing.                                                                                                                                                        |
| 🟢 | **Model Registry**             | MLFlow model registry for consistent, secure model deployment and management. Models are made available in a consistent, open format for deployment from the ML Flow registry to Kubernetes, cloud or OSS inference services. | A central repository for the entire organization. Full lineage for models.                                                                                                                                                                       |
| 🟢 | **Azure Services Integration** | Azure Databricks has can be integrated with Azure Machine learning via MLFlow                                                                                                                                                 | Azure Machine Learning pipelines allow for versioned model retraining and batch scoring pipelines that easily be integrated with other tools , including Azure Data Factory.                                                                     |

## Considerations

Databricks and Machine Learning Studio can be used in conjunction where Azure Databricks would perform training
experiment in parallel (say 100 runs), and azure ml workspace that runs model experiment through a lot of
trained models.

- **Alternative Technology**: As per the general LMP approach, general strategy is to prefer Azure native technology
  where possible and where appropriate to the use case. The referenced guidance covers these scenarios in depth.
  If alternatives are needed for specific architectural challenges, they would be treated as exceptional.
  As and when exceptions crop up, and where merited, they will be added to this pattern.

## Further Reading

- [Azure Data Bricks Clear Listing](https://gitlab.dx1.lseg.com/app/app-51285/cloud-security-controls/azure-clear-listing/-/blob/main/azure/services/Microsoft.Databricks/workspaces/v1.0.0/markdown/serviceControls.md?ref_type=heads)
- [Azure Machine Learning Studio  Clear Listing](https://gitlab.dx1.lseg.com/app/app-51285/cloud-security-controls/azure-clear-listing/-/blob/main/azure/services/Microsoft.MachineLearningServices/workspaces/v2.0.0/markdown/serviceControls.md?ref_type=heads)

## References

- [Azure Data Bricks for Machine Learning](https://learn.microsoft.com/en-us/azure/databricks/machine-learning/)
  *[Azure Machine Learning](https://learn.microsoft.com/en-us/azure/machine-learning/overview-what-is-azure-machine-learning?view=azureml-api-2)

