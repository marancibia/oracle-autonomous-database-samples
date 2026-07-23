# Terraform — Autonomous Database with mTLS Wallet Rotation

Creates an Autonomous Database with mTLS enabled and manages wallet rotation via the OCI CLI. The wallet is rotated on every `terraform apply`. Supports both new and existing databases.

## Files

| File | Description |
|---|---|
| `versions.tf` | Terraform and provider version requirements |
| `provider.tf` | OCI provider configuration |
| `main.tf` | Autonomous Database resource |
| `wallet_rotation.tf` | Wallet rotation via OCI CLI |
| `variables.tf` | All configurable parameters |
| `outputs.tf` | Values exported after apply |
| `terraform.tfvars` | Example values file — copy to `terraform.tfvars` and fill in your values |

## Quick Start

```bash
# 1. Initialize Terraform
terraform init

# 2. Review the plan before applying
terraform plan

# 3. Create the ADB and download the initial wallet
terraform apply
```

## Using an Existing Database

If the ADB already exists and was not created with this Terraform, import it into the state before applying:

```bash
# 1. Fill terraform.tfvars with the values that match your existing ADB
#    (adb_display_name, adb_db_name, adb_workload_type, adb_cpu_core_count, etc.)

# 2. Import the existing ADB into the Terraform state
terraform import oci_database_autonomous_database.adb <ADB_OCID>

# 3. Review the plan — the ADB should show no changes
terraform plan

# 4. Apply — only the wallet rotation runs, the ADB is not touched
terraform apply
```

> **Note:** After import, `admin_password` will show as a pending change on the first plan. This is expected. Terraform does not store sensitive values from imported resources. The `lifecycle { ignore_changes = [admin_password] }` block in `main.tf` suppresses this on subsequent plans.

## How Wallet Rotation Works

> **Important:** Rotating the wallet invalidates the current certificates. All apps using the old wallet will lose connection and must be updated with the new `wallet.zip` before they can reconnect.

```
terraform apply
      │
      ▼
null_resource detects timestamp() change (always true)
      │
      ▼
OCI CLI runs rotate-wallet (invalidates current certificates)
      │
      ▼
OCI CLI runs generate-wallet (downloads new wallet)
      │
      ▼
New wallet.zip saved to wallet_output_path
```

## Rotating the Wallet

```bash
# The wallet rotates automatically on every apply
terraform apply
```

## Variables

| Variable | Description | Default |
|---|---|---|
| `tenancy_ocid` | OCID of the OCI tenancy | — |
| `user_ocid` | OCID of the OCI user | — |
| `fingerprint` | Fingerprint of the API key | — |
| `private_key_path` | Path to the private key file (.pem) | — |
| `region` | OCI region (e.g. `us-ashburn-1`) | `us-ashburn-1` |
| `compartment_ocid` | OCID of the compartment where the ADB will be created | — |
| `adb_display_name` | Display name in the OCI console | — |
| `adb_db_name` | Database name — letters/numbers only, max 14 characters | — |
| `adb_admin_password` | ADMIN user password (sensitive) | — |
| `adb_workload_type` | Workload type: `OLTP` (ATP), `DW` (ADW), `AJD` (JSON), `APEX`, `LH` | `OLTP` |
| `adb_db_version` | Oracle database version | `26ai` |
| `adb_cpu_core_count` | Number of ECPUs (minimum 2) | `2` |
| `adb_storage_tbs` | Storage in terabytes | `1` |
| `wallet_password` | Password to protect the wallet zip file (sensitive) | — |
| `wallet_output_path` | Local path where the wallet zip will be saved | `./wallet.zip` |

## Outputs

| Output | Description |
|---|---|
| `adb_id` | OCID of the Autonomous Database |
| `wallet_output_path` | Local path where the wallet zip file was saved |

## Notes

- **OCI CLI required:** The wallet rotation uses `local-exec` to call the OCI CLI. Make sure it is installed and configured (`oci setup config`) before running `terraform apply`.

- **Wallet password requirements:** Minimum 8 characters, must contain at least one letter and one number. This password protects the zip file — it is separate from the ADMIN database password.

- **Rotation on every apply:** The `null_resource` uses `timestamp()` as a trigger, which always changes on every `terraform apply`. This means the wallet is rotated every time you run apply, regardless of other changes.

- **SINGLE vs ALL wallet:** The `--generate-type SINGLE` flag generates a wallet for this specific database only. Use `ALL` if you need a wallet that works across multiple databases in the same tenancy.

- **mTLS is always on:** This configuration sets `is_mtls_connection_required = true`. Clients must use the wallet to connect — standard TLS connections without the wallet are rejected.

- **Wallet file location:** The wallet is saved locally at `wallet_output_path`. Keep this file secure — it contains the credentials needed to connect to the database.
