# ============================================================
# wallet_rotation.tf — Wallet rotation via OCI CLI
# Runs on every terraform apply.
#
# Two steps:
#   1. rotate-wallet  — invalidates current certificates and generates new ones
#   2. generate-wallet — downloads the new wallet to var.wallet_output_path
# ============================================================

# Wait for the ADB to reach AVAILABLE state before rotating the wallet.
# rotate-wallet fails if the ADB is still in PROVISIONING state.
resource "time_sleep" "wait_for_adb" {
  create_duration = "120s"
  depends_on      = [oci_database_autonomous_database.adb]
}

resource "null_resource" "wallet_rotation" {
  # timestamp() always returns a new value on every apply,
  # forcing this resource to re-run every time.
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = <<-EOT
      # Step 1: Rotate — invalidates current certificates and generates new ones.
      # All apps using the old wallet will lose connection after this step.
      oci db autonomous-database rotate-wallet \
        --autonomous-database-id ${oci_database_autonomous_database.adb.id} \
        --region ${var.region}

      # Step 2: Download the new wallet to wallet_output_path.
      oci db autonomous-database generate-wallet \
        --autonomous-database-id ${oci_database_autonomous_database.adb.id} \
        --password "${var.wallet_password}" \
        --file "${var.wallet_output_path}" \
        --generate-type SINGLE \
        --region ${var.region}
    EOT
  }

  depends_on = [time_sleep.wait_for_adb]
}
