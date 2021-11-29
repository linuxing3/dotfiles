#!/usr/bin/env bash

optimize() {
	echo "调整系统控制参数"
	# tee命令用于将数据重定向到文件，另一方面还可以提供一份重定向数据的副本作为后续命令的stdin。
	# 简单的说就是把数据重定向到给定文件和屏幕上。
	sudo cat <<EOF | sudo tee /etc/sysctl.conf
# max open files
fs.file-max = 51200
# max read buffer
net.core.rmem_max = 67108864
# max write buffer
net.core.wmem_max = 67108864
# default read buffer
net.core.rmem_default = 65536
# default write buffer
net.core.wmem_default = 65536
# max processor input queue
net.core.netdev_max_backlog = 4096
# max backlog
net.core.somaxconn = 4096
# resist SYN flood attacks
net.ipv4.tcp_syncookies = 1
# reuse timewait sockets when safe
net.ipv4.tcp_tw_reuse = 1
# turn off fast timewait sockets recycling
net.ipv4.tcp_tw_recycle = 0
# short FIN timeout
net.ipv4.tcp_fin_timeout = 30
# short keepalive time
net.ipv4.tcp_keepalive_time = 1200
# outbound port range
net.ipv4.ip_local_port_range = 10000 65000
# max SYN backlog
net.ipv4.tcp_max_syn_backlog = 4096
# max timewait sockets held by system simultaneously
net.ipv4.tcp_max_tw_buckets = 5000
# TCP receive buffer
net.ipv4.tcp_rmem = 4096 87380 67108864
# TCP write buffer
net.ipv4.tcp_wmem = 4096 65536 67108864
# turn on path MTU discovery
net.ipv4.tcp_mtu_probing = 1
# for high-latency network
net.core.default_qdisc=fq
net.ipv4.tcp_congestion_control = bbr
EOF

	sudo sysctl -p

	echo "将当前文件数限制设置为51200"
	sudo cat <<EOF | sudo tee -a /etc/security/limits.conf
* soft nofile 51200
* hard nofile 51200
EOF

	sudo ulimit -SHn 51200

	sudo cat <<EOF | sudo tee -a /etc/profile
ulimit -SHn 51200
EOF
}

backup() {
	echo "-----------------------------"
	echo "Backing up caddy configurations"
	sudo mv caddy /usr/bin/
	sudo mv /etc/caddy/Caddyfile /etc/caddy/Caddyfile.old
	sudo mv /etc/systemd/system/caddy.service /etc/caddy/caddy.service.old
}

install_caddy2() {
	sudo echo "deb [trusted=yes] https://apt.fury.io/caddy/ /" |
		sudo tee -a /etc/apt/sources.list.d/caddy-fury.list
	sudo apt update
	sudo apt install caddy
	caddy version
	which caddy
	mv /etc/caddy/Caddyfile /etc/caddy/Caddyfile.bak
	touch /etc/caddy/Caddyfile

	sudo echo "
:15034 {
    root * /usr/share/caddy
    file_server
}

xray.xunqinji.xyz:80 {
    redir https://xray.xunqinji.xyz{uri}
}

xunqinji.xyz:80 {
    redir https://xray.xunqinji.xyz{uri}
}

xunqinji.xyz:80 {
    redir https://xray.xunqinji.xyz{uri}
}

gce.hk.xunqinji.xyz:80 {
    redir https://xray.xunqinji.xyz{uri}
}

nps.xunqinji.xyz:80 {
  reverse_proxy /* 127.0.0.1:8080
}
" >>/etc/caddy/Caddyfile

	echo "You are installing caddy 2, the user and group caddy will be created for you"
	echo "If not, your can do it on your own"
	echo "groupadd --system caddy"
	echo "
  useradd --system \
    --gid caddy \
    --create-home \
    --home-dir /var/lib/caddy \
    --shell /usr/sbin/nologin \
    --comment "Caddy web server" \
    caddy
  "
	echo "Usage:"
	echo "/usr/bin/caddy run --environ --adapter caddyfile --config /etc/caddy/Caddyfile"
	echo "/usr/bin/caddy reload --environ --adapter caddyfile --config /etc/caddy/Caddyfile"
	echo "Enjoy!"
}

install_caddy1() {
	echo "curl https://getcaddy.com | bash -s personal"
	echo "Optional installing nginx"
	# sudo apt install -y nginx
	# curl https://getcaddy.com | bash -s personal
	echo "-----------------------------"
	#root拥有caddy文件防止其他账户修改
	sudo touch /usr/local/bin/caddy
	sudo chown root:root /usr/local/bin/caddy

	#修改权限为755，root可读写执行，其他账户不可写
	sudo chmod 755 /usr/local/bin/caddy
	#Caddy不会由root运行，使用setcap允许caddy作为用户进程绑定低号端口（服务器需要80和443）
	sudo setcap 'cap_net_bind_service=+ep' /usr/local/bin/caddy

	echo "-----------------------------"
	echo "检查名为www-data的组和用户是否已经存在"
	sudo cat /etc/group | grep www-data
	sudo cat /etc/passwd | grep www-data
	sudo groupadd -g 33 www-data
	sudo useradd -g www-data --no-user-group --home-dir /var/www --no-create-home --shell /usr/sbin/nologin --system --uid 33 www-data

	echo "-----------------------------"
	echo "创建文件夹存储Caddy的配置文件"
	sudo mkdir /etc/caddy
	sudo chown -R root:root /etc/caddy

	sudo mkdir /etc/ssl/caddy
	sudo chown -R root:www-data /etc/ssl/caddy
	sudo chmod 770 /etc/ssl/caddy

	sudo touch /var/log/caddy.log
	sudo chown root:www-data /var/log/caddy.log
	sudo chmod 770 /var/log/caddy.log

	sudo chown -R www-data:www-data /var/www

	#创建名为Caddyfile的Caddy配置文件：
	echo "-----------------------------"
	echo "加入Caddy配置文件"
	sudo touch /etc/caddy/Caddyfile
	echo "-----------------------------"
	echo "赋予Caddy配置文件权限"
	sudo chown root:root /etc/caddy/Caddyfile
	sudo chmod 644 /etc/caddy/Caddyfile
	sudo cat <<EOF | sudo tee /etc/caddy/Caddyfile
"xunqinji.xyz:80
{
  log /var/log/caddy.log
  tls xingwenju@gmail.com
  root /var/www/html
  gzip
  browse
  proxy /ray localhost:36722 {
    websocket
    header_upstream -Origin
  }
}"
EOF

	echo "1）domain.com：要改为你自己的域名，若是这样的二级域名，其正确解析请参考前文【自己搭建代理服务器：域名购买及设置与ip服务器关联】；
  2）12345@gmail.com：要改为你自己的邮箱，Caddy将自动与Let's Encrypt联系以获取SSL证书并在90天到期后自动更新证书；
  3）Caddy将自动与Let's Encrypt联系以获取SSL证书。它将证书和密钥放在“/etc/ssl/caddy/acme/acme-v02.api.letsencrypt.org/sites/你自己的域名/” 目录中；
  4）此文件保存后，Caddy会随即向Let's Encrypt发出SSL证书申请，一般很快在一分钟就可完成，但可能有人会遇到特殊情况比较久一些才会完成。"

	echo "-----------------------------"
	echo "Use groups Setting"
	sudo cat /etc/group | grep www-data
	sudo cat /etc/passwd | grep www-data
	sudo groupadd -g 33 www-data
	sudo useradd -g www-data --no-user-group --home-dir /var/www --no-create-home --shell /usr/sbin/nologin --system --uid 33 www-data
	sudo chown -R root:www-data /etc/ssl/caddy
	sudo chown root:www-data /var/log/caddy.log

	echo "-----------------------------"
	echo "加入Caddy服务配置文件"
	echo "wget https://raw.githubusercontent.com/caddyserver/caddy/master/dist/init/linux-systemd/caddy.service"

	sudo touch /etc/systemd/system/caddy.service
	sudo chown root:root /etc/systemd/system/caddy.service
	sudo chmod 644 /etc/systemd/system/caddy.service

	sudo echo "
[Unit]
Description=Caddy HTTP/2 web server
Documentation=https://caddyserver.com/docs
After=network-online.target
Wants=network-online.target systemd-networkd-wait-online.service

[Service]
Restart=on-abnormal

; User and group the process will run as.
User=www-data
Group=www-data

; Letsencrypt-issued certificates will be written to this directory.
Environment=CADDYPATH=/etc/ssl/caddy

; Always set "-root" to something safe in case it gets forgotten in the Caddyfile.
ExecStart=/usr/local/bin/caddy -log stdout -agree=true -conf=/etc/caddy/Caddyfile -root=/var/tmp
ExecReload=/bin/kill -USR1 $MAINPID

; Use graceful shutdown with a reasonable timeout
KillMode=mixed
KillSignal=SIGQUIT
TimeoutStopSec=5s

; Limit the number of file descriptors; see $(man systemd.exec) for more limit settings.
LimitNOFILE=1048576
; Unmodified caddy is not expected to use more than that.
LimitNPROC=512

; Use private /tmp and /var/tmp, which are discarded after caddy stops.
PrivateTmp=true
; Use a minimal /dev
PrivateDevices=true
; Hide /home, /root, and /run/user. Nobody will steal your SSH-keys.
ProtectHome=true
; Make /usr, /boot, /etc and possibly some more folders read-only.
ProtectSystem=full
; except /etc/ssl/caddy, because we want Letsencrypt-certificates there.
; This merely retains r/w access rights, it does not add any new. Must still be writable on the host!
ReadWriteDirectories=/etc/ssl/caddy

; The following additional security directives only work with systemd v229 or later.
; They further retrict privileges that can be gained by caddy. Uncomment if you like.
; Note that you may have to add capabilities required by any plugins in use.
;CapabilityBoundingSet=CAP_NET_BIND_SERVICE
;AmbientCapabilities=CAP_NET_BIND_SERVICE
;NoNewPrivileges=true

[Install]
WantedBy=multi-user.target
" >>/etc/systemd/system/caddy.service

}

run() {
	echo "Caddy启动"
	sudo systemctl daemon-reload
	sudo systemctl stop caddy
	sudo systemctl start caddy

	echo "检查Caddy启动状态"
	echo "systemctl status caddy"
	echo "如果Caddy无法正常启动，则可以查看日志数据以帮助找出问题。如果已经启动，不需要此步检查。"
	echo "journalctl --boot -u caddy.service"
	sudo systemctl status caddy

	echo "若上一步启动无问题则可启用开机自启动Caddy, 输入： systemctl enable caddy"
	echo "完成！"
	echo "请打开http://xunqinji.xyz,浏览你的新网站吧！"
}

main() {
	case $@ in
	1)
		optimize
		backup
		install_caddy1
		run
		;;
	2)
		optimize
		backup
		install_caddy2
		run
		;;
	*)
		echo "本方法的trojan服务器部署系统要求：Ubuntu ≧ 16.04 or Debian ≧ 9，建议使用 Debian 10"
		echo ""
		echo "本方法以Caddy作为前端web服务器，是一个轻便的web部署工具，其功能与 nginx 类似。其优点是：单文件，无依赖，安全、轻量、方便；安装快速、不到30秒可创建一个 HTTPS 服务器；不受制于EE的版本限制，可广泛应用于各种系统；配置文件简洁，多站点配置、反向代理等功能都在一个 Caddyfile 文件里配置；默认启用HTTPS，自动签发免费的 Let's Encrypt https 证书并自动续约，默认支持HTTP/2（H2）网络协议；还有丰富的插件系统，可以快速配置缓存、CORS、自动拉取 Git 仓库、Markdown 支持、ip/地区过滤等功能。"
		echo ""
		echo "
install-caddy.sh
Install caddy for debian and other systems

Usage:

install-caddy.sh <version [1|2] >

For install caddy version1, run:
install-caddy.sh 1

For install caddy version1, run:
install-caddy.sh 2
       "
		;;
	esac
}

main $@
