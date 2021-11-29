#!/usr/bin/env bash

install_nginx_new() {
	echo ""
	echo "Installling nginx from official site"
	echo ""
	sudo apt update
	sudo apt install -y curl gnupg2 ca-certificates lsb-release
	curl -fsSL http://nginx.org/keys/nginx_signing.key | sudo gpg --dearmor -o /usr/share/keyrings/nginx-keyring.gpg
	echo "deb [signed-by=/usr/share/keyrings/nginx-keyring.gpg] http://nginx.org/packages/debian $(lsb_release -cs) nginx" | sudo tee /etc/apt/sources.list.d/nginx.list
	sudo apt update
	sudo apt install -y nginx
}

install_nginx_new
