# ============================================================
# outputs.tf — Values exported after apply
# ============================================================

# ── KMS ───────────────────────────────────────────────────────
output "vault_id" {
  description = "OCID of the created Vault"
  value       = oci_kms_vault.adb_vault.id
}

output "vault_management_endpoint" {
  description = "Management endpoint of the Vault"
  value       = oci_kms_vault.adb_vault.management_endpoint
}

output "kms_key_id" {
  description = "OCID of the Master Encryption Key (CMK)"
  value       = oci_kms_key.adb_master_key.id
}

# ── IAM ───────────────────────────────────────────────────────
output "dynamic_group_id" {
  description = "OCID of the Dynamic Group"
  value       = oci_identity_dynamic_group.adb_dynamic_group.id
}

# ── ADB ───────────────────────────────────────────────────────
output "adb_id" {
  description = "OCID of the Autonomous Database"
  value       = oci_database_autonomous_database.adb.id
}