# 开发工具下载
- 镜像 http://mirrors.ustc.edu.cn/ubuntu-releases/16.04/
- GCC http://mirrors.concertpass.com/gcc/releases/gcc-5.4.0/
- Qt源码 https://download.qt.io/new_archive/qt/5.5/5.5.1/single/

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
$ sudo apt update
```

# QT交叉编译环境搭建 - x86
```sh
# 安装cmake
# 更换源后默认安装的cmake版本为3.5，如果觉得低，可以手动安装
# 官网 https://cmake.org/download/ ，下载一个sh包
$ sudo chmod 777 cmake-3.13.2-Linux-x86_64.sh
$ ./cmake-3.13.2-Linux-x86_64.sh
$ cd /usr/bin
$ sudo ln -s cmake 'cmake可执行程序路径'

# 安装Qt5默认依赖环境
$ sudo apt-get build-dep qt5-default

# 搭建Qt源码文件目录如下
$ tree tempDir
tempDir
├── Qt-build       # 将Qt源码包解压至此
└── Qt5.5.1_static # 在运行configure时，设置Qt prefix，最终输出编译结果至此

# 新建如下脚本 autoConfigure.sh ，用于构建Qt源码的makefile
-------------------- 静态库-编译最快版本 --------------------
#! /bin/bash
QT_INSTALL_PATH="-prefix /home/xyh/Qt5.5.1_static"     # Qt安装路径(自己对应修改)
QT_COMPLIER+="-platform linux-g++-64"  # 编译器

CONFIG_PARAM+="-static "               # 静态编译
CONFIG_PARAM+="-release "              # 编译release
CONFIG_PARAM+="-make libs "
CONFIG_PARAM+="-nomake tools "         # 不编译tools
CONFIG_PARAM+="-nomake examples "      # 不编译examples
CONFIG_PARAM+="-nomake tests "         # 不编译tests

CONFIG_PARAM+="-skip qtwebengine -no-qml-debug "
CONFIG_PARAM+="-qt-zlib -qt-pcre -qt-libpng -qt-libjpeg -qt-freetype -qt-xcb -qt-harfbuzz -opengl desktop "
CONFIG_PARAM+="-dbus-linked -openssl-linked -feature-freetype -fontconfig "
CONFIG_PARAM+="-sysconfdir /etc/xdg -no-rpath -strip "
# 选择Qt版本(开源, 商业), 并自动确认许可认证
CONFIG_PARAM+="-opensource "           # 编译开源版本, -commercial商业版本
CONFIG_PARAM+="-confirm-license "      # 自动确认许可认证

echo "./configure $CONFIG_PARAM $QT_COMPLIER $QT_INSTALL_PATH"
./configure $CONFIG_PARAM $QT_COMPLIER $QT_INSTALL_PATH
-------------------- 静态库-编译最全版本 --------------------
#! /bin/bash
QT_INSTALL_PATH="-prefix /home/xyh/Qt5.5.1_static"     # Qt安装路径(自己对应修改)
QT_COMPLIER+="-platform linux-g++-64"  # 编译器

CONFIG_PARAM+="-static "               # 静态编译
CONFIG_PARAM+="-release "              # 编译release
# 选择Qt版本(开源, 商业), 并自动确认许可认证
CONFIG_PARAM+="-opensource "           # 编译开源版本, -commercial商业版本
CONFIG_PARAM+="-confirm-license "      # 自动确认许可认证

echo "./configure $CONFIG_PARAM $QT_COMPLIER $QT_INSTALL_PATH"
./configure $CONFIG_PARAM $QT_COMPLIER $QT_INSTALL_PATH
----------------------------------------------------

# 将脚本放到源码解压目录Qt-build并执行
# 这步实际就是在./configure
$ chmod +x autoConfigure.sh
$ ./autoConfigure.sh

# 编译
$ make -j $(grep -c ^processor /proc/cpuinfo) # 后面这句可查看当前系统最高可运行编译的核数

# 安装
$ make install -j $(grep -c ^processor /proc/cpuinfo)

# 添加该Qt版本的环境变量(默认用root用户搭建的交叉环境)，修改/root/.bashrc，添加如下行
----------------------------------------------------
export QTDIR=tempDir/Qt5.5.1_static
export PATH=$QTDIR/bin:$PATH
export MANPATH=$QTDIR/doc/man:$MANPATH
export LD_LIBRARY_PATH=$QTDIR/lib:$LD_LIBRARY_PATH
----------------------------------------------------

# 更新bashrc后查看是否已链接上Qt
$ source /root/.bashrc
$ qmake -v

# 在安装完成后可运行实例检查安装情况
# 如果有编译examples模块，可直接到tempDir/Qt5.5.1_static/examples下运行
# 如果没有编译该模块，则运行QTest
# 另外，静态编译只在bin目录下生成qmake，而没有make，因此实例文件只能用.pro来编译makefile
```

# 生成root登陆用户
```sh
# ===== 登陆界面添加root =====
# 修改root密码
$ sudo passwd root
# 修改配置文件
$ vim /usr/share/lightdm/lightdm.conf.d/50-unity-greeter.conf
# 末尾添加
greeter-show-manual-login=true #手工输入登陆系统的用户名和密码
all-guest=false              #不允许guest登录（可选）
# 重启后登陆出现报错修改
# 修改/root/.profile最后一行为
tty -s && mesg n || true

# ===== ssh添加root用户 =====
# 设置ssh可登陆
$ vim /etc/ssh/sshd_config
# 修改PermitRootLogin
PermitRootLogin yes
# 重启服务
& systemctl restart sshd.services
```