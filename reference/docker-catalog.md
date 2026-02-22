# Docker Container Catalog

Docker container deployments go in `scripts/docker/`. Compose files and service configs go in `stacks/`. Docs go in `docs/`.

## How Containers Are Organized

Containers are grouped into **sections by type**, then ordered by **priority within each section** (most essential first). This ordering also defines the deployment sequence.

## Tags

| Tag | Meaning |
|-----|---------|
| ⭐ | Personal pick — what I use in my own setup |
| 🆕 | Newly added — within the last 3 months. Loses the tag after any update past the 3-month mark. |

All options are listed since this is a public repo — users should pick what fits their setup.

## Container Catalog

**Infrastructure Management:**
1. ⭐ Dockge — compose stack manager (lighter than Portainer, compose-native)
2. Portainer — full Docker management UI (heavier, more features)
3. ⭐ Watchtower — automatic container image updates
4. Dozzle — real-time Docker log viewer

**DNS & Ad-Blocking:**
1. ⭐ Pi-hole — DNS-level ad blocking (standalone LXC = primary, Docker = secondary)
2. AdGuard Home — modern DNS ad-blocker with DoH/DoT
3. Unbound — recursive DNS resolver

**Reverse Proxy & SSL:**
1. Nginx Proxy Manager (NPM) — visual UI, Let's Encrypt
2. Traefik — declarative, auto-discovery
3. Caddy — automatic HTTPS, simple config

**External Access & VPN:**
1. Cloudflare Tunnel (cloudflared) — secure outbound tunneling without open ports
2. Netbird — mesh VPN / overlay network
3. Tailscale — zero-config mesh VPN

**Database:**
1. PostgreSQL — shared relational DB for apps that need it (Immich, Netbird, etc.)
2. CouchDB — document DB (Obsidian sync backend)
3. Redis — in-memory cache/store

**Monitoring & Logging:**
1. Uptime Kuma — service monitoring and alerts
2. Grafana + Prometheus — metrics dashboards
3. Loki — log aggregation (pairs with Grafana)
4. Graylog — centralized logging with search

**GPU & Media:**
1. NVIDIA Container Toolkit — GPU access for Docker (setup script, not a container)
2. Jellyfin — media server with hardware transcoding
3. Immich — photo management (needs GPU + Postgres)

**Productivity & Tools:**
1. Vaultwarden — Bitwarden-compatible password manager
2. Homepage — service dashboard / portal
3. Code-Server — VS Code in the browser
4. OpenCloud — file sync (Nextcloud alternative)
5. RustDesk — self-hosted remote desktop
6. Karakeep — bookmark manager with AI search
7. Stirling PDF — PDF tools in the browser

## Adding New Containers

When a new container is added, it goes into the appropriate section at the right priority position and gets the 🆕 tag. The tag is removed after any update past the 3-month mark.
