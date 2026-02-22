# docker-vm.sh

## Purpose

Create a Debian VM on Proxmox for running Docker, and install the Docker Engine inside it.

## What This Script Does

1. **Download ISO** — downloads the latest Debian netinst ISO if not present
2. **Create VM** — provisions a VM with configured CPU, RAM, and disk
3. **Configure networking** — assigns a static IP via cloud-init or preseed
4. **Boot VM** — starts the VM for initial Debian installation
5. **Install Docker Engine** — runs the official Docker install script via SSH after OS install
6. **Verify** — runs `docker run hello-world` to confirm Docker works

## Required Config (`node.env`)

| Variable | Required | Example | Description |
|----------|----------|---------|-------------|
| DOCKER_VM_ID | **Yes** | `500` | Proxmox VM ID |
| DOCKER_VM_IP | **Yes** | `10.0.10.200` | Static IP for the VM |
| DOCKER_VM_GW | **Yes** | `10.0.10.1` | Gateway for the VM |
| DOCKER_VM_LAN_BRIDGE | **Yes** | `vmbr1` | Bridge for LAN interface |
| DOCKER_VM_HOSTNAME | No | `docker` | VM hostname |
| DOCKER_VM_DISK | No | `32` | Disk size in GB (default: 32) |
| DOCKER_VM_RAM | No | `4096` | RAM in MB (default: 4096) |
| DOCKER_VM_CORES | No | `4` | CPU cores (default: 4) |
| SSH_PUBKEY | No | `ssh-ed25519 AAAA...` | Injected for SSH access |

## Usage

```bash
bash scripts/docker-vm.sh
```

## Idempotency

- Skips ISO download if already present
- Skips VM creation if VM ID already exists
- Skips Docker install if already running inside the VM

## Notes

- Use a VM instead of LXC when you need **full isolation** or **GPU passthrough** for Docker containers.
- LXC is lighter and faster — use `docker-host-ct.sh` unless you need VM-level isolation.
- The Debian installer requires console interaction. After the OS is installed, the script installs Docker via SSH.
- Follow up with `docker-config-vm.sh` to configure networks and directories.
