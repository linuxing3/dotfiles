cd ~/Downloads/windowsxp
# qemu-system-i386 -hda winxp.img -cdrom deepinsp3.iso -boot d -cpu qemu64 -m 512 -vga cirrus -net nic,model=rtl8139 -net user -device usb-tablet

qemu-system-i386 -hda winxp.img -boot c -cpu qemu64 -m 512 -vga cirrus -net nic,model=rtl8139 -net user


