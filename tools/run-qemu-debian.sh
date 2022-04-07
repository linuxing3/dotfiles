QEMU_EFI=/home/wjb/Downloads/debian/QEMU_EFI.fd 
DRIVE=/home/wjb/Downloads/debian/debian-11-generic-arm64-20220328-962.qcow2 

qemu-system-aarch64 \
    -M virt -m 4G -cpu cortex-a72 -smp 2 \
    -bios $QEMU_EFI \
    -drive id=hd0,media=disk,if=none,file=$DRIVE \
    -device virtio-scsi-pci \
    -device scsi-hd,drive=hd0 \
    -nic user,model=virtio-net-pci,hostfwd=tcp::2222-:22,hostfwd=tcp::8000-:80,hostfwd=tcp::8080-:8080,hostfwd=tcp::8888-:8888,hostfwd=tcp::9090-:9090,hostfwd=tcp::9000-:9000 \
    -nographic

