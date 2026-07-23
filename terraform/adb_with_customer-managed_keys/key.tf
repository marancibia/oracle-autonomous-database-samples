# ============================================================
# key.tf — Master Encryption Key (CMK)
# AES-256 key stored in HSM (FIPS 140-2 Level 3).
# This key wraps the Data Encryption Key (DEK) that directly
# encrypts the ADB data — envelope encryption pattern.
# ============================================================

resource "oci_kms_key" "adb_master_key" {
  compartment_id      = var.compartment_ocid
  display_name        = var.key_display_name
  management_endpoint = oci_kms_vault.adb_vault.management_endpoint

  key_shape {
    algorithm = "AES"
    length    = 32 # 256 bits
  }

  # HSM: key material never leaves the hardware module in plaintext.
  # Use SOFTWARE only for dev/test environments.
  protection_mode = "HSM"

  # Depends on the sleep to ensure the Vault management endpoint
  # is fully resolvable in DNS before attempting to create the key.
  depends_on = [time_sleep.wait_for_vault]
}
