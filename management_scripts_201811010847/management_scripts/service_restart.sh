#!/bin/bash
#author: liuyang
#since:  2018/10/10

#20181012
#cd /home/liuyang/workspace_shell/
cd /opt/terminal/bin/management_scripts

#1. stop all services
/bin/bash ./service_stop.sh

#2. start all services
/bin/bash ./service_start.sh
