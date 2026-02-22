# docker-dns.sh

## Purpose

Deploy a secondary DNS solution on Docker for redundancy alongside the standalone Pi-hole LXC.

## What This Script Does

1. **Deploy DNS container** — starts the chosen DNS solution
2. **Configure networking** — assigns a static IP on the Docker network (if applicable)
3. **Verify** — confirms DNS resolution is working

## Container Options

| Option | Image | Description |
|--------|-------|-------------|
| Pi-hole 2 | `pihole/pihole:latest` | Redundant Pi-hole instance for DNS failover |
| AdGuard Home | `adguard/adguardhome:latest` | Modern DNS ad-blocker with DoH/DoT support |
| Unbound | `mvance/unbound:latest` | Recursive resolver — queries root servers directly |

## Required Config (`node.env`)

| Variable | Required | Example | Description |
|----------|----------|---------|-------------|
| DOCKER_LXC_ID | **Yes** | `200` | CT or VM ID |
| DNS_SOLUTION | No | `pihole` | `pihole`, `adguard`, or `unbound` (default: pihole) |
| DNS_DOCKER_IP | No | `10.0.10.54` | Static IP for Docker DNS |

## Usage

```bash
bash scripts/docker-dns.sh
```

## Idempotency

- Skips if the DNS container is already running

## Notes

- Run **after** Docker config. This is optional — only needed for DNS redundancy.
- Configure OPNsense with **both** Pi-hole IPs as DNS servers for failover.
- Unbound works best as Pi-hole's upstream, not as a standalone ad-blocker.
- If using a Docker VM instead of LXC, substitute `DOCKER_VM_ID` for `DOCKER_LXC_ID`.
