#!/bin/bash
#author: liuyang
#since : 2018/10/17
#remove these scripts to os environment
#1. remove links from  /usr/bin  
#2. remove links from  /etc/init.d
#3. remove links from  /etc/rc0.d (shutdown os)
#4. remove links from  /etc/rc2.d /etc/rc3.d /etc/rc4.d /etc/rc5.d (normal startup os) 
#5. remove links from  /etc/rc6.d (reboot os)

#MUST BE THE SAME NAME AS IN management_scripts_install.sh BEGIN
#You can rename the script link without changing the real script name.
LN_NAME_BUILD_AND_PUBLIS_TERMINALWEB='build_and_publish_terminalweb'
LN_NAME_LOGS_ARCHIVE_AND_CLEAN='logs_archive_and_clean'
LN_NAME_LOGS_BACKUP='logs_backup'
LN_NAME_SERVICE_RESTART='service_restart'
LN_NAME_SERVICE_START='service_start'
LN_NAME_SERVICE_STATUS='service_status'
LN_NAME_SERVICE_STOP='service_stop'
LN_NAME_HBFECTERMINAL_INIT='hbfecterminal'

#For os auto execute. DO NOT change the name, especially the number.
LN_NAME_RCN_SERVICE_START='S98service_start'
LN_NAME_RCN_SERVICE_STOP='K20service_stop'
#MUST BE THE SAME NAME AS IN management_scripts_install.sh BEGIN


#1. remove links from /usr/bin  
rm -rf /usr/bin/$LN_NAME_BUILD_AND_PUBLIS_TERMINALWEB
rm -rf /usr/bin/$LN_NAME_LOGS_ARCHIVE_AND_CLEAN
rm -rf /usr/bin/$LN_NAME_LOGS_BACKUP
rm -rf /usr/bin/$LN_NAME_SERVICE_RESTART
rm -rf /usr/bin/$LN_NAME_SERVICE_START
rm -rf /usr/bin/$LN_NAME_SERVICE_STATUS
rm -rf /usr/bin/$LN_NAME_SERVICE_STOP
rm -rf /usr/bin/$LN_NAME_HBFECTERMINAL_INIT


#2. remove links from  /etc/init.d
rm -rf /etc/init.d/$LN_NAME_BUILD_AND_PUBLIS_TERMINALWEB
rm -rf /etc/init.d/$LN_NAME_LOGS_ARCHIVE_AND_CLEAN
rm -rf /etc/init.d/$LN_NAME_LOGS_BACKUP
rm -rf /etc/init.d/$LN_NAME_SERVICE_RESTART
rm -rf /etc/init.d/$LN_NAME_SERVICE_START
rm -rf /etc/init.d/$LN_NAME_SERVICE_STATUS
rm -rf /etc/init.d/$LN_NAME_SERVICE_STOP
rm -rf /etc/init.d/$LN_NAME_HBFECTERMINAL_INIT


#3. remove links from /etc/rc0.d (shutdown os)
rm -rf /etc/rc0.d/$LN_NAME_RCN_SERVICE_STOP

echo "management scripts remove done!"

#4. remove links from /etc/rc2.d /etc/rc3.d /etc/rc4.d /etc/rc5.d (normal startup os) 
rm -rf /etc/rc2.d/$LN_NAME_RCN_SERVICE_START
rm -rf /etc/rc3.d/$LN_NAME_RCN_SERVICE_START
rm -rf /etc/rc4.d/$LN_NAME_RCN_SERVICE_START
rm -rf /etc/rc5.d/$LN_NAME_RCN_SERVICE_START

#5. remove links from /etc/rc6.d (reboot os)
rm -rf /etc/rc6.d/$LN_NAME_RCN_SERVICE_STOP

