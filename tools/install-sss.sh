#! /bin/bash
PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
#===============================================================================================
#   System Required:  Debian or Ubuntu (32bit/64bit)
#   Description:  Install Shadowsocks(libev) for Debian or Ubuntu
#   Author: Arno <blogfeng@blogfeng.com>
#   Intro:  http://www.blogfeng.com
#===============================================================================================

clear
echo "#############################################################"
echo "# Install Shadowsocks(libev) for Debian or Ubuntu (32bit/64bit)"
echo "# Intro: http:/www.blogfeng.com"
echo "#"
echo "# Author: Arno <blogfeng@blogfeng.com>"
echo "#"
echo "#############################################################"
echo ""

# Install Shadowsocks-libev
function install_shadowsocks_libev() {
	rootness
	disable_selinux
	pre_install
	download_files
	config_shadowsocks
	install
}

# Make sure only root can run our script
function rootness() {
	if [[ $EUID -ne 0 ]]; then
		echo "Error:This script must be run as root!" 1>&2
		exit 1
	fi
}

# Disable selinux
function disable_selinux() {
	if [ -s /etc/selinux/config ] && grep 'SELINUX=enforcing' /etc/selinux/config; then
		sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
		setenforce 0
	fi
}

# Pre-installation settings
function pre_install() {
	#Set shadowsocks-libev config password
	echo "Please input password for shadowsocks-libev:"
	read -p "(Default password: teddysun.com):" shadowsockspwd
	if [ "$shadowsockspwd" = "" ]; then
		shadowsockspwd="teddysun.com"
	fi
	echo "password:$shadowsockspwd"
	echo "####################################"
	get_char() {
		SAVEDSTTY=$(stty -g)
		stty -echo
		stty cbreak
		dd if=/dev/tty bs=1 count=1 2>/dev/null
		stty -raw
		stty echo
		stty $SAVEDSTTY
	}
	echo ""
	echo "Press any key to start...or Press Ctrl+C to cancel"
	char=$(get_char)
	# Update System
	apt-get -y update
	# Install necessary dependencies
	apt-get install -y wget unzip curl build-essential autoconf libtool libssl-dev
	# Get IP address
	echo "Getting Public IP address, Please wait a moment..."
	IP=$(curl -s checkip.dyndns.com | cut -d' ' -f 6 | cut -d'<' -f 1)
	if [ $? -ne 0 -o -z $IP ]; then
		IP=$(curl -s -4 ipinfo.io | grep "ip" | awk -F\" '{print $4}')
	fi
	#Current folder
	cur_dir=$(pwd)
	cd $cur_dir
}

# Download latest shadowsocks-libev
function download_files() {
	if [ -f shadowsocks-libev.zip ]; then
		echo "shadowsocks-libev.zip [found]"
	else
		if ! wget --no-check-certificate https://github.com/shadowsocks/shadowsocks-libev/archive/master.zip -O shadowsocks-libev.zip; then
			echo "Failed to download shadowsocks-libev.zip"
			exit 1
		fi
	fi
	unzip shadowsocks-libev.zip
	if [ $? -eq 0 ]; then
		cd $cur_dir/shadowsocks-libev-master/
	else
		echo ""
		echo "Unzip shadowsocks-libev failed! Please visit http://www.blogfeng.com and contact."
		exit 1
	fi
}

# Config shadowsocks
function config_shadowsocks() {
	if [ ! -d /etc/shadowsocks ]; then
		mkdir /etc/shadowsocks
	fi
	cat >/etc/shadowsocks/config.json <<-EOF
		{
		    "server":"${IP}",
		    "server_port":8000,
		    "local_address":"127.0.0.1",
		    "local_port":1080,
		    "password":"${shadowsockspwd}",
		    "timeout":600,
		    "method":"md5-rc4"
		}
	EOF
}

# Install
function install() {
	# Build and Install shadowsocks-libev
	if [ -s /usr/local/bin/ss-server ]; then
		echo "shadowsocks-libev has been installed!"
		exit 0
	else
		./configure
		make && make install
		if [ $? -eq 0 ]; then
			# Add run on system start up
			cat /etc/rc.local | grep 'ss-server' >/dev/null 2>&1
			if [ $? -ne 0 ]; then
				cp -rpf /etc/rc.local /opt/rc.local_bak
				col=$(awk 'END{print NR}' /etc/rc.local)
				sed -i ''"$col"'i nohup /usr/local/bin/ss-server -c /etc/shadowsocks/config.json > /dev/null 2>&1 &' /etc/rc.local
			fi
			# Run shadowsocks in the background
			nohup /usr/local/bin/ss-server -c /etc/shadowsocks/config.json >/dev/null 2>&1 &
			# Run success or not
			ps -ef | grep -v grep | grep -v ps | grep -i '/usr/local/bin/ss-server' >/dev/null 2>&1
			if [ $? -eq 0 ]; then
				echo "Shadowsocks-libev start success!"
			else
				echo "Shadowsocks-libev start failure!"
			fi
		else
			echo ""
			echo "Shadowsocks-libev install failed! Please visit http://www.blogfeng.com and contact."
			exit 1
		fi
	fi
	cd $cur_dir
	# Delete shadowsocks-libev floder
	rm -rf $cur_dir/shadowsocks-libev-master/
	# Delete shadowsocks-libev zip file
	rm -f shadowsocks-libev.zip
	clear
	echo ""
	echo "Congratulations, shadowsocks-libev install completed!"
	echo -e "Your Server IP: \033[41;37m ${IP} \033[0m"
	echo -e "Your Server Port: \033[41;37m 8989 \033[0m"
	echo -e "Your Password: \033[41;37m ${shadowsockspwd} \033[0m"
	echo -e "Your Local IP: \033[41;37m 127.0.0.1 \033[0m"
	echo -e "Your Local Port: \033[41;37m 1080 \033[0m"
	echo -e "Your Encryption Method: \033[41;37m aes-256-cfb \033[0m"
	echo ""
	echo "Welcome to visit:http://teddysun.com/358.html"
	echo "Enjoy it!"
	echo ""
	exit 0
}

# Uninstall Shadowsocks-libev
function uninstall_shadowsocks_libev() {
	printf "Are you sure uninstall Shadowsocks-libev? (y/n) "
	printf "\n"
	read -p "(Default: n):" answer
	if [ -z $answer ]; then
		answer="n"
	fi
	if [ "$answer" = "y" ]; then
		NODE_PID=$(ps -ef | grep -v grep | grep -v ps | grep -i '/usr/local/bin/ss-server' | awk '{print $2}')
		if [ ! -z $NODE_PID ]; then
			for pid in $NODE_PID; do
				kill -9 $pid
				if [ $? -eq 0 ]; then
					echo "Shadowsocks-libev process[$pid] has been killed"
				fi
			done
		fi
		# restore /etc/rc.local
		if [[ -s /opt/rc.local_bak ]]; then
			rm -f /etc/rc.local
			mv /opt/rc.local_bak /etc/rc.local
		fi
		# delete config file
		rm -rf /etc/shadowsocks
		# delete shadowsocks
		rm -f /usr/local/bin/ss-local
		rm -f /usr/local/bin/ss-tunnel
		rm -f /usr/local/bin/ss-server
		rm -f /usr/local/bin/ss-redir
		rm -f /usr/local/lib/libshadowsocks.a
		rm -f /usr/local/lib/libshadowsocks.la
		rm -f /usr/local/include/shadowsocks.h
		rm -rf /usr/local/lib/pkgconfig
		rm -f /usr/local/share/man/man8/shadowsocks.8
		echo "Shadowsocks-libev uninstall success!"
	else
		echo "uninstall cancelled, Nothing to do"
	fi
}

# Initialization step
action=$1
[ -z $1 ] && action=install
case "$action" in
install)
	install_shadowsocks_libev
	;;
uninstall)
	uninstall_shadowsocks_libev
	;;
*)
	echo "Arguments error! [${action} ]"
	echo "Usage: $(basename $0) {install|uninstall}"
	;;
esac
