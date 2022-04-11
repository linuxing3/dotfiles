
ISO=/home/wjb/Downloads/kali/kali-linux-2022.1-installer-arm64.iso
HDA=/home/wjb/Downloads/kali/kali.qcow2

qemu-system-aarch64 -M virt -m 1024M -cpu cortex-a57 -boot d -cdrom $ISO -hda $HDA -vnc :1
