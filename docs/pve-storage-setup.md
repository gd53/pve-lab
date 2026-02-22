# pve-storage-setup.sh

## Purpose

Configure local storage directories for ISOs, backups, snippets, and container templates.

## What It Does

- Ensures standard storage directories exist under `/var/lib/vz/`
- Verifies default Proxmox storage entries are registered
- Optionally adds a custom backup directory (e.g., external drive mount)
- Registers additional storage in Proxmox via `pvesm`

## Config Needed

| Variable | Example | Description |
|----------|---------|-------------|
| STORAGE_BACKUP_PATH | /mnt/backup | Custom backup directory (optional) |

## How to Run

```bash
bash scripts/pve-storage-setup.sh
```

## Notes

- Proxmox creates default storage (`local`, `local-lvm`) during install. This script verifies and extends that setup.
- If `STORAGE_BACKUP_PATH` is set, the directory must exist (mount your drive first).
- Storage is visible in the Proxmox web UI under Datacenter → Storage.
- Idempotent — safe to rerun.
