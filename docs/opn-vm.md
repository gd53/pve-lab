# opn-vm.sh

## Purpose

Create an OPNsense firewall/router VM on the Proxmox host.

## What This Script Does

1. **Download ISO** — downloads the OPNsense ISO to Proxmox local storage (if not already present)
2. **Create VM** — creates a VM with two network interfaces (WAN + LAN bridges)
3. **Configure resources** — sets CPU cores, RAM, and disk size per config
4. **Set VirtIO drivers** — uses VirtIO for best network and disk performance
5. **Start VM** — boots the VM for initial OPNsense installation

## Required Config (`node.env`)

| Variable | Required | Example | Description |
|----------|----------|---------|-------------|
| OPN_VM_ID | **Yes** | `200` | Proxmox VM ID |
| OPN_VM_RAM | **Yes** | `2048` | RAM in MB |
| OPN_VM_CORES | **Yes** | `2` | CPU cores |
| OPN_VM_DISK | **Yes** | `32` | Disk size in GB |
| OPN_WAN_BRIDGE | **Yes** | `vmbr0` | Bridge for WAN interface |
| OPN_LAN_BRIDGE | **Yes** | `vmbr1` | Bridge for LAN interface |
| OPN_ISO_URL | No | `(auto)` | OPNsense ISO download URL (latest if omitted) |

## Usage

```bash
bash scripts/opn-vm.sh
```

## Idempotency

- Skips VM creation if VM ID already exists
- Skips ISO download if file already present

## Notes

- Run on the **Proxmox host** (not inside OPNsense).
- Requires two bridges: one for WAN (internet-facing) and one for LAN (internal). Create the LAN bridge (`vmbr1`) in Proxmox first if it doesn't exist.
- After the VM starts, connect via Proxmox console to run the OPNsense installer.
- The OPNsense installer will name the bridges `vtnet0` (WAN) and `vtnet1` (LAN). Check MAC addresses in Proxmox to confirm which is which.
