# opn-vm.sh

## Purpose

Create an OPNsense firewall/router VM on the Proxmox host.

## What It Does

- Downloads the OPNsense ISO to Proxmox local storage (if not already present)
- Creates a VM with two network interfaces (WAN + LAN bridges)
- Configures VM resources (CPU, RAM, disk)
- Sets VirtIO drivers for best performance
- Starts the VM for initial installation

## Config Needed

| Variable | Example | Description |
|----------|---------|-------------|
| OPN_VM_ID | 200 | Proxmox VM ID |
| OPN_VM_RAM | 2048 | RAM in MB |
| OPN_VM_CORES | 2 | CPU cores |
| OPN_VM_DISK | 32 | Disk size in GB |
| OPN_WAN_BRIDGE | vmbr0 | Bridge for WAN interface |
| OPN_LAN_BRIDGE | vmbr1 | Bridge for LAN interface |
| OPN_ISO_URL | (auto) | OPNsense ISO download URL (latest if omitted) |

## How to Run

```bash
bash scripts/opn-vm.sh
```

## Notes

- Run on the **Proxmox host** (not inside OPNsense).
- Requires two bridges: one for WAN (internet-facing) and one for LAN (internal). Create the LAN bridge (`vmbr1`) in Proxmox first if it doesn't exist.
- After the VM starts, connect via Proxmox console to run the OPNsense installer.
- The OPNsense installer will name the bridges `vtnet0` (WAN) and `vtnet1` (LAN). Check MAC addresses in Proxmox to confirm which is which.
- Idempotent — skips if VM ID already exists.
