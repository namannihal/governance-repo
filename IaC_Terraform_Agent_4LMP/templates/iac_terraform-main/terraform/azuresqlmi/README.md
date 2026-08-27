# Azure SQL Managed Instance (azuresqlmi)

Deploys one or more Azure SQL Managed Instances for the **PPR** environment (East US 2 primary, Central US failover) using the `azure-prdsvcpat-terraform-mssqlmanagedinstance` pattern module.

## Instances Managed

| Key | Context | Instance | Failover Enabled |
|-----|---------|----------|-----------------|
| `sqlmi_eadb` | eadb | 01 | No |
| `sqlmi_eadb_02` | eadb | 02 | No |
| `sqlmi_eadb_03` | eadb | 03 | No |
| `sqlmi_ecdb` | ecdb | 01 | Yes (CUS) |

---

## Files

| File | Purpose |
|------|---------|
| `main.tf` | Calls the pattern module for each `sql_mi` map entry |
| `variables.tf` | Input variable declarations |
| `output.tf` | Outputs: instance map, keys, count |
| `providers.tf` | AzureRM (~>4.33), AzureAD (~>2.47), Time, Random, AzAPI |
| `backend.tfvars` | Remote state config (Azure Storage) |

---

## Remote State

```hcl
resource_group_name  = "a1a-52161-ppr-rg-estimates-eus2-01"
storage_account_name = "a1a52161pprsttfsteus201"
container_name       = "terraform"
key                  = "tfstate/iac_terraform/eus2/ppr_eus2_sqlmi_1.tfstate"
```

---

## Terraform Variables

Primary tfvars file:
```
environments/ppr/terraform-vars/eus2/ppr_eus2_sqlmi_1.tfvars
```

### Subnet Routing — Important

Two separate subnet variables serve different purposes:

| Variable | Subnet Used | Resources Created In It |
|----------|------------|------------------------|
| `rt_vnet_pe_subnet_id` *(top-level)* | `a1a-52161-ppr-snet-workload-eus2-06` (rtbl) | **SQLMI instance** private endpoint |
| `rt_vnet_pe_subnet_id_failover` *(top-level)* | `a1a-52161-ppr-snet-workload-cus-06` (rtbl) | **SQLMI failover instance** private endpoint |
| `network_config.privateendpoint_subnet_id` *(per-MI)* | `a1a-52161-ppr-snet-ecpec-eus2-01` (non-rtbl) | **Storage account + Key Vault** private endpoints |
| `network_config.privateendpoint_subnet_id_failover` *(per-MI)* | `a1a-52161-ppr-snet-ecpec-cus-01` (non-rtbl) | **Storage account + KV failover** private endpoints |

### `deploy_sqlmi_pdns`

Set to `false` for all instances. DNS A records are managed by **Azure Policy** (auto-registered). Setting this to `true` causes the following error because `custom_dns_configs` is empty when DNS is policy-managed:

```
Error: Invalid index
  records = [module...privateendpoint[0].resource.custom_dns_configs[0].ip_addresses[0]]
  module...custom_dns_configs is empty list of object
```

---

## Usage

### Init

```bat
set ARM_SUBSCRIPTION_ID=7b8a8ffb-9be5-4786-8ba6-dd328b9d6857
set ARM_TENANT_ID=287e9f0e-91ec-4cf0-b7a4-c63898072181
terraform init -backend-config=backend.tfvars
```

### Plan

```bat
terraform plan -var-file=../../environments/ppr/terraform-vars/eus2/ppr_eus2_sqlmi_1.tfvars
```

### Apply

```bat
terraform apply -var-file=../../environments/ppr/terraform-vars/eus2/ppr_eus2_sqlmi_1.tfvars
```

---

## State Imports

### ECDB Failover Group

Resource `a1a-52161-ppr-sqlfg-ecdb-cus-01` was pre-existing and imported into state:

```bat
terraform import \
  -var-file=../../environments/ppr/terraform-vars/eus2/ppr_eus2_sqlmi_1.tfvars \
  "module.azure_prdapppat_terraform_sql_mi[\"sqlmi_ecdb\"].module.azure_prdsvc_terraform_mssqlmanagedinstance.azurerm_mssql_managed_instance_failover_group.failover[0]" \
  "/subscriptions/7b8a8ffb-9be5-4786-8ba6-dd328b9d6857/resourceGroups/a1a-52161-ppr-rg-estimates-eus2-01/providers/Microsoft.Sql/locations/eastus2/instanceFailoverGroups/a1a-52161-ppr-sqlfg-ecdb-cus-01"
```

Import script: `tmp_import_from_abc_failovergroup.cmd`

---

## Known Issues / Notes

- `skip_provider_registration = true` is deprecated in AzureRM v4+; replace with `resource_provider_registrations = "none"` in providers.tf when upgrading.
- `sqlmi_ecdb` has `failover_enabled = true` and deploys a secondary instance in Central US.
- `sqlmi_eadb_02` and `sqlmi_eadb_03` use pre-existing delegated subnets (`deploy_delegated_subnet = false`); `sqlmi_eadb` and `sqlmi_ecdb` deploy their own delegated subnets.
