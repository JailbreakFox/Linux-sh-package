# 简介
Qt程序的编译最好使用低版本Qt/低版本编译器(详见Ubuntu交叉编译环境)，而**运行时库**最好使用高版本Qt/低版本编译器，此处使用Centos7作为**运行时库编译环境**原因如下:  

- Ubuntu交叉编译环境的CXXABI偏高，有时候不支持低版本GLIBC系统
- 运行时库使用的Qt版本可以选择高一些，这样生成的运行时库能带动低版本Qt编译的程序

程序无法运行时，可以打开export QT_DEBUG_PLUGINS=1选项，观察Qt报错

# 系统镜像下载
下载完整版centos
http://mirrors.aliyun.com/centos/7/isos/x86_64/
https://mirrors.bfsu.edu.cn/centos-altarch/7.9.2009/isos/i386/

# 配置源 - centos7
```sh
# 直接往默认源文件中加入阿里云的源
curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
```

# 安装必要软件
```sh
# 安装wget
yum -y install wget gcc gcc-c++ cmake
```

# QT交叉编译环境搭建 - x86
```sh
# 搭建Qt源码文件目录如下
$ tree tempDir
tempDir
├── Qt-build       # 将Qt源码包解压至此
└── Qt5.12.12      # 在运行configure时，设置Qt prefix，最终输出编译结果至此

# 安装编译依赖
$ yum install mesa-libGL-devel libxkbcommon-devel
# $ yum install qt5-qtbase.x86_64

# 新建如下脚本 autoConfigure.sh ，用于构建Qt源码的makefile
-------------------- 编译最快版本 --------------------
#! /bin/bash
QT_INSTALL_PATH="-prefix /Qt-5.12.12-x64"   # Qt安装路径(自己对应修改)
QT_COMPLIER+="-platform linux-g++-64"       # 编译器(x64架构必须写成platform.aarch64/mips架构必须写成xplatform)

CONFIG_PARAM+="-release "                   # 编译release
CONFIG_PARAM+="-shared "                    # 编译动态库(静态库为'-static')
CONFIG_PARAM+="-accessibility "             # 启用辅助功能支持
CONFIG_PARAM+="-qpa xcb "                   # 选择默认的 QPA 后端

CONFIG_PARAM+="-nomake examples "           # 不编译示例
CONFIG_PARAM+="-nomake tests "              # 不编译测试代码

CONFIG_PARAM+="-skip qtwebengine "
CONFIG_PARAM+="-qt-zlib -qt-pcre -qt-libpng -qt-libjpeg -qt-freetype -qt-xcb -qt-harfbuzz "
# 选择Qt版本(开源, 商业), 并自动确认许可认证
CONFIG_PARAM+="-opensource "                # 编译开源版本, -commercial商业版本
CONFIG_PARAM+="-confirm-license "           # 自动确认许可认证

echo "../configure $CONFIG_PARAM $QT_COMPLIER $QT_INSTALL_PATH"
../configure $CONFIG_PARAM $QT_COMPLIER $QT_INSTALL_PATH
-------------------- 编译最全版本 --------------------
#! /bin/bash
QT_INSTALL_PATH="-prefix /Qt-5.12.12-x64"   # Qt安装路径(自己对应修改)
QT_COMPLIER+="-platform linux-g++-64"       # 编译器(x64架构必须写成platform.aarch64/mips架构必须写成xplatform)

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
$ make -j4
```

# 运行时库制作
手动生成后需要手动去剔除一些不必要的文件，较为麻烦。可以尝试使用linuxdeployqt自动生成。
```
1 手动生成
2 自动生成
```

***1、手动生成***  
将源码编译出来的lib与plugin文件夹单独提取出来
并新建一个qt.conf文件
```
[Paths]
prefix = .
Plugins = ./plugins
```
最终目录如下:  
$ tree tempDir
tempDir
├── qt.conf       # qt配置文件
├── plugins      # qt插件
└── lib               # qt依赖库
```sh
# 还有一点需要注意的是，Qt二进制必须添加rpath到lib目录下
$ chrpath -r 'rpath路径' '二进制路径'
```

***2、自动生成***  
https://github.com/probonopd/linuxdeployqt
```sh
# 将Qt二进制文件放入一个单独文件夹，然后使用自己编译的linuxdeployqt执行
$ ./linuxdeployqt '二进制路径' -appimage
```

# CMake-Qt技巧
```sh
# 一些特殊的关于Qt变量可以从xxx/lib/cmake/Qt5/Qt5Config.cmake查看
# _qt5_install_prefix Qt 安装位置
# Qt5Core_VERSION_STRING Qt版本号

# HINTS代表优先从QTDIR变量路径寻找QT
find_package(Qt5 HINTS "${QTDIR}" COMPONENTS Core Gui Widgets Sql REQUIRED)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTORCC ON)

target_link_libraries(${PROJECT_NAME} Qt5::Core Qt5::Gui Qt5::Widgets)

# 添加rpath
set_target_properties(${PROJECT_NAME} "-Wl,--disable-new-dtags,--rpath,:./:../lib")
```