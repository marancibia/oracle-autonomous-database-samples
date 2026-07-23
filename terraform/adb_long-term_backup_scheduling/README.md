# Terraform — Long-Term Backup Scheduling and Retention Policy

Configures automatic backup retention and a long-term backup schedule on an existing Autonomous Database. Designed for compliance scenarios where data must be retained beyond the 60-day automatic backup limit.

## Files

| File | Description |
|---|---|
| `versions.tf` | Terraform and provider version requirements |
| `provider.tf` | OCI provider configuration |
| `main.tf` | Automatic backup retention and long-term backup schedule |
| `variables.tf` | All configurable parameters |
| `outputs.tf` | Values exported after apply |
| `terraform.tfvars` | Fill in your values |

## Quick Start

```bash
# 1. Initialize Terraform
terraform init

# 2. Import the existing ADB into the Terraform state
terraform import oci_database_autonomous_database.adb <ADB_OCID>

# 3. Review the plan — the ADB should show only backup-related changes
terraform plan

# 4. Apply
terraform apply
```

## Backup Architecture

```
Existing Autonomous Database
├── Automatic backups (daily, managed by OCI)
│   └── Retained for backup_retention_days (1–60 days)
│
└── Long-term backup schedule (managed by OCI natively)
    ├── Cadence: ONE_TIME | WEEKLY | MONTHLY | YEARLY
    ├── Anchor: backup_schedule_time (RFC3339)
    └── Retained for long_term_backup_retention_days (90–3650 days)
```

## Schedule Reference

| Cadence | Behavior |
|---|---|
| `ONE_TIME` | Single backup taken at `backup_schedule_time` |
| `WEEKLY` | Repeats every 7 days at the same time and day of week |
| `MONTHLY` | Repeats on the same day each month (last day if >= 29) |
| `YEARLY` | Repeats on the same date each year |

## Retention Reference

| Period | Days |
|---|---|
| 3 months (minimum) | 90 |
| 1 year | 365 |
| 2 years | 730 |
| 5 years | 1825 |
| 7 years | 2555 |
| 10 years (maximum) | 3650 |

## Variables

| Variable | Description | Default |
|---|---|---|
| `tenancy_ocid` | OCID of the OCI tenancy | — |
| `user_ocid` | OCID of the OCI user | — |
| `fingerprint` | Fingerprint of the API key | — |
| `private_key_path` | Path to the private key file (.pem) | — |
| `region` | OCI region where the ADB resides | `us-ashburn-1` |
| `compartment_ocid` | OCID of the compartment where the ADB resides | — |
| `adb_ocid` | OCID of the existing Autonomous Database | — |
| `adb_db_name` | Technical database name (must match exactly) | — |
| `adb_admin_password` | ADMIN password (required by provider, not modified) | — |
| `backup_retention_days` | Automatic daily backup retention in days (1–60) | `30` |
| `backup_schedule_cadence` | Backup frequency: `ONE_TIME`, `WEEKLY`, `MONTHLY`, `YEARLY` | `MONTHLY` |
| `backup_schedule_time` | RFC3339 anchor timestamp for the schedule | — |
| `long_term_backup_retention_days` | Long-term backup retention in days (90–3650) | `365` |

## Outputs

| Output | Description |
|---|---|
| `adb_id` | OCID of the Autonomous Database |
| `backup_retention_days` | Automatic backup retention period in days |
| `backup_schedule_cadence` | Frequency of the long-term backup schedule |
| `backup_schedule_time` | Anchor timestamp for the long-term backup schedule |
| `long_term_backup_retention_days` | Long-term backup retention period in days |

## Notes

- **Existing ADB required:** This Terraform is designed for existing databases only. Import the ADB before running `terraform apply` — see Quick Start above.

- **Automatic backup prerequisite:** OCI requires at least one automatic backup to exist before the long-term backup schedule activates. After provisioning a new ADB, wait up to 4 hours for the first automatic backup to complete.

- **`backup_schedule_time` format:** Must be a valid RFC3339 timestamp in UTC. Example: `2025-06-01T02:00:00Z`. This timestamp serves as both the first backup date and the anchor point for the recurring schedule.

- **MONTHLY cadence edge case:** If `backup_schedule_time` falls on day 29, 30, or 31, OCI takes the backup on the last day of months with fewer days.

- **`admin_password` in tfvars:** Required by the OCI provider schema but listed in `ignore_changes`. Terraform will never use it to modify the database password.

- **Automatic backup limit:** OCI automatic backups support a maximum of 60 days. For retention beyond 60 days, the long-term backup schedule is required.

- **Storage costs:** Long-term backups incur additional Object Storage costs beyond the standard ADB storage bill.

- **Restore from long-term backup:** Long-term backups can only be used to clone a new database, not to restore in-place. Go to your ADB in the OCI console → Backups → select the long-term backup → click Clone.
