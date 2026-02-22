# Single Server Build Sequence

Basic single-NIC setup. One Proxmox host, no firewall VM, no Docker. Start here.

For a dual-NIC setup with OPNsense, Docker, and more, see [sequence-edge.md](sequence-edge.md).

Scripts run via SSH on the node, in order. Each entry links to its doc in `docs/`.

## Pre-Install (run on workstation)

| # | Script | Doc | Description |
|---|--------|-----|-------------|
| 0 | `pve-answer-toml.sh` | [doc](../docs/pve-answer-toml.md) | Generate answer.toml for Ventoy automated install |

## Host Setup (run on Proxmox node)

| # | Script | Doc | Description |
|---|--------|-----|-------------|
| 1 | `pve-post-install.sh` | [doc](../docs/pve-post-install.md) | Repos, tools, nag removal, hostname, disable cluster services |
| 2 | `pve-network-static.sh` | [doc](../docs/pve-network-static.md) | DHCP to static IP. **Console-only.** |
| 3 | `pve-ntp-locale.sh` | [doc](../docs/pve-ntp-locale.md) | Timezone, NTP, locale |
| 4 | `pve-ssh-harden.sh` | [doc](../docs/pve-ssh-harden.md) | Key-based auth, disable root password |
| 5 | `pve-firewall-setup.sh` | [doc](../docs/pve-firewall-setup.md) | Proxmox firewall rules + fail2ban |
| 6 | `pve-system-tuning.sh` | [doc](../docs/pve-system-tuning.md) | Kernel params, TCP BBR, swappiness, journald |
| 7 | `pve-storage-setup.sh` | [doc](../docs/pve-storage-setup.md) | Local storage directories |
| 8 | `pve-microcode.sh` | [doc](../docs/pve-microcode.md) | Intel/AMD CPU microcode updates (reboot) |
| 9 | `pve-gpu-passthrough.sh` | [doc](../docs/pve-gpu-passthrough.md) | IOMMU + VFIO GPU passthrough (optional, reboot) |

## Storage (OpenMediaVault NAS)

| # | Script | Doc | Description |
|---|--------|-----|-------------|
| 10 | `omv-vm.sh` | [doc](../docs/omv-vm.md) | Create OMV VM with disk passthrough |
| 11 | `omv-config.sh` | [doc](../docs/omv-config.md) | OMV config (storage pools, SMB/NFS, MergerFS, SnapRAID) |

## Backups (Proxmox Backup Server)

| # | Script | Doc | Description |
|---|--------|-----|-------------|
| 12 | `pbs-vm.sh` | [doc](../docs/pbs-vm.md) | Create PBS VM with dedicated backup disk |
| 13 | `pbs-config.sh` | [doc](../docs/pbs-config.md) | PBS datastore, retention policy, PVE integration |

## Notes

- Copy `node.env.template` to `node.env` and fill in values before running any scripts.
- Scripts are idempotent — safe to rerun if interrupted.
- Steps requiring console access (no SSH) are marked.
- Steps 8 and 9 require a reboot after running.
- OMV and PBS require console access for their initial installer.
