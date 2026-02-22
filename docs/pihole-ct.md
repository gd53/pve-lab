# pihole-ct.sh

## Purpose

Create a lightweight standalone LXC container running Pi-hole for DNS ad-blocking and local DNS resolution.

## What This Script Does

1. **Download CT template** — fetches the latest Debian LXC template if not present
2. **Create LXC** — provisions a lightweight container (512 MB RAM, 1 core, 4 GB disk)
3. **Configure networking** — assigns a static IP and gateway
4. **Install Pi-hole** — runs the automated Pi-hole installer inside the container
5. **Configure DNS** — sets upstream DNS servers
6. **Verify** — confirms Pi-hole web UI is accessible

## Required Config (`node.env`)

| Variable | Required | Example | Description |
|----------|----------|---------|-------------|
| PIHOLE_LXC_ID | **Yes** | `101` | Proxmox CT ID |
| PIHOLE_LXC_IP | **Yes** | `10.0.10.53` | Static IP for Pi-hole |
| GATEWAY | **Yes** | `10.0.10.1` | Default gateway (OPNsense LAN IP) |
| PIHOLE_PASSWORD | No | — | Admin password (default: random) |

## Usage

```bash
bash scripts/pihole-ct.sh
```

## Idempotency

- Skips template download if already present
- Skips LXC creation if CT ID already exists
- Skips Pi-hole install if already running

## Notes

- This is a **standalone LXC**, not Docker-based — simpler, faster, fully isolated.
- After running, Pi-hole web UI is at `http://PIHOLE_LXC_IP/admin`.
- Update OPNsense DNS settings to point to Pi-hole for network-wide ad-blocking.
- A second Pi-hole can run on Docker later for redundancy (see `docker-dns.md`).
