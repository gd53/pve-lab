# pve-ssh-harden.sh

## Purpose

Harden SSH access on the Proxmox host.

## What It Does

- Adds the configured public key to `/root/.ssh/authorized_keys`
- Disables root password authentication (`PermitRootLogin prohibit-password`)
- Disables password authentication entirely (`PasswordAuthentication no`)
- Optionally changes the SSH port
- Restarts the `sshd` service

## Config Needed

| Variable | Example | Description |
|----------|---------|-------------|
| SSH_PUBKEY | ssh-ed25519 AAAA... | Your public SSH key |
| SSH_PORT | 22 | SSH port (default: 22) |

## How to Run

```bash
bash scripts/pve-ssh-harden.sh
```

## Notes

- **Test your SSH key login before running this script.** If your key is not set up correctly, you will be locked out.
- If you change the SSH port, update your SSH client config and firewall rules accordingly.
- Run `pve-firewall-setup.sh` after this to ensure the firewall allows the configured SSH port.
- Idempotent — safe to rerun.
