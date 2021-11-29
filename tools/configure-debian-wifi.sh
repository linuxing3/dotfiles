#! /usr/bin/env bash

echo Please install net-tools and wireless-tools first

ip link set wlp1s0 up

echo "auto wlp1s0
iface wlp1s0 inet static
address 192.168.1.166
netmask 255.255.255.0
gateway 192.168.1.1
nameserver 80.80.80.80, 80.80.81.81
pre-up ip link set wlp1s0 up
pre-up iwconfig wlp1s0 essid ssid
wpa-ssid dulce
wpa-psk 20dulce17" | sudo tee /etc/network/interfaces

ifup wlp1s0
