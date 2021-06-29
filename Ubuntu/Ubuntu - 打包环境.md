# 系统镜像下载
http://mirrors.ustc.edu.cn/ubuntu-releases/16.04/

# 配置源
直接往默认源文件中加入清华源
```sh
$ vi /etc/apt/source.list
# deb cdrom:[Ubuntu 16.04 LTS _Xenial Xerus_ - Release amd64 (20160420.1)]/ xenial main restricted
deb-src http://archive.ubuntu.com/ubuntu xenial main restricted #Added by software-properties
deb http://mirrors.aliyun.com/ubuntu/ xenial main restricted
deb-src http://mirrors.aliyun.com/ubuntu/ xenial main restricted multiverse universe #Added by software-properties
deb http://mirrors.aliyun.com/ubuntu/ xenial-updates main restricted
deb-src http://mirrors.aliyun.com/ubuntu/ xenial-updates main restricted multiverse universe #Added by software-properties
deb http://mirrors.aliyun.com/ubuntu/ xenial universe
deb http://mirrors.aliyun.com/ubuntu/ xenial-updates universe
deb http://mirrors.aliyun.com/ubuntu/ xenial multiverse
deb http://mirrors.aliyun.com/ubuntu/ xenial-updates multiverse
deb http://mirrors.aliyun.com/ubuntu/ xenial-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ xenial-backports main restricted universe multiverse #Added by software-properties
deb http://archive.canonical.com/ubuntu xenial partner
deb-src http://archive.canonical.com/ubuntu xenial partner
deb http://mirrors.aliyun.com/ubuntu/ xenial-security main restricted
deb-src http://mirrors.aliyun.com/ubuntu/ xenial-security main restricted multiverse universe #Added by software-properties
deb http://mirrors.aliyun.com/ubuntu/ xenial-security universe
deb http://mirrors.aliyun.com/ubuntu/ xenial-security multiverse
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

# deb打包环境搭建
```sh
# debuild环境
sudo apt install dh-make devscripts

# dpkg-buildpackage环境
sudo apt install dh-make

# dpkg-deb环境
sudo apt install fakeroot
```