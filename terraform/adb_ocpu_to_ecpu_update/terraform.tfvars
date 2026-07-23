# ── OCI Credentials ──────────────────────────────────────────
tenancy_ocid     = ""
user_ocid        = ""
fingerprint      = ""
private_key_path = ""
region           = "us-ashburn-1"

compartment_ocid = ""

# ── ADB Configuration ─────────────────────────────────────────
adb_display_name   = ""
adb_db_name        = ""
adb_admin_password = ""
adb_workload_type  = "LH"    # OLTP=ATP | LH=LAKEHOUSE | DW=ADW | AJD=JSON | APEX
adb_cpu_core_count = 2       # ECPU: minimum 2, multiples of 2
adb_storage_tbs    = 1
adb_auto_scaling   = false
