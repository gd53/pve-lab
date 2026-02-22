# omv-config.sh

## Purpose

Apply initial OpenMediaVault configuration — networking, storage pools, and file sharing.

## What This Script Does

1. **Set hostname** — configures hostname and domain
2. **Configure static IP** — sets a static IP on the LAN interface
3. **Enable SSH** — turns on SSH access for remote management
4. **Update OMV** — applies available system updates
5. **Create filesystems** — formats data disks if not already formatted
6. **Create shared folders** — sets up folders for media, backups, documents (per config)
7. **Enable SMB/CIFS** — configures Windows-compatible file sharing with permissions
8. **Install MergerFS** — pools multiple drives into a single mount point
9. **Install SnapRAID** — adds parity-based data protection for the pool

## Required Config (`node.env`)

| Variable | Required | Example | Description |
|----------|----------|---------|-------------|
| OMV_IP | **Yes** | `192.168.1.50` | OMV static IP |
| OMV_HOSTNAME | **Yes** | `nas` | OMV hostname |
| DOMAIN | **Yes** | `local` | Domain name |
| OMV_SHARES | **Yes** | `media,backups,documents` | Shared folder names (comma-separated) |
| OMV_API_USER | **Yes** | `admin` | OMV admin username |
| OMV_API_PASS | **Yes** | `(secret)` | OMV admin password |

## Usage

```bash
bash scripts/omv-config.sh
```

## Idempotency

- Skips filesystem creation if disks already formatted
- Skips shares that already exist
- Skips plugin install if already present

## Notes

- Run **after** the OMV installer completes and the VM is accessible on the network.
- Uses the OMV REST API for configuration. The default admin password is `openmediavault` — change it during or after this script.
- API password goes in `node.env` (gitignored, never committed).
- MergerFS and SnapRAID are optional but recommended for multi-disk setups. If only one data disk is passed through, these are skipped.
