# pve-storage-setup.sh

## Purpose

Configure local storage directories for ISOs, backups, snippets, and container templates.

## What This Script Does

1. **Create storage directories** — ensures standard directories exist under `/var/lib/vz/`
2. **Verify Proxmox storage** — checks that default storage entries (`local`, `local-lvm`) are registered
3. **Add custom backup path** — optionally registers a custom backup directory (e.g., external drive mount)
4. **Register in Proxmox** — adds any additional storage via `pvesm`

## Required Config (`node.env`)

| Variable | Required | Example | Description |
|----------|----------|---------|-------------|
| STORAGE_BACKUP_PATH | No | `/mnt/backup` | Custom backup directory |

## Usage

```bash
bash scripts/pve-storage-setup.sh
```

## Idempotency

- Skips directory creation if already exists
- Skips storage registration if already configured in Proxmox

## Notes

- Proxmox creates default storage (`local`, `local-lvm`) during install. This script verifies and extends that setup.
- If `STORAGE_BACKUP_PATH` is set, the directory must exist (mount your drive first).
- Storage is visible in the Proxmox web UI under Datacenter → Storage.
