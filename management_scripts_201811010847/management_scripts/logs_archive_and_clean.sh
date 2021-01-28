#!/bin/bash
#author: liuyang
#since:  2018/10/10
#NOTE:   This script process sequence:
#	 step1: Stop all the services first
#	 step2: Backup and Clean logs when processes related to the log are inactive
#	 This script DO NOT start all the services, Because service_start.sh dan service_restart.sh will call this script! 

reset_terminal=$(tput sgr0)
style_info='\E[32m'   #green
style_error='\E[31m'  #red
style_prompt='\E[34m' #blue

echo "#########################################################" $reset_terminal
echo "################logs archive and clean###################" $reset_terminal
echo "#########################################################" $reset_terminal

#20181012
#cd /home/liuyang/workspace_shell/
cd /opt/terminal/bin/management_scripts

LOG_PATH='/var/log/hbfec/terminal'
TIME_STR=$(date "+%Y%m%d%H%M%S")
BACKUP_DIR_NAME=$TIME_STR'_logs_archived'
PATH_BACKUP_TO=$LOG_PATH'/'$BACKUP_DIR_NAME
TARGET_COMPRESSED_FILE_NAME=$BACKUP_DIR_NAME'.tar.gz'

LOG_FILE_NAME='archive_and_clean_logs_'$TIME_STR'.log'
PATH_LOG_FILE=$LOG_PATH'/'$LOG_FILE_NAME


##############################################################
#STEP1: Stoping all the services...
echo -e $style_info"STEP1: Stoping all the services..." $reset_terminal
/bin/bash ./service_stop.sh>>$PATH_LOG_FILE


##############################################################
#SETP2: Backup and Clean logs when processes related to the log are inactive
echo -e $style_info"SETP2: Backup and Clean logs when processes related to the log are inactive" $reset_terminal

#0. create log parent directory
if [ ! -d $LOG_PATH ]; then
  mkdir -p $LOG_PATH
  chmod -R 755 $LOG_PATH
fi

#1. create backup directory name
if [ ! -d $PATH_BACKUP_TO ]; then
  mkdir -p $PATH_BACKUP_TO
  chmod -R 755 $PATH_BACKUP_TO
fi

#2. copy log files and clean
#nginx
echo -e $style_info"  backupand clean nginx logs ..." $reset_terminal
ret=$(service nginx status | grep 'is not running' | grep -v 'grep' -c)
if [ $ret -ge 1 ]; then
  cp -aR /var/log/nginx/access.log $PATH_BACKUP_TO
  cp -aR /var/log/nginx/error.log $PATH_BACKUP_TO
  echo "">/var/log/nginx/access.log
  echo "">/var/log/nginx/error.log
fi

#mongodb
echo -e $style_info"  backupand clean mongodb logs ..." $reset_terminal
ret=$(ps -ef | grep mongod | grep -v 'grep' -c)
if [ $ret -lt 1 ]; then
  cp -aR /var/log/mongodb/mongodb.log $PATH_BACKUP_TO  
  echo "">/var/log/mongodb/mongodb.log
fi

#GenieACS cwmp
echo -e $style_info"  backupand clean GenieACS cwmp logs ..." $reset_terminal
ret=$(ps -ef | grep node | grep cwmp | grep -v 'grep' -c)
if [ $ret -lt 1 ]; then
  cp -aR /var/cwmp.log $PATH_BACKUP_TO
  echo "">/var/cwmp.log
fi

#GenieACS fs
echo -e $style_info"  backupand clean GenieACS fs logs ..." $reset_terminal
ret=$(ps -ef | grep node | grep fs | grep -v 'grep' -c)
if [ $ret -lt 1 ]; then
  cp -aR /var/fs.log $PATH_BACKUP_TO
  echo "">/var/fs.log	
fi

#GenieACS nbi
echo -e $style_info"  backupand clean GenieACS nbi logs ..." $reset_terminal
ret=$(ps -ef | grep node | grep nbi | grep -v 'grep' -c)
if [ $ret -lt 1 ]; then
  cp -aR /var/nbi.log $PATH_BACKUP_TO
  echo "">/var/nbi.log
fi


#hbfec_upgrades
echo -e $style_info"  backupand clean hbfec_upgrades logs ..." $reset_terminal
ret1=$(ps -ef | grep node | grep upgrades_controller | grep -v 'grep' -c)	#old app name,before refactor. @deprecated
ret2=$(ps -ef | grep node | grep app | grep -v 'grep' -c)			#new app name,after refacor
if [ $ret1 -ge 1 -o $ret2 -ge 1 ]; then
  #echo -e $style_info"hbfec_upgrades status [ok]" $reset_terminal
  echo "">/dev/null
else
  #echo -e $style_error"hbfec_upgrades status [down]" $reset_terminal
  cp -aR /opt/terminal/bin/hbfec_upgrades/log/upgrades.log $PATH_BACKUP_TO
  echo "">/opt/terminal/bin/hbfec_upgrades/log/upgrades.log
fi

echo -e $style_info"  backupand clean offline_mon logs ..." $reset_terminal
ret=$(ps -ef | grep node | grep service_offline_mon | grep -v 'grep' -c)
if [ $ret -ge 1 ]; then
  #echo -e $style_info"[ok]" $reset_terminal
  echo "">/dev/null
else 
  #echo -e $style_error"[down]" $reset_terminal
  cp -aR /opt/terminal/bin/hbfec_upgrades/log/offline.log $PATH_BACKUP_TO
  echo "">/opt/terminal/bin/hbfec_upgrades/log/offline.log
fi


#3. compress logs
pushd $LOG_PATH>>/dev/null
tar -cvzf $TARGET_COMPRESSED_FILE_NAME $BACKUP_DIR_NAME>>$PATH_LOG_FILE

#4. delete directory
rm -rf $PATH_BACKUP_TO


##############################################################
#STEP3: Statr all services.
#echo -e $style_info"STEP3: Start all the services..." $reset_terminal
#popd
#/bin/bash ./service_start.sh>>$PATH_LOG_FILE


echo -e $style_info"Logs Archive and Clean completed. " $reset_terminal
echo -e $style_info"File output to: "$LOG_PATH'/'$TARGET_COMPRESSED_FILE_NAME
echo -e $style_info"This script has stoped all the services."
echo -e $style_info"Please run "$style_prompt"service hbfecterminal start"$style_info"or run"$style_prompt"service_start.sh"$style_info"manually if you want all the services work again." $reset_terminal 

