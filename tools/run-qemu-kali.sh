
ISO=/home/wjb/Downloads/kali/kali-linux-2022.1-installer-arm64.iso
HDA=/home/wjb/Downloads/kali/kali.qcow2

/home/wjb/Downloads/qemu-5.0.0/build/aarch64-softmmu/qemu-system-aarch64 -M virt -m 1024M -cpu cortex-a57 -boot d -cdrom $ISO -hda kali.qcow2 -vnc :1
# qemu -m 512 -nic user -hda alpine.qcow2