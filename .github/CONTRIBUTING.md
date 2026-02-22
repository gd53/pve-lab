# Contributing

## Commit Conventions

Use [Conventional Commits](https://www.conventionalcommits.org/):

- `feat:` — new script or feature
- `docs:` — documentation changes
- `fix:` — bug fix
- `chore:` — maintenance (CI, config, deps)

## Code Quality

- All shell scripts must pass [ShellCheck](https://www.shellcheck.net/).
- Use `lib/common.sh` helpers for logging, config, and idempotency.
- Scripts must be idempotent — safe to run multiple times.

## File Organization

- Every script in `scripts/` must have a matching doc in `docs/`.
- `docs/` contains **only** script documentation (1:1 with scripts).
- Sequences, guides, and other docs go in `reference/`.
- Compose files go in `stacks/<service>/`.

## Pull Requests

- One logical change per PR.
- Reference the relevant build sequence entry if applicable.
- Ensure ShellCheck passes before submitting.
