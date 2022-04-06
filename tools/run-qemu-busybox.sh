/home/wjb/Downloads/qemu-5.0.0/build/aarch64-softmmu/qemu-system-aarch64 \
    -machine virt -cpu cortex-a53 -smp 1 -m 2G \
    -kernel /home/wjb/Downloads/linux-4.19.237/build/arch/arm64/boot/Image \
    -append "console=ttyAMA0" \
    -initrd /home/wjb/Downloads/busybox-1.35.0/build/initramfs.cpio.gz \
    -nographic
