#!/bin/bash
# 创建一个容器并通过pipework指定一个与宿主处于同一物理网段的IP。
#
#powered by  kevin3101

#define bridge name
br_name="br0"

#check pipework and docker weather installed
check_deps() {
     which pipework  && which docker
     if [ $? -ne 0 ];then
        echo "ERROR:need pipework and docker installed! check your system first!"
        exit 2
     fi
}

#creat container and config ip address
create_docker() {

        docker run -dt --name $c_name --net=none  $i_name
        if [ $? -eq 0 ];then
            pipework $br_name  $c_name $ip
            if [ $? -eq 0 ];then
                docker ps
                ping -c 4 ${ip%/*}
            fi
        else
            echo "start docker container failed!"
            exit 1
        fi
}


#interface main
#
if [ $# -eq 3 ];then

    c_name=$1
    i_name=$2
    ip=$3

    echo "Create  container  $c_name :  Image is $i_name  and IP is $ip "
    check_deps
    create_docker

else
        echo "Need thress args!"
        echo "Usage: pipedocker.sh [container_name| image_name| ipaddress]"
fi
