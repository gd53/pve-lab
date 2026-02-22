# omv-config.sh

## Purpose

Apply initial OpenMediaVault configuration — networking, storage pools, and file sharing.

## What It Does

### System

- Sets hostname and domain
- Configures static IP on the LAN interface
- Enables SSH access
- Updates OMV and installs available updates

### Storage

- Creates a filesystem on data disks (if not already formatted)
- Sets up shared folders for common use cases (media, backups, documents)

### File Sharing

- Enables and configures SMB/CIFS sharing
- Sets share permissions

### Plugins

- Installs `openmediavault-mergerfs` (pool multiple drives into one mount)
- Installs `openmediavault-snapraid` (parity-based data protection)

## Config Needed

| Variable | Example | Description |
|----------|---------|-------------|
| OMV_IP | 192.168.1.50 | OMV static IP |
| OMV_HOSTNAME | nas | OMV hostname |
| DOMAIN | local | Domain name |
| OMV_SHARES | media,backups,documents | Shared folder names (comma-separated) |
| OMV_API_USER | admin | OMV admin username |
| OMV_API_PASS | (secret) | OMV admin password |

## How to Run

```bash
bash scripts/omv-config.sh
```

## Notes

- Run **after** the OMV installer completes and the VM is accessible on the network.
- Uses the OMV REST API for configuration. The default admin password is `openmediavault` — change it during or after this script.
- API password goes in `node.env` (gitignored, never committed).
- MergerFS and SnapRAID are optional but recommended for multi-disk setups. If only one data disk is passed through, these are skipped.
- Idempotent — safe to rerun.
