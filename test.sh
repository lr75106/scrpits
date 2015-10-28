#!/bin/bash
#清除 版本2

LOG_DIR=/var/log
ROOT_UID=0       #uid为0时，用户才具有root用户权限
LINES=50         #默认的保存行数
E_XCD=66
E_NOTROOT=67     #非root用户以error退出

if [ "$UID" -ne "$ROOT_UID" ]
then
    echo "Must be root to run this script."
    exit $E_NOTROOT
fi

if [ -n "$1" ]     #测试是否有命令行参数
then
    lines=$1
else
    lines=$LINES
fi

cd $LOG_DIR 

if [ `pwd` != "$LOG_DIR" ]  #或者 if["$pwd" != "$LOG_DIR"]
then  
    echo "Can't change to $LOG_DIR."
    exit $E_XCD
fi                        #在处理log file 之前，再确认一遍当前目录是否正确

# 更有效的做法：
# cd /var/log || {
#    echo "Cannot change to necessary directory." >&2
#    exit $E_XCD;
#}
#
#

tail -$lines messages > mesg.temp   #保存log file 消息的最后部分
mv mesg.temp messages

cat /dev/null > wtmp                #': > wtmp'  和 '> wtmp'具有相同的作用
echo "logs cleaned up."

exit 0
#退出前返回0，
#返回0表示成功。
