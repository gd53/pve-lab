# pve-answer-toml.sh

## Purpose

Generate a Ventoy answer.toml for automated Proxmox VE installation.

## What It Does

- Reads node.env for hostname, network, and install preferences
- Substitutes values into the answer.toml template
- Outputs a ready-to-use file to `generated/answer.toml`

## Config Needed

| Variable | Example | Description |
|----------|---------|-------------|
| NODE_NAME | pve | Hostname for the node |
| DOMAIN | local | Domain name (combined into FQDN) |
| TIMEZONE | UTC | System timezone |
| KEYBOARD | en-us | Keyboard layout |
| COUNTRY | us | Locale country code |
| DISK_FS | ext4 | Root filesystem (ext4, xfs, zfs, btrfs) |
| ADMIN_EMAIL | admin@local | Notification email |

## How to Run

```bash
bash scripts/pve-answer-toml.sh
```

Copy `generated/answer.toml` to your Ventoy USB drive.

## Notes

- Run on your **workstation**, not on the Proxmox node (the node doesn't exist yet).
- The `generated/` directory is gitignored — output files are not committed.
- Uses `templates/answer.toml` as the base template.
- Password is **not** read from config. The template ships with `changeme` — edit the generated file before use.
