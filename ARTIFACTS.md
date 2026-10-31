# Local artifacts and verification

Binary images are staged under `artifacts/local/` for the user's local
reference. They are excluded from Git by `.gitignore`; their presence here
does not grant permission to redistribute them. `artifacts/SHA256SUMS` records
their SHA-256 hashes.

The local `Image.gz` contains build-host path strings because the kernel was
built with debug information enabled. It is ignored by Git, but do not upload
it, force-add it, or include it in a ZIP/public archive. The other staged
firmware-derived images are likewise local-only pending rights review.

| File | Size | SHA-256 | Purpose and verification |
|---|---:|---|---|
| `Image.gz` | 6,382,589 bytes | `0a212bfa374155bada6cbb5ffe7923a1a735351513ec67d600ef10ff53fc7eea` | Compressed kernel without appended DTB. |
| `Image.gz-dtb` | 6,438,669 bytes | `99903487d67d7ad09d67567ec2cfbadd3f1d34b065e3b6f2b5cfe61c3b75643d` | Kernel plus appended AC80OX DTB, kernel #39. |
| `boot_nethunter_noencrypt-touchfix.img` | 8,333,312 bytes | `6ed183de60fd5f1e297d6e6c87ee79d70ea2a99518dfbdfb9d27e607ba26b8bf` | Temporarily boot-tested Android image; user confirmed touch works. `/data` is configured `encryptable`, not decrypted. |
| `recovery-ac80ox-touch-sd-working.img` | 10,795,008 bytes | `f591a785f8097eba5ceb0c9d1651f3d2ad5bf3200468559e6a81e4a283406b32` | TWRP 3.0.2-0, stock kernel #7; user-confirmed working display, touch, and SD. |

These are device-specific images. Preserve the stock firmware and recovery
unchanged. A repackaged boot image is unsigned, and an image derived from stock
firmware may include components that cannot be redistributed. Keep local-only
images out of a public release unless the rights for every included component
are established.

The RT5370/RT53xx driver configuration is present, but adapter operation over
the tablet's OTG port has not been hardware-tested. Do not advertise Wi-Fi
functionality as verified.

The original stock boot ramdisk is not included. The no-encryption image
changes only the `/data` fstab mode from `forceencrypt` to `encryptable`; it
does not decrypt data and does not preserve the original vendor signature.
