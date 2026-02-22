# pbs-vm.sh

## Purpose

Create a Proxmox Backup Server (PBS) VM for centralized backup storage.

## What It Does

- Downloads the PBS ISO to Proxmox local storage (if not already present)
- Creates a VM with configured resources
- Optionally passes through a dedicated backup drive
- Attaches the VM to the LAN bridge
- Starts the VM for initial installation

## Config Needed

| Variable | Example | Description |
|----------|---------|-------------|
| PBS_VM_ID | 400 | Proxmox VM ID |
| PBS_VM_RAM | 2048 | RAM in MB |
| PBS_VM_CORES | 2 | CPU cores |
| PBS_VM_DISK | 16 | Boot disk size in GB |
| PBS_LAN_BRIDGE | vmbr1 | Bridge for LAN interface |
| PBS_BACKUP_DISK | /dev/sdd | Physical disk for backup datastore (optional) |

## How to Run

```bash
bash scripts/pbs-vm.sh
```

## Notes

- Run on the **Proxmox host**.
- PBS is lightweight — 2 CPU cores and 2 GB RAM is sufficient for a homelab.
- A dedicated backup disk is strongly recommended. Storing backups on the same storage as VMs defeats the purpose.
- After the VM starts, connect via Proxmox console to run the PBS installer.
- PBS web UI is available on port 8007 after install.
- Idempotent — skips if VM ID already exists.
