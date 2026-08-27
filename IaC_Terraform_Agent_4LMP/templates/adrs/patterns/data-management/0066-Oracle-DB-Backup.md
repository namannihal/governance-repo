<span class="md-content__button md-icon md-status--published" href="#" title="Status: Published"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE4LjUgMmgtMTNDMy42IDIgMiAzLjYgMiA1LjV2MTNDMiAyMC40IDMuNiAyMiA1LjUgMjJIMTZsNi02VjUuNUMyMiAzLjYgMjAuNCAyIDE4LjUgMk0yMCAxNWgtMS41Yy0xLjkgMC0zLjUgMS42LTMuNSAzLjVWMjBINS44Yy0xIDAtMS44LS44LTEuOC0xLjhWNS44QzQgNC44IDQuOCA0IDUuOCA0aDEyLjVjMSAwIDEuOC44IDEuOCAxLjhWMTVtLTQuOS02LjggMS41IDEuNS02IDYtMy41LTMuNSAxLjUtMS41IDIgMnoiIC8+PC9zdmc+) </span> <span class="md-content__button md-icon .md-status--published" title="Valid from 2025-11-03"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE5IDE5SDVWOGgxNG0wLTVoLTFWMWgtMnYySDhWMUg2djJINWEyIDIgMCAwIDAtMiAydjE0YTIgMiAwIDAgMCAyIDJoMTRhMiAyIDAgMCAwIDItMlY1YTIgMiAwIDAgMC0yLTJtLTIuNDcgOC4wNkwxNS40NyAxMGwtNC44OCA0Ljg4LTIuMTItMi4xMi0xLjA2IDEuMDZMMTAuNTkgMTd6IiAvPjwvc3ZnPg==) </span> <span class="md-content__button md-icon actions-date" title="Published on 2024-08-20">![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTkgMTB2Mkg3di0yem00IDB2MmgtMnYtMnptNCAwdjJoLTJ2LTJ6bTItN2EyIDIgMCAwIDEgMiAydjE0YTIgMiAwIDAgMS0yIDJINWEyIDIgMCAwIDEtMi0yVjVhMiAyIDAgMCAxIDItMmgxVjFoMnYyaDhWMWgydjJ6bTAgMTZWOEg1djExek05IDE0djJIN3YtMnptNCAwdjJoLTJ2LTJ6bTQgMHYyaC0ydi0yeiIgLz48L3N2Zz4=)</span> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/edit/main/docs/patterns/data-management/0066-Oracle-DB-Backup.md" class="md-content__button md-icon" title="Edit this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTEwIDIwSDZWNGg3djVoNXYzLjFsMi0yVjhsLTYtNkg2Yy0xLjEgMC0yIC45LTIgMnYxNmMwIDEuMS45IDIgMiAyaDR6bTEwLjItN2MuMSAwIC4zLjEuNC4ybDEuMyAxLjNjLjIuMi4yLjYgMCAuOGwtMSAxLTIuMS0yLjEgMS0xYy4xLS4xLjItLjIuNC0uMm0wIDMuOUwxNC4xIDIzSDEydi0yLjFsNi4xLTYuMXoiIC8+PC9zdmc+" /></a> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/blob/main/docs/patterns/data-management/0066-Oracle-DB-Backup.md" class="md-content__button md-icon" title="View source of this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE3IDE4Yy41NiAwIDEgLjQ0IDEgMXMtLjQ0IDEtMSAxLTEtLjQ0LTEtMSAuNDQtMSAxLTFtMC0zYy0yLjczIDAtNS4wNiAxLjY2LTYgNCAuOTQgMi4zNCAzLjI3IDQgNiA0czUuMDYtMS42NiA2LTRjLS45NC0yLjM0LTMuMjctNC02LTRtMCA2LjVhMi41IDIuNSAwIDAgMS0yLjUtMi41IDIuNSAyLjUgMCAwIDEgMi41LTIuNSAyLjUgMi41IDAgMCAxIDIuNSAyLjUgMi41IDIuNSAwIDAgMS0yLjUgMi41TTkuMjcgMjBINlY0aDd2NWg1djQuMDdjLjcuMDggMS4zNi4yNSAyIC40OVY4bC02LTZINmEyIDIgMCAwIDAtMiAydjE2YTIgMiAwIDAgMCAyIDJoNC41YTguMiA4LjIgMCAwIDEtMS4yMy0yIiAvPjwvc3ZnPg==" /></a>

Document Metadata

|  |  |
|----|----|
| Identifier | **`LMP-PAT-0066`** |
| Type | **Technical Design Pattern** |
| Status | **Published** |
| Approvals | <span class="md-tag">LMP Migration Architecture Approval</span> |
| Governance Reference | **[]()** |
| Pattern Source Repo | []() |
| Published on | **August 20, 2024** |
| Valid From | **November 03, 2025** |
| Authors | <span class="md-source-file__fact"> </span> |
| Tags | <span class="md-tag">Data Management</span> |
| Technology Capabilities | <span class="md-tag">Platform / Data / Data Management</span> |

# Oracle DB Backup Strategy<a href="#oracle-db-backup-strategy" class="headerlink" title="Permanent link">¶</a>

## Introduction<a href="#introduction" class="headerlink" title="Permanent link">¶</a>

This document outlines the backup strategy for an Oracle database hosted on an Azure Linux Virtual Machine. The backup process utilizes Oracle RMAN, executed via bash scripts scheduled through crontab. Backups are stored on striped LVM locally, then copied to Azure Blob for retention and disaster recovery.

## Backup Storage Architecture<a href="#backup-storage-architecture" class="headerlink" title="Permanent link">¶</a>

### Local Filesystem<a href="#local-filesystem" class="headerlink" title="Permanent link">¶</a>

- Mount Point: /backups
- Type: Linux LVM (Logical Volume Manager)
- Configuration: Striped logical volumes across at least two Azure managed disks

### Striped Logical Volumes<a href="#striped-logical-volumes" class="headerlink" title="Permanent link">¶</a>

Striped volumes distribute data blocks evenly across multiple physical volumes, enabling parallel I/O operations.

### Advantages over Linear Volumes<a href="#advantages-over-linear-volumes" class="headerlink" title="Permanent link">¶</a>

- Higher Throughput: Parallel disk access improves performance.
- Optimized for Sequential Workloads: Ideal for large backup operations.
- Balanced Disk Utilization: Prevents bottlenecks on a single disk.

## Backup Strategy<a href="#backup-strategy" class="headerlink" title="Permanent link">¶</a>

### Backup Types<a href="#backup-types" class="headerlink" title="Permanent link">¶</a>

| Type         | Description              | Frequency               | Compression |
|--------------|--------------------------|-------------------------|-------------|
| Full         | Complete database backup | Weekly (e.g., Sat, Sun) | Optional    |
| Incremental  | Hardware-accelerated     | Daily                   | Optional    |
| Archive logs | Native support           | Every 2/4/8 hours       | Optional    |

## RMAN Configuration<a href="#rman-configuration" class="headerlink" title="Permanent link">¶</a>

- Retention Policy: 3-day recovery window
- Backup Piece Size: Limited to 100 GB
- Control File Autobackup: Enabled
- Folder structure : - /backups/rman/{db_unique_name}/full/dd-mm-yyyy - /backups/rman/{db_unique_name}/incr/dd-mm-yyyy - /backups/rman/{db_unique_name}/arch/dd-mm-yyyy

## Azure Blob Storage Integration<a href="#azure-blob-storage-integration" class="headerlink" title="Permanent link">¶</a>

### Storage Details<a href="#storage-details" class="headerlink" title="Permanent link">¶</a>

- Storage Account: \[Configured Azure Storage Account\]
- Container Name: ora_db_backups
- Folder Structure (similar format as local filesystem): {container_name}/rman/{db_unique_name}/\[full,incr,arch\]/dd-mm-yyyy

### Authentication<a href="#authentication" class="headerlink" title="Permanent link">¶</a>

- Method: Managed Identity (MSI)
- Environment Variable:
- export AZCOPY_AUTO_LOGIN_TYPE=MSI
- Login Command: azcopy login --identity

## Backup Script Design<a href="#backup-script-design" class="headerlink" title="Permanent link">¶</a>

### Script Features<a href="#script-features" class="headerlink" title="Permanent link">¶</a>

- Name: TBD
- Arguments: --type \[full\|incr\|arch\] --compress \[yes\|no\]
- Functions: - Executes RMAN backup - Organizes backups in date-wise folders - Upon successful completion of backup, transfers backup pieces to Azure Blob Storage - Redirect azcopy logs to /backups/azcopy_logs/ - Deletes obsolete backups using RMAN retention policy - Cleans up old azcopy logs

### Error Handling<a href="#error-handling" class="headerlink" title="Permanent link">¶</a>

- Validates RMAN and azcopy execution
- Logs errors and exits with appropriate status codes
- Integrate with observability tools for alerting

## Automation & Maintenance<a href="#automation-maintenance" class="headerlink" title="Permanent link">¶</a>

### Required Tools<a href="#required-tools" class="headerlink" title="Permanent link">¶</a>

- azcopy:

### Installation Paths<a href="#installation-paths" class="headerlink" title="Permanent link">¶</a>

- azcopy logs: /backups/azcopy_logs/

### Updates<a href="#updates" class="headerlink" title="Permanent link">¶</a>

- azcopy binaries to be maintained in BAMS/Artifactory
- Periodic update during GI refresh

### Update Strategy<a href="#update-strategy" class="headerlink" title="Permanent link">¶</a>

- Download latest version from Microsoft (<https://github.com/Azure/azure-storage-azcopy/releases>)
- Replace binary in {installation_path}
- Validate version post-update

## Housekeeping<a href="#housekeeping" class="headerlink" title="Permanent link">¶</a>

### Local Filesystem<a href="#local-filesystem_1" class="headerlink" title="Permanent link">¶</a>

- Managed by: RMAN retention policy
- Operation: DELETE OBSOLETE based on 3-day recovery window

### Azure Blob Storage<a href="#azure-blob-storage" class="headerlink" title="Permanent link">¶</a>

- Retention: Long-term – 45 days recommended or more than that based on application requirement
- Create Azure Blob Storage lifecycle management policy to delete the rman backup files.
- Folder Naming: Date-based for easy retrieval

### Log Management<a href="#log-management" class="headerlink" title="Permanent link">¶</a>

- azcopy logs: to be redirected to /backups/azcopy_logs/ using AZCOPY_LOG_LOCATION env var in the script
- Cleanup: Implement age-based deletion in script to retain last 30 days of azcopy logs

### Recovery Strategy<a href="#recovery-strategy" class="headerlink" title="Permanent link">¶</a>

- Point-in-Time Recovery (PITR): - Within 3 Days: Use local backup pieces - Beyond 3 Days: Download required pieces from Azure Blob Storage
- Scripts to download the files from Blob to local filesystem

## Further Reading<a href="#further-reading" class="headerlink" title="Permanent link">¶</a>

[Oracle DB Backup Strategy](https://confluence.refinitiv.com/spaces/DCCE/pages/1498977100/OVM+Backup+Strategy)

<span class="md-source-file__fact"> <span class="md-icon" title="Last update"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIxIDEzLjFjLS4xIDAtLjMuMS0uNC4ybC0xIDEgMi4xIDIuMSAxLTFjLjItLjIuMi0uNiAwLS44bC0xLjMtMS4zYy0uMS0uMS0uMi0uMi0uNC0uMm0tMS45IDEuOC02LjEgNlYyM2gyLjFsNi4xLTYuMXpNMTIuNSA3djUuMmw0IDIuNC0xIDFMMTEgMTNWN3pNMTEgMjEuOWMtNS4xLS41LTktNC44LTktOS45QzIgNi41IDYuNSAyIDEyIDJjNS4zIDAgOS42IDQuMSAxMCA5LjMtLjMtLjEtLjYtLjItMS0uMnMtLjcuMS0xIC4yQzE5LjYgNy4yIDE2LjIgNCAxMiA0Yy00LjQgMC04IDMuNi04IDggMCA0LjEgMy4xIDcuNSA3LjEgNy45bC0uMS4yeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="January 19, 2026 11:12:45 UTC">January 19, 2026</span> </span> <span class="md-source-file__fact"> <span class="md-icon" title="Created"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE0LjQ3IDE1LjA4IDExIDEzVjdoMS41djUuMjVsMy4wOCAxLjgzYy0uNDEuMjgtLjc5LjYyLTEuMTEgMW0tMS4zOSA0Ljg0Yy0uMzYuMDUtLjcxLjA4LTEuMDguMDgtNC40MiAwLTgtMy41OC04LThzMy41OC04IDgtOCA4IDMuNTggOCA4YzAgLjM3LS4wMy43Mi0uMDggMS4wOC42OS4xIDEuMzMuMzIgMS45Mi42NC4xLS41Ni4xNi0xLjEzLjE2LTEuNzIgMC01LjUtNC41LTEwLTEwLTEwUzIgNi41IDIgMTJzNC40NyAxMCAxMCAxMGMuNTkgMCAxLjE2LS4wNiAxLjcyLS4xNi0uMzItLjU5LS41NC0xLjIzLS42NC0xLjkyTTE4IDE1djNoLTN2MmgzdjNoMnYtM2gzdi0yaC0zdi0zeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="October 7, 2025 15:00:55 UTC">October 7, 2025</span> </span>

<a href="../0054-data-factory-service-pattern/" class="md-footer__link md-footer__link--prev" aria-label="Previous: Azure Data Factory Service Pattern"></a>

<div class="md-footer__button md-icon">

![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIwIDExdjJIOGw1LjUgNS41LTEuNDIgMS40Mkw0LjE2IDEybDcuOTItNy45MkwxMy41IDUuNSA4IDExeiIgLz48L3N2Zz4=)

</div>

<div class="md-footer__title">

<span class="md-footer__direction"> Previous </span>

<div class="md-ellipsis">

Azure Data Factory Service Pattern

</div>

</div>

<a href="../0067-db-housekeeping/" class="md-footer__link md-footer__link--next" aria-label="Next: Azure Automation"></a>

<div class="md-footer__title">

<span class="md-footer__direction"> Next </span>

<div class="md-ellipsis">

Azure Automation

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
