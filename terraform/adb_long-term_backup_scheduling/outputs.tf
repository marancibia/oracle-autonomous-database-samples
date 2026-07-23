# ============================================================
# outputs.tf — Values exported after apply
# ============================================================

# ── ADB ───────────────────────────────────────────────────────
output "adb_id" {
  description = "OCID of the Autonomous Database"
  value       = oci_database_autonomous_database.adb.id
}

output "backup_retention_days" {
  description = "Automatic backup retention period in days"
  value       = oci_database_autonomous_database.adb.backup_retention_period_in_days
}

# ── Long-term backup schedule ─────────────────────────────────
output "backup_schedule_cadence" {
  description = "Frequency of the long-term backup schedule"
  value       = var.backup_schedule_cadence
}

output "backup_schedule_time" {
  description = "Anchor timestamp for the long-term backup schedule"
  value       = var.backup_schedule_time
}

output "long_term_backup_retention_days" {
  description = "Long-term backup retention period in days"
  value       = var.long_term_backup_retention_days
}
