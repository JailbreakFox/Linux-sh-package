# 系统镜像下载
http://mirrors.ustc.edu.cn/ubuntu-releases/16.04/

# 配置源
直接往默认源文件中加入清华源
```sh
$ vi /etc/apt/source.list
# deb cdrom:[Ubuntu 16.04 LTS _Xenial Xerus_ - Release amd64 (20160420.1)]/ xenial main restricted
# 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-updates main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-updates main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-backports main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-backports main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-security main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-security main restricted universe multiverse
```
更新源
```sh
sudo apt update
```

# deb打包编译环境搭建
```sh
# 安装cmake
# 更换源后默认安装的cmake版本为3.5，如果觉得低，可以手动安装
# 官网 https://cmake.org/download/ ，下载一个sh包
sudo chmod 777 cmake-3.13.2-Linux-x86_64.sh
./cmake-3.13.2-Linux-x86_64.sh
cd /usr/bin
sudo ln -s cmake 'cmake可执行程序路径'

# 降级安装gcc
# 默认安装的gcc版本为5.4，如果我们的程序需要用c98来编译，则gcc需要降级到4.8.5
# 否则链接库编译的时候会根据cmake给定的编译c++11选项来同时编译库
sudo apt install gcc-4.8
sudo apt install g++-4.8
cd /usr/bin
sudo ln -s gcc-4.8 gcc
sudo ln -s g++-4.8 g++
```

# Apache服务搭建
```sh
# 安装Apache2
$ sudo apt-get install apache2

# 重启服务
# 配置文件路径 /etc/apache2/apache2.conf
# 网页路径 /var/www/html
$ sudo /etc/init.d/apache2 restart
```

# Apache网站文件服务
```sh
# 直接在 /var/www/html 放置文件夹(以 tmp 目录为例)
# 直接访问 http://XXX/tmp 即可
```

# Tomcat服务搭建
apache支持静态页，tomcat支持动态页
```sh
# 安装JDK
$ sudo apt install openjdk-8-jdk

# 下载tomcat源码
# https://dlcdn.apache.org/tomcat/tomcat-8/v8.5.84/bin/apache-tomcat-8.5.84.tar.gz

# 开启服务
$ tar -zxvf apache-tomcat-8.5.84.tar.gz
$ chmod 755 -R apache-tomcat-8.5.84
$ ./bin/startup.sh

# 浏览器访问
# http://localhost:8080
```