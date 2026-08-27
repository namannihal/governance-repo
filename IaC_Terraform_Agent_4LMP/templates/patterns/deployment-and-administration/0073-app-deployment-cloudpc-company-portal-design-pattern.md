---
id: LMP-PAT-0073
type: Technical Design Pattern
status: published
date: 2025-09-17
valid_from: 2025-09-17
approved_by:
  - LMP Migration Architecture Approval
tags:
  - Deployment & Administration
tech_capabilities:
  - Delivery / Operations / Deployment & Administration
---

# Application deployment using Cloud PC W365 and Company Portal Pattern

## Introduction

This pattern helps application teams migrating to Azure who relied on Remote Desktop Protocol (RDP) to consume the
application from the terminal servers in on-premises to move over to the W365 Cloud PC with Intune company portal
option for deploying the application.

### Context

In the current on-premises environment, the end user accesses legacy desktop applications by remotely connecting
(via RDP) to Windows Server “terminal servers” (remote desktops). This means users launch a RDP session from their
laptops to a central server where the applications are installed. In the current target Azure architecture the same
RDP approach is not an efficient / cost effective solution and since the machines are not domain joined it
does not provide centralized authentication.

This would require a solution which suffices the application requirements and adhering to LSEG network and security
standards.

## Scope

This pattern helps to work on designing the deployment architecture which includes Cloud PC W365 along with
Intune company portal

## Use Cases

- This pattern currently focuses on-premises applications which are deployed on to terminal servers for RDP access.
- The desktop application currently on-premises which runs on windows.
- On-premise WPF desktop (Windows Presentation Foundation) applications.

## Architectural Design

The pattern suggests to package the application under consideration using any of the suitable packaging options
and deploy it to the company portal. End users can be provided with Windows 365 desktops (W365) which is in Azure and
the application can be downloaded from the company portal. Users can then use the application from the W365 desktops.
The end user will be connecting to the W365 cloud PC using their NWow laptops and from the cloud PC they will be
accessing
the applications using the company portal.
The users should be added to the security groups in the Intune to manage the centralized access.

![Figure 1 - Company portal deployment design](img/0073-app-deployment-cloudpc-company-portal-architecture-dgm.png)

![Figure 2 - Company portal process diagram](img/0073-app-deployment-cloudpc-company-portal-process-dgm.png)

### Architectural Components

#### Windows 365 Cloud PCs

Every end user is assigned a Windows 365 Cloud PC—an Azure‑hosted, persistent virtual desktop that provides a full
Windows experience without the need for traditional on‑prem RDP. This delivers a secure, isolated environment and
simplifies management through Azure AD–based identity and conditional access policies.

#### Application Packaging

Legacy desktop applications are re‑packaged, for example using the MSIX packaging format. This ensures that application
dependencies are isolated and the apps can be deployed and updated consistently.

#### Company Portal & Intune Management

The Company Portal (the enterprise app store) acts as the secure distribution point, where packaged apps are made
available. It is tightly integrated with Microsoft Intune, which handles app deployment, device management,
and compliance enforcement. This ensures that only authorized users can access and update the applications while
enforcing corporate security policies.

#### Security & Identity Integration

Entra ID authenticates users and enforces conditional access controls (including MFA). This protects resources, ensures
that only compliant devices can access apps, and guarantees a consistent user experience across Cloud PC and
Company Portal interactions.

#### Workflow Summary

In production, the workflow will be:

1. Application team packages the binaries and connect with Intune team for uploading it to company portal.
   This can be done by raising a [service now request][servicenow-packaging-request].
   [Packaging Team DL][packaging-team-email].
2. IT provisions a Cloud PC for the end user via Intune.
3. IT publishes the required app in Intune (making it available in Company Portal).
4. The end user opens the Windows 365 client on their laptop and launches their Cloud PC (after Entra ID sign-in and
   MFA).
5. On the Cloud PC’s Windows session, the end user opens Company Portal and gets the required desktop application
   pre-installed by policy.
6. The application runs on the Cloud PC, but the end user interacts with it through their remote session from the
   laptop.
   Data can be saved on the Cloud PC or in cloud storage – nothing is running on the shared servers anymore, and nothing
   heavyweight is running on the local laptop either, aside from the remote session.

### Key Considerations

#### Application Packaging & Compatibility

Ensure the legacy applications are fully tested as packaged apps.
Validate that dependencies, registry settings, and configurations are adequately captured within the package.

#### Identity & Security

Enforce Entra ID authentication with conditional access, ensuring MFA is in place.
Existing Intune policies to manage Cloud PCs, including rule sets should prevent unapproved network connections or data
exfiltration.

#### User Experience

Validate that download and application launch times meet user expectations.

## Further Reading

[Application deployment in W365 recomended practices][w365-app-deployment-practices]

[servicenow-packaging-request]: https://lseg.service-now.com/esc?id=sc_cat_item&table=sc_cat_item&sys_id=3394bed883e4c290e8c10478beaad391

[packaging-team-email]: mailto:BAU-Packaging-Team@lseg.com

[w365-app-deployment-practices]: https://techcommunity.microsoft.com/blog/windows-itpro-blog/application-deployment-in-windows-365-recommended-practices/3915376

