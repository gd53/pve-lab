# pve-network-migrate.sh

## Purpose

Migrate Proxmox management from `vmbr0` (temp DHCP IP) to `vmbr1` (final static IP behind OPNsense).

## When to Run

```
Install → Host Setup → Bridge → OPNsense → Config OPNsense → Cable switch → THIS SCRIPT
                                                                                ↓
                                                          Proxmox on final management IP
```

## What This Script Does

1. **Verify OPNsense is routing** — confirms internet works through the switch
2. **Add management IP to vmbr1** — assigns the final static IP to the OPNsense LAN bridge
3. **Remove IP from vmbr0** — converts vmbr0 to `inet manual` (pure WAN passthrough)
4. **Update gateway** — points the default route to OPNsense LAN IP
5. **Update DNS and hosts** — sets resolver and hostname mapping
6. **Reload networking** — applies all changes

## Required Config (`node.env`)

| Variable | Required | Example | Description |
|----------|----------|---------|-------------|
| NODE_IP | **Yes** | `10.0.10.11` | Final management IP |
| GATEWAY | **Yes** | `10.0.10.1` | OPNsense LAN IP |
| SUBNET_MASK | **Yes** | `24` | CIDR prefix |
| DNS_SERVER | No | `10.0.10.1` | DNS server (default: gateway) |

## Usage

```bash
# Run from the LOCAL CONSOLE — not SSH!
bash scripts/pve-network-migrate.sh
```

## Idempotency

- Skips if vmbr1 already has the configured NODE_IP

## Notes

- **Console-only** — run from the Proxmox local console (keyboard/monitor or IPMI), NOT over SSH. The IP change will disconnect SSH.
- After migration, reconnect from your laptop (on the switch): `ssh root@NODE_IP`.
- `vmbr0` will have **no IP** after this — it's purely a passthrough for OPNsense WAN traffic.
- Run **after** OPNsense is configured, the switch is connected, and your laptop has internet through OPNsense.
