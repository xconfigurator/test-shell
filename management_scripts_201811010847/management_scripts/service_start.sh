#!/bin/bash
#author: liuyang
#since:  2018/10/09
#NOTE:   The startup sequence: mongodb --> redis --> GenieACS(cwmp, fs, nbi) --> hbfec_upgrades --> nginx

reset_terminal=$(tput sgr0)
style_info='\E[32m'  #green
style_error='\E[31m' #red

echo "#########################################################" $reset_terminal
echo "#####Startup Terminal Device Management all services#####" $reset_terminal
echo "#########################################################" $reset_terminal

#20181012
cd /opt/terminal/bin/management_scripts

#0. Stop all services
#If node processes still alive can lead to troubles. 
/bin/bash ./service_stop.sh>>/dev/null

###########################################################
#20181009 strategy begin 
#
#0. Archive all logs
/bin/bash ./logs_archive_and_clean.sh>>/dev/null

#0. Clean upload temp files
if [ -d '/opt/terminal/bin/hbfec_upgrades/upload' ]; then
  rm -rf /opt/terminal/bin/hbfec_upgrades/upload/*
fi
#20181009 strategy end
###########################################################

#1. start up MongoDB
echo 'Starting up MongoDB...'
mongod -f /etc/mongodb.conf --fork>>/dev/null

#2. start up Redis
echo 'Starting up Redis...'
service redis-server start>>/dev/null

#3. start up GenieACS
echo 'Starting up GenieACS (cwmp, fs, nbi)...'
pushd /opt/terminal/bin/genieacs>>/dev/null
npm start
popd>>/dev/null

#4. start up hbfec_upgrades
echo 'Starting up hbfec_upgrades and offline_mon...'
pushd /opt/terminal/bin/hbfec_upgrades/bin>>/dev/null
/bin/bash ./start.sh>>/dev/null
popd>>/dev/null

#5. start up Nginx
echo 'Starting up Nginx...'
service nginx start

#6. Check all services status
/bin/bash ./service_status.sh
