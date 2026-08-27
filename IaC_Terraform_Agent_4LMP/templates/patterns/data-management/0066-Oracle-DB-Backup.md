---
id: LMP-PAT-0066
type: Technical Design Pattern
status: published
approved_by:
  - LMP Migration Architecture Approval
valid_from: 2025-11-03
date: 2024-08-20
tags:
  - Data Management
tech_capabilities:
  - Platform / Data / Data Management
---

# Oracle DB Backup Strategy

## Introduction

 This document outlines the backup strategy for an Oracle database hosted on an Azure Linux Virtual Machine.
 The backup process utilizes Oracle RMAN, executed via bash scripts scheduled through crontab.
 Backups are stored on striped LVM locally, then copied to Azure Blob for retention and disaster recovery.

## Backup Storage Architecture

### Local Filesystem

- Mount Point: /backups
- Type: Linux LVM (Logical Volume Manager)
- Configuration: Striped logical volumes across at least two Azure managed disks

### Striped Logical Volumes

Striped volumes distribute data blocks evenly across multiple physical volumes, enabling parallel I/O operations.

### Advantages over Linear Volumes

- Higher Throughput: Parallel disk access improves performance.
- Optimized for Sequential Workloads: Ideal for large backup operations.
- Balanced Disk Utilization: Prevents bottlenecks on a single disk.

## Backup Strategy

### Backup Types

|Type                          |Description              |Frequency              |Compression |
|------------------------------|-------------------------|-----------------------|------------|
|Full                          |Complete database backup |Weekly (e.g., Sat, Sun)|Optional    |
|Incremental                   |Hardware-accelerated     |Daily                  |Optional    |
|Archive logs                  |Native support           |Every 2/4/8 hours      |Optional    |

## RMAN Configuration

- Retention Policy: 3-day recovery window
- Backup Piece Size: Limited to 100 GB
- Control File Autobackup: Enabled
- Folder structure :
    - /backups/rman/{db_unique_name}/full/dd-mm-yyyy
    - /backups/rman/{db_unique_name}/incr/dd-mm-yyyy
    - /backups/rman/{db_unique_name}/arch/dd-mm-yyyy

## Azure Blob Storage Integration

### Storage Details

- Storage Account: [Configured Azure Storage Account]
- Container Name: ora_db_backups
- Folder Structure (similar format as local filesystem): {container_name}/rman/{db_unique_name}/[full,incr,arch]/dd-mm-yyyy

### Authentication

- Method: Managed Identity (MSI)
- Environment Variable:
- export AZCOPY_AUTO_LOGIN_TYPE=MSI
- Login Command:
azcopy login --identity

## Backup Script Design

### Script Features

- Name: TBD
- Arguments:
--type [full|incr|arch]
--compress [yes|no]
- Functions:
    - Executes RMAN backup
    - Organizes backups in date-wise folders
    - Upon successful completion of backup, transfers backup pieces to Azure Blob Storage
    - Redirect azcopy logs to /backups/azcopy_logs/
    - Deletes obsolete backups using RMAN retention policy
    - Cleans up old azcopy logs

### Error Handling

- Validates RMAN and azcopy execution
- Logs errors and exits with appropriate status codes
- Integrate with observability tools for alerting

## Automation & Maintenance

### Required Tools

- azcopy:

### Installation Paths

- azcopy logs: /backups/azcopy_logs/

### Updates

- azcopy binaries to be maintained in BAMS/Artifactory
- Periodic update during GI refresh

### Update Strategy

- Download latest version from Microsoft (<https://github.com/Azure/azure-storage-azcopy/releases>)
- Replace binary in {installation_path}
- Validate version post-update

## Housekeeping

### Local Filesystem

- Managed by: RMAN retention policy
- Operation: DELETE OBSOLETE based on 3-day recovery window

### Azure Blob Storage

- Retention: Long-term – 45 days recommended or more than that based on application requirement
- Create Azure Blob Storage lifecycle management policy to delete the rman backup files.
- Folder Naming: Date-based for easy retrieval

### Log Management

- azcopy logs: to be redirected to /backups/azcopy_logs/ using AZCOPY_LOG_LOCATION env var in the script
- Cleanup: Implement age-based deletion in script to retain last 30 days of azcopy logs

### Recovery Strategy

- Point-in-Time Recovery (PITR):
    - Within 3 Days: Use local backup pieces
    - Beyond 3 Days: Download required pieces from Azure Blob Storage
- Scripts to download the files from Blob to local filesystem

## Further Reading

[Oracle DB Backup Strategy](https://confluence.refinitiv.com/spaces/DCCE/pages/1498977100/OVM+Backup+Strategy)

