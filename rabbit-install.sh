#!/bin/bash
#--coding=utf8

#erlang 源
rpm -Uvh https://packages.erlang-solutions.com/erlang-solutions-1.0-1.noarch.rpm


yum install epel-release -y 
yum install socat -y

#upload packages first
cd  /usr/local/src
yum localinstall erlang-*  -y 

rpm -ivh ./rabbitmq-server-*
chkconfig rabbitmq-server off


#配置rabbitmq
rabbitmq-plugins enable rabbitmq_management
rabbitmq-plugins enable rabbitmq_tracing 

rabbitmq-server -detached

rabbitmqctl add_user admin 111111				#新增用户并配置密码
rabbitmqctl set_user_tags admin administrator		#给用户打标签
rabbitmqctl  set_permissions -p "/" admin ".*" ".*" ".*"


#test test
