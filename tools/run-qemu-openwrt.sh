#!/bin/sh

IMAGE=/home/wjb/Downloads/openwrt/openwrt-19.07.9-armvirt-64-Image-initramfs
LAN=enp125s0f0
HDA=/home/wjb/Downloads/openwrt/openwrt-19.07.9-armvirt-64-root.ext4

# create tap interface which will be connected to OpenWrt LAN NIC
# ip tuntap add mode tap $LAN
# ip link set dev $LAN up
# configure interface with static ip to avoid overlapping routes
# ip addr add 192.168.1.101/24 dev $LAN

qemu-system-aarch64 \
  -M virt -nographic -m 1024m \
  -cpu cortex-a53 -smp 4 \
  # -device virtio-net-pci,netdev=lan \
  # -netdev tap,id=lan,ifname=$LAN,script=no,downscript=no \
  # -device virtio-net-pci,netdev=wan \
  # -netdev user,id=wan \
  -kernel $IMAGE -drive file=$HDA -append 'root=/dev/vda console=ttyS0'

# cleanup. delete tap interface created earlier
# ip addr flush dev $LAN
# ip link set dev $LAN down
# ip tuntap del mode tap dev $LAN
