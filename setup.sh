#!/bin/bash

wget https://github.com/manjaro-arm/rpi4-images/releases/download/22.08/Manjaro-ARM-minimal-rpi4-22.08.img.xz
xz -d Manjaro-ARM-minimal-rpi4-22.08.img.xz --verbose
qemu-img resize Manjaro-ARM-minimal-rpi4-22.08.img 4G
