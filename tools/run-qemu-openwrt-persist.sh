#!/bin/sh

IMAGE=/home/wjb/Downloads/openwrt/openwrt-19.07.9-armvirt-64-Image-initramfs
LAN=enp125s0f0
HDA=/home/wjb/Downloads/openwrt/openwrt-19.07.9-armvirt-64-root.ext4

cd /home/wjb/Downloads/openwrt/
qemu --enable-kvm -M virt -nographic -nodefaults \
  -m 1024m \
  -cpu host -smp 2 \
  -kernel $IMAGE -append "root=fe00" \
  -blockdev driver=raw,node-name=hd0,cache.direct=on,file.driver=file,file.filename=$HDA\
  # -device virtio-blk-pci,drive=hd0 \
  # -netdev type=tap,id=nic1,ifname=kvm0,script=no,downscript=no \
  -device virtio-net-pci,disable-legacy=on,disable-modern=off,netdev=nic1,mac=ba:ad:1d:ea:01:02 \
  -device qemu-xhci,id=xhci,p2=8,p3=8 
