# pbs-config.sh

## Purpose

Configure Proxmox Backup Server and integrate it with the Proxmox VE host for scheduled backups.

## What It Does

### PBS Setup

- Sets hostname and static IP
- Creates a backup datastore on the dedicated disk
- Creates an API token for PVE integration
- Configures garbage collection schedule (prune old backups)
- Sets backup retention policy (daily, weekly, monthly)

### PVE Integration

- Adds PBS as a storage target on the Proxmox VE host
- Configures the PBS fingerprint for trust
- Sets up backup schedules for VMs and containers via `vzdump`

## Config Needed

| Variable | Example | Description |
|----------|---------|-------------|
| PBS_IP | 192.168.1.60 | PBS static IP |
| PBS_HOSTNAME | pbs | PBS hostname |
| PBS_DATASTORE | backups | Datastore name |
| PBS_RETENTION_DAILY | 7 | Keep last N daily backups |
| PBS_RETENTION_WEEKLY | 4 | Keep last N weekly backups |
| PBS_RETENTION_MONTHLY | 3 | Keep last N monthly backups |
| PBS_API_TOKEN | (generated) | API token for PVE connection |
| PBS_BACKUP_SCHEDULE | daily | Backup frequency (daily, weekly) |

## How to Run

```bash
bash scripts/pbs-config.sh
```

## Notes

- Run **after** the PBS installer completes and the VM is accessible on the network.
- PBS uses incremental backups with deduplication — subsequent backups are fast and space-efficient.
- The PVE host connects to PBS as a storage target. Once configured, backups and restores are managed from the PVE web UI.
- API token goes in `node.env` (gitignored, never committed).
- Verify backups regularly — PBS has a built-in verification job that checks backup integrity.
- Idempotent — safe to rerun.
