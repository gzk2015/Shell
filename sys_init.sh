#!/bin/bash


yum install -y wget 
rm -rf /etc/yum.repo.d/*
wget -O /etc/yum.repos.d/CentOS-Base.repo "http://mirrors.aliyun.com/repo/Centos-6.repo"

yum install -y  lrzsz  gcc  svn
yum groupinstall -y  "base"

#dirs 

mkdir -p  {/opt/software,/home/httpd/,/opt/yingmoo}


#software

cd /opt/software


wget  "http://172.16.10.16/software/nginx-1.6.3.tar.gz"
tar xzf nginx-1.6.3.tar.gz
cd nginx-1.6.3
./configure --prefix=/opt/yingmoo/nginx
make
make install
wget "http://172.16.10.16/shell/nginx"
mv ./nginx   /etc/init.d/

#
wget  "http://172.16.10.16/software/apache-tomcat-6.0.44.tar.gz"
tar xzf apache-tomcat-6.0.44.tar.gz
mv apache-tomcat-6.0.44 /opt/yingmoo/tomcat
#
wget  "http://172.16.10.16/software/jdk-6u45-linux-x64-rpm.bin"
chmod u+x jdk-6u45-linux-x64-rpm.bin
./jdk-6u45-linux-x64-rpm.bin 
#
wget  "http://172.16.10.16/software/maven.tar.gz"

tar xzf maven.tar.gz  -C  /opt/yingmoo



echo  "export JAVA_HOME=/usr/java/jdk1.6.0_45
       export PATH=$JAVA_HOME/bin:$PATH:/usr/local/php/bin:/opt/yingmoo/maven/bin
       export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
       export LD_LIBRARY_PATH=/usr/local/apr/lib"   >> /etc/profile


source /etc/profile

echo "alias check='ps aux | grep ' 
      alias port='netstat -tlnp '"  >> /etc/bashrc





