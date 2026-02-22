# omv-vm.sh

## Purpose

Create an OpenMediaVault NAS VM on the Proxmox host with disk passthrough.

## What This Script Does

1. **Download ISO** — downloads the OMV ISO to Proxmox local storage (if not already present)
2. **Create VM** — creates a VM with configured CPU, RAM, and boot disk
3. **Pass through data disks** — attaches physical drives to the VM for direct access (if configured)
4. **Attach to LAN** — connects the VM to the LAN bridge
5. **Start VM** — boots the VM for initial OMV installation

## Required Config (`node.env`)

| Variable | Required | Example | Description |
|----------|----------|---------|-------------|
| OMV_VM_ID | **Yes** | `300` | Proxmox VM ID |
| OMV_VM_RAM | **Yes** | `2048` | RAM in MB |
| OMV_VM_CORES | **Yes** | `2` | CPU cores |
| OMV_VM_DISK | **Yes** | `16` | Boot disk size in GB |
| OMV_LAN_BRIDGE | **Yes** | `vmbr1` | Bridge for LAN interface |
| OMV_DATA_DISKS | No | `/dev/sdb,/dev/sdc` | Physical disks to pass through (comma-separated) |

## Usage

```bash
bash scripts/omv-vm.sh
```

## Idempotency

- Skips VM creation if VM ID already exists
- Skips ISO download if file already present

## Notes

- Run on the **Proxmox host**.
- OMV runs best as a **VM** (not LXC) when using disk passthrough, since VMs get direct SATA/SAS access.
- Disk passthrough uses `qm set` with `scsi` or `sata` device mapping. Passed-through disks are managed entirely by OMV, not Proxmox.
- If no `OMV_DATA_DISKS` are set, the VM is created without passthrough. You can add disks later via the Proxmox web UI.
- After the VM starts, connect via Proxmox console to run the OMV installer.
- Default OMV web UI login after install: `admin` / `openmediavault`.
