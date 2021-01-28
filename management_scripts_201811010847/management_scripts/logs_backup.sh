#!/bin/bash
#author: liuyang
#since:  2018/10/10

reset_terminal=$(tput sgr0)
style_info='\E[32m'   #green
style_error='\E[31m'  #red

echo "#########################################################" $reset_terminal
echo "######################logs backup########################" $reset_terminal
echo "#########################################################" $reset_terminal

#20181012
#cd /home/liuyang/workspace_shell/
cd /opt/terminal/bin/management_scripts

LOG_PATH='/var/log/hbfec/terminal'
BACKUP_DIR_NAME=$(date "+%Y%m%d%H%M%S")'_logs_backup'
PATH_BACKUP_TO=$LOG_PATH'/'$BACKUP_DIR_NAME
TARGET_COMPRESSED_FILE_NAME=$BACKUP_DIR_NAME'.tar.gz'

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

#2. copy log files
echo -e $style_info"STEP1: copying log files..." $reset_terminal
cp -aR /var/log/nginx/access.log $PATH_BACKUP_TO
cp -aR /var/log/nginx/error.log $PATH_BACKUP_TO
cp -aR /var/log/mongodb/mongodb.log $PATH_BACKUP_TO
cp -aR /var/cwmp.log $PATH_BACKUP_TO
cp -aR /var/fs.log $PATH_BACKUP_TO
cp -aR /var/nbi.log $PATH_BACKUP_TO
cp -aR /opt/terminal/bin/hbfec_upgrades/log/upgrades.log $PATH_BACKUP_TO
cp -aR /opt/terminal/bin/hbfec_upgrades/log/offline.log $PATH_BACKUP_TO

#3. compress logs
echo -e $style_info"STEP2: compressing log files..." $reset_terminal
cd $LOG_PATH
tar -czf $TARGET_COMPRESSED_FILE_NAME $BACKUP_DIR_NAME

#4. delete directory
rm -rf $PATH_BACKUP_TO

echo -e $style_info"Logs backup completed. " $reset_terminal
echo -e $style_info"File output to: "$LOG_PATH'/'$TARGET_COMPRESSED_FILE_NAME $reset_terminal
