# !/bin/bash
echo "tunneling..."
echo "Forward terminus ssh server 8022 of your android phone"
echo "Open Terminus and you can login with the following command"
echo "ssh -p 8022 u0_a101@localhost"
adb forward tcp:8022 tcp:8022

echo "Running tunnel server on 31416"
cd ~/Downloads/gnirehtet-java
./gnirehtet run

echo "Done!"
