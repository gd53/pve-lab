# pve-gpu-passthrough.sh

## Purpose

Configure GPU passthrough via IOMMU and VFIO for use in virtual machines.

## What It Does

- Detects CPU vendor and enables IOMMU in GRUB (`intel_iommu=on` or `amd_iommu=on`)
- Loads VFIO kernel modules (`vfio`, `vfio_iommu_type1`, `vfio_pci`, `vfio_virqfd`)
- Blacklists the GPU's native drivers (nouveau, nvidia, radeon, amdgpu)
- Binds the GPU to VFIO using the configured PCI device IDs
- Updates initramfs

## Config Needed

| Variable | Example | Description |
|----------|---------|-------------|
| GPU_DEVICE_IDS | 10de:1b80,10de:10f0 | PCI vendor:device IDs for GPU + audio |
| GPU_BLACKLIST | nouveau,nvidia | Drivers to blacklist (comma-separated) |

## How to Run

```bash
bash scripts/pve-gpu-passthrough.sh
```

## Notes

- **Requires IOMMU-capable hardware** (VT-d for Intel, AMD-Vi for AMD). Check BIOS settings.
- **Reboot required** after running.
- Find your GPU's PCI IDs with `lspci -nn | grep -i vga` (and the associated audio device).
- Verify IOMMU groups after reboot with `find /sys/kernel/iommu_groups/ -type l`.
- The host will lose access to the GPU after passthrough. Use a second GPU or headless console.
- This script prepares the host. You still need to add the PCI device to a VM in the Proxmox web UI.
- Idempotent — safe to rerun.
