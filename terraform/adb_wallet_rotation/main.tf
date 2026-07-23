# ============================================================
# main.tf — Autonomous Database with mTLS
# ============================================================

resource "oci_database_autonomous_database" "adb" {
  compartment_id           = var.compartment_ocid
  display_name             = var.adb_display_name
  db_name                  = var.adb_db_name
  admin_password           = var.adb_admin_password
  db_workload              = var.adb_workload_type
  db_version               = var.adb_db_version
  compute_model            = "ECPU"
  compute_count            = var.adb_cpu_core_count
  data_storage_size_in_tbs = var.adb_storage_tbs

  # ── mTLS — wallet required ────────────────────────────────
  is_mtls_connection_required = true

  lifecycle {
    ignore_changes = [admin_password]
  }
}
