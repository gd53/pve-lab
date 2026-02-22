# docker-infra.sh

## Purpose

Deploy core Docker management containers: Dockge (compose stack manager) and Watchtower (automatic image updater).

## What This Script Does

1. **Deploy Dockge** — web-based Docker Compose manager on port 5001
2. **Deploy Watchtower** — automatic container image updater (daily checks)
3. **Verify** — confirms both containers are running

## Containers Deployed

| Container | Image | Port | Description |
|-----------|-------|------|-------------|
| Dockge | `louislam/dockge:latest` | 5001 | Compose stack manager with web UI |
| Watchtower | `containrrr/watchtower:latest` | — | Auto-updates container images daily |

## Required Config (`node.env`)

| Variable | Required | Example | Description |
|----------|----------|---------|-------------|
| DOCKER_LXC_ID | **Yes** | `200` | CT or VM ID (use DOCKER_VM_ID if VM) |
| DOCKER_LXC_IP | **Yes** | `10.0.10.200` | Docker host IP (for access URLs) |

## Usage

```bash
bash scripts/docker-infra.sh
```

## Idempotency

- Skips containers that are already running

## Notes

- Run **after** Docker config (`docker-config-ct.sh` or `docker-config-vm.sh`).
- Dockge UI: `http://DOCKER_HOST_IP:5001`.
- Watchtower runs silently in the background.
- If using a Docker VM instead of LXC, substitute `DOCKER_VM_ID` and `DOCKER_VM_IP` for the LXC variables.
