# ============================================================
# dynamic_group.tf — Dynamic Group
# Identifies all ADB instances in the compartment so that
# IAM policies can grant them access to the Vault and Key.
# Dynamic groups must be created at the tenancy root level.
# ============================================================

resource "oci_identity_dynamic_group" "adb_dynamic_group" {
  compartment_id = var.tenancy_ocid
  name           = var.dynamic_group_name
  description    = "Dynamic group for Autonomous Databases using CMK"

  # Matches all resources in the compartment.
  # If the ADB already exists, you can scope it further:
  # resource.id = '<adb_ocid>'
  matching_rule = "resource.compartment.id = '${var.compartment_ocid}'"
}
