# pbs-vm.sh

## Purpose

Create a Proxmox Backup Server (PBS) VM for centralized backup storage.

## What This Script Does

1. **Download ISO** — downloads the PBS ISO to Proxmox local storage (if not already present)
2. **Create VM** — creates a VM with configured CPU, RAM, and boot disk
3. **Pass through backup disk** — attaches a dedicated physical drive for the backup datastore (if configured)
4. **Attach to LAN** — connects the VM to the LAN bridge
5. **Start VM** — boots the VM for initial PBS installation

## Required Config (`node.env`)

| Variable | Required | Example | Description |
|----------|----------|---------|-------------|
| PBS_VM_ID | **Yes** | `400` | Proxmox VM ID |
| PBS_VM_RAM | **Yes** | `2048` | RAM in MB |
| PBS_VM_CORES | **Yes** | `2` | CPU cores |
| PBS_VM_DISK | **Yes** | `16` | Boot disk size in GB |
| PBS_LAN_BRIDGE | **Yes** | `vmbr1` | Bridge for LAN interface |
| PBS_BACKUP_DISK | No | `/dev/sdd` | Physical disk for backup datastore |

## Usage

```bash
bash scripts/pbs-vm.sh
```

## Idempotency

- Skips VM creation if VM ID already exists
- Skips ISO download if file already present

## Notes

- Run on the **Proxmox host**.
- PBS is lightweight — 2 CPU cores and 2 GB RAM is sufficient for a homelab.
- A dedicated backup disk is strongly recommended. Storing backups on the same storage as VMs defeats the purpose.
- After the VM starts, connect via Proxmox console to run the PBS installer.
- PBS web UI is available on port 8007 after install.
