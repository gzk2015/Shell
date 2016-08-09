#!/bin/bash
#tomcat restart script
#gzk 20150729
#v1 
#v2 at 20160309
#--coding:utf-8--
#changes for base and ymv4
export PATH=$PATH:/opt/yingmoo/maven/bin

#var of tomcat
PRO=base
daemon=/opt/yingmoo/tomcat/bin/catalina-$PRO.sh
port=8080
pid=`lsof -i:$port -t`

#var of projects
url="http://211.103.211.154:88/svn/yingmoo/BaseService"
proname=`basename $url`
packagename=ym_baseService-0.0.1-SNAPSHOT
logfile=/home/logs/tomcat/catalina-$PRO.out
datetime=`date +%Y%m%d`


#############################################################################
#check lsof is/not exist
#add fllow 
#
#clear temp code dir; if not exist create it 
#if [ -d /home/httpd/tmpcode ];then
#	rm -rf /home/httpd/tmpcode/*
#else
#	mkdir -p /home/httpd/tmpcode
#fi
#cd /home/httpd/tmpcode/
#
#functions
#build() {
#	
#	svn co --username=sys --password=sys@yingmoo  $url
#	cd $proname
#	mvn clean package -Ppro
#	if [ $? -eq 0 ];then
#		cp -a target/packagename  /home/httpd/
#	else
#		echo "error,check output info!"
#		exit 1
#	fi
#}
#############################################################################

build1() {

	cd /home/httpd/tmpcode/$proname
	svn up
	mvn clean package -Ppro
	if [ $? -eq 0 ];then
        	cp -a ./target/$packagename  /home/httpd/
#config mysql fdfs 
		cd /home/httpd/ym_baseService-0.0.1-SNAPSHOT/WEB-INF/classes
	        sed  -i  34s/172.16.10.3/192.168.1.195/g spring-mybatis.xml
	        sed  -i  40s/1qa2ws3ed/YM7s1Kdzfj0sT195z/g spring-mybatis.xml
        	sed  -i  73s/172.16.10.3:3306/192.168.1.195:3307/g spring-mybatis.xml 
        	sed  -i  76s/yingmoo/leduser/g spring-mybatis.xml 
        	sed  -i  79s/1qa2ws3ed/nf73dMqA96pQ#Fov07/g spring-mybatis.xml 
        	sed  -i 1s/172.16.10.3/192.168.1.198/g ./redis.properties 
        	sed  -i 10s/172.16.10.3/192.168.1.198/g ./redis.properties 
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
	build1
	;;
	*)
	echo "useage:{start|stop|restart|taillog|check}"
	;;
esac

	
