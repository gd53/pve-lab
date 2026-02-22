# docker-proxy.sh

## Purpose

Deploy a reverse proxy for HTTPS access to services via `service.yourdomain.com` with automatic SSL certificates.

## What This Script Does

1. **Deploy reverse proxy** — starts the chosen proxy container (NPM, Traefik, or Caddy)
2. **Configure ports** — maps HTTP (80), HTTPS (443), and admin UI
3. **Create proxy network** — ensures the `proxy` Docker network exists
4. **Verify** — confirms the proxy is running and responding

## Container Options

| Option | Image | Admin Port | Best for |
|--------|-------|------------|----------|
| Nginx Proxy Manager | `jc21/nginx-proxy-manager:latest` | 81 | Visual UI, beginners |
| Traefik | `traefik:latest` | 8080 | GitOps, auto-discovery |
| Caddy | `caddy:latest` | — | Simple config, automatic HTTPS |

## Required Config (`node.env`)

| Variable | Required | Example | Description |
|----------|----------|---------|-------------|
| DOCKER_LXC_ID | **Yes** | `200` | CT or VM ID |
| DOMAIN | **Yes** | `local` | Base domain for proxy hosts |
| PROXY_TYPE | No | `npm` | `npm`, `traefik`, or `caddy` (default: npm) |

## Usage

```bash
bash scripts/docker-proxy.sh
```

## Idempotency

- Skips if the proxy container is already running

## Notes

- Run **after** Docker infra (`docker-infra.sh`).
- NPM default login: `admin@example.com` / `changeme` — change immediately.
- NPM admin UI: `http://DOCKER_HOST_IP:81`.
- All containers that need proxying must be on the `proxy` Docker network.
- For wildcard SSL, use DNS challenge with your DNS provider's API.
- If using a Docker VM instead of LXC, substitute `DOCKER_VM_ID` for `DOCKER_LXC_ID`.
