#!/bin/sh
. ./config.sh

qemu-system-x86_64 \
    -display gtk,gl=on \
    -no-reboot \
    -m ${RUNMEM} \
    -kernel "${OUTPUTPATH}"/bzImage \
    -device virtio-vga \
    -cpu host \
    -enable-kvm \
    -serial mon:stdio \
    -append "console=ttyS0 panic=-1 vga=0x34B" \
    -initrd "${OUTPUTPATH}"/rootfs.cpio \
    -nic user,model=virtio-net-pci \
    -virtfs local,path=${INPUTPATH},mount_tag=host0,security_model=none,id=host0 \
    -virtfs local,path=${OUTPUTPATH},mount_tag=host1,security_model=none,id=host1

    #-no-user-config \
    #-nodefaults \
