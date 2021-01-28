#!/bin/bash
#author:liuyang
#since: 2018/10/9
#desc:  build terminal_web and then publish to nginx
#NOTE:  for vue-element-admin 3.7.0 (CURRENT VERSION) the output folder name is "public". 
#	for vue-element-admin 3.9.0 the output folder name is "dist" not "public".

reset_terminal=$(tput sgr0)
style_info='\E[32m'   #green
style_error='\E[31m'  #red

echo "#########################################################" $reset_terminal
echo "######Building and Publishing terminal_web to Nginx######" $reset_terminal
echo "#########################################################" $reset_terminal

#20181012
#cd /home/liuyang/workspace_shell/
cd /opt/terminal/bin/management_scripts

PATH_TERMINAL_WEB='/opt/terminal/bin/terminal_web'
PATH_NGINX_WEB_ROOT='/usr/share/nginx/html'

PATH_BUILD_OUTPUT_FOLDER=$PATH_TERMINAL_WEB'/public' #vue-element-admin 3.7.0
#PATH_BUILD_OUTPUT_FOLDER=$PATH_TERMINAL_WEB'/dist'  #vue-element-admin 3.9.0

PUBLISH_FILES_CLEAN=$PATH_NGINX_WEB_ROOT'/*'
PUBLISH_FILES_COPY_FROM=$PATH_BUILD_OUTPUT_FOLDER'/*'
PUBLISH_PATH_COPY_TO=$PATH_NGINX_WEB_ROOT'/'

LOG_PATH='/var/log/hbfec/terminal'
BUILD_TERMINAL_WEB_LOG_NAME=$LOG_PATH'/build_terminal_web_'$(date "+%Y%m%d%H%M%S")'.log'


#0. create log parent directory
if [ ! -d $LOG_PATH ]; then
  mkdir -p $LOG_PATH
  chmod -R 755 $LOG_PATH
fi


#1. build terminal_web
echo -e $style_info"STEP1: Building terminal_web..." $reset_terminal
echo -e $style_info"  This may take several minutes. Please wait for a while." $reset_terminal
#timer begin 
str_date_begin=$(date "+%Y-%m-%d %H:%M:%S")
echo -e $style_info"  Build Tasks Begin at   : "$str_date_begin $reset_terminal
cd $PATH_TERMINAL_WEB
npm run build:prod>$BUILD_TERMINAL_WEB_LOG_NAME
#timer end
str_date_complete=$(date "+%Y-%m-%d %H:%M:%S")
echo -e $style_info"  Build Tasks Complete at: "$str_date_complete $reset_terminal


#2. publish to nginx
echo -e $style_info"STEP2: Publishing files to Nginx" $reset_terminal
echo -e $style_info"  FROM "$PUBLISH_FILES_COPY_FROM $reset_terminal
echo -e $style_info"  TO   "$PUBLISH_PATH_COPY_TO $reset_terminal
rm -rf $PUBLISH_FILES_CLEAN
cp -aR $PUBLISH_FILES_COPY_FROM $PUBLISH_PATH_COPY_TO

#3. Prompt
echo -e $style_info"Publish has completed." $reset_terminal
echo -e $style_info"Build log see: "$BUILD_TERMINAL_WEB_LOG_NAME $reset_terminal



