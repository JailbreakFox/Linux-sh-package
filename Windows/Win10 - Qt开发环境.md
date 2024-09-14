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
#           在安装之前先打开 控制中心 - 卸载程序，搜索 'Windows Software Development Kit' 和 'Redistributable'，卸载干净
#         2015版本：1. 离线包 - 已保存在硬盘。只需要安装VC++开发模块
#                           2. qt-vsaddin-msvc2015 - 已保存在硬盘。安装后，VS能使用Qt开发的插件
#                           3. WindowsSDK(10.0.14393.795) - 已保存在硬盘(内部包含debug工具,硬盘中存放为离线包)。在线安装方式:winsdksetup.exe->'Debugging tools for Windows';离线包下载的方式winsdksetup.exe->选择第二个为其他机器安装的包(将该下载的目录放到目标机器中并执行winsdksetup.exe->'Debugging tools for Windows'安装)
#         2017版本：1.在线包 - 已保存在硬盘。需要在线安装，离线包未找到。安装时选择 '使用C++的桌面开发' 勾选单个组件->VC++ 2017 version 15.9 v14.16 latest v141 tools 即可
#                           2. qt-vsaddin-msvc2017 - 已保存在硬盘(硬盘中存放为离线包)。
#                           3. WindowsSDK(10.0.17763.132) - 已保存在硬盘。如果用不了就安装2015的sdk
#                           4. WindowsSDK_Win11(10.1.22621.755) - win11安装这个
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

# CMake 3.14(已保存在硬盘)

# MSVC编译器(vs2017生成工具用于单独安装编译器，无需安装vs)
# 官网 https://my.visualstudio.com/Downloads 搜索"Build Tools for Visual Studio 2017 (version 15.9)"
# 使用下载的工具生成离线安装包(生成的离线包已放在硬盘中)
# $ vs_buildtools.exe -h可查看帮助
# --add 额外功能包列表https://learn.microsoft.com/en-us/visualstudio/install/workload-component-id-vs-build-tools?view=vs-2017&preserve-view=true
$ vs_buildtools.exe --layout C:\VS_BuildTools2017_offline --add Microsoft.VisualStudio.Workload.MSBuildTools --add Microsoft.VisualStudio.Workload.VCTools --add Microsoft.VisualStudio.Component.Windows10SDK.17763 --lang en-US
# 将VS_BuildTools2017_offline目录放到目标机器中
# 首先安装VS_BuildTools2017_offline\certificates目录下的三个签名(第一步选择“本地计算机”)
# 双击安装VS_BuildTools2017_offline\vs_BuildTools.exe(选择对应sdk 10.0.17763 安装路径选择默认C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools 否则Qt找不到)

# WindowsSDK(10.0.17763.132) - 内部包含cdb
# 已在vs2017生成工具中包含，但是需要在"添加或删除程序"中找到Windows Software Development Kit，并点击修复->changed，点选添加(不要删除之前安装的内容)安装'Debugging tools for Windows'功能即可
# 安装路径默认为C:\Program Files (x86)\Windows Kits\10

1.添加 qtcreator -> 工具 -> 选项 -> Qt Versions : XXX\bin\qmake.exe
2.添加 qtcreator -> 工具 -> 选项 -> 编译器 : XXX\VC\Auxiliary\Build\vcvarsall.bat x86
3.添加 qtcreator -> 工具 -> 选项 -> Debuggers : XXX\Windows Kits\10\Debuggers\x86\cdb.exe
4.添加 qtcreator -> 工具 -> 选项 -> CMake : XXX\bin\cmake.exe
5.工具 -> 选项 -> 文本编辑器 -> 行为 -> 制表符策略(混合) 制表符尺寸(4) 对其连续的行(用一般的缩进对齐)
6.Kit -> CMake generator -> NMake Makefiles + CodeBlocks

# 卸载
Microsoft Visual C++ 2017 Redistributable(x64)
Microsoft Visual C++ 2017 Redistributable(x86)
Microsoft Visual Studio Installer
Visual Studio 15 生成工具2017
Windows SDK AddOn
Windows software Development Kit
```

# Qt源码编译
```sh
# 下载源码
https://download.qt.io/archive/qt/5.15/5.15.6/single/

# 安装python
https://www.python.org/downloads/windows/

# 生成makefile
$ configure -prefix "D:\Qt-5.15.6-build" -shared -nomake examples -nomake tests -skip qtwebengine -skip qtspeech -no-qml-debug -opensource -confirm-license -platform win32-msvc -mp

# 开始编译
$ nmake
$ nmake install
```

# QtCreator源码编译
```sh
# 下载源码(尽量选择高版本 低版本搜索不到msvc编译器)
https://mirrors.tuna.tsinghua.edu.cn/qt/archive/qtcreator/5.0/5.0.3/

# 生成makefile
$ cmake -G "NMake Makefiles" -DCMAKE_INSTALL_PREFIX=../install ..

# 开始编译
$ nmake && nmake install
```

# Qt打包工具的使用
```sh
# 将已经编译好的exe文件单独放到某目录下
windeployqt 'XXX.exe'
```

# Android开发环境搭建
```sh
# 安装jdk-8u351-windows-x64.exe(已保存在硬盘)
# 添加JAVA_HOME环境变量，路径为xxx\jdk1.8.0_351
# 在PATH环境变量中添加，%JAVA_HOME%\bin
$ javac -version

# 解压android-ndk-r21e-windows-x86_64.zip(已保存在硬盘)

# 解压android-sdk_r24.4.1-windows.zip(已保存在硬盘)
# 双击 xxx\android-sdk-windows\SDK Manager.exe 安装
	'Tools==>Android SDK Build-tools(版本28.03)'
	'Android 10==>SDK Platform'
	'Extras==>Google USB Driver'
# 将platform-tools.zip解压到xxx\android-sdk-windows\platform-tools
# 在PATH环境变量中添加，xxx\android-sdk-windows\platform-tools

# 安装qtcreator(5.14.2),注意这里不要使用Qt预编译版本了(安卓编译工具链似乎要与Qt版本一致)
# 打卡qtcreator-工具-选项-设备
	'Android SDK的路径': xxx\android-sdk-windows
	'Android NDK的路径': xxx\android-ndk-r21e

# 打卡qtcreator-工具-选项-Kits   添加构建套件
	'名称': 安卓
	'Device type': Android设备
	'Device': 在Android上运行（Andorid类型的默认设备）
	'Compiler': Android Clang（C/C++，arm）  # arm是32位 aarch64是64位
	'Debbuger': Android Debugger for Android Clang（C/C++，arm）
	'Qt version': Qt 5.14.2（android）

# 任意编译一个项目，会提示gradle无法下载，此时进入'C:\Users\Administrator\.gradle\wrapper\dists\gradle-5.5.1-bin\下载乱码'目录，删除所有文件，并将gradle-5.5.1-bin.zip放置到该目录下
# 再次编译项目
```

# Andorid远程调试
```sh
# 手机必须提前打开USB开发模式
# 如果可以,关闭外部应用检测(不关闭的话每次调试手机会提醒安装)

# 注意在使用Qt for android时,CMake必须将add_excutable都替换为add_library
# qmake/cmake的安卓示例程序可以直接在qtcreator里面新建实现

# 注意如果有用到64位的库,需要将
	'qtcreator-项目-Key-ANDROID_ABI设置为arm64-v8a'
	'qtcreator-项目-Key-ANDROID_BUILD_ABI_arm64-v8a设置为ON'
	'qtcreator-项目-Key-ANDROID_BUILD_ABI_armeabi-v7a设置为OFF'
```
