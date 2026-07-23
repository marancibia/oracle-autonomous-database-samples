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
  description = "OCID of the compartment where the ADB will be created"
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
    condition     = contains(["OLTP", "DW", "AJD", "APEX", "LH"], var.adb_workload_type)
    error_message = "Must be one of: OLTP, DW, AJD, APEX, LH."
  }
}

variable "adb_db_version" {
  description = "Oracle database version"
  type        = string
  default     = "26ai"
}

variable "adb_cpu_core_count" {
  description = "Number of ECPUs (minimum 2)"
  type        = number
  default     = 2
}

variable "adb_storage_tbs" {
  description = "Storage size in terabytes"
  type        = number
  default     = 1
}

# ── Wallet ────────────────────────────────────────────────────

variable "wallet_password" {
  description = "Password to protect the wallet zip file (min 8 chars, 1 letter, 1 number)"
  type        = string
  sensitive   = true
}

variable "wallet_output_path" {
  description = "Local path where the wallet zip file will be saved"
  type        = string
  default     = "./wallet.zip"
}
