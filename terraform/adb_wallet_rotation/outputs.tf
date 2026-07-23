# ============================================================
# outputs.tf — Values exported after apply
# ============================================================

# ── ADB ───────────────────────────────────────────────────────
output "adb_id" {
  description = "OCID of the Autonomous Database"
  value       = oci_database_autonomous_database.adb.id
}

# ── Wallet ────────────────────────────────────────────────────
output "wallet_output_path" {
  description = "Local path where the wallet zip file was saved"
  value       = var.wallet_output_path
}
