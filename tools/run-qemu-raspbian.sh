/home/wjb/Downloads/qemu-5.0.0/build/aarch64-softmmu/qemu-system-aarch64 \
    -kernel /home/wjb/Downloads/raspbian/kernel-qemu-4.19.50-buster -cpu arm1176 -m 256 \
    -M versatilepb -dtb /home/wjb/Downloads/raspbian/versatile-pb-buster.dtb \
    -no-reboot -append "root=/dev/sda2 console=ttyAMA0 panic=1 rootfstype=ext4 rw" \
    -net nic -net user,hostfwd=tcp::5022-:22 \
    -hda /home/wjb/Downloads/raspbian/2020-02-13-raspbian-buster.img