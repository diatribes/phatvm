#!/bin/sh
set -e

# this script is in alvm, and in built images it is filtered out in write-cpio.sh

if [ -f /root/bin/write-cpio.sh ]; then
    # update and upgrade
    apk upgrade --no-cache

    # install packages
    apk add --no-cache alpine-base alpine-conf icewm xterm rxvt-unicode udev dbus chromium
    setup-xorg-base || true
    rc-status || true
    #apk add --no-cache `cat /mnt/input/packages.conf`

    echo 'icewm-session' > /root/.xinitrc

    # write cpio and exit
    echo WRITING CPIO...
    chmod +x /root/bin/write-cpio.sh
    /root/bin/write-cpio.sh
else
    echo "firstboot: no /root/bin/write-cpio.sh, exiting"
    find / ! -path "/mnt/*" ! -path "/sys/*" ! -path "/proc/*" ! -path "/dev/*" ! -path "/etc/firstboot" ! -path "/etc/firstboot.sh"
    find / -name firstboot
    find / -name firstboot.sh
    echo "this case is an error"
    exit 1
fi
