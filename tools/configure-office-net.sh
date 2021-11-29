echo "Configure your network and routing"

# configure beijing office
# 192.168.76.1 as gateway to offcelan to visit all sites 0.0.0.
# 192.168.76.63 as gateway to local lan of department 192.168.76.0/8
# 192.168.76.3 as gateway to 224.0.0.0 - 255.255.255.255

ifconfig enp3s0 down

ifconfig enp3s0 192.168.76.54 netmask 255.255.252.0

route add -net 0.0.0.0 netmask 0.0.0.0 gateway 192.168.76.1 dev enp3s0

route add -net 192.168.76.0 netmask 255.255.252.0 gateway 192.168.76.63 dev enp3s0

route add -net 192.168.76.255 netmask 255.255.255.255 gateway 192.168.76.63 dev enp3s0

route add -net 224.0.0.0 netmask 240.0.0.0 gateway 192.168.76.3 dev enp3s0

route add -net 255.255.255.255 netmask 255.255.255.255 gateway 192.168.76.3 dev enp3s0

ifconfig enp3s0 up

echo "Done!"
