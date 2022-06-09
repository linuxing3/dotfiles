sudo cp /etc/systemd/system/getty.target.wants/getty@tty{1,3}.service

sudo sed -i -e "s/tty1/tty3/" /etc/systemd/system/getty.target.wants/getty@tty3.service
sudo sed -i -e "s/\/sbin\/agetty/\0 --login-pause --autologin vagrant/" /etc/systemd/system/getty.target.wants/getty@tty3.service 

sudo sed -i -e "s/\/sbin\/agetty/\0 --login-pause --autologin root/" /etc/systemd/system/getty.target.wants/getty@tty1.service 

sudo systemctl daemon-reload
