#!/bin/bash
#tomcat restart script
#gzk 20150729
#v1
#

export PATH

port=8081
PROGRAMPATH=/usr/local/tomcat01
PID=`lsof -i:$port -t`
LOG=$PROGRAMPATH/logs/catalina.out
LOG2=

#start program use offical script

start() {

	echo "Start tomcat.....$port"

	cd  $PROGRAMPATH/bin
	./startup.sh

	echo "========================================================"

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


forcestop() {

	echo "========================================================"
	# kill tomcat force no wiat noarmal exit
	echo "kill tomcat....$port...."
	kill -9 $PID

	echo "========================================================"
}


cleancache() {

	echo "delete cache..."
	cd $PROGRAMPATH/work

#	pwd

	rm -rf  ./*

}

check() {

	ps aux | grep tomcat
}


case $1 in 

	start)
	start
	;;

	stop)

	stop
	cleancache

	;;

	restart)

	forcestop

	cleancache

	start

	check 	
	;;

	taillog)

	tail -f $LOG

	;;

	check)

	ps aux | grep tomcat


	;;

	*)
	echo "useage:{start|stop|restart|taillog|check|forcestop}"

	;;

esac

	
