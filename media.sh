#!/bin/bash
#tomcat restart script
#gzk 20150729
#v1
#

export PATH



EXEC=media
port=8606
PROGRAMPATH=/opt/yingmoo/tomcat
PID=`lsof -i:$port -t`
LOG=/home//logs/tomcat/catalina-$EXEC.out
LOG2=
DATE=`date +%Y%m%d`
CODE=/home/httpd/mediaService/target/mediaService
BAKFILE=`basename $CODE`_$DATE.tar.gz

#start program use offical script

backup() {
	tar -czvf /home/backup/$BAKFILE   $CODE
	if [ $? = 0 ];then 
		echo "backup succesed!"
	fi

	}
      


start() {

	echo "Start tomcat.....$port"

	cd  $PROGRAMPATH/bin
	./catalina-$EXEC.sh start

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

	ps aux | grep $EXEC
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

	check

	;;

	backup)
	backup
	;;

	*)
	echo "useage:{start|stop|restart|taillog|check|forcestop}"

	;;

esac

	
