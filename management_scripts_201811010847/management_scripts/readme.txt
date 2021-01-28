#终端维护软件管理脚本集
#author :liuyang
#since  :2018/10/09

#编写脚本的目的：
完成服务自启动、停止、重启、日志归档、当前日志备份、terminal_web工程编译和发布

#发布方式：
直接打包至发布包根路径的management_scripts文件夹下
安装脚本（发布包的安装脚本install.sh）负责把程序发布至/opt/terminal/bin/management_scripts/下

#安装
执行 /opt/terminal/bin/management_scripts/management_script_install.sh

#卸载
执行 /opt/terminal/bin/management_scripts/management_script_uninstall.sh

#使用：常用操作
sudo service hbfecterminal start             #启动所有组件
sudo service hbfecterminal stop              #停止
sudo service hbfecterminal restart           #重启
sudo service hbfecterminal status            #查看所有组件状态
#使用：部署前端应用时使用
sudo service hbfecterminal build             #构建并发布前端应用程序            
#使用：故障诊断收集日志时使用
sudo service hbfecterminal backuplog         #备份日志
sudo service hbfecterminal archivelog        #归档日志（正常情况下不需要手动执行，服务重启前会自动做日志的归档和清理）
#使用：命令提示，查看可用操作
sudo service hbfecterminal

#脚本介绍：
build_and_publish_terminalweb.sh    
    编译和发布终端软件到nginx
hbfecterminal_init.d.sh
    将维护脚本在注册在操作系统中
    适用版本：Ubuntu 14.04 LTS。 注：Ubuntu 18.04 LTS采用systemd引导，而不是system-v方式，需要少量重新适配工作。
logs_archive_and_clean.sh
    归档并清理终端维护软件相关组件日志
    每次执行将清理运行时日志
    打包压缩发布至/var/log/hbfec/terminal/XXXX_logs_archived.tar.gz中，XXXX是时间戳。
logs_backup.sh
    备份当前运行日志
    不清空当前运行日志，
    打包压缩发布至/var/log/hbfec/terminal/XXXX_logs_backup.tar.gz中，XXXX是时间戳。
management_script_install.sh
    安装管理脚本
    1. 将脚本复制到目标文件夹/opt/terminal/bin/management_scripts
    2. 在操作系统环境中注册（符号链接）管理脚本
    执行之后，可以在shell中使用如service hbfecterminal start等命令
management_script_uninstall.sh
    卸载管理脚本
    清理在操作系统中注册的管理脚本符号链接，不删除管理文件夹本身。（交由其他调用脚本执行，目前在uninstall.sh中会删除/opt/terminal整个文件夹）
service_restart.sh
    重启所有组件
service_start.sh
    启动所有组件
service_status.sh
    查看系统组件服务状态
service_stop.sh
    停止所有组件
