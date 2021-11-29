#!/usr/bin/env bash
echo "Enable samba on your pi"
sudo apt install -y samba

echo "Enable share folder in home directory"
mkdir -p ~/share
sudo echo <<EOF | sudo tee /etc/samba/smb.conf
[share]
comment="Welcome to pi home directory"
path=/home/pi/share
[sda1]
comment="ext hdd sda1"
path=/mnt/sda1/share
[sda2]
comment="ext hdd sda2 xing"
path=/mnt/sda2/home/xing
EOF

# sudo service samba
# sudo pdbedit -a -u pi
sudo /etc/init.d/samba start
sudo smbpass -a -u vagrant

sudo apt install -y ntfs-3g fuse
sudo modprobe fuse

echo "Edit system table for you"
# uuid=$(sudo blkid | awk 'END { print $3 }' | cut -f2 -d= | sed 's/\"//g')
sudo cat <<EOF | sudo tee /etc/fstab
# main passport
PARTUUID="89147e32-01" /mnt/sda1 ntfs auto,exec,rw,user,dmask=002,fmask=113,uid=1000,gid=1000 0 0
PARTUUID="89147e32-02" /mnt/sda2 ext4   defaults,auto,users,rw,nofail   0       0
PARTUUID="89147e32-03" /mnt/sda3 ntfs auto,exec,rw,user,dmask=002,fmaks=113,uid=1000,gid=1000 0 0
# ipod
PARTUUID="b2d61d33-01" /mnt/sdb1 ext4   defaults,auto,users,rw,nofail   0       0
PARTUUID="b2d61d33-02" /mnt/sdb2 ext4   defaults,auto,users,rw,nofail   0       0
PARTUUID="b2d61d33-03" /mnt/sdb3 ext4   defaults,auto,users,rw,nofail   0       0
PARTUUID="b2d61d33-04" /mnt/sdb4 ext4   defaults,auto,users,rw,nofail   0       0
EOF

echo "Enabled samba on your debian and rasbian"
echo "3. sudo reboot"

# /etc/fstab: static file system information.
#
# Use 'blkid' to print the universally unique identifier for a
# device; this may be used with UUID= as a more robust way to name devices
# that works even if disks are added and removed. See fstab(5).
#
# <file system> <mount point>   <type>  <options>       <dump>  <pass>
# / was on /dev/sdb8 during installation
# UUID=d0a1ec3d-0b42-45ef-ac9e-d1316b2e37e0 /               ext4    errors=remount-ro 0       1
# swap was on /dev/sdb7 during installation
# UUID=d0f9b1a0-4eaa-42ee-ba5f-bbd6be8e74b1 none            swap    sw              0       0

# windows 10 120G
# /dev/sda1                                 /mnt/sda1       ntfs    defaults    0   0
# /dev/sda2                                 /mnt/sda2       ntfs    defaults    0   0

# Seatay 320G
# /dev/sdb2                                 /mnt/sdb2       ntfs    defaults    0   0
# /dev/sdb5                                 /mnt/sdb5       ntfs    defaults    0   0
# /dev/sdb6                                 /mnt/sdb6       ntfs    defaults    0   0

# WD Element 500G
# /dev/sdc1                                 /mnt/sdc1      ntfs    defaults    0   0

## Refer to blkid information:

# /dev/sda1: LABEL="superboot" UUID="000F9FF10002107B" TYPE="ntfs" PARTUUID="e9aa0689-01"
# /dev/sda2: LABEL="win10" UUID="46689D91689D7FFB" TYPE="ntfs" PARTUUID="e9aa0689-02"
# /dev/sdb1: LABEL="boot" UUID="D4B2C888B2C87092" TYPE="ntfs" PARTUUID="2c5f2c5e-01"
# /dev/sdb2: LABEL="vms" UUID="A07E3EA07E3E6F62" TYPE="ntfs" PARTUUID="2c5f2c5e-02"
# /dev/sdb3: UUID="5ecf3456-7a77-30e9-bddf-18e5e6ecec8d" LABEL="mac" TYPE="hfsplus" PARTUUID="2c5f2c5e-03"
# /dev/sdb5: LABEL="media" UUID="38507CB2507C7888" TYPE="ntfs" PARTUUID="2c5f2c5e-05"
# /dev/sdb6: LABEL="data" UUID="4A5CACC85CACAFDD" TYPE="ntfs" PARTUUID="2c5f2c5e-06"
# /dev/sdb7: UUID="d0f9b1a0-4eaa-42ee-ba5f-bbd6be8e74b1" TYPE="swap" PARTUUID="2c5f2c5e-07"
# /dev/sdb8: UUID="d0a1ec3d-0b42-45ef-ac9e-d1316b2e37e0" TYPE="ext4" PARTUUID="2c5f2c5e-08"
# /dev/sdc1: LABEL="ElementPassport" UUID="78324AB7324A7A60" TYPE="ntfs" PARTUUID="016ac585-01"
