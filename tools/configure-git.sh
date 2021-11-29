#!/bin/bash

read -p "请输入username:" username
git config --global user.name $username

read -p "请输入email:" email
git config --global user.email $email

echo "Your password will be stored in .git-credential file"
git config --global credential.helper store

GCMCORE=https://github.com/microsoft/Git-Credential-Manager-Core/releases/download/v2.0.567/gcmcore-linux_amd64.2.0.567.18224.deb
wget $GCMCORE
dpkg --install gcmcore-linux_amd64.2.0.567.18224.deb
git-credential-manager-core configure
