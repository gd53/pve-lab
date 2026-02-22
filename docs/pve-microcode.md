# pve-microcode.sh

## Purpose

Install CPU microcode updates for Intel or AMD processors.

## What It Does

- Detects the CPU vendor (Intel or AMD)
- Installs the appropriate microcode package (`intel-ucode` or `amd64-microcode`)
- Verifies the microcode is loaded

## Config Needed

None. Auto-detects CPU vendor.

## How to Run

```bash
bash scripts/pve-microcode.sh
```

## Notes

- **Reboot required** after installation for the microcode to load.
- Microcode patches fix CPU bugs and security vulnerabilities (Spectre, Meltdown, etc.).
- Verify after reboot with `dmesg | grep microcode`.
- Idempotent — safe to rerun. Skips if already installed.
