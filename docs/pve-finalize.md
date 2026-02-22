# pve-finalize.sh

## Purpose

Run final configuration tasks — DNS cutover, firewall hardening, service health checks, and cleanup.

## What This Script Does

1. **DNS cutover** — updates OPNsense to use Pi-hole as DNS server instead of upstream
2. **Firewall hardening** — adds OPNsense rules to restrict inter-VLAN traffic
3. **Proxy verification** — checks that reverse proxy hosts are configured with SSL
4. **Service health check** — pings and HTTP-checks every deployed service
5. **Cleanup** — removes temp files, apt cache, unused Docker images
6. **Generate summary** — outputs a status report of everything running

## Required Config (`node.env`)

| Variable | Required | Example | Description |
|----------|----------|---------|-------------|
| PIHOLE_LXC_IP | **Yes** | `10.0.10.53` | Primary Pi-hole IP |
| DOCKER_LXC_IP | **Yes** | `10.0.10.200` | Docker host IP |
| GATEWAY | **Yes** | `10.0.10.1` | OPNsense LAN IP |
| DOMAIN | **Yes** | `local` | For proxy verification |

## Usage

```bash
bash scripts/pve-finalize.sh
```

## Idempotency

- Health checks and cleanup are safe to rerun
- DNS cutover skips if already configured

## Notes

- This is the **final script** in the edge sequence. Run only after all services are deployed.
- The health check output is useful for troubleshooting.
- If using a Docker VM, substitute `DOCKER_VM_IP` for `DOCKER_LXC_IP`.
