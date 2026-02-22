# pve-firewall-setup.sh

## Purpose

Configure the Proxmox firewall and install fail2ban for brute-force protection.

## What It Does

### Proxmox Firewall

- Enables the firewall at the datacenter level
- Enables the firewall on the node
- Allows SSH (configurable port)
- Allows Proxmox web UI (port 8006)
- Allows ICMP (ping)
- Default policy: drop incoming, accept outgoing

### fail2ban

- Installs fail2ban
- Configures an SSH jail (bans IPs after repeated failed logins)
- Configures a Proxmox web UI jail (protects the web login)
- Enables and starts the fail2ban service

## Config Needed

| Variable | Example | Description |
|----------|---------|-------------|
| SSH_PORT | 22 | SSH port (must match pve-ssh-harden) |

## How to Run

```bash
bash scripts/pve-firewall-setup.sh
```

## Notes

- Run **after** `pve-ssh-harden.sh` so the firewall allows the correct SSH port.
- Verify you can SSH in before enabling the firewall. Test in a second terminal.
- Proxmox firewall is managed via `/etc/pve/firewall/` — these are cluster-aware config files.
- fail2ban logs to `/var/log/fail2ban.log`. Check banned IPs with `fail2ban-client status sshd`.
- Idempotent — safe to rerun.
