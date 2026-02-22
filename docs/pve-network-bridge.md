# pve-network-bridge.sh

## Purpose

Add a second network bridge (`vmbr1`) on the second NIC for OPNsense LAN, and make `vmbr0` VLAN-aware.

## Network Topology

```
BEFORE (after Proxmox install):
  [ISP Modem] ──NIC1──> [vmbr0] = DHCP temp IP
                  NIC2   (idle)

AFTER THIS SCRIPT:
  [ISP Modem] ──NIC1──> [vmbr0] = DHCP temp IP (unchanged)
                  NIC2──> [vmbr1] = no IP (ready for OPNsense LAN)

AFTER OPNsense + MIGRATION:
  [ISP Modem] ──NIC1──> [vmbr0] ──> OPNsense WAN
                                      OPNsense LAN ──> [vmbr1] ──NIC2──> [Switch]
```

## What This Script Does

1. **Make vmbr0 VLAN-aware** — modifies the existing bridge to support VLAN tagging (non-destructive, keeps current IP)
2. **Backup interfaces** — saves `/etc/network/interfaces` before any changes
3. **Create vmbr1** — adds a new bridge on the second NIC with no IP assigned (OPNsense LAN side)

## Required Config (`node.env`)

| Variable | Required | Example | Description |
|----------|----------|---------|-------------|
| LAN_NIC | **Yes** | `enp6s1` | Second NIC — for OPNsense LAN / switch |
| WAN_NIC | No | `enp6s0` | First NIC (auto-detected from vmbr0 if blank) |

## Usage

```bash
bash scripts/pve-network-bridge.sh
```

## Idempotency

- Skips VLAN-aware if already set on vmbr0
- Skips vmbr1 creation if it already exists
- Backs up interfaces before any change

## Notes

- `vmbr0` keeps its DHCP IP — do **not** change it now. Internet access stays working.
- `LAN_NIC` is the **second** NIC (goes to the switch), not the one used during install.
- If you only have one NIC, skip this script — use `pve-network-static.sh` instead.
- The IP migration from vmbr0 to vmbr1 happens later via `pve-network-migrate.sh`.
