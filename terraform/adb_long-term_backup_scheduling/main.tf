# ============================================================
# main.tf — Existing ADB — backup retention and schedule
# Updates automatic backup retention and configures a long-term
# backup schedule on an existing Autonomous Database.
# ============================================================

resource "oci_database_autonomous_database" "adb" {
  # Required by the provider schema — values must match the existing ADB.
  compartment_id = var.compartment_ocid
  db_name        = var.adb_db_name
  admin_password = var.adb_admin_password

  # ── Automatic backup retention ────────────────────────────
  # Retention period for daily automatic backups (1–60 days).
  # For retention beyond 60 days use long_term_backup_schedule below.
  backup_retention_period_in_days = var.backup_retention_days

  # ── Long-term backup schedule ─────────────────────────────
  # OCI manages the schedule natively — no crontab or external tooling required.
  # repeat_cadence options: ONE_TIME | WEEKLY | MONTHLY | YEARLY
  # time_of_backup: RFC3339 timestamp — anchor point for the recurring schedule.
  long_term_backup_schedule {
    repeat_cadence           = var.backup_schedule_cadence
    retention_period_in_days = var.long_term_backup_retention_days
    time_of_backup           = var.backup_schedule_time
    is_disabled              = false
  }

  # ── Lifecycle ─────────────────────────────────────────────
  # Ignore fields not relevant to backup configuration so that
  # Terraform does not attempt to modify the existing ADB.
  lifecycle {
    ignore_changes = [
      admin_password,
      display_name,
      db_workload,
      db_version,
      compute_model,
      compute_count,
      data_storage_size_in_tbs,
      license_model,
      is_mtls_connection_required,
      whitelisted_ips,
      freeform_tags,
    ]
  }
}
