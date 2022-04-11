
ISO=/home/wjb/Downloads/alpine/alpine-standard-3.15.4-aarch64.iso
HDA=/home/wjb/Downloads/alpine/alpine.qcow2

# qemu-system-aarch64 -M virt -m 512M -cpu cortex-a57 -kernel $KERNEL -initrd $INITRID -hda $HDA -append "console=ttyAMA0 ip=dhcp alpine_repo=https://mirrors.ustc.edu.cn/alpine/edge/main/" \
#  -nographic

qemu-system-aarch64 -M virt -m 512 -nic user -boot d -cdrom $ISO -hda $HDA
# qemu -m 512 -nic user -hda alpine.qcow2
