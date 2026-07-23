# ── OCI Credentials ──────────────────────────────────────────
tenancy_ocid     = ""
user_ocid        = ""
fingerprint      = ""
private_key_path = ""
region           = "us-ashburn-1"

compartment_ocid = ""

# ── Existing ADB ──────────────────────────────────────────────
adb_ocid           = ""
adb_db_name        = ""
adb_admin_password = ""

# ── Backup — automatic ────────────────────────────────────────
backup_retention_days = 60   # 1–60 days

# ── Backup — long-term schedule ───────────────────────────────
backup_schedule_cadence         = "MONTHLY"              # ONE_TIME | WEEKLY | MONTHLY | YEARLY
backup_schedule_time            = "2026-06-01T02:00:00Z" # RFC3339 — first backup and recurring anchor
long_term_backup_retention_days = 365                    # 365=1yr | 730=2yr | 1825=5yr | 3650=10yr
