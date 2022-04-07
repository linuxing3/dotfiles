
ISO=/home/wjb/Downloads/alpine/
KERNEL=/home/wjb/Downloads/alpine/boot/vmlinuz-vanilla
INITRID=/home/wjb/Downloads/alpine/boot/initramfs-vanilla

/home/wjb/Downloads/qemu-5.0.0/build/aarch64-softmmu/qemu-system-aarch64 -M virt -m 512M -cpu cortex-a57 -kernel $KERNEL -initrd $INITRID -append "console=ttyAMA0 ip=dhcp alpine_repo=https://mirrors.ustc.edu.cn/alpine/edge/main/" \
  -nographic

# qemu-m 512 -nic user -boot d -cdrom alpine-standard-3.10.2-x86_64.iso -hda alpine.qcow2 -display gtk -enable-kvm
# qemu -m 512 -nic user -hda alpine.qcow2