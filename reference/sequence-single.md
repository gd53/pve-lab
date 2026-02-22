# Single Server Build Sequence

Monolithic single-node setup. One Proxmox host running everything — start here.

Scripts run via SSH on the node, in order. Each entry links to its doc in `docs/`.

| # | Script | Doc | Description |
|---|--------|-----|-------------|
| | | | *Scripts will be added as they are written.* |

## Notes

- Copy `node.env.template` to `node.env` and fill in values before running any scripts.
- Scripts are idempotent — safe to rerun if interrupted.
- Steps requiring console access (no SSH) will be marked.
