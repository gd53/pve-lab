# pve-ssh-harden.sh

## Purpose

Harden SSH access on the Proxmox host.

## What This Script Does

1. **Add public key** — adds the configured SSH public key to `/root/.ssh/authorized_keys`
2. **Disable root password login** — sets `PermitRootLogin prohibit-password` in sshd config
3. **Disable password auth** — sets `PasswordAuthentication no` (key-only access)
4. **Change SSH port** — optionally changes the listening port (if configured)
5. **Restart SSH** — restarts `sshd` to apply changes

## Required Config (`node.env`)

| Variable | Required | Example | Description |
|----------|----------|---------|-------------|
| SSH_PUBKEY | **Yes** | `ssh-ed25519 AAAA...` | Your public SSH key |
| SSH_PORT | No | `22` | SSH port (default: 22) |

## Usage

```bash
bash scripts/pve-ssh-harden.sh
```

## Idempotency

- Skips key addition if already in `authorized_keys`
- Skips sshd config changes if already set

## Notes

- **Test your SSH key login before running this script.** If your key is not set up correctly, you will be locked out.
- If you change the SSH port, update your SSH client config and firewall rules accordingly.
- Run `pve-firewall-setup.sh` after this to ensure the firewall allows the configured SSH port.
