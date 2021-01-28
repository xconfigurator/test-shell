#!/bin/bash
### BEGIN INIT INFO
# Provides:		hbfec_terminal_device_management_services
# Required-Start:	$syslog $remote_fs
# Required-Stop:	$syslog $remote_fs
# Should-Start:		$local_fs
# Should-Stop:		$local_fs
# Default-Start:	2 3 4 5
# Default-Stop:		0 1 6
# Short-Description:	hbfec terminal device management software
# Description:		hbfec terminal device management software
### END INIT INFO
#author: liuyang
#since:  2018/10/15


PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
NAME=hbfecterminal

case "$1" in
  start)
	#echo "hbfec start"
	service_start
	;;
  stop)
	#echo "hbfec stop"
	service_stop
	;;
  restart|force-reload)
	${0} stop
	${0} start
	;;
  status)
	#echo "hbfec status"
	service_status	
	;;	
  backuplog)
	#echo "hbfec backuplog"
	logs_backup
	;;
  archivelog)
	#echo "hbfec archivelog"
	logs_archive_and_clean
	;;
  build)
	#echo "hbfec buildandpublis"
	build_and_publish_terminalweb 
	;;
  *)
	echo "Usage: /etc/init.d/$NAME {start|stop|restart|force-reload|status|backuplog|archivelog|build}" >&2
	exit 1
	;;
esac

exit 0
