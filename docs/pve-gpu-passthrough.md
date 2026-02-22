# pve-gpu-passthrough.sh

## Purpose

Configure GPU passthrough via IOMMU and VFIO for use in virtual machines.

## What This Script Does

1. **Detect CPU vendor** — determines Intel or AMD for correct IOMMU parameter
2. **Enable IOMMU** — adds `intel_iommu=on` or `amd_iommu=on` to GRUB
3. **Load VFIO modules** — adds `vfio`, `vfio_iommu_type1`, `vfio_pci` to `/etc/modules`
4. **Blacklist GPU driver** — auto-determines driver to block based on GPU_TYPE (nouveau/nvidia for Nvidia, amdgpu for AMD)
5. **Bind GPU to VFIO** — optionally locks a specific PCI device to the `vfio-pci` driver
6. **Update initramfs** — rebuilds initramfs with the new module configuration

## Required Config (`node.env`)

| Variable | Required | Example | Description |
|----------|----------|---------|-------------|
| GPU_TYPE | **Yes** | `nvidia` | GPU vendor: `nvidia` or `amd` (blank to skip) |
| GPU_PCI_ID | No | `01:00.0` | PCI address for VFIO binding (auto-detected if blank) |

## Usage

```bash
bash scripts/pve-gpu-passthrough.sh
```

## Idempotency

- Skips IOMMU if already enabled in GRUB
- Skips VFIO modules if already loaded
- Skips blacklist if drivers already blocked

## Notes

- If `GPU_TYPE` is blank, the script exits immediately with no changes.
- **Requires IOMMU-capable hardware** (VT-d for Intel, AMD-Vi for AMD). Must be enabled in BIOS.
- **Reboot required** after running.
- Find your GPU PCI address with `lspci -nn | grep -i vga`.
- Verify after reboot: `dmesg | grep -i iommu` and `lspci -nnk -s <GPU_PCI_ID>`.
- The host will lose access to the GPU after passthrough. Use a second GPU or headless console.
- This script prepares the host. You still need to add the PCI device to a VM in the Proxmox web UI.
