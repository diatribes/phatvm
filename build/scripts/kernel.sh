#!/bin/sh

mkdir -p "${CACHEPATH}"
cd "${CACHEPATH}"
if [ ! -d "linux-${KERNELVER}" ]; then
    curl -o "linux-${KERNELVER}.tar.xz" "https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-${KERNELVER}.tar.xz"
    tar xvf "linux-${KERNELVER}.tar.xz"
fi
cd "linux-${KERNELVER}"
cp "${KERNELCONFIGPATH}" .config
make -j$(nproc) && cp arch/x86/boot/bzImage "${OUTPUTPATH}/${CURRENTKERNELFILENAME}"
