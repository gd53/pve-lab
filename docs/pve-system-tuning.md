# pve-system-tuning.sh

## Purpose

Apply kernel and system performance tuning for a Proxmox host.

## What This Script Does

1. **Enable TCP BBR** — switches to BBR congestion control for better throughput
2. **Enable TCP Fast Open** — reduces connection latency
3. **Set swappiness** — sets `vm.swappiness=10` to prefer RAM over swap
4. **Tune shared memory** — adjusts kernel KSM settings
5. **Increase inotify watchers** — prevents "too many open files" for containers
6. **Optimize journald** — sets size limits and persistent storage for systemd journal
7. **Install haveged** — provides entropy for faster crypto and boot
8. **Set panic recovery** — enables auto-reboot on kernel panic

## Required Config (`node.env`)

None. Uses sensible defaults that work for most single-node setups.

## Usage

```bash
bash scripts/pve-system-tuning.sh
```

## Idempotency

- Skips sysctl settings if already applied
- Skips journald config if already set
- Skips haveged install if already present

## Notes

- Optional but recommended. All tunings are well-established best practices.
- Kernel parameters are written to `/etc/sysctl.d/` and applied immediately.
- Reboot recommended for full effect (some kernel params only apply at boot).
