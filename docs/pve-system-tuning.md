# pve-system-tuning.sh

## Purpose

Apply kernel and system performance tuning for a Proxmox host.

## What It Does

### Network

- Enables TCP BBR congestion control (better throughput)
- Enables TCP Fast Open (reduces latency)

### Memory

- Sets swappiness to 10 (prefer RAM over swap)
- Tunes kernel shared memory (KSM)

### System

- Increases inotify watchers (prevents "too many open files" for containers)
- Optimizes journald logging (size limits, persistent storage)
- Installs and enables `haveged` for entropy generation (faster crypto, boot)
- Sets kernel panic recovery timeout (auto-reboot on panic)

## Config Needed

None. Uses sensible defaults that work for most single-node setups.

## How to Run

```bash
bash scripts/pve-system-tuning.sh
```

## Notes

- Optional but recommended. All tunings are well-established best practices.
- Kernel parameters are written to `/etc/sysctl.d/` and applied immediately.
- Reboot recommended for full effect (some kernel params only apply at boot).
- Idempotent — safe to rerun.
