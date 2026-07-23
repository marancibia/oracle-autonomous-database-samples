# ============================================================
# variables.tf — Configurable parameters
# ============================================================

# ── OCI Credentials ──────────────────────────────────────────
variable "tenancy_ocid" {
  description = "OCID of the Oracle Cloud tenancy"
  type        = string
}

variable "user_ocid" {
  description = "OCID of the OCI user"
  type        = string
}

variable "fingerprint" {
  description = "Fingerprint of the user's API key"
  type        = string
}

variable "private_key_path" {
  description = "Path to the private key file (.pem)"
  type        = string
}

variable "region" {
  description = "OCI region where the ADB resides"
  type        = string
  default     = "us-ashburn-1"
}

variable "compartment_ocid" {
  description = "OCID of the compartment where the ADB resides"
  type        = string
}

# ── Existing ADB ──────────────────────────────────────────────
variable "adb_ocid" {
  description = "OCID of the existing Autonomous Database"
  type        = string
}

variable "adb_db_name" {
  description = "Technical database name of the existing ADB (must match exactly)"
  type        = string
}

variable "adb_admin_password" {
  description = "ADMIN password of the existing ADB (required by provider schema, not modified)"
  type        = string
  sensitive   = true
}

# ── Backup — automatic ────────────────────────────────────────
variable "backup_retention_days" {
  description = "Retention period for automatic daily backups (1–60 days)"
  type        = number
  default     = 30

  validation {
    condition     = var.backup_retention_days >= 1 && var.backup_retention_days <= 60
    error_message = "Must be between 1 and 60 days."
  }
}

# ── Backup — long-term schedule ───────────────────────────────
variable "backup_schedule_cadence" {
  description = "Frequency of the long-term backup schedule: ONE_TIME | WEEKLY | MONTHLY | YEARLY"
  type        = string
  default     = "MONTHLY"

  validation {
    condition     = contains(["ONE_TIME", "WEEKLY", "MONTHLY", "YEARLY"], var.backup_schedule_cadence)
    error_message = "Must be one of: ONE_TIME, WEEKLY, MONTHLY, YEARLY."
  }
}

variable "backup_schedule_time" {
  description = "RFC3339 timestamp — anchor point for the recurring schedule. Example: 2025-06-01T02:00:00Z"
  type        = string
}

variable "long_term_backup_retention_days" {
  description = "Retention period for long-term backups in days (90–3650)"
  type        = number
  default     = 365

  validation {
    condition     = var.long_term_backup_retention_days >= 90 && var.long_term_backup_retention_days <= 3650
    error_message = "Must be between 90 and 3650 days. Reference: 365=1yr, 730=2yr, 1825=5yr, 3650=10yr."
  }
}
