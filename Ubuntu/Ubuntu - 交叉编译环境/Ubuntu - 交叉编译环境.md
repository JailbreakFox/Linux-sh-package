# 开发工具下载
- 镜像 http://mirrors.ustc.edu.cn/ubuntu-releases/16.04/
- GCC http://mirrors.concertpass.com/gcc/releases/gcc-5.4.0/
- Qt源码 https://download.qt.io/new_archive/qt/5.5/5.5.1/single/
- 已编译交叉编译环境 https://zhuanlan.zhihu.com/p/79043170

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

# GCC交叉编译环境搭建 - x86
```
1. 源码编译
2. apt下载
```
***1、源码编译***  
GCC源码编译对环境要求很高，比如ubuntu16.04几乎编不了4.8.5版本的GCC，所以如果能找到已编译版本或者能使用apt下载，则优先考虑，源码编译方法如下:
```sh
# 官网 https://gcc.gnu.org/releases.html ，下载一个GCC
# 以GCC-5.4.0为例 http://mirrors.concertpass.com/gcc/releases/gcc-5.4.0/

# 搭建GCC源码文件目录如下
$ tree tempDir
tempDir
├── gcc-build # 将GCC源码包解压至此
└── gcc-5.4.0 # 在运行configure时，设置GCC prefix，最终输出编译结果至此

# 安装GCC编译依赖
# 方案一: GCC源码自带安装依赖的文件
$ cd tempDir/gcc-build/contrib
$ ./download_prerequisites
# 方案二: 直接下载(推荐，速度更快)
& sudo apt-get install build-essential libgmp-dev libmpfr-dev libmpc-dev

# 在源码目录下新建build目录并开始编译
$ cd tempDir/gcc-build
$ ../configure --prefix='安装路径' --enable-threads=posix --disable-checking --disable-multilib

# 编译
$ make -j $(grep -c ^processor /proc/cpuinfo) # 后面这句可查看当前系统最高可运行编译的核数

# 安装
$ make install -j $(grep -c ^processor /proc/cpuinfo)

# .bashrc末尾添加添加环境变量
& vi /root/.bashrc
export PATH='build目录下的bin文件夹路径':$PATH

# 实例检验
# 修改CTest项目CMakeLists.txt文件下的gcc与g++路径
# 编译运行
```
***2、apt下载***  
```sh
# 下载安装
& sudo apt-get install gcc-4.8 g++-4.8

# .bashrc末尾添加添加环境变量
& vi /root/.bashrc
export PATH='build目录下的bin文件夹路径':$PATH

# 实例检验
# 修改CTest项目CMakeLists.txt文件下的gcc与g++路径
# 编译运行
```

# GCC交叉编译环境搭建 - arm
由于arm版GCC源码编译困难，直接网上找已编译版本
```sh
# ARM已编译版本GCC下载网址 (arm 针对是是 32 位的， aarch64 针对 Arm64.)
# https://mirrors.tuna.tsinghua.edu.cn/armbian-releases/_toolchain/

# .bashrc末尾添加添加环境变量
& vim /root/.bashrc
'
export PATH='build目录下的bin文件夹路径':$PATH
'

# 实例检验
# CTest项目编译运行
$ cmake -DCROSS_COMPILE_FRAMEWORK=aarch64 ..
$ make
```

# GCC交叉编译环境搭建 - mips
网上已编译版本很难找，只有最新和最旧的版本
```sh
# 旧版下载地址 http://mirrors.aliyun.com/loongson/mirrors.html
# 新版下载地址 http://www.loongnix.cn/index.php/Cross-compile

# 这边用已经下载好的预编译版本
# 直接解压 cross-gcc-4.9.3-n64-loongson-rc6.1

# 添加环境变量
$ vim /root/.bashrc
'
export LD_LIBRARY_PATH=?/cross-gcc-4.9.3-n64-loongson-rc6.1/usr/x86_64-unknown-linux-gnu/mips64el-loongson-linux/lib:$LD_LIBRARY_PATH
export PATH=?/cross-gcc-4.9.3-n64-loongson-rc6.1/usr/bin:$PATH
'

# 实例检验
# CTest项目编译运行
$ cmake -DCROSS_COMPILE_FRAMEWORK=mips64 ..
$ make
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
# !!注意只有编译最快版本的时候需要安装该环境，如果安装最全版本则不需要该依赖(估计是会使用自己打出来的依赖)
$ sudo apt-get build-dep qt5-default

# 搭建Qt源码文件目录如下
$ tree tempDir
tempDir
├── Qt-build       # 将Qt源码包解压至此
└── Qt5.5.1        # 在运行configure时，设置Qt prefix，最终输出编译结果至此

# 新建如下脚本 autoConfigure.sh ，用于构建Qt源码的makefile
-------------------- 编译最快版本 --------------------
#! /bin/bash
QT_INSTALL_PATH="-prefix /home/xyh/Qt5.5.1" # Qt安装路径(自己对应修改)
QT_COMPLIER+="-platform linux-g++-64"       # 编译器(x64架构必须写成platform.aarch64架构必须写成xplatform)

CONFIG_PARAM+="-shared "                    # 编译动态库(动态库为'-static')
CONFIG_PARAM+="-release "                   # 编译release
CONFIG_PARAM+="-make libs "
CONFIG_PARAM+="-nomake tools "              # 不编译tools
CONFIG_PARAM+="-nomake examples "           # 不编译examples
CONFIG_PARAM+="-nomake tests "              # 不编译tests

CONFIG_PARAM+="-skip qtwebengine -no-qml-debug "
CONFIG_PARAM+="-qt-zlib -qt-pcre -qt-libpng -qt-libjpeg -qt-freetype -qt-xcb -qt-harfbuzz -opengl desktop "
CONFIG_PARAM+="-dbus-linked -openssl-linked -feature-freetype -fontconfig "
CONFIG_PARAM+="-sysconfdir /etc/xdg -no-rpath -strip "
# 选择Qt版本(开源, 商业), 并自动确认许可认证
CONFIG_PARAM+="-opensource "                # 编译开源版本, -commercial商业版本
CONFIG_PARAM+="-confirm-license "           # 自动确认许可认证

echo "../configure $CONFIG_PARAM $QT_COMPLIER $QT_INSTALL_PATH"
../configure $CONFIG_PARAM $QT_COMPLIER $QT_INSTALL_PATH
-------------------- 编译最全版本 --------------------
#! /bin/bash
QT_INSTALL_PATH="-prefix /home/xyh/Qt5.5.1" # Qt安装路径(自己对应修改)
QT_COMPLIER+="-platform linux-g++-64"       # 编译器(x64架构必须写成platform.aarch64架构必须写成xplatform)

CONFIG_PARAM+="-shared "                    # 编译动态库(动态库为'-static')
CONFIG_PARAM+="-release "                   # 编译release
# 选择Qt版本(开源, 商业), 并自动确认许可认证
CONFIG_PARAM+="-opensource "                # 编译开源版本, -commercial商业版本
CONFIG_PARAM+="-confirm-license "           # 自动确认许可认证

echo "../configure $CONFIG_PARAM $QT_COMPLIER $QT_INSTALL_PATH"
../configure $CONFIG_PARAM $QT_COMPLIER $QT_INSTALL_PATH
----------------------------------------------------

# 将脚本放到源码解压目录Qt-build/build并执行
# 这步实际就是在../configure
$ chmod +x autoConfigure.sh
$ ./autoConfigure.sh

# 编译
$ make -j $(grep -c ^processor /proc/cpuinfo) # 后面这句可查看当前系统最高可运行编译的核数

# 安装
$ make install -j $(grep -c ^processor /proc/cpuinfo)

# 添加该Qt版本的环境变量(默认用root用户搭建的交叉环境)，修改/root/.bashrc，添加如下行
----------------------------------------------------
export QTDIR=tempDir/Qt5.5.1
export PATH=$QTDIR/bin:$PATH
export MANPATH=$QTDIR/doc/man:$MANPATH
export LD_LIBRARY_PATH=$QTDIR/lib:$LD_LIBRARY_PATH
----------------------------------------------------

# 更新bashrc后查看是否已链接上Qt
$ source /root/.bashrc
$ qmake -v

# 在安装完成后可运行实例检查安装情况
# 如果有编译examples模块，可直接到tempDir/Qt5.5.1/examples下运行
# 如果没有编译该模块，则运行QTest
# 另外，静态编译只在bin目录下生成qmake，而没有make，因此实例文件只能用.pro来编译makefile
$ make -DCROSS_COMPILE_FRAMEWORK=x64 ..
```

# QT交叉编译环境搭建 - arm/mips
```sh
# 不需要安装依赖
# 因为build-dep qt5-default只会安装x64版本的依赖工具，这就导致aarch64在编译最快版本的时候找不到某些依赖，目前交叉编译只能编最全版本
# !!注意mips必须配置好LD_LIBRARY_PATH与PATH两个环境变量，不然会找不到一些库

# 搭建Qt源码文件目录如下
$ tree tempDir
tempDir
├── Qt-build       # 将Qt源码包解压至此
└── Qt5.5.1        # 在运行configure时，设置Qt prefix，最终输出编译结果至此

# 新增qmake.conf文件
-------------------- arm --------------------
$ cp -r qtbase/mkspecs/linux-arm-gnueabi-g++ qtbase/mkspecs/linux-aarch64-gnu-g++
$ vim qtbase/mkspecs/linux-aarch64-gnu-g++/qmake.conf
'
#
# qmake configuration for building with linux-aarch64-gnu-g++
#

MAKEFILE_GENERATOR      = UNIX
CONFIG                 += incremental
QMAKE_INCREMENTAL_STYLE = sublib

include(../common/linux.conf)
include(../common/gcc-base-unix.conf)
include(../common/g++-unix.conf)

# modifications to g++.conf
QMAKE_CC                = aarch64-linux-gnu-gcc
QMAKE_CXX               = aarch64-linux-gnu-g++
QMAKE_LINK              = aarch64-linux-gnu-g++
QMAKE_LINK_SHLIB        = aarch64-linux-gnu-g++

# modifications to linux.conf
QMAKE_AR                = aarch64-linux-gnu-ar cqs
QMAKE_OBJCOPY           = aarch64-linux-gnu-objcopy
QMAKE_NM                = aarch64-linux-gnu-nm -P
QMAKE_STRIP             = aarch64-linux-gnu-strip
load(qt_config)
'
-------------------- mips --------------------
$ cp -r qtbase/mkspecs/linux-arm-gnueabi-g++ qtbase/mkspecs/linux-mips-g++
$ vim qtbase/mkspecs/linux-mips-g++/qmake.conf
'
#
# qmake configuration for building with linux-mips-g++
#

MAKEFILE_GENERATOR      = UNIX
CONFIG                 += incremental
QMAKE_INCREMENTAL_STYLE = sublib

include(../common/linux.conf)
include(../common/gcc-base-unix.conf)
include(../common/g++-unix.conf)

# modifications to g++.conf
QMAKE_CC                = mips64el-loongson-linux-gcc
QMAKE_CXX               = mips64el-loongson-linux-g++
QMAKE_LINK              = mips64el-loongson-linux-g++
QMAKE_LINK_SHLIB        = mips64el-loongson-linux-g++

# modifications to linux.conf
QMAKE_AR                = mips64el-loongson-linux-ar cqs
QMAKE_OBJCOPY           = mips64el-loongson-linux-objcopy
QMAKE_NM                = mips64el-loongson-linux-nm -P
QMAKE_STRIP             = mips64el-loongson-linux-strip
load(qt_config)
'
----------------------------------------------------

# 新建如下脚本 autoConfigure.sh ，用于构建Qt源码的makefile
-------------------- 编译最全版本 --------------------
#! /bin/bash
QT_INSTALL_PATH="-prefix /home/xyh/Qt5.5.1"     # Qt安装路径(自己对应修改)
QT_COMPLIER+="-xplatform linux-aarch64-gnu-g++" # 编译器(x64架构必须写成platform.aarch64架构必须写成xplatform)
#QT_COMPLIER+="-xplatform linux-mips-g++"

CONFIG_PARAM+="-shared "                        # 编译动态库(动态库为'-static')
CONFIG_PARAM+="-release "                       # 编译release
# 选择Qt版本(开源, 商业), 并自动确认许可认证
CONFIG_PARAM+="-opensource "                    # 编译开源版本, -commercial商业版本
CONFIG_PARAM+="-confirm-license "               # 自动确认许可认证

echo "../configure $CONFIG_PARAM $QT_COMPLIER $QT_INSTALL_PATH"
../configure $CONFIG_PARAM $QT_COMPLIER $QT_INSTALL_PATH
----------------------------------------------------

# 将脚本放到源码解压目录Qt-build/build并执行
# 这步实际就是在../configure
$ chmod +x autoConfigure.sh
$ ./autoConfigure.sh

# 编译
$ make -j $(grep -c ^processor /proc/cpuinfo) # 后面这句可查看当前系统最高可运行编译的核数

# 安装
$ make install -j $(grep -c ^processor /proc/cpuinfo)

# 添加该Qt版本的环境变量(默认用root用户搭建的交叉环境)，修改/root/.bashrc，添加如下行
----------------------------------------------------
export QTDIR=tempDir/Qt5.5.1
export PATH=$QTDIR/bin:$PATH
export MANPATH=$QTDIR/doc/man:$MANPATH
export LD_LIBRARY_PATH=$QTDIR/lib:$LD_LIBRARY_PATH
----------------------------------------------------

# 更新bashrc后查看是否已链接上Qt
$ source /root/.bashrc
$ qmake -v

# 在安装完成后可运行实例检查安装情况
# 如果有编译examples模块，可直接到tempDir/Qt5.5.1/examples下运行
# 如果没有编译该模块，则运行QTest
# 另外，静态编译只在bin目录下生成qmake，而没有make，因此实例文件只能用.pro来编译makefile
$ make -DCROSS_COMPILE_FRAMEWORK=aarch64 ..
# $ make -DCROSS_COMPILE_FRAMEWORK=mips64 ..
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