#!/usr/bin/env bash
# common.sh — shared helpers sourced by every script
set -euo pipefail

# ── Logging ──────────────────────────────────────────────────────────────────

log_info()  { printf '[INFO]  %s\n' "$*"; }
log_warn()  { printf '[WARN]  %s\n' "$*" >&2; }
log_error() { printf '[ERROR] %s\n' "$*" >&2; }
log_step()  { printf '\n══ %s ══\n' "$*"; }

# ── Config ───────────────────────────────────────────────────────────────────

load_config() {
  local config="${1:-node.env}"
  if [[ ! -f "$config" ]]; then
    log_error "Config file not found: $config"
    return 1
  fi
  # shellcheck source=/dev/null
  source "$config"
}

require_vars() {
  local missing=()
  for var in "$@"; do
    if [[ -z "${!var:-}" ]]; then
      missing+=("$var")
    fi
  done
  if [[ ${#missing[@]} -gt 0 ]]; then
    log_error "Missing required variables: ${missing[*]}"
    return 1
  fi
}

# ── Idempotency ──────────────────────────────────────────────────────────────

line_in_file() {
  local line="$1" file="$2"
  grep -qxF "$line" "$file" 2>/dev/null
}

ensure_line() {
  local line="$1" file="$2"
  if ! line_in_file "$line" "$file"; then
    printf '%s\n' "$line" >> "$file"
    log_info "Added to $file: $line"
  fi
}

cmd_exists() {
  command -v "$1" &>/dev/null
}

service_active() {
  systemctl is-active --quiet "$1" 2>/dev/null
}

# ── Proxmox ──────────────────────────────────────────────────────────────────

ct_exists() {
  pct status "$1" &>/dev/null
}

vm_exists() {
  qm status "$1" &>/dev/null
}

# ── Network ──────────────────────────────────────────────────────────────────

detect_nic() {
  ip -o link show | awk -F': ' '/state UP/ && !/lo|veth|docker|br|tap|fwbr|fwln|fwpr/ {print $2; exit}'
}

bridge_exists() {
  ip link show "$1" &>/dev/null
}
