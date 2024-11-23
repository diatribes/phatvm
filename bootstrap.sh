#!/bin/sh
set -e
# Source config.sh
. ./config.sh

# Restore the cached values if they were set
if [ -n "$UPINEVM_OUTPUTPATH" ]; then
    OUTPUTPATH="$UPINEVM_OUTPUTPATH"
fi

if [ -n "$UPINEVM_CACHEPATH" ]; then
    CACHEPATH="$UPINEVM_CACHEPATH"
fi

: "${OUTPUTPATH:?OUTPUTPATH must be set}"
: "${CACHEPATH:?CACHEPATH must be set}"

mkdir -pv "${CACHEPATH}"
mkdir -pv "${OUTPUTPATH}"

./build/scripts/sdhcp.sh
./build/scripts/dumb-init.sh
./build/scripts/carl-exit.sh
sudo -E ./build/scripts/rootfs.sh

if [ ! -f "${OUTPUTPATH}"/bzImage ]; then
    echo "bzImage: not found, building..."
    export CURRENTKERNELFILENAME="bzImage"
    export CURRENTKERNELCONFIG=${KERNELCONFIG}
    ./build/scripts/kernel.sh
fi

