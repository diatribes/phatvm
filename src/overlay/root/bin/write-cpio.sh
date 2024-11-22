#!/bin/sh
set -e

if [ -d /mnt/output ]; then
    /bin/busybox find / ! -path "/run/*" ! -path "/mnt/*" ! -path "/sys/*" ! -path "/proc/*" ! -path "/dev/*" ! -path "/etc/firstboot" ! -path "/etc/firstboot.sh" \
     | cpio -o -H newc > /mnt/output/rootfs-new.cpio
else
    echo "no /mnt/output directory found"
    exit 1
fi

