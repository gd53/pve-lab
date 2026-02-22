# pve-microcode.sh

## Purpose

Install CPU microcode updates for Intel or AMD processors.

## What This Script Does

1. **Detect CPU vendor** — reads `/proc/cpuinfo` to determine Intel or AMD
2. **Install microcode** — installs the appropriate package (`intel-ucode` or `amd64-microcode`)
3. **Verify installation** — confirms the microcode package is installed

## Required Config (`node.env`)

None. Auto-detects CPU vendor.

## Usage

```bash
bash scripts/pve-microcode.sh
```

## Idempotency

- Skips install if microcode package is already installed

## Notes

- **Reboot required** after installation for the microcode to load.
- Microcode patches fix CPU bugs and security vulnerabilities (Spectre, Meltdown, etc.).
- Verify after reboot with `dmesg | grep microcode`.
