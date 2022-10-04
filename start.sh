#!/bin/bash

IMAGE=$1

LOOP=$(udisksctl loop-setup -f $IMAGE | grep -oE '[^ ]+$' | sed 's/.$//')
BOOT=$(udisksctl mount -b ${LOOP}p1 | grep -oE '[^ ]+$')
ROOT=$(udisksctl mount -b ${LOOP}p2 | grep -oE '[^ ]+$')

qemu-system-aarch64 -M raspi3b \
    -kernel $BOOT/kernel8.img -dtb $BOOT/bcm2710-rpi-3-b-plus.dtb -sd $IMAGE \
    -append "root=/dev/mmcblk0p2 rootwait console=ttyAMA0" \
    -usb -device usb-net,netdev=u1 -netdev user,id=u1,hostfwd=tcp::8888-:22 -nographic

udisksctl unmount -b ${LOOP}p1
udisksctl unmount -b ${LOOP}p2
udisksctl loop-delete -b $LOOP
