---
id: LMP-PAT-0071
type: Technical Design Pattern
status: superseded
date: 2025-05-27
valid_from: 2025-06-30
valid_to: 2025-12-02
superseded_by: LMP-PAT-0075
approved_by:
  - LMP Migration Architecture Approval
tags:
  - Virtual Compute & Containers
govid: GOVI0004361
govid_url: https://lseg.service-now.com/x_lsegp_eag_governance_item.do?sys_id=57290e73c3ede6d0ec253a1c050131d0
tech_capabilities:
  - Infrastructure / Compute / Virtual Compute & Containers
developer_productivity_hrs: 0
---
# Integrate Azure VMs with Entra ID

## Introduction

This pattern describes design for integrating Azure VMs( Windows and Linux) with Microsoft Entra
authentication.Microsoft Entra ID serves as a core authentication platform to Remote Desktop Protocol (RDP) into
Windows Server and SSH into a Linux VM.

### Context and Problem

- Reduce reliance on local administrator accounts, credential theft, and weak credentials.
- Local user accounts pose challenges in enforcing centralized identity management and access control.
- Administrative complexity, security risks due to un-managed accounts.

### Security Benefits of proposed solution

- Use Microsoft Entra authentication governed by centralised LSEG IAM policies to sign in to VMs in Azure.

- Azure RBAC  provide control to manage who can sign in to a VM as a regular user or with administrator privileges.
- Manage RBAC to grant or revoke access to the VMs.
- When employees leave LSEG and their user accounts are disabled or removed from Microsoft Entra ID, they no longer
  have access to your resources.
- Manage the overhead of sharing and managing the local admin credentials.
- All sign-in attempts using Entra ID are logged in Microsoft Entra logs.
- Integration with Azure Bastion supports Entra ID authentication, allowing secure, browser-based RDP/SSH access to VMs
  without exposing public IPs or requiring local credentials.

## Scope

This pattern is applicable for integrating Azure VMs with Entra ID. It provides design for accessing the Azure VMs
using the Entra ID, list of supported operating system. Access to integrated VMs would be using the Azure Bastion
service.

## Pattern Design

The design uses the Azure VM extension for Entra ID login to enable login to the Azure VM using Entra ID. <br/>The VM
extension runs on the Azure VM agent.VM must have have system-assigned managed identity enabled on the virtual
machine.The access to the Entra joined VM will be using the Azure Bastion service. <br/>The Entra join will create a
device ID for the VM in the tenant but does not  enroll in Intune, there for the device state will still be non-managed
e.g. Conditional Access.

![Figure 1 - Entra Login design](img/0071-entra-vmlogin-hld-dgm.png)

## Supported Operating systems

- Windows Server 2022 Datacenter and later.
- RedHat Enterprise Linux -  RHEL 8.3+, RHEL 9.0+
- Ubuntu 16.04 to Ubuntu 2- 04

## Supported Azure Roles

| **Azure Role**                      | **Description**                                                  |
|-------------------------------------|------------------------------------------------------------------|
| Virtual Machine Administrator Login | View Virtual Machines in the portal and login as administrator.  |
| Virtual Machine User Login          | View Virtual Machines in the portal and login as a regular user. |

** App operator role doesn't grant permission to login to the Azure VM, user must have Azure role for Virtual Machine
login.

## Use Cases

- Login to the Jumpboxes.
- Login to the VMs for administration or as a regular user, e.g. including Oracle installed Linux VMs.
- Entra ID based authentication to an interactive application hosted on Entra enabled VMs.

## Workflow for Secure VM Login

### Enable PIM

- Group-Based Role Assignment : Assign **Virtual Machine Administrator Login** or **Virtual Machine User Login** access
  to user groups.
- Enable **Privilege Identity Management** (PIM) on these Entra ID groups to manage **just-in-time** (JIT) access.
- PIM allows to:
    - Assign eligibility for group membership or ownership.
    - Require activation before access is granted.
    - Set approval workflows per group
- Use Access Reviews in Entra ID to periodically validate group memberships and role assignments.
- This ensures compliance and reduces the risk of privilege creep .

### Linux VM

![Figure 2 - Entra Login Linux VM Flow](img/0071-entra-linuxvm-flow-dgm.png)

- User will login to the Azure portal from the LSEG device using the -c account and get the MFA verification.
- The authentication will be governed by the Entra ID Conditional access policies.
- Launch the Bastion service from the Azure Portal to connect to the Linux VM.
- Bastion will validate the access,the User must have an Azure role for login to VM
- Upon successful access validation, bastion established the SSH connection to the VM.

### Windows VM

![Figure 3 - Entra Login Windows VM Flow](img/0071-entra-winvm-flow-dgm.png)

- Login to the Azure VM using Entra ID is supported by the Azure Cli.User will login to Azure using Azure cli from the
   LSEG device/w365 VDI using the -c account. The authentication will be governed by the Entra ID Conditional access
   policies and MFA verification happen as part of AZ login.
- Execute Az cli command </br>**az network bastion rdp --name <rdp_name>  --resource-group <rg_name>
--target-resource-id <vm_resource_id>  --enable-mfa true**' to download the rdp file and login with  '-c' account
credentials. <br/> The name in the RDP file must match the hostname of the remote device in Microsoft Entra ID and be
network addressable, resolving to the IP address of the remote device. In case, Computername and hostname are
different, then replace the displayname with the hostname in the RDP file.
- Bastion will validate the access,the User must have an Azure role for login to VM
- Upon successful authentication, RDP client establishes a VM session

#### **Dependencies**

##### **Local Computer**

- Azure CLI should be installed on the host machine e.g. AWS VDI.
- 'az network bastion rdp' works with Azure CLI version 2.62.0 or higher. The extension will automatically install the
  first time you run an az network bastion command, if you have an older version of CLI installed.

##### **Target VMS**

- Remote connection to VMs that are joined to Microsoft Entra ID is allowed only from Windows 10 or later PCs that are
  Microsoft Entra registered, Microsoft Entra joined, or Microsoft Entra hybrid joined to the same directory as the VM.
- Microsoft Entra Guest accounts can't connect to Azure VMs or Azure Bastion enabled VMs via Microsoft Entra
  authentication.
- Ensure that the required endpoints are accessible from the VM via PowerShell:
    - curl.exe <https://login.microsoftonline.com/> -D -
    - curl.exe <https://login.microsoftonline.com/><TenantID>/ -D -
    - curl.exe <https://enterpriseregistration.windows.net/> -D -
    - curl.exe <https://device.login.microsoftonline.com/> -D -
    - curl.exe <https://pas.windows.net/> -D -
- Enable the extensions
    - AADSSHLogin for Linux VM
    - AADLoginWindows for windows VM

### Architecture Decisions

- For Windows VM enabled with Entra ID, authentication is blocked by the Entra ID conditional access policies in the
   tenant, e.g. LSEGroup.onmicrosoft.com . To allow login , the external IP address of Spoke Azure Firewall needs to be
   added as named location in Conditional Access Verify CA Rules via the existing service now ticket and governed by
   LSEG process.
- Application team must use Entra ID groups and grant relevant Azure role for VM login. It is recommended that the
   Privileged Identity management for role assignment to the Entra ID group. To enable just in time access, efficient
   user management and provide the audit capability.

### **Note**

- Windows 2019 datacenter is not supported in the LSEG environment since it requires Windows Hello for Business.
- A non-interactive login SSH using with Service Principal is supported but yet to be tested, which will be included in
the second iteration as well as further conditional access optimisation.
- The stale device can be removed by LSEG with proper approvals, as part of LSEG's business as usual operational
  process.
- Both VM extensions can be enabled via Terraform, while deploying the VMs or manually in portal if the user has
  **Virtual Machine Contributor** Access.
- Please ensure that outbound traffic from the VM is permitted to access the required endpoints listed in the
**Dependencies** section. Since all inbound traffic is routed through the Azure Bastion host via the Azure backplane,
there is no need to configure inbound traffic rules for the VM.

## Further Reading

- [Azure-ad-windows](https://learn.microsoft.com/en-us/entra/identity/devices/howto-vm-sign-in-azure-ad-windows)
- [Azure-ad-linux](https://learn.microsoft.com/en-us/entra/identity/devices/howto-vm-sign-in-azure-ad-linux)
- [Steps for
  testing](https://dev.azure.com/LSEGroup/Migration/_wiki/wikis/Migration.wiki/7748/VM-Entra-Logon-Documentation-(DRAFT-not-ready-for-production))
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/network/bastion?view=azure-cli-latest)
- [RBAC for VMs](https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles#compute)
- [Non-interactive SSH
  Login](https://learn.microsoft.com/en-us/entra/identity/devices/howto-vm-sign-in-azure-ad-linux#log-in-by-using-the-microsoft-entra-service-principal-to-ssh-into-the-linux-vm)

