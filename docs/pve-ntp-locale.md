# pve-ntp-locale.sh

## Purpose

Configure timezone, NTP synchronization, and system locale on the Proxmox host.

## What This Script Does

1. **Set timezone** — applies the configured timezone via `timedatectl`
2. **Enable NTP** — ensures time synchronization is active
3. **Generate locale** — uncomments and generates the configured locale
4. **Set default locale** — sets `LANG` system-wide

## Required Config (`node.env`)

| Variable | Required | Example | Description |
|----------|----------|---------|-------------|
| TIMEZONE | **Yes** | `Australia/Melbourne` | IANA timezone identifier |
| LOCALE | **Yes** | `en_AU.UTF-8` | System locale |

## Usage

```bash
bash scripts/pve-ntp-locale.sh
```

## Idempotency

- Skips if timezone already matches
- Skips if NTP already enabled
- Skips if locale already generated and set

## Notes

- Run early in the host setup sequence — accurate time is important for certificates and logs.
