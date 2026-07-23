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
  description = "OCI region where the resources will be created"
  type        = string
  default     = "us-ashburn-1"
}

variable "compartment_ocid" {
  description = "OCID of the compartment where all resources will be created"
  type        = string
}

# ── Vault ─────────────────────────────────────────────────────
variable "vault_display_name" {
  description = "Display name for the OCI KMS Vault"
  type        = string
}

# ── Master Encryption Key ─────────────────────────────────────
variable "key_display_name" {
  description = "Display name for the Master Encryption Key (CMK)"
  type        = string
}

# ── Dynamic Group ─────────────────────────────────────────────
variable "dynamic_group_name" {
  description = "Name for the Dynamic Group"
  type        = string
}

# ── IAM Policy ────────────────────────────────────────────────
variable "policy_name" {
  description = "Name for the IAM Policy"
  type        = string
}

# ── ADB Configuration ─────────────────────────────────────────
variable "adb_display_name" {
  description = "Display name in the OCI console"
  type        = string
}

variable "adb_db_name" {
  description = "Technical database name (letters/numbers only, max 14 chars)"
  type        = string
}

variable "adb_admin_password" {
  description = "ADMIN user password (min 12 chars, uppercase, number and symbol required)"
  type        = string
  sensitive   = true
}

variable "adb_workload_type" {
  description = "Workload type: OLTP (ATP), DW (ADW), AJD (JSON), APEX"
  type        = string
  default     = "OLTP"

  validation {
    condition     = contains(["OLTP", "DW", "AJD", "APEX"], var.adb_workload_type)
    error_message = "Must be one of: OLTP, DW, AJD, APEX."
  }
}

variable "adb_db_version" {
  description = "Oracle database version"
  type        = string
  default     = "26ai"
}

variable "adb_compute_model" {
  description = "Compute model for the ADB (ECPU is required for new databases)"
  type        = string
  default     = "ECPU"
}

variable "adb_cpu_core_count" {
  description = "Number of ECPUs (minimum 2 in ECPU model)"
  type        = number
  default     = 2
}

variable "adb_storage_tbs" {
  description = "Storage size in terabytes"
  type        = number
  default     = 1
}

# ── Auto-scaling ──────────────────────────────────────────────
variable "adb_auto_scaling" {
  description = "Enable ECPU auto-scaling"
  type        = bool
  default     = false
}