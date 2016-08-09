#!/bin/bash
#挂载软件源

mkdir /mnt/software
mount  -t nfs 192.168.1.196:/opt/software /mnt/software

yum install -y wget 
rm -rf /etc/yum.repo.d/*
wget -O /etc/yum.repos.d/CentOS-Base.repo "http://mirrors.aliyun.com/repo/Centos-6.repo"

yum install -y  lrzsz  gcc  svn
yum groupinstall -y  "base"

#dirs 

mkdir -p  {/opt/software,/home/httpd/,/opt/yingmoo}


#software

# install java
cp /mnt/software/jdk-6u45-linux-amd64.rpm.bin  /opt/software/
cd /opt/software
chmod u+x jdk-6u45-linux-x64-rpm.bin
./jdk-6u45-linux-x64-rpm.bin 

echo  "export JAVA_HOME=/usr/java/jdk1.6.0_45
       export PATH=$JAVA_HOME/bin:$PATH:/usr/local/php/bin:/opt/yingmoo/maven/bin
       export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
       export LD_LIBRARY_PATH=/usr/local/apr/lib"   >> /etc/profile


#tomcat
cd /opt/software

#cp /mnt/software/apache-tomcat-6.0.44.tar.gz  /opt/software/
#tar xzf apache-tomcat-6.0.44.tar.gz
#mv apache-tomcat-6.0.44 /opt/yingmoo/tomcat
#

cp /mnt/software/basesoft/maven_0107.tar.gz  /opt/software/
tar xzf maven.tar.gz 

cp /mnt/software/basesoft/tomcat.tar.gz  /opt/software/
tar xzf tomcat.tar.gz  






source /etc/profile

echo "alias check='ps aux | grep ' 
      alias port='netstat -tlnp '"  >> /etc/bashrc





