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

# Qt开发环境搭建
```sh
# ===== 安装Qt =====
# 默认安装库里的Qt版本与依赖
sudo apt install qtcreator qt5-default

# 可以使用安装包
# 从官网(http://download.qt.io/)下载，但是速度很慢
# 建议从国内源下载
#     中国科学技术大学：http://mirrors.ustc.edu.cn/qtproject/
#     清华大学：https://mirrors.tuna.tsinghua.edu.cn/qt/
#     北京理工大学：http://mirror.bit.edu.cn/qtproject/
#     中国互联网络信息中心：https://mirrors.cnnic.cn/qt/
$ sudo chmod +x ./qt-opensource-linux-x64-5.7.1.run
$ ./qt-opensource-linux-x64-5.7.1.run

# ===== 安装必要软件 =====
$ sudo apt install g++ gdb openssh-server cmake
```

# Qt打包工具使用
```sh
# 下载linuxdeployqt，直接下载linuxdeployqt-continuous-x86_64.AppImage即可
# https://github.com/probonopd/linuxdeployqt/releases

# 注意使用linuxdeployqt的前提是有Qt环境
$ chmod +x linuxdeployqt-x86_64.AppImage
$ mv linuxdeployqt-x86_64.AppImage linuxdeployqt
$ mv linuxdeployqt /usr/local/bin
$ linuxdelpoyqt --version
#输出的版本信息
linuxdeployqt 5 (commit 37631e5), build 631 built on 2019-01-25 22:47:58 UTC

# 将已经编译好的exe文件单独放到某目录下
# 注意必须要加上'-appimage'
$ linuxdeployqt '可执行程序' -appimage

# 注意该工具会修改可执行程序的RPATH
# 我们只需要生成后的 ./lib 文件下的所有库文件即可
```