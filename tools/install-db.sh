#!/bin/bash
# Copyright 2019 the Deno authors. All rights reserved. MIT license.
# Copyright 2020 justjavac. All rights reserved. MIT license.
# TODO(everyone): Keep this script simple and easily auditable.

install_nginx_new() {

	sudo apt update
	sudo apt install -y curl gnupg2 ca-certificates lsb-release
	curl -fsSL http://nginx.org/keys/nginx_signing.key | sudo gpg --dearmor -o /usr/share/keyrings/nginx-keyring.gpg
	echo "deb [signed-by=/usr/share/keyrings/nginx-keyring.gpg] http://nginx.org/packages/debian $(lsb_release -cs) nginx" | sudo tee /etc/apt/sources.list.d/nginx.list
	sudo apt update
	sudo apt install -y nginx
}

install_mysql_phpmyadmin() {

<<<<<<< HEAD
  echo ""
  echo "Installling nginx from official site"
  echo ""
  while true; do
    read -r -p "    [1] Install Nginx [2] Quit:  " opt
    case $opt in
      1)
        install_nginx_new
        break
        ;;
      2)
        break
        ;;
      *)
        echo "Please choose a correct answer"
        ;;
    esac
  done

  echo ""
  echo "Downloading mariadb and php"
  echo ""
  sudo apt install -y mariadb-server mariadb-client
  sudo apt install -y php-fpm php-mysql php-cli

  echo ""
  echo "Creating nginx php site configuration file"
  echo "Don't forget to add vagrant.local to your hosts file"
  echo "FIXME: denied error: change 777 of root dir to avoid access denied error"
  echo "FIXME: to avoid 502 gateway error"
  echo "FIXME: change user=www-data listen.user=www-data in /etc/php/7.4/fpm/pool.d/www.conf"
  echo ""
  echo "server {
=======
	echo ""
	echo "Installling nginx from official site"
	echo ""
	while true; do
		read -r -p "    [1] Install Nginx [2] Quit:  " opt
		case $opt in
		1)
			install_nginx_new
			break
			;;
		2)
			break
			;;
		*)
			echo "Please choose a correct answer"
			;;
		esac
	done

	echo ""
	echo "Downloading mariadb and php"
	echo ""
	sudo apt install -y mariadb-server mariadb-client
	sudo apt install -y php-fpm php-mysql php-cli

	echo ""
	echo "Creating nginx php site configuration file"
	echo "Don't forget to add vagrant.local to your hosts file"
	echo ""
	echo "server {
>>>>>>> bfc9f8b19434011bda4361f8fb1e5b9208e4c43c
  server_name vagrant.local;
  root /usr/share/nginx/html/vagrant.local;
  location / {
    index index.html index.htm index.php;
  }
  location ~ \.php$ {
    include /etc/nginx/fastcgi_params;
    fastcgi_pass unix:/run/php/php7.4-fpm.sock;
    fastcgi_index index.php;
    fastcgi_param SCRIPT_FILENAME /usr/share/nginx/html/vagrant.local$fastcgi_script_name;
  }
}" | sudo tee /etc/nginx/conf.d/vagrant.local.conf

	sudo mkdir /usr/share/nginx/html/vagrant.local
	echo "<?php phpinfo(); ?>" | sudo tee /usr/share/nginx/html/vagrant.local/index.php

	echo ""
	echo "Downloading phpmyadmin"
	echo ""

	sudo apt install -y php-json php-mbstring php-xml
	wget --no-check-certificate https://files.phpmyadmin.net/phpMyAdmin/5.1.1/phpMyAdmin-5.1.1-all-languages.tar.gz
	tar -zxvf phpMyAdmin-5.1.1-all-languages.tar.gz
	sudo mv phpMyAdmin-5.1.1-all-languages /usr/share/phpMyAdmin
	rm phpMyAdmin-5.1.1-all-languages.tar.gz

	echo ""
	echo "Copying sample configuration file"
	echo "Uncomment phpMyAdmin configuration storage settings by yourself in /use/share/phpAdmin/config.inc.php"
	echo "And also generate your blowfish_secret"
	echo ""
	sudo cp -pr /usr/share/phpMyAdmin/config.sample.inc.php /usr/share/phpMyAdmin/config.inc.php

	echo "Creating table for phpmyadmin"
	sudo mysql -u root -p </usr/share/phpMyAdmin/sql/create_tables.sql

	echo ""
	echo "Add the user and grant permission to phpMyAdmin’s database."
	echo ""

	echo "Please login and run commands in mysql to create pma user:"
	echo "sudo mysql -u root -p"
	echo "CREATE USER 'pma'@'localhost' IDENTIFIED BY 'pmapass';"
	echo " GRANT ALL PRIVILEGES ON phpmyadmin.* TO 'pma'@'localhost' WITH GRANT OPTION;"
	echo "FLUSH PRIVILEGES;"

	echo ""
	echo "By default, the MariaDB root user is allowed to log in locally via Unix socket (MariaDB v10.4 and below). "
	echo "So, we will create a database user and login to phpMyAdmin with that user."
	echo ""

	echo "Please login and run commands in mysql to create app_db and app_user:"
	echo "sudo mysql -u root -p"
	echo "REATE DATABASE app_db;"
	echo "CREATE USER 'app_user'@'localhost' IDENTIFIED BY 'password';"
	echo "GRANT ALL PRIVILEGES ON app_db.* TO 'app_user'@'localhost' WITH GRANT OPTION;"
	echo "FLUSH PRIVILEGES;"
	echo "EXIT;"

	echo ""
	echo "Generating phpmyadmin virtual host nginx configuration file"
	echo "Don't forget to add pma.vagrant.local to your hosts file"
	echo ""
	echo "server {
  listen 80;
  server_name pma.vagrant.local;
  root /usr/share/phpMyAdmin;
  location / {
    index index.php;
  }
  ## Images and static content is treated different
  location ~* ^.+.(jpg|jpeg|gif|css|png|js|ico|xml)$ {
    access_log off;
    expires 30d;
  }
  location ~ /\.ht {
    deny all;
  }
  location ~ /(libraries|setup/frames|setup/libs) {
    deny all;
    return 404;
  }
  location ~ \.php$ {
    include /etc/nginx/fastcgi_params;
    fastcgi_pass unix:/run/php/php7.4-fpm.sock;
    fastcgi_index index.php;
    fastcgi_param SCRIPT_FILENAME /usr/share/phpMyAdmin$fastcgi_script_name;
  }
}" | sudo tee /etc/nginx/conf.d/phpMyAdmin.conf

	echo ""
	echo "Making tmp directories"
	echo "Fixing ownership of /usr/share/phpMyAdmin"
	echo ""
	sudo mkdir /usr/share/phpMyAdmin/tmp
	sudo chmod 777 /usr/share/phpMyAdmin/tmp
	sudo chown -R www-data:www-data /usr/share/phpMyAdmin

	echo ""
	echo "Restarting nginx and php"
	echo ""
	sudo systemctl restart nginx
	sudo systemctl restart php7.4-fpm
	echo ""
	echo "Done! Enjoy!"
	echo ""
}

install_postgres_mysql() {
	cd ~/.dotfiles/custom/db
	docker-compose -up
}

install_mongodb() {
	docker run -d -p 27017:27017 --name -v /data/db/mongodb:/data/db mongodb dockerfile/mongodb mongod --smallfiles
	echo "Client Command"
	echo "docker run -it --rm --link mongodb:mongodb dockerfile/mongodb bash -c 'mongo --host mongodb'"
}

install_couchdb() {
	docker run -d --name couchdb -p 8091-8094:8091-8094 -p 11210:11210 couchbase
	echo "Client Command"
	echo "visit http://localhost:8091 to create your cluster"
}

install_redis() {
	docker run -d -p 6379:6379 -v /data/db/redis:/data --name redis dockerfile/redis redis-server /etc/redis/redis.conf --requirepass 20090909
	echo "Client Command"
	echo "docker run -it --rm --link redis:redis dockerfile/redis bash -c 'redis-cli -h redis'"
}

install_hasura_cli() {
	curl -L https://github.com/hasura/graphql-engine/raw/stable/cli/get.sh | bash
	echo "or install globally on your system"
	npm install --global hasura-cli@latest
	echo "run hasura init to start"
}

install_mongo_redis() {
	mkdir -pv ~/development/db
	cd ~/development/db
	cat >>docker-compose.yml <<EOF
version: '3'
services:
  mongo:
    container_name: dev-mongo
    image: mongo
    ports:
      - '27017:27017'
  redis:
    container_name: dev-redis
    image: redis
    ports:
      - '6379:6379'
  rabbitmq:
    container_name: dev-rabbitmq
    image: rabbitmq
    ports:
      - '15672:15672'
      - '5672:5672'
EOF
}

echo "==========================================================="
echo "installing database environment for you..."
echo "==========================================================="

cd

echo "[1] Postgres+Mysql on Docker"
echo "[2] Mongodb+Redis on Docker"
echo "[3] Couchdb"
echo "[4] Hasura"
echo "[5] LEMP Native"
echo "[0] Quit:"
while true; do
	read -r -p "Please Choose one option: " opt
	case $opt in
	0)
		break
		;;
	1)
		install_postgres_mysql
		break
		;;
	2)
		install_mongo_redis
		break
		;;
	3)
		install_couchdb
		break
		;;
	4)
		install_hasura_cli
		break
		;;
	5)
		install_mysql_phpmyadmin
		break
		;;
	*)
		echo "Please choose a correct answer"
		;;
	esac
done
