# pve-network-static.sh

## Purpose

Switch the Proxmox node from DHCP to a static IP configuration.

## What This Script Does

1. **Backup interfaces** — saves a copy of `/etc/network/interfaces` to `.bak`
2. **Configure static IP** — sets a static IP on the bridge interface (`vmbr0`)
3. **Set gateway and DNS** — writes gateway and DNS server to the interface config
4. **Apply changes** — restarts networking to apply the new configuration

## Required Config (`node.env`)

| Variable | Required | Example | Description |
|----------|----------|---------|-------------|
| NODE_IP | **Yes** | `192.168.1.100` | Static IP for the node |
| NODE_CIDR | **Yes** | `24` | Subnet mask in CIDR notation |
| GATEWAY_IP | **Yes** | `192.168.1.1` | Default gateway |
| DNS | **Yes** | `192.168.1.1` | DNS server |

## Usage

```bash
bash scripts/pve-network-static.sh
```

## Idempotency

- Skips if static IP is already configured on `vmbr0`

## Notes

- **Console-only** — this script changes the node's IP. SSH sessions will disconnect. Run from the Proxmox console (physical keyboard/monitor or IPMI/iLO).
- Assumes `vmbr0` already exists (created by the Proxmox installer).
- After running, reconnect via SSH using the new static IP.
- Backup is saved as `/etc/network/interfaces.bak`.
