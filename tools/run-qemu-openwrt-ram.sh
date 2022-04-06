#!/bin/sh

IMAGE=/home/wjb/Downloads/openwrt/openwrt-19.07.9-armvirt-64-Image-initramfs

qemu \
  -M virt -nographic -m 512 \
  -cpu cortex-a53 -smp 4 \
  -kernel $IMAGE 