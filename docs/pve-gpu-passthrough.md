# pve-gpu-passthrough.sh

## Purpose

Configure GPU passthrough via IOMMU and VFIO for use in virtual machines.

## What This Script Does

1. **Detect CPU vendor** — determines Intel or AMD for correct IOMMU parameter
2. **Enable IOMMU** — adds `intel_iommu=on` or `amd_iommu=on` to GRUB
3. **Load VFIO modules** — adds `vfio`, `vfio_iommu_type1`, `vfio_pci`, `vfio_virqfd` to initramfs
4. **Blacklist GPU drivers** — prevents the host from claiming the GPU (nouveau, nvidia, radeon, amdgpu)
5. **Bind GPU to VFIO** — assigns the GPU to VFIO using the configured PCI device IDs
6. **Update initramfs** — rebuilds initramfs with the new module configuration

## Required Config (`node.env`)

| Variable | Required | Example | Description |
|----------|----------|---------|-------------|
| GPU_DEVICE_IDS | **Yes** | `10de:1b80,10de:10f0` | PCI vendor:device IDs for GPU + audio |
| GPU_BLACKLIST | **Yes** | `nouveau,nvidia` | Drivers to blacklist (comma-separated) |

## Usage

```bash
bash scripts/pve-gpu-passthrough.sh
```

## Idempotency

- Skips IOMMU if already enabled in GRUB
- Skips VFIO modules if already loaded
- Skips blacklist if drivers already blocked

## Notes

- **Requires IOMMU-capable hardware** (VT-d for Intel, AMD-Vi for AMD). Check BIOS settings.
- **Reboot required** after running.
- Find your GPU's PCI IDs with `lspci -nn | grep -i vga` (and the associated audio device).
- Verify IOMMU groups after reboot with `find /sys/kernel/iommu_groups/ -type l`.
- The host will lose access to the GPU after passthrough. Use a second GPU or headless console.
- This script prepares the host. You still need to add the PCI device to a VM in the Proxmox web UI.
