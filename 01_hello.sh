echo "hello, bash"

# week 1 course

# man

# date
# date "+%Y-%m-%d %H:%M:%S Day %j"
# man date

# ntpdate
# ntpdate -q 0.pool.ntp.org # normal user query
# ntpdate 0.pool.ntp.org    # must be root to set

# cal
# cal year
# cal 2020
# cal month year
# cal 10 2020

# bc
# bc -l

# passwd

# who
# w
# tty
# who am i
# whoami

# uptime

# top

# ps
# ps -ef 
# ps -efl
# ps -fl

# free
# free -h

# vmstat
# vmstat 1

# df -h
# df -Th
# du -sh


# ctrl + d 

# more/less

# cat
# cat -n

# od
# od -t x1 test.data | more
# od -t d1 test.data | more

# head/tail
# netstat -s -p tcp | head
# ls -s | sort | head -n20

# tee
# ./myapp | tee myapp.log

# wc
# wc sum.c
# wc x.c makefile stat.sh
# wc -l *.c makefile start.sh
# ps -ef | wc -l
# ps -ef | grep liuyang | wc -l
# who | wc -l

# sort
# tr
# uniq

ls