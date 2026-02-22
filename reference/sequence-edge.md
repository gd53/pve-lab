# Edge Firewall Build Sequence

Dual-NIC setup with OPNsense firewall, Docker services, Pi-hole DNS, and the full stack.

For a simpler single-NIC setup, see [sequence-single.md](sequence-single.md).

Scripts run via SSH on the node, in order. Each entry links to its doc in `docs/`.

## Pre-Install (run on workstation)

| # | Script | Doc | Description |
|---|--------|-----|-------------|
| 0 | `pve-answer-toml.sh` | [doc](../docs/pve-answer-toml.md) | Generate answer.toml for Ventoy automated install |

## Host Setup (on DHCP IP)

| # | Script | Doc | Description |
|---|--------|-----|-------------|
| 1 | `pve-post-install.sh` | [doc](../docs/pve-post-install.md) | Repos, tools, nag removal, hostname, disable cluster services |
| 2 | `pve-network-bridge.sh` | [doc](../docs/pve-network-bridge.md) | Add vmbr1 on NIC2, make vmbr0 VLAN-aware |
| 3 | `pve-ntp-locale.sh` | [doc](../docs/pve-ntp-locale.md) | Timezone, NTP, locale |
| 4 | `pve-ssh-harden.sh` | [doc](../docs/pve-ssh-harden.md) | Key-based auth, disable root password |
| 5 | `pve-system-tuning.sh` | [doc](../docs/pve-system-tuning.md) | Kernel params, TCP BBR, swappiness, journald |
| 6 | `pve-microcode.sh` | [doc](../docs/pve-microcode.md) | Intel/AMD CPU microcode updates (reboot) |
| 7 | `pve-gpu-passthrough.sh` | [doc](../docs/pve-gpu-passthrough.md) | IOMMU + VFIO GPU passthrough (optional, reboot) |

## Networking (OPNsense)

| # | Script | Doc | Description |
|---|--------|-----|-------------|
| 8 | `opn-vm.sh` | [doc](../docs/opn-vm.md) | Create OPNsense VM (WAN=vmbr0, LAN=vmbr1) |
| 9 | `opn-config.sh` | [doc](../docs/opn-config.md) | OPNsense base config (interfaces, DHCP, DNS, firewall) |
| 10 | `opn-plugins.sh` | [doc](../docs/opn-plugins.md) | Install and update OPNsense plugins |

## Network Migration (console-only)

| # | Script | Doc | Description |
|---|--------|-----|-------------|
| 11 | `pve-network-migrate.sh` | [doc](../docs/pve-network-migrate.md) | Move management IP from vmbr0 to vmbr1. **Console-only.** |
| 12 | `pve-firewall-setup.sh` | [doc](../docs/pve-firewall-setup.md) | Proxmox firewall rules + fail2ban (now behind OPNsense) |

## Storage & Backups

| # | Script | Doc | Description |
|---|--------|-----|-------------|
| 13 | `pve-storage-setup.sh` | [doc](../docs/pve-storage-setup.md) | Local storage directories |
| 14 | `omv-vm.sh` | [doc](../docs/omv-vm.md) | Create OMV VM with disk passthrough |
| 15 | `omv-config.sh` | [doc](../docs/omv-config.md) | OMV config (storage pools, SMB/NFS, MergerFS, SnapRAID) |
| 16 | `pbs-vm.sh` | [doc](../docs/pbs-vm.md) | Create PBS VM with dedicated backup disk |
| 17 | `pbs-config.sh` | [doc](../docs/pbs-config.md) | PBS datastore, retention policy, PVE integration |

## DNS

| # | Script | Doc | Description |
|---|--------|-----|-------------|
| 18 | `pihole-ct.sh` | [doc](../docs/pihole-ct.md) | Standalone Pi-hole LXC for DNS ad-blocking |

## Docker (pick LXC or VM path)

| # | Script | Doc | Description |
|---|--------|-----|-------------|
| 19a | `docker-host-ct.sh` | [doc](../docs/docker-host-ct.md) | Create Docker LXC + install engine |
| 19b | `docker-vm.sh` | [doc](../docs/docker-vm.md) | Create Docker VM + install engine *(alternative)* |
| 20a | `docker-config-ct.sh` | [doc](../docs/docker-config-ct.md) | Docker networks, dirs, .env (LXC) |
| 20b | `docker-config-vm.sh` | [doc](../docs/docker-config-vm.md) | Docker networks, dirs, .env (VM) *(alternative)* |
| 21 | `docker-infra.sh` | [doc](../docs/docker-infra.md) | Dockge + Watchtower |
| 22 | `docker-dns.sh` | [doc](../docs/docker-dns.md) | Secondary DNS for redundancy (optional) |
| 23 | `docker-proxy.sh` | [doc](../docs/docker-proxy.md) | Reverse proxy (NPM / Traefik / Caddy) |

## Network Extras (optional)

| # | Script | Doc | Description |
|---|--------|-----|-------------|
| 24 | `pve-network-vlans.sh` | [doc](../docs/pve-network-vlans.md) | VLAN schema for network isolation |
| 25 | `net-switch-ap.sh` | [doc](../docs/net-switch-ap.md) | Managed switch + AP config reference |

## Finalize

| # | Script | Doc | Description |
|---|--------|-----|-------------|
| 26 | `pve-finalize.sh` | [doc](../docs/pve-finalize.md) | DNS cutover, health checks, cleanup |

## Notes

- Copy `node.env.template` to `node.env` and fill in values before running any scripts.
- Scripts are idempotent — safe to rerun if interrupted.
- Steps requiring console access (no SSH) are marked.
- Steps 6 and 7 require a reboot after running.
- For Docker, pick **either** the LXC path (19a/20a) **or** the VM path (19b/20b), not both.
- OPNsense, OMV, and PBS require console access for their initial installer.
