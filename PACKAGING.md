# Boot-image packaging notes

The local Android test image was built from the kernel #39 payload and a
stock-derived Android ramdisk. The stock vendor package is wrapped and signed;
the repackaged image is an unsigned raw Android boot image. Changing the kernel
means the vendor signature cannot be retained without the signing key.

The stock inner boot header was Android boot header v0 with 2048-byte pages,
kernel address `0x40080000`, ramdisk address `0x44000000`, second address
`0x40f00000`, tags address `0x4e000000`, board string `1476149884`, and
cmdline `bootopt=64S3,32N2,64N2`. The signed vendor wrapper began with `BFBF`;
the inner `ANDROID!` header began at byte offset 16,448.

Do not include stock firmware, ramdisks, or the recovery image in a public
release unless redistribution rights for every component are established.
Users reproducing the package should obtain the matching firmware through an
authorized source, preserve its original copy, and use the exact AC80OX board
metadata. Do not substitute AC101BOX/AC70OX files.

The stock ramdisk uses `forceencrypt` for `/data`. The locally tested
`boot_nethunter_noencrypt-touchfix.img` changed that option to `encryptable`;
this changes boot-time encryption policy only and does not decrypt existing
data. The modified image is not OEM-signed. These notes intentionally do not
provide instructions for flashing a partition.
