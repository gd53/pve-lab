# net-switch-ap.sh

## Purpose

Generate VLAN configuration reference for managed switches and wireless access points. This is a guided reference script — switch and AP UIs vary by vendor.

## What This Script Does

1. **Generate switch config** — outputs recommended VLAN port assignments for your managed switch
2. **Generate AP config** — outputs recommended SSID-to-VLAN mappings for your wireless AP
3. **Validate connectivity** — pings the switch and AP management IPs to confirm they're reachable

## Required Config (`node.env`)

| Variable | Required | Example | Description |
|----------|----------|---------|-------------|
| SWITCH_IP | No | `10.0.10.2` | Managed switch management IP |
| AP_IP | No | `10.0.10.3` | Access point management IP |
| SWITCH_MODEL | No | `TP-Link TL-SG108E` | For reference in output |
| AP_MODEL | No | `UniFi U6 Lite` | For reference in output |

## Usage

```bash
bash scripts/net-switch-ap.sh
```

## Idempotency

- This script only generates reference output — no system changes.

## Notes

- This is a **guided reference**, not full automation — switch and AP web UIs vary by vendor (TP-Link, Ubiquiti, Netgear all differ).
- VLANs are **optional** — skip if using a flat network.
- Recommended VLAN layout matches `pve-network-vlans.sh`.
