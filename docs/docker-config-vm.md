# docker-config-vm.sh

## Purpose

Configure the Docker environment inside the Docker VM — directory structure, networks, compose layout, and daemon settings.

## What This Script Does

1. **Create directory structure** — standardized paths under `/opt/stacks/` for compose files, volumes, and configs
2. **Create Docker networks** — `proxy` network (for reverse proxy) and `internal` network (backend services)
3. **Create base `.env`** — shared environment variables for all compose stacks (DOMAIN, TZ, PUID, PGID)
4. **Set Docker daemon config** — log rotation, default DNS, restart policy
5. **Verify Docker health** — confirms daemon is running and networks exist

## Directory Structure Created

```
/opt/stacks/
├── .env              Shared env vars
├── infra/            Dockge, Watchtower
├── dns/              Secondary DNS
├── proxy/            Reverse proxy
├── essential/        Vaultwarden, Uptime Kuma, etc.
└── media/            Jellyfin, Immich, etc.
```

## Required Config (`node.env`)

| Variable | Required | Example | Description |
|----------|----------|---------|-------------|
| DOCKER_VM_ID | **Yes** | `500` | VM ID to configure |
| DOCKER_VM_IP | **Yes** | `10.0.10.200` | VM IP (for SSH access) |
| DOMAIN | **Yes** | `local` | Domain for reverse proxy |
| TIMEZONE | **Yes** | `Australia/Melbourne` | TZ for containers |

## Usage

```bash
bash scripts/docker-config-vm.sh
```

## Idempotency

- Skips directories that already exist
- Skips networks that already exist
- Skips .env if already present

## Notes

- Run **after** `docker-vm.sh` (Docker must be installed first).
- Functionally identical to `docker-config-ct.sh` but accesses the VM via SSH instead of `pct exec`.
- All compose stacks share the base `.env` and predefined Docker networks.
