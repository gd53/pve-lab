# pbs-config.sh

## Purpose

Configure Proxmox Backup Server and integrate it with the Proxmox VE host for scheduled backups.

## What This Script Does

1. **Set hostname and IP** — configures PBS hostname and static IP
2. **Create datastore** — creates a backup datastore on the dedicated disk
3. **Create API token** — generates an API token for PVE integration
4. **Configure garbage collection** — schedules cleanup of old backup chunks
5. **Set retention policy** — configures daily, weekly, and monthly retention
6. **Add PBS to PVE** — registers PBS as a storage target on the Proxmox VE host
7. **Configure trust** — adds the PBS fingerprint for secure communication
8. **Schedule backups** — sets up automated VM and container backups via `vzdump`

## Required Config (`node.env`)

| Variable | Required | Example | Description |
|----------|----------|---------|-------------|
| PBS_IP | **Yes** | `192.168.1.60` | PBS static IP |
| PBS_HOSTNAME | **Yes** | `pbs` | PBS hostname |
| PBS_DATASTORE | **Yes** | `backups` | Datastore name |
| PBS_RETENTION_DAILY | **Yes** | `7` | Keep last N daily backups |
| PBS_RETENTION_WEEKLY | **Yes** | `4` | Keep last N weekly backups |
| PBS_RETENTION_MONTHLY | **Yes** | `3` | Keep last N monthly backups |
| PBS_API_TOKEN | **Yes** | `(generated)` | API token for PVE connection |
| PBS_BACKUP_SCHEDULE | **Yes** | `daily` | Backup frequency (daily, weekly) |

## Usage

```bash
bash scripts/pbs-config.sh
```

## Idempotency

- Skips datastore creation if already exists
- Skips PVE storage registration if already configured
- Skips backup schedule if already set

## Notes

- Run **after** the PBS installer completes and the VM is accessible on the network.
- PBS uses incremental backups with deduplication — subsequent backups are fast and space-efficient.
- The PVE host connects to PBS as a storage target. Once configured, backups and restores are managed from the PVE web UI.
- API token goes in `node.env` (gitignored, never committed).
- Verify backups regularly — PBS has a built-in verification job that checks backup integrity.
