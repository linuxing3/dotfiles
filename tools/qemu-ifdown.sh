#!/bin/sh
 
echo sudo brctl delif br0 $1
sudo brctl delif br0 $1
echo sudo tunctl -d $1
sudo tunctl -d $1
echo brctl show
brctl show