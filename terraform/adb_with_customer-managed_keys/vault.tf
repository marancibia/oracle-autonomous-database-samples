# ============================================================
# vault.tf — OCI KMS Vault
# Stores the Customer-Managed Key (CMK) used to encrypt the ADB.
# Must be in the same region as the Autonomous Database.
# ============================================================

resource "oci_kms_vault" "adb_vault" {
  compartment_id = var.compartment_ocid
  display_name   = var.vault_display_name
  vault_type     = "DEFAULT"
}

# Wait for the Vault to reach ACTIVE state before any key is created.
# The management endpoint DNS is not resolvable until the Vault is fully active.
resource "time_sleep" "wait_for_vault" {
  create_duration = "90s"
  depends_on      = [oci_kms_vault.adb_vault]
}