#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 3 ]]; then
    echo "Usage: $0 /path/to/kernel-tree /path/to/output /path/to/ndk-toolchain-bin" >&2
    exit 2
fi

kernel_tree=$(cd "$1" && pwd)
out_dir=$(mkdir -p "$2" && cd "$2" && pwd)
toolchain_bin=$(cd "$3" && pwd)
cross_prefix="$toolchain_bin/aarch64-linux-android-"

for tool in "${cross_prefix}gcc" "${cross_prefix}ld" "${cross_prefix}as"; do
    if [[ ! -x "$tool" ]]; then
        echo "Missing executable: $tool" >&2
        exit 1
    fi
done

if [[ ! -r /lib/firmware/rt2870.bin ]]; then
    echo "Missing /lib/firmware/rt2870.bin; obtain the firmware and review its license." >&2
    exit 1
fi

make -C "$kernel_tree" O="$out_dir" ARCH=arm64 \
    CROSS_COMPILE="$cross_prefix" HOSTCFLAGS=-fcommon ac80ox_defconfig
make -C "$kernel_tree" O="$out_dir" ARCH=arm64 \
    CROSS_COMPILE="$cross_prefix" HOSTCFLAGS=-fcommon olddefconfig
make -C "$kernel_tree" O="$out_dir" ARCH=arm64 \
    CROSS_COMPILE="$cross_prefix" HOSTCFLAGS=-fcommon \
    -j"$(nproc)" Image.gz-dtb

image="$out_dir/arch/arm64/boot/Image.gz-dtb"
if [[ ! -s "$image" ]]; then
    echo "Kernel build did not produce $image" >&2
    exit 1
fi

sha256sum "$image"
