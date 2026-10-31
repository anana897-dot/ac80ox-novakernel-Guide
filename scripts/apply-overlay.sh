#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 /path/to/android_kernel_archos_oxygen" >&2
    exit 2
fi

repo_root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
kernel_tree=$(cd "$1" && pwd)

if [[ ! -f "$kernel_tree/Makefile" || ! -d "$kernel_tree/arch/arm64/configs" ]]; then
    echo "Not a Linux kernel source tree: $kernel_tree" >&2
    exit 1
fi

cp -a "$repo_root/kernel-overlay/." "$kernel_tree/"
echo "Applied AC80OX overlay to $kernel_tree"
