# docker-host-ct.sh

## Purpose

Create a Debian LXC container on Proxmox configured to run Docker, and install the Docker Engine inside it.

## What This Script Does

1. **Download CT template** — fetches the latest Debian LXC template if not present
2. **Create LXC** — provisions a privileged container with nesting, keyctl, and FUSE support (required for Docker)
3. **Configure networking** — assigns a static IP and gateway
4. **Boot container** — starts the LXC and waits for it to be ready
5. **Install Docker Engine** — runs the official Docker install script inside the LXC via `pct exec`
6. **Verify** — runs `docker run hello-world` to confirm Docker works

## Required Config (`node.env`)

| Variable | Required | Example | Description |
|----------|----------|---------|-------------|
| DOCKER_LXC_ID | **Yes** | `200` | Proxmox CT ID |
| DOCKER_LXC_IP | **Yes** | `10.0.10.200` | Static IP for the container |
| DOCKER_LXC_GW | **Yes** | `10.0.10.1` | Gateway for the container |
| DOCKER_LXC_HOSTNAME | No | `docker` | Container hostname |
| DOCKER_LXC_DISK | No | `32` | Root disk in GB (default: 32) |
| DOCKER_LXC_RAM | No | `4096` | RAM in MB (default: 4096) |
| DOCKER_LXC_CORES | No | `4` | CPU cores (default: 4) |
| DOCKER_LXC_STORAGE | No | `local-lvm` | Proxmox storage target |
| SSH_PUBKEY | No | `ssh-ed25519 AAAA...` | Injected into the LXC |

## Usage

```bash
bash scripts/docker-host-ct.sh
```

## Idempotency

- Skips template download if already present
- Skips LXC creation if CT ID already exists
- Skips Docker install if `docker` command exists inside the LXC

## Notes

- The container is created as **privileged** with nesting enabled — required for Docker in LXC.
- This LXC is for general Docker workloads. For GPU workloads, use `docker-vm.sh` instead.
- Follow up with `docker-config-ct.sh` to configure networks and directories.
