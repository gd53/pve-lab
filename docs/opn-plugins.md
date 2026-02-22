# opn-plugins.sh

## Purpose

Install and update OPNsense plugins.

## What This Script Does

1. **Update OPNsense** — runs `opnsense-update` to apply latest patches
2. **Install plugins** — installs each configured plugin via the OPNsense API or SSH
3. **Verify installation** — confirms each plugin is installed and active

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

## Required Config (`node.env`)

| Variable | Required | Example | Description |
|----------|----------|---------|-------------|
| OPN_PLUGINS | **Yes** | `os-wireguard,os-haproxy` | Comma-separated list of plugins to install |
| OPN_API_KEY | **Yes** | `(generated)` | API key |
| OPN_API_SECRET | **Yes** | `(generated)` | API secret |

## Usage

```bash
bash scripts/opn-plugins.sh
```

## Idempotency

- Skips plugins that are already installed
- Updates are applied only if available

## Notes

- Run **after** `opn-config.sh` (OPNsense must be configured and API accessible).
- Plugin names use the `os-` prefix (e.g., `os-wireguard`, not `wireguard`).
- Some plugins require additional configuration after installation (e.g., WireGuard peers, HAProxy backends). Those are manual via the web UI.
- OPNsense updates are also applied by this script. Review release notes before running in production.
