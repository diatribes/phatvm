#!/bin/sh
export HOME=/root
export PATH=$PATH:/sbin

# mount /dev/ /proc /sys
mount -t devtmpfs devtmpfs /dev
mount -t proc none /proc
mount -t sysfs none /sys

echo
echo $(uname -a)
echo



# dhcp
ifconfig eth0 up
sdhcp
echo

# mount input
mkdir -pv /mnt/input
mount -t 9p -o trans=virtio host0 /mnt/input

# mount output
mkdir -pv /mnt/output
mount -t 9p -o trans=virtio host1 /mnt/output

# 1st boot, install packages and write cpio
# 2nd+ boot, start shell
if [ -f "/etc/firstboot.sh" ]; then

    chmod +x /etc/firstboot.sh
    /etc/firstboot.sh
else
    rc-status
    touch /run/openrc/softlevel
    rc-service udev restart
    rc-service dbus restart
    cd
    /bin/sh
fi

echo "carl signing off"
/carl-exit

