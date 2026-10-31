# Build instructions

These steps reproduce the AC80OX kernel build using the upstream source plus
the overlay in this repository. They do not package or flash an Android boot
image.

## Requirements

- Linux x86_64 host with `make`, `bc`, `bison`, `flex`, `perl`, `python`,
  `openssl` development headers, and standard build tools.
- Android NDK r14b AArch64 GCC 4.9 toolchain. Do not commit the toolchain.
- The `rt2870.bin` firmware file available at `/lib/firmware/rt2870.bin`, as
  configured in the defconfig. Check its redistribution terms before including
  it in any public release.
- Several gigabytes of free disk space for the kernel source and build output.

## Prepare source

```sh
git clone https://github.com/carlitros900/android_kernel_archos_oxygen.git \
  android_kernel_archos_oxygen
cd android_kernel_archos_oxygen
git checkout b49c639cc6c3821683bbae8f966939d0b10de6d3
```

From the root of this project, apply the AC80OX overlay to that fresh checkout:

```sh
./scripts/apply-overlay.sh /path/to/android_kernel_archos_oxygen
```

## Build

```sh
TOOLCHAIN_BIN=/path/to/android-ndk-r14b/toolchains/aarch64-linux-android-4.9/prebuilt/linux-x86_64/bin
OUT=/path/to/android_kernel_archos_oxygen/out-ac80ox
./scripts/build-kernel.sh /path/to/android_kernel_archos_oxygen "$OUT" "$TOOLCHAIN_BIN"
```

The expected output is `out-ac80ox/arch/arm64/boot/Image.gz-dtb`. The historical
kernel #39 artifact has SHA-256
`99903487d67d7ad09d67567ec2cfbadd3f1d34b065e3b6f2b5cfe61c3b75643d`.
Build output can differ if the compiler, host tools, source checkout, or
firmware differs.

The build uses `HOSTCFLAGS=-fcommon` because this legacy kernel's host-side DTC
code otherwise hits a multiple-definition error with newer host compilers.
The target compiler is GCC 4.9 from NDK r14b.

## Relevant configuration

The tested configuration selects AC80OX, the SL008 panel, portrait dimensions,
the AC80OX GSL profile, RT2800 USB RT53xx support, embedded `rt2870.bin`, and
dm-crypt/device-mapper:

```text
CONFIG_ARCH_MTK_PROJECT="ac80ox"
CONFIG_CUSTOM_KERNEL_LCM="SL008PN21D1019_A00_MIPI"
CONFIG_LCM_WIDTH="1200"
CONFIG_LCM_HEIGHT="1920"
CONFIG_MTK_GSLX680_8011A_8INCH_1280x800_20160617=y
CONFIG_RT2800USB=y
CONFIG_RT2800USB_RT53XX=y
CONFIG_DM_CRYPT=y
CONFIG_BLK_DEV_DM=y
```

`config/kernel39.config` records the generated configuration used for the
tested kernel; `config/ac80ox_defconfig` is the project defconfig. Review the
generated `.config` after `olddefconfig`, especially firmware and board options.
