# pve-network-static.sh

## Purpose

Switch the Proxmox node from DHCP to a static IP configuration.

## What It Does

- Backs up `/etc/network/interfaces` before making changes
- Configures a static IP on the bridge interface (vmbr0)
- Sets gateway and DNS
- Applies the network configuration

## Config Needed

| Variable | Example | Description |
|----------|---------|-------------|
| NODE_IP | 192.168.1.100 | Static IP for the node |
| NODE_CIDR | 24 | Subnet mask in CIDR notation |
| GATEWAY_IP | 192.168.1.1 | Default gateway |
| DNS | 192.168.1.1 | DNS server |

## How to Run

```bash
bash scripts/pve-network-static.sh
```

## Notes

- **Console-only** — this script changes the node's IP. If you are connected via SSH, you will be disconnected. Run from the Proxmox console (physical keyboard/monitor or IPMI/iLO).
- Assumes the bridge `vmbr0` already exists (created by the Proxmox installer).
- After running, reconnect via SSH using the new static IP.
- Backup is saved as `/etc/network/interfaces.bak`.
