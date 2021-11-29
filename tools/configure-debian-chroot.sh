#! /usr/bin/env bash

echo chroom helper
echo mount sda5
sudo mkdir /mnt/sda5
sudo mount /dev/sda5 /mnt/sda5

echo Chroot to sda5
sudo mount -o bind /dev /mnt/sda5/dev
sudo mount -o bind /proc /mnt/sda5/proc
sudo mount /dev/sdb8 /mnt/sda5/mirror
sudo chroot /mnt/sda5 /bin/bash
