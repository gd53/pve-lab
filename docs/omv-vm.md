# omv-vm.sh

## Purpose

Create an OpenMediaVault NAS VM on the Proxmox host with disk passthrough.

## What It Does

- Downloads the OMV ISO to Proxmox local storage (if not already present)
- Creates a VM with configured resources (CPU, RAM, boot disk)
- Passes through physical data drives to the VM (if configured)
- Attaches the VM to the LAN bridge
- Starts the VM for initial installation

## Config Needed

| Variable | Example | Description |
|----------|---------|-------------|
| OMV_VM_ID | 300 | Proxmox VM ID |
| OMV_VM_RAM | 2048 | RAM in MB |
| OMV_VM_CORES | 2 | CPU cores |
| OMV_VM_DISK | 16 | Boot disk size in GB |
| OMV_LAN_BRIDGE | vmbr1 | Bridge for LAN interface |
| OMV_DATA_DISKS | /dev/sdb,/dev/sdc | Physical disks to pass through (comma-separated, optional) |

## How to Run

```bash
bash scripts/omv-vm.sh
```

## Notes

- Run on the **Proxmox host**.
- OMV runs best as a **VM** (not LXC) when using disk passthrough, since VMs get direct SATA/SAS access.
- Disk passthrough uses `qm set` with `scsi` or `sata` device mapping. Passed-through disks are managed entirely by OMV, not Proxmox.
- If no `OMV_DATA_DISKS` are set, the VM is created without passthrough. You can add disks later via the Proxmox web UI.
- After the VM starts, connect via Proxmox console to run the OMV installer.
- Default OMV web UI login after install: `admin` / `openmediavault`.
- Idempotent — skips if VM ID already exists.
