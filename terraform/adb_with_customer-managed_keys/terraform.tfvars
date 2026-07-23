# ── OCI Credentials ──────────────────────────────────────────
tenancy_ocid     = ""
user_ocid        = ""
fingerprint      = ""
private_key_path = ""
region           = "us-ashburn-1"

compartment_ocid = ""

# ── Vault ─────────────────────────────────────────────────────
vault_display_name = ""

# ── Master Encryption Key ─────────────────────────────────────
key_display_name = ""

# ── Dynamic Group ─────────────────────────────────────────────
dynamic_group_name = ""

# ── IAM Policy ────────────────────────────────────────────────
policy_name = ""

# ── ADB Configuration ─────────────────────────────────────────
adb_display_name   = ""
adb_db_name        = ""
adb_admin_password = ""
adb_compute_model  = "ECPU"
adb_workload_type  = "LH"   # OLTP=ATP | LH=LAKEHOUSE | DW=ADW | AJD=JSON | APEX
adb_db_version     = "26ai"
adb_cpu_core_count = 2   # minimum 2 in ECPU model
adb_storage_tbs    = 1
adb_auto_scaling   = false