#!/bin/bash


yum install -y pcre pcre-devel  zlib zlib-devel

tar xzf nginx-1.8.1.tar.gz

cd nginx-1.8.2

./configure --prefix=/opt/yingmoo/nginx

make

make install
