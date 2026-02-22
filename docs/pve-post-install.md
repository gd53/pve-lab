# pve-post-install.sh

## Purpose

Prepare a fresh Proxmox node — fix repos, upgrade packages, install essential tools, remove subscription nag, set hostname, and disable cluster services.

## What This Script Does

1. **Disable enterprise repo** — comments out the `pve-enterprise` APT source (requires paid subscription)
2. **Disable Ceph enterprise repo** — prevents APT errors if Ceph is not in use
3. **Enable no-subscription repo** — adds the free community `pve-no-subscription` APT source
4. **System upgrade** — runs `apt update && apt dist-upgrade`
5. **Install essential tools** — `curl`, `wget`, `git`, `jq`, `htop`, `nano`, `vim`, `unzip`, `lsb-release`, `gnupg2`, `ca-certificates`
6. **Set hostname** — applies the configured hostname from node.env
7. **Remove subscription nag** — patches the web UI to remove the "No valid subscription" popup
8. **Persist nag removal** — creates an apt hook so the patch survives package updates
9. **Disable HA services** — stops and disables `pve-ha-lrm` and `pve-ha-crm` (not needed without a cluster)
10. **Disable Corosync** — stops cluster communication service (unnecessary for single-node)

## Required Config (`node.env`)

| Variable | Required | Example | Description |
|----------|----------|---------|-------------|
| NODE_NAME | No | `pve` | Hostname for this node |

## Usage

```bash
bash scripts/pve-post-install.sh
```

## Idempotency

- Skips repo changes if already applied
- Skips tools that are already installed
- Skips hostname if already matches
- Skips nag removal if already patched
- Skips service disabling if already stopped

## Notes

- Run this **first** after a fresh Proxmox install.
- Reboot recommended after completion (kernel and package updates may require it).
- If you later add nodes to form a cluster, re-enable HA and Corosync services manually.
