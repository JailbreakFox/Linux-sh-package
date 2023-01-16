# 纯净镜像下载
https://jingyan.baidu.com/article/37bce2bec1a11d5002f3a28b.html

# Win10 + Qt + MinGW开发环境
```sh
# Qt
# 可以从官网(http://download.qt.io/)下载，但是速度很慢
# 建议从国内源下载
#     中国科学技术大学：http://mirrors.ustc.edu.cn/qtproject/
#     清华大学：https://mirrors.tuna.tsinghua.edu.cn/qt/
#     北京理工大学：http://mirror.bit.edu.cn/qtproject/
#     中国互联网络信息中心：https://mirrors.cnnic.cn/qt/
#         安装组件: sources - 源码
#                        Qt所有插件
#                        MinGW - prebuild版 + build版
# ---MingGW(尽量在上一步中就勾选Qt内置的MinGW，因为其内部包含了qmake，用于找到qt源码)
# ---官网 https://sourceforge.net/projects/mingw-w64/files/mingw-w64/mingw-w64-release/
# ---如果不需要在线下载，就下载离线包(已编译版本) x86_64-win32-seh
# ---将解压出来的bin文件夹路径添加到path环境变量(搜索"编辑系统环境变量")
# CMake
# 编译器使用MingGW，还需要CMake来构建
# 官网 https://cmake.org/download/
# 注意：1. CMake在windows下不能使用命令行，直接用CMake-gui界面来编译
#           2. 第一次运行CMake的时候，需要用CMake-gui配置一次，具体步骤：
#               1）Where is the source code -  '目标程序目录'
#               2）Where to build the binaries - '目标程序目录'/build
#               3）告诉CMake关于Qt的路径。
#                   方案一：'Add Entry'，添加 'CMAKE_PREFIX_PATH' 'D:\\applications\\Qt\\5.11.3\\mingw53_32\\lib\\cmake'
#                   方案二：CMakeList.txt中添加 set(CMAKE_PREFIX_PATH ${CMAKE_PREFIX_PATH} "D:\\applications\\Qt\\5.11.3\\mingw53_32\\lib\\cmake")
#                   方案三：系统环境变量添加 "D:\\applications\\Qt\\5.11.3\\mingw53_32\\lib\\cmake"
#               4）点击'Configure'，选择'MinGW Makefiles'，'Specify native compilers'，添加MinGW的gcc与g++路径
#           3. Make在windows下的使用方法是：
#               1）将MinGW的bin目录路径(...\Qt\Tools\mingw530_32\bin 或者 ...\Qt\5.11.3\mingw530_32\bin)添加到系统环境变量下
#               2）在PowerShell中使用'MinGW32-make'命令来执行对makefile的编译
#           4. CMakeList.txt
#               程序编译时可能找不到Qt的Qt5Config.cmake，需要告诉CMake关于Qt5的安装位置，比如:
#               set(CMAKE_PREFIX_PATH ${CMAKE_PREFIX_PATH} "D:\\applications\\Qt\\5.11.3\\mingw53_32\\lib\\cmake")
#              上述路径即为Qt的模块.cmake存放位置(或者也可以设置系统环境变量)
```

# Win10 + Qt + MSVC开发环境
```sh
# ----------        Qtcreator作为IDE            ---------
# 由于Windows下Visual Studio开发是使用MSVC编译器，因此由该编译器生成的链接库无法被MinGW使用(MinGW那套GNU是在linux平台下使用的)。
# 因此有必要搭建一套能链接上MSVC生成库的开发环境。安装顺序最好如下：
# CMake
# 安装方式往上找，版本使用3.13
# Visual Studio
# 官网 https://visualstudio.microsoft.com/zh-hans/downloads/
# sdk https://developer.microsoft.com/zh-cn/windows/downloads/sdk-archive/
# 离线开发环境就装离线包，能联网也能使用在线安装
# 注意：不同版本安装过程不一样。
#           在安装之前先打开 控制中心 - 卸载程序，搜索 'sdk' 和 'redistributable'，卸载干净
#         2015版本：1. 离线包 - 已保存在硬盘。只需要安装VC++开发模块
#                           2. qt-vsaddin-msvc2015 - 已保存在硬盘。安装后，VS能使用Qt开发的插件
#                           3. WindowsSDK - 已保存在硬盘。内部包含debug工具，安装时只需要'Debugging tools for Windows'（可认为就是linux下的gdb，下载地址在上方）
#         2017版本：1.在线包 - 已保存在硬盘。需要在线安装，离线包未找到。安装时选择 '使用C++的桌面开发' 即可
#                           2. qt-vsaddin-msvc2017 - 已保存在硬盘。
#                           3. WindowsSDK - 已保存在硬盘。与2015使用相同版本，即windows sdk 10.0.16299
# Qt
# 安装方式往上找，版本使用5.12.0
#         安装组件: sources - 源码
#                        Qt所有插件
#                        MSVC - prebuild版（注意，对应上VS的版本号，还有X86与X64自行选择）
# 安装完成后需要修改：
#          工具-选项-Kits-CMake generator 选择'NMake Makefiles'（因为JOM未下载，编译时会报错）
# 系统环境变量可以添加也可以不添
#          ...\Qt5.12.10\5.12.0\msvc2015_64\bin
#          ...\Qt5.12.10\5.12.0\msvc2015_64\lib\cmake
# 由于CDB调试打开占用时间很长，如果是在离线的条件下开发的话，清除工具-选项-调试器-CDB Paths 中的所有Symbol Paths
# ！！！至此，Qtcreator的开发环境搭建完成（可以使用CMakeList.txt），且VS也能开始使用.pro去开发qt
# ----------        VisualStudio作为IDE            ---------
# 如果想用CMakeList.txt开发，则需在VS2017以上版本，安装过程中选择 '开发C++桌面' 与 'CMake工具'
# 如果想开发Qt应用，需要：
#          1. 安装qt-vsaddin-msvc，方法在上面
#          2. 打开VS后，点击 'Qt VS Tools' - 'Qt Options' -'Add'，添加qtcreator.exe的路径
```

# Qt预编译版本
```sh
# qt-5.15.6已编译版本(x86 msvc2017编译   已保存在硬盘)

# qtcreator-4.9.2
# https://mirrors.tuna.tsinghua.edu.cn/qt/archive/qtcreator/4.9/4.9.2/installer_source/windows_msvc2017_x86/
# 下载组件: qtcreator.7z        qtcreator已编译版本(已保存在硬盘)
#          qtcreatorcbdext.7z 用于CDB调试debug(已保存在硬盘)

# CMake

# Visual Studio 2017

# CDB的安装包  WindowsSDK/sdksetup.exe 只需要勾选Debuggers x86

1.添加 qtcreator -> 工具 -> 选项 -> Qt Versions : XXX\bin\qmake.exe
2.添加 qtcreator -> 工具 -> 选项 -> 编译器 : XXX\VC\Auxiliary\Build\vcvarsall.bat x86
3.添加 qtcreator -> 工具 -> 选项 -> Debuggers : C:\Program Files (x86)\Windows Kits\10\Debuggers\x86\cdb.exe
4.添加 qtcreator -> 工具 -> 选项 -> CMake : XXX\bin\cmake.exe
```

# Qt打包工具的使用
```sh
# 将已经编译好的exe文件单独放到某目录下
windeployqt 'XXX.exe'
```
