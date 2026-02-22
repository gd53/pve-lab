# Future Scripts

Scripts planned for later phases. Not part of the current single-server sequence.

## Containers & VMs

| Script | Description |
|--------|-------------|
| `ct-docker-create.sh` | Create a Debian LXC container for Docker |
| `ct-docker-setup.sh` | Install Docker + Compose inside the LXC |
| `docker/<service>.sh` | One script per Docker service (see docker-catalog.md) |

## Hardware

| Script | Description |
|--------|-------------|
| `pve-coral-passthrough.sh` | Google Coral TPU passthrough for AI/ML workloads |

## Networking

| Script | Description |
|--------|-------------|
| `opn-wireguard.sh` | WireGuard VPN configuration on OPNsense |
| `opn-haproxy.sh` | HAProxy reverse proxy configuration on OPNsense |

## Clustering

| Script | Description |
|--------|-------------|
| `pve-ceph-setup.sh` | Ceph distributed storage for multi-node clusters |
| `pve-cluster-join.sh` | Join a node to an existing Proxmox cluster |

## Customization

| Script | Description |
|--------|-------------|
| `pve-theme.sh` | Console and web UI theme customization |
