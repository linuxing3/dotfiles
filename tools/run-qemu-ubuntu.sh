BIN=/home/wjb/Downloads/qemu-5.0.0/build/aarch64-softmmu/qemu-system-aarch64
QEMU_EFI=/home/wjb/Downloads/ubuntu/QEMU_EFI.fd 
DRIVE=/home/wjb/Downloads/ubuntu/ubuntu-image.img 
ISO=/home/wjb/Downloads/ubuntu/ubuntu-20.04.4-live-server-arm64.iso

sudo $BIN -M virt-2.12 -smp 4 -m 1G -cpu host -enable-kvm \
    -bios $QEMU_EFI -device ramfb \
    -device qemu-xhci,id=xhci -usb \
    -device usb-kbd -device usb-mouse -device usb-tablet -k en-us \
    -device virtio-blk,drive=system \
    -drive if=none,id=system,format=raw,media=disk,file=$DRIVE \
    -device usb-storage,drive=install \
    -drive if=none,id=install,format=raw,media=cdrom,file=$ISO \
    -device virtio-net,disable-legacy=on,netdev=net0 \
    -netdev user,id=net0,hostfwd=tcp::2222-:22 \
    -vnc :1
