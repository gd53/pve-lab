# pve-network-vlans.sh

## Purpose

Configure VLAN isolation on Proxmox and prepare OPNsense for VLAN tagging.

## What This Script Does

1. **Create VLAN interfaces** — adds Linux VLAN interfaces on `vmbr1` (e.g., `vmbr1.10`, `vmbr1.20`) if needed for host-level routing
2. **Prepare OPNsense config** — generates VLAN tag definitions for OPNsense LAN interface via API

## Standard VLAN Schema

| VLAN | Name | Purpose |
|------|------|---------|
| 01 | Management | Proxmox, switches, APs |
| 10 | Services | Docker LXC, VMs, servers |
| 20 | IoT | Smart devices (restricted internet) |
| 30 | Guest | Client isolation, guest WiFi |

## Required Config (`node.env`)

| Variable | Required | Example | Description |
|----------|----------|---------|-------------|
| OPN_API_KEY | **Yes** | `(generated)` | OPNsense API key |
| OPN_API_SECRET | **Yes** | `(generated)` | OPNsense API secret |
| OPN_LAN_IP | **Yes** | `10.0.10.1` | OPNsense LAN IP |

## Usage

```bash
bash scripts/pve-network-vlans.sh
```

## Idempotency

- Skips VLAN interfaces that already exist
- Skips OPNsense VLANs that are already configured

## Notes

- VLANs are **optional** — the network works on a flat IP scheme without them.
- `vmbr1` must already be VLAN-aware (set by `pve-network-bridge.sh`).
- VMs and containers are assigned to a VLAN by setting `tag=` on their virtual network interface.
- `vmbr0` (WAN) stays untagged.
