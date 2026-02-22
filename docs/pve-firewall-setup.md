# pve-firewall-setup.sh

## Purpose

Configure the Proxmox firewall and install fail2ban for brute-force protection.

## What This Script Does

1. **Enable datacenter firewall** — turns on the firewall at the datacenter level
2. **Enable node firewall** — turns on the firewall for this node
3. **Allow SSH** — adds a rule for the configured SSH port
4. **Allow web UI** — adds a rule for Proxmox web UI (port 8006)
5. **Allow ICMP** — permits ping for diagnostics
6. **Set default policy** — drop incoming, accept outgoing
7. **Install fail2ban** — installs the fail2ban package
8. **Configure SSH jail** — bans IPs after repeated failed SSH logins
9. **Configure web UI jail** — protects the Proxmox web login from brute force
10. **Start fail2ban** — enables and starts the fail2ban service

## Required Config (`node.env`)

| Variable | Required | Example | Description |
|----------|----------|---------|-------------|
| SSH_PORT | No | `22` | SSH port (must match pve-ssh-harden) |

## Usage

```bash
bash scripts/pve-firewall-setup.sh
```

## Idempotency

- Skips firewall rules if already present
- Skips fail2ban install if already installed
- Skips jail config if already configured

## Notes

- Run **after** `pve-ssh-harden.sh` so the firewall allows the correct SSH port.
- Verify you can SSH in before enabling the firewall. Test in a second terminal.
- Proxmox firewall is managed via `/etc/pve/firewall/` — these are cluster-aware config files.
- fail2ban logs to `/var/log/fail2ban.log`. Check banned IPs with `fail2ban-client status sshd`.
