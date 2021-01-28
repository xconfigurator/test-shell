#!/bin/bash
#author: liuyang
#since:  2018/10/09
#update: 2018/10/10 fix restop mongodb issue
#NOTE:   The stop sequence: nginx --> node processes (GenieACS nbi, fs, cwmp) --> redis --> mongodb

reset_terminal=$(tput sgr0)
style_info='\E[32m'   #green
style_error='\E[31m'  #red

echo "#########################################################" $reset_terminal
echo "######Stop Terminal Device Management all services#######" $reset_terminal
echo "#########################################################" $reset_terminal

#20181012
#cd /home/liuyang/workspace_shell/
cd /opt/terminal/bin/management_scripts

#1. stop nginx (.deb install can use this mode. see /etc/init.d/nginx)
#nginx -s stop
echo 'Stopping Nginx...'
service nginx stop

#2. stop genieacs and hbfec_upgrades
#kill node process
echo 'Stopping GenieACS and hbfec_upgrades and offline_mon ...'
#ps -ef | grep node | grep -v grep | awk '{print $2}' |xargs kill -15
ps -ef | grep node | grep -v grep | awk '{print $2}' |xargs kill -9

#3. stop redis (.deb install can use this mode. see /etc/init.d/redis-server)
echo 'Stopping Redis...'
service redis-server stop>>/dev/null

#4. stop mongodb
#DO NOT USE kill -9! kill -9 MAY lead to damage consequences!
#You should always stop mongodb normally!
echo 'Stopping MongoDB...'
ret=$(ps -ef | grep mongod | grep -v 'grep' -c)
if [ $ret -ge 1 ]; then
  mongod -f /etc/mongodb.conf --shutdown>>/dev/null  
fi

#201810181450
#sleep 10

#5. Check all services status
/bin/bash ./service_status.sh
