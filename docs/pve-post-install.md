# pve-post-install.sh

## Purpose

Configure Proxmox repos, update packages, remove the subscription nag, and disable unnecessary cluster services on a single-node setup.

## What It Does

### Repositories

- Disables the `pve-enterprise` repo (requires paid subscription)
- Enables the `pve-no-subscription` repo (free, community)
- Runs `apt update` and `apt dist-upgrade`

### Subscription Nag

- Patches the web UI to remove the "No valid subscription" popup
- Creates a persistent apt hook (`/usr/local/bin/pve-remove-nag.sh`) so the patch survives package updates

### Single-Node Services

- Disables `pve-ha-lrm` (HA local resource manager) — not needed without a cluster
- Disables `pve-ha-crm` (HA cluster resource manager)
- Disables `corosync` — cluster communication, unnecessary for single-node

## Config Needed

None. This script uses standard Proxmox paths and requires no variables.

## How to Run

```bash
bash scripts/pve-post-install.sh
```

## Notes

- Run this **first** after a fresh Proxmox install.
- Reboot recommended after completion (kernel and package updates may require it).
- Idempotent — safe to rerun. Skips steps already applied.
- If you later add nodes to form a cluster, re-enable HA and Corosync services manually.
