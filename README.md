Scripts that will generate a bloated kernel+alpine+xorg rootfs cpio that can be direct booted with qemu.

* cd phatvm
* vi ./build/input/packages.conf
* ./bootstrap.sh
* ./qrun.sh

Generate a new rootfs-new.cpio:
* rm ./build/output/rootfs-new.cpio
* ./bootstrap.sh
