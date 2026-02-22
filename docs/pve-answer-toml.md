# pve-answer-toml.sh

## Purpose

Generate a Ventoy answer.toml for automated Proxmox VE installation.

## What This Script Does

1. **Read config** — reads node.env for hostname, network, and install preferences
2. **Substitute values** — fills in the answer.toml template with configured values
3. **Output file** — writes a ready-to-use file to `generated/answer.toml`

## Required Config (`node.env`)

| Variable | Required | Example | Description |
|----------|----------|---------|-------------|
| NODE_NAME | **Yes** | `pve` | Hostname for the node |
| DOMAIN | **Yes** | `local` | Domain name (combined into FQDN) |
| TIMEZONE | **Yes** | `UTC` | System timezone |
| KEYBOARD | **Yes** | `en-us` | Keyboard layout |
| COUNTRY | **Yes** | `us` | Locale country code |
| INSTALL_DISK | No | `sda` | Target disk for install (default: sda) |
| INSTALL_FS | No | `ext4` | Root filesystem (ext4, xfs, zfs, btrfs) |
| ADMIN_EMAIL | **Yes** | `admin@local` | Notification email |

## Usage

```bash
bash scripts/pve-answer-toml.sh
```

Copy `generated/answer.toml` to your Ventoy USB drive.

## Idempotency

- Overwrites `generated/answer.toml` on each run (always regenerates from current config)

## Notes

- Run on your **workstation**, not on the Proxmox node (the node doesn't exist yet).
- The `generated/` directory is gitignored — output files are not committed.
- Uses `templates/answer.toml` as the base template.
- Password is **not** read from config. The template ships with `changeme` — edit the generated file before use.
- **Ventoy setup**: Download the Proxmox ISO + Ventoy. Create a Ventoy USB, copy the ISO to the root, and place `answer.toml` in the `/ventoy/` directory. Boot from USB to start the automated install.
