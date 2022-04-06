#!/bin/sh

IMAGE=/home/wjb/Downloads/openwrt/openwrt-19.07.9-armvirt-64-Image
HDA=/home/wjb/Downloads/openwrt/openwrt-19.07.9-armvirt-64-root.ext4

qemu -M virt -m 1024m -kernel $IMAGE -drive file=$HDA,format=raw,if=virtio -no-reboot -nographic -nic user -nic user -cpu cortex-a53 -smp 4 -append root=/dev/vda
