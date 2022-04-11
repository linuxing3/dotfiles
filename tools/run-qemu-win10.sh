cd ~/Downloads/win10/Ghost_Win10_X64_S_V2021.iso
# qemu-system-i386 -hda winxp.img -cdrom deepinsp3.iso -boot d -cpu host -m 512 -vga cirrus -net nic,model=rtl8139 -net user -device usb-tablet
qemu-system-i386 -hda win10.img -cdrom Ghost_Win10_X64_S_V2021.iso -boot d -cpu qemu64 -m 2048 -vga cirrus -net nic,model=rtl8139 -net user

