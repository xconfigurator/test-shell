#!/bin/bash
#author:liuyang
#since: 2018/10/09

reset_terminal=$(tput sgr0)
style_info='\E[32m'  #green
style_error='\E[31m' #red

echo "#########################################################" $reset_terminal
echo "###Check Terminal Device Management all services status##" $reset_terminal
echo "#########################################################" $reset_terminal

#20181012
#cd /home/liuyang/workspace_shell/
cd /opt/terminal/bin/management_scripts

#1. Check MongoDB status
echo -ne "MongoDB\t\t"
ret=$(ps -ef | grep mongod | grep -v 'grep' -c)
if [ $ret -lt 1 ]; then
  echo -e $style_error"[down]" $reset_terminal
else 
  echo -e $style_info"[ok]" $reset_terminal
fi

#2. Check Redis status
echo -ne "Redis\t\t"
ret=$(service redis-server status | grep 'is running' | grep -v 'grep' -c)
if [ $ret -ge 1 ]; then
  echo -e $style_info"[ok]" $reset_terminal
fi
ret=$(service redis-server status | grep 'is not running' | grep -v 'grep' -c)
if [ $ret -ge 1 ]; then 
  echo -e $style_error"[down]" $reset_terminal  
fi

#3. Check GenieACS status
echo -ne "GenieACS - cwmp\t"
ret=$(ps -ef | grep node | grep cwmp | grep -v 'grep' -c)
if [ $ret -ge 1 ]; then
  echo -e $style_info"[ok]" $reset_terminal
else
  echo -e $style_error"[down]" $reset_terminal
fi

echo -ne "GenieACS - fs\t"
ret=$(ps -ef | grep node | grep fs | grep -v 'grep' -c)
if [ $ret -ge 1 ]; then
  echo -e $style_info"[ok]" $reset_terminal
else
  echo -e $style_error"[down]" $reset_terminal
fi

echo -ne "GenieACS - nbi\t"
ret=$(ps -ef | grep node | grep nbi | grep -v 'grep' -c)
if [ $ret -ge 1 ]; then
  echo -e $style_info"[ok]" $reset_terminal
else 
  echo -e $style_error"[down]" $reset_terminal
fi

#4. Check hbfec_upgrades status
echo -ne "hbfec_upgrades\t"
ret1=$(ps -ef | grep node | grep upgrades_controller | grep -v 'grep' -c)	#old app name,before refactor. @deprecated
ret2=$(ps -ef | grep node | grep app | grep -v 'grep' -c)			#new app name,after refacor
if [ $ret1 -ge 1 -o $ret2 -ge 1 ]; then
  echo -e $style_info"[ok]" $reset_terminal
else
  echo -e $style_error"[down]" $reset_terminal
fi

echo -ne "offline_mon\t"
ret=$(ps -ef | grep node | grep service_offline_mon | grep -v 'grep' -c)
if [ $ret -ge 1 ]; then
  echo -e $style_info"[ok]" $reset_terminal
else 
  echo -e $style_error"[down]" $reset_terminal
fi

#5. Check Nginx status
echo -ne "Nginx\t\t"
ret=$(service nginx status | grep 'is running' | grep -v 'grep' -c)
if [ $ret -ge 1 ]; then
  echo -e $style_info"[ok]" $reset_terminal
fi
ret=$(service nginx status | grep 'is not running' | grep -v 'grep' -c)
if [ $ret -ge 1 ]; then
  echo -e $style_error"[down]" $reset_terminal
fi

