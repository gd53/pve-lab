# opn-config.sh

## Purpose

Apply initial OPNsense configuration after installation.

## What This Script Does

1. **Assign interfaces** — maps WAN and LAN to the correct network interfaces
2. **Configure LAN** — sets LAN IP address and subnet
3. **Configure WAN** — sets DHCP or static IP per config
4. **Enable DHCP server** — starts DHCP on the LAN interface with configured pool range
5. **Configure DNS** — sets up Unbound DNS resolver
6. **Set hostname** — configures hostname and domain
7. **Set timezone and NTP** — configures time synchronization
8. **Allow LAN management** — permits web UI (port 443) and SSH on LAN
9. **Set WAN policy** — default deny on WAN inbound

## Required Config (`node.env`)

| Variable | Required | Example | Description |
|----------|----------|---------|-------------|
| OPN_LAN_IP | **Yes** | `192.168.1.1` | OPNsense LAN IP |
| OPN_LAN_SUBNET | **Yes** | `24` | LAN subnet CIDR |
| OPN_DHCP_START | **Yes** | `192.168.1.100` | DHCP pool start |
| OPN_DHCP_END | **Yes** | `192.168.1.254` | DHCP pool end |
| OPN_HOSTNAME | **Yes** | `opnsense` | OPNsense hostname |
| DOMAIN | **Yes** | `local` | Domain name |
| TIMEZONE | **Yes** | `UTC` | System timezone |
| OPN_API_KEY | **Yes** | `(generated)` | API key for automation |
| OPN_API_SECRET | **Yes** | `(generated)` | API secret for automation |

## Usage

```bash
bash scripts/opn-config.sh
```

## Idempotency

- Skips interface assignment if already configured
- Skips service settings if already applied

## Notes

- Run **after** the OPNsense installer completes and you can reach the web UI.
- Uses the OPNsense API (requires API key/secret — generate these in the web UI under System → Access → Users).
- Alternatively, push a pre-built `config.xml` via SSH for initial bootstrap before API is available.
- **Console-only for initial interface assignment** — the OPNsense installer requires manual interface assignment on first boot.
- API key and secret go in `node.env` (gitignored, never committed).
