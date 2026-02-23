# Future Scripts

Scripts planned for later phases. Not part of the current build sequences.

Ideas sourced from homelab v1 reference code, project roadmap, and refresh v4 analysis.

## Docker Services

| Script | Description |
|--------|-------------|
| `docker/<service>.sh` | One script per Docker service (Jellyfin, Immich, Vaultwarden, etc.) |
| `docker-macvlan.sh` | Create macvlan network for services needing real IPs (Pi-hole, reverse proxy) |
| `docker-daemon-tune.sh` | Docker daemon tuning — log rotation (10m/3 files), default address pools |
| `docker-gravity-sync.sh` | Sync Pi-hole blocklists/DNS from primary LXC to secondary Docker instance |
| `docker-cloudflared.sh` | Cloudflare Tunnel for zero-trust access without port forwarding |
| `docker-netbird.sh` | Netbird self-hosted WireGuard mesh VPN (signal + relay) |
| `docker-caddy-cf.sh` | Custom Caddy build with Cloudflare DNS-01 plugin for wildcard certs |
| `docker-homepage.sh` | Homepage dashboard with service status widgets and organized categories |
| `docker-dozzle.sh` | Dozzle real-time container log viewer |
| `docker-authelia.sh` | Authelia SSO + 2FA with reverse proxy forward-auth integration |
| `docker-monitoring-stack.sh` | Prometheus + Grafana + node-exporter + cAdvisor metrics stack |
| `docker-scrutiny.sh` | Scrutiny disk SMART health monitoring with alerting |

## Hardware

| Script | Description |
|--------|-------------|
| `pve-coral-passthrough.sh` | Google Coral TPU passthrough for AI/ML workloads |
| `pve-gpu-docker.sh` | NVIDIA Container Toolkit + driver install for GPU containers in VM |
| `pve-bios-verify.sh` | Post-boot BIOS setting verification via dmidecode, dmesg, lscpu |
| `pve-hw-validate.sh` | Hardware validation — memtester, stress-ng with thermals, SMART, NIC speed |
| `pve-disk-erase.sh` | Secure disk erasure for SATA (blkdiscard/hdparm) and NVMe (nvme format) |
| `pve-hw-inventory.sh` | Auto-discover and catalog hardware as structured YAML/JSON |
| `pve-power-monitor.sh` | Monitor per-node power consumption via IPMI/smart plug APIs |

## Networking

| Script | Description |
|--------|-------------|
| `opn-wireguard.sh` | WireGuard VPN configuration on OPNsense |
| `opn-haproxy.sh` | HAProxy reverse proxy configuration on OPNsense |
| `opn-vlan-firewall.sh` | Per-VLAN firewall rules (mgmt=allow, services=internet+mgmt, IoT=internet-only, guest=block-internal) |
| `net-switch-vlan.sh` | Cisco SG300 VLAN configuration via SSH/expect |

## Security

| Script | Description |
|--------|-------------|
| `pve-hardening.sh` | fail2ban + CrowdSec bouncer, GeoIP blocking, phased SSH hardening (week 1: password+fail2ban, week 2: add keys, week 3: disable password), default password audit, boot order + auto-start |
| `pve-secrets-gen.sh` | Automated credential/token generation for all services |
| `pve-cold-reboot-test.sh` | Full lab reboot test — validate all services recover automatically |
| `pve-alerting.sh` | Alerting pipeline — SMTP config for PVE/PBS/OPNsense, push notifications |
| `pve-auto-update.sh` | Automated OS/container updates with staging and maintenance windows |
| `pve-telemetry-audit.sh` | Scan VMs/CTs for telemetry endpoints, generate firewall block rules |
| `pve-encryption-verify.sh` | Verify LUKS on data drives, SSH key strengths, TLS versions |
| `security-baseline-check.sh` | Comprehensive security posture check (passwords, ports, services, firewall) |
| `pve-preflight.sh` | Pre-deployment validation — BIOS via dmidecode, network, ISO checksums, disk health |

## Validation

| Script | Description |
|--------|-------------|
| `pve-cutover-validate.sh` | Pre/post network cutover health checks (DNS, DHCP, VLANs, FQDN, services) |
| `lib/network-check.sh` | Network validation helpers — `check_ping`, `check_port`, `check_url`, `poll_url` |
| `lib/healthcheck.sh` | Post-deployment health validation framework for all roles |
| `pve-vlan-isolation-test.sh` | Automated VLAN isolation matrix testing (cross-VLAN pings, verify blocks) |
| `pve-bandwidth-test.sh` | Inter-node/inter-VLAN bandwidth testing via iperf3 |

## Clustering

| Script | Description |
|--------|-------------|
| `pve-ceph-setup.sh` | Ceph distributed storage for multi-node clusters |
| `pve-cluster-join.sh` | Join a node to an existing Proxmox cluster |
| `pve-node-planner.sh` | Multi-node VM/CT placement algorithm based on hardware constraints |

## Testing

| Script | Description |
|--------|-------------|
| `tests/runner.sh` | Bash unit test framework with assertions (assert_eq, assert_ok, assert_contains) |
| `tests/lint.sh` | ShellCheck linting for all scripts |
| `tests/validate-compose.sh` | Docker Compose syntax validation for all stacks |
| `tests/validate-env.sh` | Environment file validation (syntax, secrets permissions, leak detection) |

## Customization

| Script | Description |
|--------|-------------|
| `pve-theme.sh` | Console and web UI theme customization |

## Tooling (Stretch Goals)

| Script | Description |
|--------|-------------|
| `pve-wizard.sh` | Interactive TUI setup wizard (node config, network, services, secrets, plan review) |
| `pve-orchestrator.sh` | Deployment orchestrator — run scripts in sequence with dependency ordering |
| `lib/api.sh` | Proxmox REST API wrapper library for cluster management |
| `pve-multi-lab.sh` | Multi-lab environment support — separate configs per lab instance |
