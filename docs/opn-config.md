# opn-config.sh

## Purpose

Apply initial OPNsense configuration after installation.

## What It Does

### Interfaces

- Assigns WAN and LAN interfaces
- Sets LAN IP address and subnet
- Configures WAN (DHCP or static, per config)

### Services

- Enables and configures DHCP server on LAN
- Configures Unbound DNS resolver
- Sets hostname and domain
- Sets timezone and NTP servers

### Firewall

- Allows management access on LAN (web UI on port 443)
- Allows SSH access on LAN
- Default deny on WAN inbound

## Config Needed

| Variable | Example | Description |
|----------|---------|-------------|
| OPN_LAN_IP | 192.168.1.1 | OPNsense LAN IP |
| OPN_LAN_SUBNET | 24 | LAN subnet CIDR |
| OPN_DHCP_START | 192.168.1.100 | DHCP pool start |
| OPN_DHCP_END | 192.168.1.254 | DHCP pool end |
| OPN_HOSTNAME | opnsense | OPNsense hostname |
| DOMAIN | local | Domain name |
| TIMEZONE | UTC | System timezone |
| OPN_API_KEY | (generated) | API key for automation |
| OPN_API_SECRET | (generated) | API secret for automation |

## How to Run

```bash
bash scripts/opn-config.sh
```

## Notes

- Run **after** the OPNsense installer completes and you can reach the web UI.
- Uses the OPNsense API (requires API key/secret — generate these in the web UI under System → Access → Users).
- Alternatively, push a pre-built `config.xml` via SSH for initial bootstrap before API is available.
- **Console-only for initial interface assignment** — the OPNsense installer requires manual interface assignment on first boot.
- API key and secret go in `node.env` (gitignored, never committed).
