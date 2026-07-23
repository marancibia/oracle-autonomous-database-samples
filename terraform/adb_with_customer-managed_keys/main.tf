# ============================================================
# main.tf — Autonomous Database with Customer-Managed Keys (CMK)
# ============================================================

resource "oci_database_autonomous_database" "adb" {
  compartment_id           = var.compartment_ocid
  display_name             = var.adb_display_name
  db_name                  = var.adb_db_name
  admin_password           = var.adb_admin_password
  db_workload              = var.adb_workload_type  # OLTP | DW | AJD | APEX
  db_version               = var.adb_db_version
  compute_model            = var.adb_compute_model  # ECPU required for new databases
  compute_count            = var.adb_cpu_core_count
  data_storage_size_in_tbs = var.adb_storage_tbs

  # ── Customer-Managed Keys ─────────────────────────────────
  # The ADB uses envelope encryption: data is encrypted with a DEK,
  # and the DEK is wrapped using this CMK stored in OCI Vault.
  kms_key_id = oci_kms_key.adb_master_key.id
  vault_id   = oci_kms_vault.adb_vault.id

  # ── Auto-scaling ──────────────────────────────────────────
  is_auto_scaling_enabled             = var.adb_auto_scaling

  # The IAM policy must exist before the ADB attempts the CMK switch.
  depends_on = [oci_identity_policy.adb_kms_policy, oci_kms_key.adb_master_key]
}
