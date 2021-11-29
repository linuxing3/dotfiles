#! /bin/sh

### BEGIN INIT INFO
# Provides:		npc
### END INIT INFO

set -e

# /etc/init.d/npc: start and stop the npc" daemon

test -x /home/pi/npc/npc || exit 0

umask 022
export PATH="${PATH:+$PATH:}/usr/sbin:/sbin:/home/pi/npc"

start_config() {
	if [ -e /home/pi/conf/npc.conf ]; then
		nohup /home/pi/npc -config /home/pi/conf/npc.conf &
	fi
}

case "$1" in
start)
	start_config
	;;
stop)
	pkill npc
	;;

status)
	ps ax | grep npc >>/tmp/npc.log
	netstat -ntlp | grep npc >>/tmp/npc.log
	echo "npc status:"
	cat /tmp/npc.log
	;;

*)
	echo "Usage: /etc/init.d/npc {start|stop|status}"
	exit 1
	;;
esac

exit 0
