# Device and test notes

## Device

- Archos 80 Oxygen, board name AC80OX, MediaTek MT8163.
- Android 6.0, arm64.
- Panel configuration: SL008 MIPI, 1200x1920, physical rotation 0.
- Kernel version tested: `3.18.22-by-Novatillo #39`.

## Touchscreen

The user confirmed the Android touch mapping works with the kernel #39
no-encryption test image. Sampled event coordinates were:

| Physical location | Reported coordinate |
|---|---:|
| Center | `(583, 924)` |
| Top-left | `(30, 48)` |
| Top-right | `(1173, 40)` |
| Bottom-left | `(65, 1918)` |
| Bottom-right | `(1175, 1902)` |

The GSL driver clamps raw coordinates to X 0-1920 and Y 0-1200, then scales
them to the Android input ranges. It also releases an active touch on suspend.
These are device-specific settings, not generic GSL defaults.

## Recovery

The staged TWRP image is `recovery-ac80ox-touch-sd-working.img`, SHA-256
`f591a785f8097eba5ceb0c9d1651f3d2ad5bf3200468559e6a81e4a283406b32`.
It was temporarily booted and confirmed to have working display, touch, and SD
access. It runs TWRP 3.0.2-0 with stock kernel `3.18.22 #7`.

## Limitations

- RT5370 hardware enumeration and Wi-Fi operation over tablet OTG are not
  confirmed.
- Negative/inverted display colors after sleep/wake have not been diagnosed.
- The no-encryption image does not decrypt already-encrypted user data.
- The images were tested on this one tablet; no claim is made for other
  revisions or panels.
- Keep known-good stock/recovery images and user data backups before device
  experiments. No partition flashing is part of these instructions.
