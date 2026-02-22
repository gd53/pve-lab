<div align="center">

# pve-lab

**Build your Proxmox homelab from scratch, one script at a time.**

From bare metal to running services — Proxmox host setup, OPNsense firewall,
NAS storage, backups, Docker containers, and everything in between.

[![License: MIT](https://img.shields.io/github/license/gd53/pve-lab?style=flat-square)](LICENSE)
[![ShellCheck](https://img.shields.io/github/actions/workflow/status/gd53/pve-lab/lint.yml?label=ShellCheck&style=flat-square)](https://github.com/gd53/pve-lab/actions)
[![Shell](https://img.shields.io/badge/Shell-Bash-4EAA25?style=flat-square&logo=gnubash&logoColor=white)]()
[![Proxmox](https://img.shields.io/badge/Proxmox-VE%209.1+-E57000?style=flat-square&logo=proxmox&logoColor=white)]()
[![Docker](https://img.shields.io/badge/Docker-ready-2496ED?style=flat-square&logo=docker&logoColor=white)]()
[![Maintained](https://img.shields.io/badge/Maintained-yes-brightgreen?style=flat-square)]()
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen?style=flat-square)]()

</div>

---

**pve-lab** is a collection of idempotent shell scripts that automate a
Proxmox VE homelab build. Each script does one thing, has its own documentation,
and is safe to rerun. Designed for beginners who want to understand every step.

> Tested on Proxmox VE 9.1+

## What You Get

| Section | What's automated |
|---------|-----------------|
| Host Setup | Repos, SSH, firewall, tuning, microcode, GPU passthrough |
| Networking | OPNsense firewall/router VM, VLANs |
| Storage | OpenMediaVault NAS with disk passthrough |
| Backups | Proxmox Backup Server with dedup and retention |
| DNS | Pi-hole ad-blocking |
| Docker | LXC host, reverse proxy, services |

## Quickstart

```bash
cp node.env.template node.env
# Fill in your values
bash scripts/<script-name>.sh
```

## How It Works

Docs-first workflow: every script has a matching doc in `docs/` that explains
what it does before you run it. Read the doc, fill in your config, run the script.

1. Copy and fill in `node.env`
2. Follow the [build sequence](reference/sequence-single.md) in order
3. Each script checks state before acting — safe to rerun if interrupted

## Build Sequences

- [Single Server](reference/sequence-single.md) — single-NIC, no firewall VM (start here)
- [Edge Firewall](reference/sequence-edge.md) — dual-NIC with OPNsense, Docker, the works

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

## Reference

- [Credits](reference/CREDITS.md)
- [Changelog](reference/CHANGELOG.md)
- [Contributing](.github/CONTRIBUTING.md)
- [Future Scripts](reference/future-scripts.md)

## License

[MIT](LICENSE)
