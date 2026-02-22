# Single Server Build Sequence

Monolithic single-node setup. One Proxmox host running everything — start here.

Scripts run via SSH on the node, in order. Each entry links to its doc in `docs/`.

## Pre-Install (run on workstation)

| # | Script | Doc | Description |
|---|--------|-----|-------------|
| 0 | `pve-answer-toml.sh` | [doc](../docs/pve-answer-toml.md) | Generate answer.toml for Ventoy automated install |

## Host Setup (run on Proxmox node)

| # | Script | Doc | Description |
|---|--------|-----|-------------|
| 1 | `pve-post-install.sh` | [doc](../docs/pve-post-install.md) | Repos, updates, nag removal, disable cluster services |
| 2 | `pve-network-static.sh` | [doc](../docs/pve-network-static.md) | DHCP to static IP. **Console-only.** |
| 3 | `pve-ssh-harden.sh` | [doc](../docs/pve-ssh-harden.md) | Key-based auth, disable root password |
| 4 | `pve-firewall-setup.sh` | [doc](../docs/pve-firewall-setup.md) | Proxmox firewall rules + fail2ban |
| 5 | `pve-system-tuning.sh` | [doc](../docs/pve-system-tuning.md) | Kernel params, TCP BBR, swappiness, journald |
| 6 | `pve-storage-setup.sh` | [doc](../docs/pve-storage-setup.md) | Local storage directories |
| 7 | `pve-microcode.sh` | [doc](../docs/pve-microcode.md) | Intel/AMD CPU microcode updates |
| 8 | `pve-gpu-passthrough.sh` | [doc](../docs/pve-gpu-passthrough.md) | IOMMU + VFIO GPU passthrough (optional) |

## Networking (OPNsense firewall/router)

| # | Script | Doc | Description |
|---|--------|-----|-------------|
| 9 | `opn-vm.sh` | [doc](../docs/opn-vm.md) | Create OPNsense VM on Proxmox (dual-NIC) |
| 10 | `opn-config.sh` | [doc](../docs/opn-config.md) | OPNsense base config (interfaces, DHCP, DNS, firewall) |
| 11 | `opn-plugins.sh` | [doc](../docs/opn-plugins.md) | Install and update OPNsense plugins |

## Storage (OpenMediaVault NAS)

| # | Script | Doc | Description |
|---|--------|-----|-------------|
| 12 | `omv-vm.sh` | [doc](../docs/omv-vm.md) | Create OMV VM with disk passthrough |
| 13 | `omv-config.sh` | [doc](../docs/omv-config.md) | OMV config (storage pools, SMB/NFS, MergerFS, SnapRAID) |

## Backups (Proxmox Backup Server)

| # | Script | Doc | Description |
|---|--------|-----|-------------|
| 14 | `pbs-vm.sh` | [doc](../docs/pbs-vm.md) | Create PBS VM with dedicated backup disk |
| 15 | `pbs-config.sh` | [doc](../docs/pbs-config.md) | PBS datastore, retention policy, PVE integration |

## Notes

- Copy `node.env.template` to `node.env` and fill in values before running any scripts.
- Scripts are idempotent — safe to rerun if interrupted.
- Steps requiring console access (no SSH) are marked.
- Scripts 7 and 8 require a reboot after running.
- OPNsense, OMV, and PBS require console access for their initial installer.
