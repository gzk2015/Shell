#!/bin/bash
#set ip of host
#
#20160304  ver 0.1  powerd by gzk


interface=$2
configfile='ifcfg-'$interface

#change dir to config directory
cd /etc/sysconfig/network-scripts


## enable interface
enable_if () {
	if [ -f $configfile ]; then
		sed -i s/ONBOOT=no/ONBOOT=yes/g  $configfile
		restart
	else
		echo "error! no such file as $configfile!"
	fi
}

#set ip of interface
set_static () {
	if [ -f $configfile ]; then
                sed -i s/ONBOOT=no/ONBOOT=yes/g  $configfile
		sed -i s/dhcp/static/g $configfile
		read -p "enter ip address:" ip 
		read -p "enter netmask:" netmask
		read -p  "enter gateway:" gateway

		echo "IPADDR=$ip" >>$configfile
		echo "NETMASK=$netmask" >>$configfile
		echo "GATEWAY=$gateway" >>$configfile
		echo "-------------------------------------------------"
		restart 
        else
                echo "error! no such file as $configfile!"
        fi
}

restart() {
	echo "check configfile correct or not?"
	echo "-------------------------------------------------"
	cat $configfile
	echo "-------------------------------------------------"
	read -p "enter yes/no:" YN
	echo "-------------------------------------------------"
	if [ $YN == yes ];then
		ifdown $interface
		sleep 1
		ifup $interface
	else
		echo "check the configuration mannal!"
		exit 9 
	fi
}

	


case $1 in 
	enable)
	enable_if $2
	;;

	static)
	set_static
	;;

	*)
	echo "usage: setip.sh [enable|static] [eth0|em1|...]"
	;;

esac
	
	

	

