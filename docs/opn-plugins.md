# opn-plugins.sh

## Purpose

Install and update OPNsense plugins.

## What It Does

- Updates OPNsense to the latest version (`opnsense-update`)
- Installs configured plugins via the OPNsense API or SSH
- Verifies plugin installation

## Common Plugins

| Plugin | Package | Description |
|--------|---------|-------------|
| WireGuard | os-wireguard | Modern VPN for remote access |
| HAProxy | os-haproxy | Reverse proxy and load balancer |
| Crowdsec | os-crowdsec | Crowdsourced threat intelligence |
| Tailscale | os-tailscale | Zero-config mesh VPN |
| Nginx | os-nginx | Web server / reverse proxy |
| Git backup | os-git-backup | Backup config to a git repo |
| Theme | os-theme-cicada | Community dark theme |

## Config Needed

| Variable | Example | Description |
|----------|---------|-------------|
| OPN_PLUGINS | os-wireguard,os-haproxy | Comma-separated list of plugins to install |
| OPN_API_KEY | (generated) | API key |
| OPN_API_SECRET | (generated) | API secret |

## How to Run

```bash
bash scripts/opn-plugins.sh
```

## Notes

- Run **after** `opn-config.sh` (OPNsense must be configured and API accessible).
- Plugin names use the `os-` prefix (e.g., `os-wireguard`, not `wireguard`).
- Some plugins require additional configuration after installation (e.g., WireGuard peers, HAProxy backends). Those are manual via the web UI.
- OPNsense updates are also applied by this script. Review release notes before running in production.
- Idempotent — already-installed plugins are skipped.
