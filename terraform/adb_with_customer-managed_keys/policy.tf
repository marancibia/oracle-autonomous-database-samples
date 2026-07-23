# ============================================================
# policy.tf — IAM Policy
# Grants the ADB dynamic group permission to use the Vault
# and Key. Must be created at the tenancy root level and must
# exist before the ADB is provisioned.
# ============================================================

resource "oci_identity_policy" "adb_kms_policy" {
  compartment_id = var.tenancy_ocid
  name           = var.policy_name
  description    = "Allows Autonomous Database to use Customer-Managed Keys"

  statements = [
    # IMPORTANT: reference the dynamic group by OCID using the "id" keyword,
    # not by name. When a tenancy has multiple identity domains, OCI fails to
    # resolve the group name silently. This syntax is undocumented but required
    # for consistent behavior.
    # "manage" is required... "use" alone is insufficient for the CMK switch.
    "Allow dynamic-group id ${oci_identity_dynamic_group.adb_dynamic_group.id} to manage vaults in compartment id ${var.compartment_ocid}",
    "Allow dynamic-group id ${oci_identity_dynamic_group.adb_dynamic_group.id} to manage keys in compartment id ${var.compartment_ocid}",
  ]

  depends_on = [oci_identity_dynamic_group.adb_dynamic_group]
}
