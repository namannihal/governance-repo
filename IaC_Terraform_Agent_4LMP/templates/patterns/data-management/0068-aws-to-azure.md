---
id: LMP-PAT-0068
type: Technical Design Pattern
status: published
valid_from: 2025-03-01
date: 2025-03-01
approved_by:
  - LMP Migration Architecture Approval
tags:
  - Data Management
tech_capabilities:
  - Platform / Data / Data Management
---

# AWS to Azure Data Migration

## Introduction

This document provides a structured approach for securely transferring data from AWS to Azure.

### Context and Problem

Organizations often need to migrate data from AWS to Azure for cost optimization, compliance. Ensuring secure,
efficient, and scalable data transfer is critical, especially for sensitive information.

## Scope

This guide outlines:

- Copy Methods: Handling LSEG data kept in Amazon S3 bucket or syncing the data between AWS S3 bucket and Azure hosted
  application.
- AzCopy Steps: Command-line-based efficient data transfer.
- Security Considerations: Encryption, access controls and compliance.
- Alternative Approaches: Other migration options for specific use cases.
- Reference Links: Azure Wiki for additional details.

## Use Cases

- Cloud Migration: Moving datasets from AWS S3 to Azure Blob Storage.
- Data Sync: Syncing the data between AWS S3 bucket and Azure hosted application.
- Regulatory Compliance: Ensuring secure data transfer for sensitive information.
- Cost Optimization: Shifting workloads for better cost management.
- Disaster Recovery & Backup: Replicating data across cloud environments.
- This document ensures a secure, efficient, and structured data transfer approach between AWS and Azure.

## Consideration while moving the data

- Data classification
- Data Size
- Security considerations for using presigned URLs/ Access Keys and IDs.
- Cut over window/timeline.

## How to Transfer data from AWS to Azure

  ![File Transfer 1](./img/0068-aws_to_azure.png)

### Scenario 1: One-Time Data Transfer Using AzCopy (Internet-Based)

In scenarios involving AWS S3 buckets, AzCopy  requires internet access to interact with the public S3 endpoints, and
appropriate firewall and bucket policy configurations must be in place to allow such communication

- Ensure the AWS S3 bucket has public access completely disabled.
- Deploy a VM in a non-routable VNet within Azure.
- Install AzCopy on the VM if not already present.
- Create and assign a User Assigned Managed Identity to the VM.
- Grant Blob Contributor Access to the Azure Storage Account.
- Submit a request to add FQDN rules to the spoke firewall:
    - For internet-based transfer: Use the S3 bucket's public endpoint URL.
- Whitelist the public IP addresses of the Azure Spoke Firewall in the S3 bucket policy to allow point-to-point
    connection.
- Ensure all controls are in place to securely copy data using AzCopy.
- Once migration is complete, decommission the Jump VM.

### Scenario 2: SDNET-Based Data Transfer

- For continuous sync, use application-level integration.
- Use SDKs to establish federation between AWS and Azure for authentication and authorisation (AuthN/AuthZ).
- Submit a request to add FQDN rules to the spoke firewall:
    - For SDNET/private transfer: Use the S3 bucket's VPC endpoint URL.
- Do not update the S3 bucket policy with public IPs, as SDNET handles secure private connectivity. <br>

  **Note**

- Azure and AWS CLI SDKs can be downloaded from [Enterprise
  Artifactory](https://artifactory.lseg.com/ui/repos/tree/General/200048-docker-dev).

## Data Transfer Methods

AzCopy supports direct **cloud-to-cloud** transfers using **federated Tokens**, AWS S3 **pre-signed URLs** and Azure
SAS tokens. These methods eliminates the need to store data locally, ensuring **faster and more secure transfers**. The
Azcopy command runs from an Azure VM which should have a system/user defined identity with **Storage Account Blob
Contributor Access** assigned to the storage account.

### Long Lived Data Transfer

Leveraging Entra ID Managed Identity for this process eliminates the need for hardcoded credentials, enhancing both
security and automation. This approach uses identity federation via **OpenID Connect** (OIDC) to enable a **User
Assigned Managed Identity** (UAMI) in Azure to assume an AWS IAM role, granting temporary access to S3 resources. Once
federated, tools like AzCopy can be used to transfer data directly from AWS S3 to Azure Blob Storage, with
authentication handled entirely through managed identities.

- Create and attach a **User Assigned Managed Identity** (UAMI) to the VM which has **Storage Account Blob Contributor
  Access** to the Storage Account.
- Install Azure CLI and AWS CLI, Azcopy in the VM.
- Submit a request for the below steps since it requires elevated access permission.
    - Create an Entra application (Service Principal) for your application.
    - Under "Expose an API", define a custom Application ID URI like. e.g.

      ```powershell
      URN://AWSOIDCFederationTarget
      ```

    - Create an App Role and Assign It to the UAMI. Use PowerShell to grant the UAMI permission to call the API.

      ```powershell
      New-AzureADServiceAppRoleAssignment `
      -ObjectId <object id of your managed identity> `
      -Id <id of the app role defined in the app> `
      -PrincipalId <object id of your managed identity again> `
      -ResourceId <object id of the app registration's service principal>
      ```

    - Create an OpenID Connect (OIDC) identity provider in AWS with the following example
        - ****Provider URL****: `sts.windows.net/<Azure_Tenant_ID>/`
        - ****Audience****: `URN://AWSOIDCFederationTarget` (created as per)
    - Create an AWS IAM Role for the OpenID Connect (OIDC) identity provider with Get,Set,List access to S3 bucket with
        the audience set as the exposed AI of the service principal created e.g `URN://AWSOIDCFederationTarget`
    - Whitelist the URLs on AFW policy
        - management.azure.com
        - login.microsoftonline.com
        - aadcdn.msftauth.net,login.windows.net
        - secure.aadcdn.microsoftonline-p.com -sts.windows.net
        - <storage_account_name>.blob.core.windows.net
        - azcopyvnextrelease.z22.web.core.windows.net
        - <s3_bucketname>.s3.dualstack.<location>.amazonaws.com or the URL of the VPC endpoint
        - sts.amazonaws.com
    - Data sync or data movement over the private or public connection.

#### Data transfer over internet

- This approach can be used for both azcopy and data syncing between AWS and Azure. ![File Transfer
   2](./img/0068-aws_to_azure_fed.png)

- The virtual machine initiates a data transfer using the azcopy tool to move data to or from Azure Storage.
- The outbound request is routed through Azure Firewall for inspection and policy enforcement.
- The VM uses its attached managed identity to request an access token from Entra ID.
- The token request specifies the Service Principal Name (SPN) as the audience, which is validated by the OpenID
  Connect (OIDC) provider.
- Access is granted based on the IAM role assigned to the managed identity, allowing it to interact with the target
  resource
- Run the below commands to initiate data copy using Azcopy.

  ```powershell
     az login --identity
     azcopy login --identity --identity-client-id "<your-uami-client-id>"
     cd '<AZ COPY PATH>'
     $audience = "<SPN_URI>"
     $clientId = "<UAMI_CLIENTID>"
     $awsArn = "<OIDC_ROLE_ARN>"
     $response = Invoke-RestMethod -Uri "http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=$audience&client_id=$clientId" `
     -Headers @{Metadata="true"} -Method GET
     $token =$response.access_token
     $acknowledgement = aws sts assume-role-with-web-identity `
         --role-arn $awsArn `
         --role-session-name "azureSession" `
         --web-identity-token $token `
         --duration-seconds <time_in_seconds>
     $value = $acknowledgement | ConvertFrom-Json
     $env:AWS_ACCESS_KEY_ID  = $value.Credentials.AccessKeyId.ToString()
     $env:AWS_SECRET_ACCESS_KEY = $value.Credentials.SecretAccessKey.ToString()
     $env:AWS_SESSION_TOKEN   = $value.Credentials.SessionToken
     .\azcopy.exe copy 'https://<S3 endpoint>/<file/folder>' "https://<storage_account>.blob.core.windows.net/<container>" --recursive=true
     ```

- The time in seconds can be varied from 1 hour to 12  hours where, the minimum lifespan is 1 hour and the maximum is
  12.

#### Data transfer over a private connection

- This approach is suitable for data syncing between AWS and Azure over a private channel.

  ![File Transfer 3](./img/0068-aws_to_azure_fed_02.png)

- The virtual machine/ application initiates a data transfer to sync the data between Azure and AWS.
- The outbound request is routed through Azure Firewall for inspection and policy enforcement
- The request is re-routed privately to the VPC endpoint and then to the S3 bucket via SDnet
- The VM uses its attached managed identity to request an access token from Entra ID.
- The token request specifies the Service Principal Name (SPN) as the audience, which is validated by the OpenID
  Connect (OIDC) provider.
- Access is granted based on the IAM role assigned to the managed identity, allowing it to interact with the target
  resource
- Data sync between S3 bucket and blob

### Short Lived Data Transfer

#### Using a Presigned URL

- This approach is suitable for short-term data transfers, as AWS S3 pre-signed URLs have a maximum lifespan of 7 days
  when generated using the AWS SDK, and is suitable only for public data transfer, where the public transfer is done
  via internet.<br>
**Steps**
    - Generate a Pre-Signed URL from AWS S3:
        - This URL provides temporary read access to your S3 objects. s3://your-source-bucket/your-file --expires-in
      <time_in_seconds>:
            - The **--expires-** in parameter defines **how long** the URL remains valid.
            - This can be set as per the data size.
        - The generated  **pre-signed URL**  should be kept in a secure credential store and communicated via a secured
    channel.
        - The signed URL **includes authentication**, ensuring **only authorized access**.
    - Submit a request to whitelist the <s3_bucketname>.s3.dualstack.<location>.amazonaws.com in the spoke AFW.
    - Submit a request to add and permit the public IP addresses of the spoke firewall to the S3 bucket policy, if
  migrating the data over internet else omit this request(migration using azcopy).
    - Use AzCopy to Transfer Data to Azure
        - .\azcopy.exe copy "<https://s3.amazonaws.com/your-bucket/your-file?AWS-Signed-URL>"
     "<https://yourstorageaccount.blob.core.windows.net/your-container?sas-token%22>"
            - The **AWS pre-signed URL** ensures **secure, time-limited access** to the source file.
            - The **Azure SAS token** restricts access to the target container.

## **Encryption**

- **In Transit**:
    - Data is transferred over **HTTPS (TLS 1.2)** to **encrypt data in motion**.
    - AWS **pre-signed URLs** and **Azure SAS tokens** provide **temporary, controlled access**.
    - Data will be securely transferred over HTTPS using the user's credentials, specifically the **access_key and**
    **access_id**, with **GET** and **PUT** access to the designated S3 bucket.
    - After the successful migration, this user will be decommissioned, and the corresponding access will be revoked.
- **At Rest**:
    - AWS S3 supports **SSE-S3, SSE-KMS, and SSE-C** encryption.
    - Azure Blob Storage supports **Storage Service Encryption (SSE)**. **Access Control**
- AWS **IAM roles & policies** ensure only authorized users generate pre-signed URLs.
- Azure **RBAC & SAS tokens** restrict access to destination storage.
- Using **Azure Private Link & AWS Direct Connect**, the exposure to the Public network can be avoided.

## Alternative Approaches

### Migration Using Azure Data Factory

ADF offers a serverless architecture that allows parallelism at different levels, which allows developers to build
pipelines to fully utilize your network bandwidth and storage IOPS and bandwidth to maximize data movement throughput
for LSEG environment.

![File Transfer 4](./img/0068-aws_to_azure_adf.png)

- Deploy Azure Data Factory:
    - CPF already has a module to deploy Azure Data Factory.
    - While deploying the SHIR on an EC2 instance is an available option, the proposed and recommended solution is to
    use a Windows Server 2022 virtual machine on Azure.
- Configure and Register SHIR:
    - Once deployed, the SHIR should be configured and registered to the ADF studio using the access key.
- Create ADF Pipelines:
    - Once the setup is completed and the SHIR is onboarded, ADF pipelines can be created.
    - The source is an S3 bucket, and the data type should be Binary.
    - The target is an Azure Storage account.
- Authenticate to S3 Bucket:
    - The authentication to the S3 bucket is done by federated tokens pre-signed URL or a user account with access key
      and access ID.
    - Ensure GET-PUT access to the S3 bucket.

### MFT

- MFT can be used for moving smaller data chunks, more information can be found on
[MFT](https://lsegroup.sharepoint.com/sites/InfrastructureandApplicationService/SitePages/GoAnyWhere---MFT.aspx?web=1).

## Further Reading

- [AWS to Azure History data migration design
  options](https://dev.azure.com/LSEGroup/Migration/_wiki/wikis/Migration.wiki/7605/AWS-to-Azure-History-data-migration-design-options)
- [Azure Blob to AWS S3
  Sync](https://dev.azure.com/LSEGroup/Migration/_wiki/wikis/Migration.wiki/7582/Azure-Blob-to-AWS-S3-Sync)
- [AWS S3 to Azure Blob
  Sync](https://dev.azure.com/LSEGroup/Migration/_wiki/wikis/Migration.wiki/7581/AWS-S3-to-Azure-Blob-Sync)
- [AWS to Azure: Cross region Routing of traffic from RDP and PDG to CIAM
  IA](https://dev.azure.com/LSEGroup/Migration/_wiki/wikis/Migration.wiki/7526/AWS-to-Azure-Cross-region-Routing-of-traffic-from-RDP-and-PDG-to-CIAM-IA)
- [Azure to AWS - AAA Entitlement API over Public
  Internet](https://dev.azure.com/LSEGroup/Migration/_wiki/wikis/Migration.wiki/7507/Azure-to-AWS-AAA-Entitlement-API-over-Public-Internet)
- [Data Platform Migration
  Approach](https://dev.azure.com/LSEGroup/Migration/_wiki/wikis/Migration.wiki/217/Data-Platform-Migration-Approach-Technical-)
- [Data Migration](https://dev.azure.com/LSEGroup/Migration/_wiki/wikis/Migration.wiki/810/Data-Migration)
- [Setting up a federated
  Identity](https://dev.azure.com/LSEGroup/Migration/_wiki/wikis/Migration.wiki/7875/AWS-to-Azure-Data-Migration-Steps)
- [Storage Account Security
  Controls](https://gitlab.dx1.lseg.com/app/app-51285/cloud-security-controls/azure-clear-listing/-/blob/main/azure/services/Microsoft.Storage/storageAccounts/v2.2.0/markdown/serviceControls.md#-control-title-shared-access-signatures-sas-where-approved-for-external-access-must-apply-resource-and-permission-restrictions-in-accordance-with-the-principle-of-least-privilege-and-ip-address-restrictions-where-possible-to-apply)

