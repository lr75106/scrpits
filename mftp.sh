#! /bin/bash

#update frome a server

#version   v0.1    2015/11/26  lr75106 

configure()
{
host=192.168.10.252
name=test
passwd=123456
server_path='/ftp/www'
local_path='/home/lr75106'
file_name=test.sh
}
sed_cfg()
{
host=$(sed -n '1p' configure.ftp)
echo host=$host
name=$(sed -n '2p' configure.ftp)
echo name=$name
passwd=$(sed -n '3p' configure.ftp)
echo passwd=$passwd
server_path=$(sed -n '4p' configure.ftp)
echo server_path=$server_path
local_path=$(sed -n '5p' configure.ftp)
echo local_path=$local_path
file_name=$(sed -n '6p' configure.ftp)
echo file_name=$file_name
}
check_and_install()
{
    echo 2
    md5sum $file_name > check.md5
    md5sum -c check.md5
    if [ $? -eq 0 ];
    then
        echo check correct
       # dpkg -i file_name && echo install successful
    else
        echo check error
    fi
}


#link ftp server---------------
#configure
sed_cfg
ftp -n<<!
open $host
user $name $passwd
binary
cd $server_path
lcd $local_path
prompt
get $file_name
close
bye
!
check_and_install
