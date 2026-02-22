# pve-lab

One-script-per-task Proxmox homelab automation. Inspired by [community-scripts/ProxmoxVE](https://github.com/community-scripts/ProxmoxVE), extended into Docker deployments.

## Quickstart

```bash
cp node.env.template node.env
# Fill in your values
bash scripts/<script-name>.sh
```

## Structure

```
docs/           Script documentation (1:1 with scripts/)
scripts/        Infrastructure and network scripts
scripts/docker/ Container deployment scripts
lib/            Shared helpers (common.sh)
stacks/         Docker compose files
templates/      Ventoy answer.toml and other templates
reference/      Build sequences, guides, credits
tests/          Test scaffolding
```

- `docs/` contains **only** documentation files that have a matching script in `scripts/`.
- Build sequences, guides, and other standalone docs live in [`reference/`](reference/).

## Principles

- **Idempotent** — scripts check target state before acting, safe to rerun.
- **Docs before code** — doc defines what the script does, script implements it.
- **Git-first** — conventional commits, semver tags, everything tracked.
- **Stable** — minimize connectivity downtime, flag console-only steps.

## Configuration

Flat `KEY="value"` format. Copy `node.env.template` to `node.env` and fill in your values. For multi-node setups, use `node-<name>.env`.

## Build Sequences

- [Single Server](reference/sequence-single.md) — monolithic single-node setup (start here)

## License

[MIT](LICENSE)
