# Archos 80 Oxygen (AC80OX) NetHunter kernel

This project collects the AC80OX kernel configuration, device-specific source
overlay, build instructions, and local test-artifact metadata for the Archos 80
Oxygen tablet (MT8163, arm64, Android 6).

## Upstream and attribution

The kernel is based on
[`carlitros900/android_kernel_archos_oxygen`](https://github.com/carlitros900/android_kernel_archos_oxygen),
branch `3.18.22-NovaKernel`, pinned to commit
`b49c639cc6c3821683bbae8f966939d0b10de6d3`. The overlay in `kernel-overlay/`
contains the AC80OX build configuration and project changes captured from the
locally built kernel tree. Preserve upstream and file-level copyright and
license notices when publishing or redistributing it.

The Linux kernel is GPL-2.0-only unless a source file states otherwise; see
`COPYING`. The tree also contains third-party and device-vendor code with
separate notices. Review those notices and provide complete corresponding
source for any binaries distributed.

## What is included

- AC80OX defconfig and a copy of the tested kernel #39 `.config`.
- Source overlay for the AC80OX touchscreen, SL008 panel, build compatibility,
  and RT2800 USB configuration.
- Build script and reproducibility notes.
- Hash manifest for locally staged binaries.

`artifacts/local/` contains local copies of the validated kernel and images.
Those binary files are ignored by Git. In particular, do not publish the
TWRP/recovery or boot images until their embedded vendor, firmware, and
recovery components have been reviewed for redistribution rights. The original
stock-signed firmware was not modified. The local `Image.gz` was built with
kernel debug information and contains build-host path strings; do not attach
or publish that local binary. Do not zip or upload the whole working folder:
publish the Git-eligible source/docs only, after reviewing the staged file
list.

## Current status

- Kernel: Linux `3.18.22-by-Novatillo #39`.
- Touch: the user confirmed the Android touch mapping works with the
  `boot_nethunter_noencrypt-touchfix.img` test image.
- USB Wi-Fi: RT2800 USB and RT53xx support are enabled, and `rt2870.bin` is
  configured as embedded firmware. The adapter has not been verified on the
  tablet's OTG port.
- Encryption: device-mapper and dm-crypt are enabled. The no-encryption boot
  image changes the ramdisk `/data` fstab mode to `encryptable`; it does not
  decrypt existing encrypted data.
- Wake display colors: negative colors after sleep/wake remain unresolved.
- Recovery: the locally staged TWRP 3.0.2-0 image was confirmed to boot with
  working display, touch, and SD access. It uses the stock kernel.

The custom boot image is unsigned. Replacing a kernel invalidates the vendor
signature wrapper; do not describe the repackaged image as OEM-signed. No
flashing instructions are provided here: use a temporary boot/test path and
retain a verified stock recovery route.

## Build

See [`BUILD.md`](BUILD.md). Do not use the generated kernel or images on another
device or board without adapting and testing the device-specific configuration.
