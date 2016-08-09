#!/bin/bash
#tomcat restart script
#gzk 20150729
#v1 
#v2 at 20160309
#--coding:utf-8--
#for search onle
#

export PATH=$PATH:/opt/yingmoo/maven/bin

project=luceneService-0.0.1-SNAPSHOT
exec=search
port=8080
programpath=/opt/yingmoo/tomcat
PID=`lsof -i:$port -t`
LOG=/home//logs/tomcat/catalina-${exec}.out
DATE=`date +%Y%m%d`
sourcecode="http://211.103.211.154:88/svn/yingmoo/ym-lucene-parent-v4"


#
#check lsof is/not exist
#add fllow 

mkdir -p /home/httpd/tmpcode
cd /home/httpd/tmpcode

build() {
	codedir=`basename $sourcecode`
	if [ -d $codedir ];then 
		rm -rf $codedir 
	fi
	svn co --username=sys --password=sys@yingmoo  $sourcecode
	cd $codedir
	mvn clean package -Pprp
	cp -a ym-lucene-web/target/luceneService-0.0.1-SNAPSHOT  /home/httpd/
}



back() {
	cd /home/httpd/
	if [ -d ${project} ];then
		mv ${project} ${project}_${DATE}
	else
		echo "No such file existed:${project}"
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

#stop program

stop() {
	echo "========================================================"
	echo "Stopping tomcat.....$port"
	kill $PID
	sleep 2
	pidtemp=`lsof -i:$port -t`
	if [ $pidtemp != 0 ];then
		kill -9 $PID
	fi
}


#cleancache() {
#	echo "delete cache..."
#	cd $PROGRAMPATH/work
#	pwd
#	rm -rf  ./*
#}

check() {
	ps aux | grep $exec
}


case $1 in 
	start)
	start
	;;
	stop)
	stop
	;;
	taillog)
	tail -f $LOG
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

	
