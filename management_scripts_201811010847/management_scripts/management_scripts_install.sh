#!/bin/bash
#author: liuyang
#since : 2018/10/12
#regist these scripts to os environment
#0. copy files to /opt/terminal/bin/management_scripts
#1. create links to  /usr/bin  
#2. create links to  /etc/init.d
#3. create links to  /etc/rc0.d (shutdown os)
#4. create links to  /etc/rc2.d /etc/rc3.d /etc/rc4.d /etc/rc5.d (normal startup os) 
#5. create links to  /etc/rc6.d (reboot os)

#SCRIPTS_DIRECTORY='/home/liuyang/workspace_shell'
SCRIPTS_DIRECTORY='/opt/terminal/bin/management_scripts'
SCRIPTS_DIRECTORY_FROM=`pwd`

SCRIPT_NAME_BUILD_AND_PUBLIS_TERMINALWEB='build_and_publish_terminalweb.sh'
SCRIPT_NAME_LOGS_ARCHIVE_AND_CLEAN='logs_archive_and_clean.sh'
SCRIPT_NAME_LOGS_BACKUP='logs_backup.sh'
SCRIPT_NAME_SERVICE_RESTART='service_restart.sh'
SCRIPT_NAME_SERVICE_START='service_start.sh'
SCRIPT_NAME_SERVICE_STATUS='service_status.sh'
SCRIPT_NAME_SERVICE_STOP='service_stop.sh'
SCRIPT_NAME_HBFECTERMINAL_INIT='hbfecterminal_init.d.sh'


#You can rename the script link without changing the real script name.
LN_NAME_BUILD_AND_PUBLIS_TERMINALWEB='build_and_publish_terminalweb'
LN_NAME_LOGS_ARCHIVE_AND_CLEAN='logs_archive_and_clean'
LN_NAME_LOGS_BACKUP='logs_backup'
LN_NAME_SERVICE_RESTART='service_restart'
LN_NAME_SERVICE_START='service_start'
LN_NAME_SERVICE_STATUS='service_status'
LN_NAME_SERVICE_STOP='service_stop'
LN_NAME_HBFECTERMINAL_INIT='hbfecterminal'
LN_NAME_SERVICE_START_AUTO='service_start_auto'


#For os auto execute. DO NOT change the name, especially the number.
LN_NAME_RCN_SERVICE_START='S98service_start'
LN_NAME_RCN_SERVICE_STOP='K20service_stop'


##################################
#0. copy files to /opt/terminal/bin/management_scripts 
if [ ! -d $SCRIPTS_DIRECTORY ]; then
  mkdir -p $SCRIPTS_DIRECTORY
fi
FROM=$SCRIPTS_DIRECTORY_FROM'/*'
TO=$SCRIPTS_DIRECTORY
cp -arf $FROM $TO 
chmod -R 755 $SCRIPTS_DIRECTORY


##################################
#1. create links to  /usr/bin
FROM=$SCRIPTS_DIRECTORY'/'$SCRIPT_NAME_BUILD_AND_PUBLIS_TERMINALWEB
TO='/usr/bin/'$LN_NAME_BUILD_AND_PUBLIS_TERMINALWEB  
ARGS=$FROM' '$TO
if [ ! -f $TO ]; then
  ln -s $ARGS
fi

FROM=$SCRIPTS_DIRECTORY'/'$SCRIPT_NAME_LOGS_ARCHIVE_AND_CLEAN
TO='/usr/bin/'$LN_NAME_LOGS_ARCHIVE_AND_CLEAN
ARGS=$FROM' '$TO
if [ ! -f $TO ]; then
  ln -s $ARGS
fi

FROM=$SCRIPTS_DIRECTORY'/'$SCRIPT_NAME_LOGS_BACKUP
TO='/usr/bin/'$LN_NAME_LOGS_BACKUP
ARGS=$FROM' '$TO
if [ ! -f $TO ]; then
  ln -s $ARGS
fi

FROM=$SCRIPTS_DIRECTORY'/'$SCRIPT_NAME_SERVICE_RESTART
TO='/usr/bin/'$LN_NAME_SERVICE_RESTART
ARGS=$FROM' '$TO
if [ ! -f $TO ]; then
  ln -s $ARGS
fi

FROM=$SCRIPTS_DIRECTORY'/'$SCRIPT_NAME_SERVICE_START
TO='/usr/bin/'$LN_NAME_SERVICE_START
ARGS=$FROM' '$TO
if [ ! -f $TO ]; then
  ln -s $ARGS
fi

FROM=$SCRIPTS_DIRECTORY'/'$SCRIPT_NAME_SERVICE_STATUS
TO='/usr/bin/'$LN_NAME_SERVICE_STATUS  
ARGS=$FROM' '$TO
if [ ! -f $TO ]; then
  ln -s $ARGS
fi

FROM=$SCRIPTS_DIRECTORY'/'$SCRIPT_NAME_SERVICE_STOP
TO='/usr/bin/'$LN_NAME_SERVICE_STOP
ARGS=$FROM' '$TO
if [ ! -f $TO ]; then
  ln -s $ARGS
fi


##################################
#2. create links to  /etc/init.d
FROM=$SCRIPTS_DIRECTORY'/'$SCRIPT_NAME_BUILD_AND_PUBLIS_TERMINALWEB
TO='/etc/init.d/'$LN_NAME_BUILD_AND_PUBLIS_TERMINALWEB  
ARGS=$FROM' '$TO
if [ ! -f $TO ]; then
  ln -s $ARGS
fi

FROM=$SCRIPTS_DIRECTORY'/'$SCRIPT_NAME_LOGS_ARCHIVE_AND_CLEAN
TO='/etc/init.d/'$LN_NAME_LOGS_ARCHIVE_AND_CLEAN
ARGS=$FROM' '$TO
if [ ! -f $TO ]; then
  ln -s $ARGS
fi

FROM=$SCRIPTS_DIRECTORY'/'$SCRIPT_NAME_LOGS_BACKUP
TO='/etc/init.d/'$LN_NAME_LOGS_BACKUP
ARGS=$FROM' '$TO
if [ ! -f $TO ]; then
  ln -s $ARGS
fi

FROM=$SCRIPTS_DIRECTORY'/'$SCRIPT_NAME_SERVICE_RESTART
TO='/etc/init.d/'$LN_NAME_SERVICE_RESTART
ARGS=$FROM' '$TO
if [ ! -f $TO ]; then
  ln -s $ARGS
fi

FROM=$SCRIPTS_DIRECTORY'/'$SCRIPT_NAME_SERVICE_START
TO='/etc/init.d/'$LN_NAME_SERVICE_START
ARGS=$FROM' '$TO
if [ ! -f $TO ]; then
  ln -s $ARGS
fi

FROM=$SCRIPTS_DIRECTORY'/'$SCRIPT_NAME_SERVICE_STATUS
TO='/etc/init.d/'$LN_NAME_SERVICE_STATUS  
ARGS=$FROM' '$TO
if [ ! -f $TO ]; then
  ln -s $ARGS
fi

FROM=$SCRIPTS_DIRECTORY'/'$SCRIPT_NAME_SERVICE_STOP
TO='/etc/init.d/'$LN_NAME_SERVICE_STOP
ARGS=$FROM' '$TO
if [ ! -f $TO ]; then
  ln -s $ARGS
fi

#NOTE! IMPORTANT TO AUTO STARTUP! REGIST AS SERVICE!
FROM=$SCRIPTS_DIRECTORY'/'$SCRIPT_NAME_HBFECTERMINAL_INIT
TO='/etc/init.d/'$LN_NAME_HBFECTERMINAL_INIT
ARGS=$FROM' '$TO
if [ ! -f $TO ]; then
  ln -s $ARGS
fi


##################################
#3. create links to  /etc/rc0.d (shutdown os)
#FROM='/etc/init.d/'$LN_NAME_SERVICE_STOP
FROM='/etc/init.d/'$LN_NAME_HBFECTERMINAL_INIT
TO='/etc/rc0.d/'$LN_NAME_RCN_SERVICE_STOP
ARGS=$FROM' '$TO
if [ ! -f $TO ]; then
  ln -s $ARGS
fi


##################################
#4. create links to  /etc/rc2.d /etc/rc3.d /etc/rc4.d /etc/rc5.d (normal startup os) 
#/etc/rc2.d 
#FROM='/etc/init.d/'$LN_NAME_SERVICE_START
FROM='/etc/init.d/'$LN_NAME_HBFECTERMINAL_INIT
TO='/etc/rc2.d/'$LN_NAME_RCN_SERVICE_START
ARGS=$FROM' '$TO
if [ ! -f $TO ]; then
  ln -s $ARGS
fi

#/etc/rc3.d 
#FROM='/etc/init.d/'$LN_NAME_SERVICE_START
FROM='/etc/init.d/'$LN_NAME_HBFECTERMINAL_INIT
TO='/etc/rc3.d/'$LN_NAME_RCN_SERVICE_START
ARGS=$FROM' '$TO
if [ ! -f $TO ]; then
  ln -s $ARGS
fi

#/etc/rc4.d 
#FROM='/etc/init.d/'$LN_NAME_SERVICE_START
FROM='/etc/init.d/'$LN_NAME_HBFECTERMINAL_INIT
TO='/etc/rc4.d/'$LN_NAME_RCN_SERVICE_START
ARGS=$FROM' '$TO
if [ ! -f $TO ]; then
  ln -s $ARGS
fi

#/etc/rc5.d
#FROM='/etc/init.d/'$LN_NAME_SERVICE_START
FROM='/etc/init.d/'$LN_NAME_HBFECTERMINAL_INIT
TO='/etc/rc5.d/'$LN_NAME_RCN_SERVICE_START
ARGS=$FROM' '$TO
if [ ! -f $TO ]; then
  ln -s $ARGS
fi


##################################
#5. create links to  /etc/rc6.d (reboot os)
#FROM='/etc/init.d/'$LN_NAME_SERVICE_STOP
FROM='/etc/init.d/'$LN_NAME_HBFECTERMINAL_INIT
TO='/etc/rc0.d/'$LN_NAME_RCN_SERVICE_STOP
ARGS=$FROM' '$TO
if [ ! -f $TO ]; then
  ln -s $ARGS
fi


echo "management scripts install completed"
