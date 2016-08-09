#!/bin/bash
# tomcat restart script
# gzk 20150729
# v1 
# v2 at 20160309
# v2.1 at 20160310
# --coding:utf-8--
#common scripts for busi member media

export PATH=$PATH:/opt/yingmoo/maven/bin

#var of tomcat
#
PRO=media
daemon=/opt/yingmoo/tomcat/bin/catalina-$PRO.sh
port=8080
pid=`lsof -i:$port -t`

#var of projects
#
datetime=`date +%Y-%m-%d-%H`
packagename=mediaService
logfile=/home/logs/tomcat/catalina-$PRO.out
url="http://211.103.211.154:88/svn/yingmoo/ym-mediaService"
proname=`basename $url`


#
#clear temp code dir; if not exist create it 
#
clear_tmpdir() {
	if [ -d /home/httpd/tmpcode ];then
		rm -rf /home/httpd/tmpcode/*
	else
		mkdir -p /home/httpd/tmpcode
	fi
	cd /home/httpd/tmpcode/
}
#
#functions
#
build() {

	clear_tmpdir	
	svn co --username=sys --password=sys@yingmoo  $url
	cd $proname
	mvn clean package -U -Ppro
	if [ $? -eq 0 ];then
		cp -a target/$packagename  /home/httpd/
	else
		echo "error,check output info!"
		exit 1
	fi
}

back() {
	cd /home/httpd/
	if [ -d $packagename ];then
		mv $packagename  ${packagename}_$datetime
	else
		echo "No such file existed:$packagename"
	fi
}

start() {
	if [ $pid ];then
		echo "Tomcat::$port already running!"
	else
		echo "Start tomcat.....$port"
		$daemon start
		echo "========================================================"
	fi
}

stop() {
	echo "========================================================"
	echo "Stopping tomcat.....$port"
	kill $pid
	sleep 2
	pidtemp=`lsof -i:$port -t`
	if [ $pidtemp ! = 0 ];then
		kill -9 $pid
	fi
}

cleancache() {
	echo "delete cache..."
	cd /opt/yingmoo/tomcat/work
#	pwd
	rm -rf ./*
}

check() {
	ps aux | grep $PRO
}

push() {
#push tested package to online environment
#coding  
#finished in ver3
}

case $1 in 
	start)
	start
	;;
	stop)
	stop
	;;
	taillog)
	tail -f $logfile
	;;
	check)
	check
	;;
	back)
	back
	;;
	build)
	build
	;;
	*)
	echo "useage:{start|stop|restart|taillog|check}"
	;;
esac

	
