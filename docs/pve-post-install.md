# pve-post-install.sh

## Purpose

Configure Proxmox repos, update packages, remove the subscription nag, and disable unnecessary cluster services on a single-node setup.

## What This Script Does

1. **Disable enterprise repo** — comments out the `pve-enterprise` APT source (requires paid subscription)
2. **Enable no-subscription repo** — adds the free community `pve-no-subscription` APT source
3. **System upgrade** — runs `apt update && apt dist-upgrade`
4. **Remove subscription nag** — patches the web UI to remove the "No valid subscription" popup
5. **Persist nag removal** — creates an apt hook (`/usr/local/bin/pve-remove-nag.sh`) so the patch survives package updates
6. **Disable HA services** — stops and disables `pve-ha-lrm` and `pve-ha-crm` (not needed without a cluster)
7. **Disable Corosync** — stops cluster communication service (unnecessary for single-node)

## Required Config (`node.env`)

None. This script uses standard Proxmox paths and requires no variables.

## Usage

```bash
bash scripts/pve-post-install.sh
```

## Idempotency

- Skips repo changes if already applied
- Skips nag removal if already patched
- Skips service disabling if already stopped

## Notes

- Run this **first** after a fresh Proxmox install.
- Reboot recommended after completion (kernel and package updates may require it).
- If you later add nodes to form a cluster, re-enable HA and Corosync services manually.
