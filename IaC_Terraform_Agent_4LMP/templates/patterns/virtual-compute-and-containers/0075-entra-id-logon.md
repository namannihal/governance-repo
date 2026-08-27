---
id: LMP-PAT-0075
type: Technical Design Pattern
status: published
valid_from: 2025-02-17
date: 2026-02-17
approved_by:
  - LMP Migration Architecture Approval
tags:
  - Virtual Compute & Containers
govid: GOVI0004361
govid_url: https://lseg.service-now.com/x_lsegp_eag_governance_item.do?sys_id=57290e73c3ede6d0ec253a1c050131d0
tech_capabilities:
  - Infrastructure / Compute / Virtual Compute & Containers
---
# Integrate Azure VMs with Entra ID

## Introduction

This pattern describes design for integrating Azure VMs (Windows and Linux) with Microsoft Entra authentication.
Microsoft Entra-ID serves as a core authentication platform for Remote Desktop Protocol (RDP) into Windows Server and
SSH into a Linux VM.

### Context and Problem

- Reduce reliance on local administrator accounts, credential theft, and weak credentials.
- Local user accounts pose challenges in enforcing centralized identity management and access control.
- Administrative complexity, security risks due to un-managed accounts.

### Security Benefits of proposed solution

- Use Microsoft Entra-ID authentication governed by centralised LSEG IAM policies to sign in to VMs in Azure.

- Azure RBAC provide control to manage who can sign in to a VM as a regular user or with administrator privileges.
- Manage RBAC to grant or revoke access to the VMs.
- When employees leave LSEG and their user accounts are disabled or removed from Microsoft Entra ID, they no longer
  have access to your resources.
- Manage the overhead of sharing and managing the local admin credentials.
- All sign-in attempts using Entra-ID are logged in Microsoft Entra logs.
- Integration with Azure Bastion supports Entra ID authentication, allowing secure, browser-based RDP/SSH access to VMs
  without exposing public IPs or requiring local credentials.

## Scope

This pattern is applicable for integrating Azure VMs with Entra-ID. It provides a design for accessing Azure VMs, and
lists supported operating systems. Access to integrated VMs uses the Azure Bastion service. service.

## Pattern Design

The design uses the Azure VM extension for Entra-ID login to enable sign-in to the Azure VM. The extension runs on the
Azure VM agent. The VM must have a system-assigned managed identity enabled. Access to the Entra-joined VM is performed
via the Azure Bastion service. Entra join will create a device ID for the VM in the tenant but does not enroll the VM
in Intune; therefore the device state remains non-managed for Conditional Access purposes.

![Figure 1 - Entra Login design](img/0075-entra-vmlogin-hld-dgm.png)

## Supported Operating systems

- Windows Server 2022 Datacenter and later.
- RedHat Enterprise Linux -  RHEL 8.3+, RHEL 9.0+
- Ubuntu 16.04 to Ubuntu 20.04

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

![Figure 2 - Entra Login Linux VM Flow](img/0075-entra-linuxvm-flow-dgm.png)

- User will login to the Azure portal from the LSEG device using the -c account and get the MFA verification.
- The authentication will be governed by the Entra ID Conditional access policies.
- Launch the Bastion service from the Azure Portal to connect to the Linux VM.
- Bastion will validate the access,the User must have an Azure role for login to VM
- Upon successful access validation, bastion established the SSH connection to the VM.

### Windows VM

![Figure 3 - Entra Login Windows VM Flow](img/0075-entra-winvm-flow-dgm.png)

- Login to the Azure VM using Entra-ID is supported via the Azure CLI. A user should run `az login -u <user>` from an
  Entra-registered device (for example the LSEG device or a W365 VDI) using the appropriate account. Authentication is
  governed by Entra-ID Conditional Access policies and MFA will occur as part of `az login`.

  Execute the Azure CLI command to download an RDP file from Bastion and enable MFA when required:

  ```bash
  az network bastion rdp \
    --name <rdp_name> \
    --resource-group <rg_name> \
    --target-resource-id <vm_resource_id> \
    --enable-mfa true
  ```

  Use the downloaded RDP file to sign in with the `-c` account credentials. The name in the RDP file must match the
  hostname of the remote device in Microsoft Entra-ID and resolve to the VM's IP address. If the computer name and
  hostname differ, update the RDP display name to the VM hostname before connecting.

    - Bastion will validate the access; the user must have an Azure role that permits VM sign-in.
    - Upon successful authentication, the RDP client establishes a VM session.

#### **Dependencies**

##### **Local Computer**

- Azure CLI should be installed on the host machine e.g. AWS VDI.
- The `az network bastion rdp` command requires Azure CLI version 2.62.0 or higher. The Bastion extension will
  automatically install the first time you run a Bastion command if it isn't present.

##### **Target VMS**

- Remote connection to VMs that are joined to Microsoft Entra ID is allowed only from Windows 10 or later PCs that are
  Microsoft Entra registered, Microsoft Entra joined, or Microsoft Entra hybrid joined to the same directory as the VM.
- Microsoft Entra Guest accounts can't connect to Azure VMs or Azure Bastion enabled VMs via Microsoft Entra
  authentication.

- Ensure that the required endpoints are accessible from the VM via PowerShell (examples):

    - `curl.exe "https://login.microsoftonline.com/" -D -`
    - `curl.exe "https://login.microsoftonline.com/<TenantID>/" -D -`
    - `curl.exe "https://enterpriseregistration.windows.net/" -D -`
    - `curl.exe "https://device.login.microsoftonline.com/" -D -`
    - `curl.exe "https://pas.windows.net/" -D -`

- Enable the VM extension(s):
    - AADSSHLogin for Linux VM
    - AADLoginWindows for Windows VM

### Architecture Decisions

- For Windows VMs enabled with Entra-ID, authentication can be blocked by tenant Conditional Access policies (for
  example LSEGroup.onmicrosoft.com). To allow logins from the Azure environment, the external IP address of the Spoke
  Azure Firewall should be added as a named location in Conditional Access (via the normal ServiceNow request and LSEG
  governance process).
- Application team must use Entra ID groups and grant relevant Azure role for VM login. It is recommended that the
   Privileged Identity management for role assignment to the Entra ID group. To enable just in time access, efficient
   user management and provide the audit capability.

### **Note**

- Windows 2019 datacenter is not supported in the LSEG environment since it requires Windows Hello for Business.
- A non-interactive SSH login using a Microsoft Entra service principal is supported but not yet fully tested; this
  will be addressed in a subsequent iteration along with Conditional Access refinements.
- The stale device can be removed by LSEG with proper approvals, as part of LSEG's business as usual operational
  process.
- Both VM extensions can be enabled via Terraform at deployment time, or manually in the portal by a user with
  **Virtual Machine Contributor** access.
- Please ensure that outbound traffic from the VM is permitted to access the required endpoints listed in the
**Dependencies** section. Since all inbound traffic is routed through the Azure Bastion host via the Azure backplane,
there is no need to configure inbound traffic rules for the VM.

## Operational Considerations

### Image refresh and operational process

The golden image is refreshed every 90 days to include the latest patches and hotfixes. VM owners must apply the
refreshed golden image to their VMs on the same cadence. A typical safe workflow is:

#### Remove the Entra-ID extension before refresh

- Set the Terraform variable `enable_entraid_login` to `false` and run the pipeline to remove the extension from the VM
    prior to the golden image refresh.

#### Disjoin the VM from Entra-ID

- Sign in to the VM using a local administrator account.
- Run: `dsregcmd /leave` to disjoin the VM from Entra-ID.
- Verify the device status: `dsregcmd /status`.

#### Apply refreshed golden image and re-enable Entra-ID

- Once the golden image has been refreshed, set the Terraform variable `enable_entra_auth` to `true` (applies to both
  Windows and Linux VM patterns) and run the pipeline. This will apply the refreshed image and reinstall the Entra-ID
  extension, restoring Entra-ID login.
- Verify the device status: `dsregcmd /status`.

    ![Figure 4 - #entraid joined](img/0075-entra-dsregcmd-joined.png)

## Further Reading

- [Azure-ad-windows](https://learn.microsoft.com/en-us/entra/identity/devices/howto-vm-sign-in-azure-ad-windows)
- [Azure-ad-linux](https://learn.microsoft.com/en-us/entra/identity/devices/howto-vm-sign-in-azure-ad-linux)
- [Steps for
  testing](https://dev.azure.com/LSEGroup/Migration/_wiki/wikis/Migration.wiki/7748/VM-Entra-Logon-Documentation-(DRAFT-not-ready-for-production))
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/network/bastion?view=azure-cli-latest)
- [RBAC for VMs](https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles#compute)
- [Non-interactive SSH
  Login](https://learn.microsoft.com/en-us/entra/identity/devices/howto-vm-sign-in-azure-ad-linux#log-in-by-using-the-microsoft-entra-service-principal-to-ssh-into-the-linux-vm)
- [Troubleshoot with dsregcmd](https://learn.microsoft.com/en-us/entra/identity/devices/troubleshoot-device-dsregcmd)

