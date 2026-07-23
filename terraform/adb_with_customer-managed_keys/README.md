# Terraform — Autonomous Database with Customer-Managed Keys (CMK)

Creates an OCI Vault, a Master Encryption Key, a Dynamic Group, an IAM Policy, and an Autonomous Database encrypted with Customer-Managed Keys.

## Files

| File | Description |
|---|---|
| `versions.tf` | Terraform and provider version requirements |
| `provider.tf` | OCI provider configuration |
| `vault.tf` | OCI KMS Vault resource |
| `key.tf` | Master Encryption Key (CMK) resource |
| `dynamic_group.tf` | Dynamic Group resource |
| `policy.tf` | IAM Policy resource |
| `main.tf` | Autonomous Database resource |
| `variables.tf` | All configurable parameters |
| `outputs.tf` | Values exported after apply |
| `terraform.tfvars` | Fill in your values |

## Quick Start

```bash
# 1. Initialize Terraform
terraform init

# 2. Review the plan before applying
terraform plan

# 3. Create all resources
terraform apply
```

## Resources Created

| Resource | Type | Description |
|---|---|---|
| `vault_display_name` | `oci_kms_vault` | OCI Vault that stores the master encryption key |
| `key_display_name` | `oci_kms_key` | AES-256 Master Encryption Key (CMK) stored in HSM |
| `dynamic_group_name` | `oci_identity_dynamic_group` | Dynamic group that identifies the ADB instance |
| `policy_name` | `oci_identity_policy` | IAM policy granting the ADB access to the Vault and Key |
| `adb_display_name` | `oci_database_autonomous_database` | Autonomous Database encrypted with the CMK |

## Variables

| Variable | Description | Default |
|---|---|---|
| `tenancy_ocid` | OCID of the OCI tenancy | — |
| `user_ocid` | OCID of the OCI user | — |
| `fingerprint` | Fingerprint of the API key | — |
| `private_key_path` | Path to the private key file (.pem) | — |
| `region` | OCI region (e.g. `us-ashburn-1`, `mx-queretaro-1`) | `us-ashburn-1` |
| `compartment_ocid` | OCID of the compartment where all resources will be created | — |
| `vault_display_name` | Display name for the OCI KMS Vault | — |
| `key_display_name` | Display name for the Master Encryption Key (CMK) | — |
| `dynamic_group_name` | Name for the Dynamic Group | — |
| `policy_name` | Name for the IAM Policy | — |
| `adb_display_name` | Display name in the OCI console | — |
| `adb_db_name` | Database name — letters/numbers only, max 14 characters | — |
| `adb_admin_password` | ADMIN user password (sensitive) | — |
| `adb_workload_type` | Workload type: `OLTP` (ATP), `DW` (ADW), `AJD` (JSON), `APEX` | `OLTP` |
| `adb_db_version` | Oracle database version | `26ai` |
| `adb_cpu_core_count` | Number of ECPUs | `2` |
| `adb_storage_tbs` | Storage in terabytes | `1` |
| `adb_auto_scaling` | Enable ECPU auto-scaling | `false` |

## Outputs

| Output | Description |
|---|---|
| `vault_id` | OCID of the created Vault |
| `vault_management_endpoint` | Management endpoint of the Vault |
| `kms_key_id` | OCID of the Master Encryption Key (CMK) |
| `dynamic_group_id` | OCID of the Dynamic Group |
| `adb_id` | OCID of the Autonomous Database |
| `adb_connection_strings` | Connection strings for the ADB |
| `adb_state` | Current lifecycle state of the ADB |

## Notes

- **Resource order:** Terraform creates resources in this order: Vault → Master Key → Dynamic Group → IAM Policy → ADB. The `depends_on` blocks enforce this sequence. The IAM Policy must exist before the ADB is provisioned, otherwise the CMK switch will fail.

- **Vault and ADB region:** The Vault and the ADB must be in the **same OCI region**. Placing them in different regions causes the CMK switch to fail at provisioning time.

- **Dynamic Group policy syntax — undocumented behavior:** The IAM policy must reference the Dynamic Group by its **OCID** using the `id` keyword, not by name:
  ```
  Allow dynamic-group id <dynamic_group_ocid> to manage vaults in compartment id <compartment_ocid>
  Allow dynamic-group id <dynamic_group_ocid> to manage keys in compartment id <compartment_ocid>
  ```
  Using the Dynamic Group name instead of the OCID causes OCI to fail silently with a generic IAM configuration error, even when the policy appears valid in the console.

- **`manage` vs `use`:** The policy uses `manage vaults` and `manage keys` instead of `use`. Using only `use` is insufficient for the ADB to complete the CMK switch during provisioning.

- **HSM protection mode:** The Master Key is created with `protection_mode = "HSM"`. The key material never leaves the HSM in plaintext... not even Oracle can extract it. Use `SOFTWARE` only for dev/test environments.

- **Envelope encryption:** OCI uses a two-layer encryption model. The ADB data is encrypted with a Data Encryption Key (DEK), and the DEK itself is encrypted with your CMK. Your CMK never directly touches the data, it only protects the DEK. Revoking or disabling the CMK makes the DEK permanently inaccessible, which renders all database data unreadable.

- **Key revocation impact:** If the CMK is disabled or deleted, the ADB enters an `Inaccessible` state after a 2-hour grace period. All existing connections are dropped and new connections are rejected. This is intentional — it is the primary control that CMK provides over your data.
