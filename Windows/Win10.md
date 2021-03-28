# 纯净镜像下载
https://jingyan.baidu.com/article/37bce2bec1a11d5002f3a28b.html

# 安装应用
```sh
# 微信、钉钉、Git、Vscode、WPS

# chrome
https://www.google.cn/intl/zh-CN/chrome/

# VMware
https://www.vmware.com/cn/products/workstation-pro/workstation-pro-evaluation.html
# 激活码
ZF3R0-FHED2-M80TY-8QYGC-NPKYF

# Qt
# 可以从官网(http://download.qt.io/)下载，但是速度很慢
# 建议从国内源下载
#     中国科学技术大学：http://mirrors.ustc.edu.cn/qtproject/
#     清华大学：https://mirrors.tuna.tsinghua.edu.cn/qt/
#     北京理工大学：http://mirror.bit.edu.cn/qtproject/
#     中国互联网络信息中心：https://mirrors.cnnic.cn/qt/
#         安装组件: sources - 源码
#                        Qt所有插件
#                        MinGW - 源码 + 安装
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
#               1）将MinGW的bin目录路径(...\Qt\Tools\mingw530_32\bin)添加到系统环境变量下
#               2）在PowerShell中使用'MinGW32-make'命令来执行对makefile的编译
# CMakeList.txt
# 程序编译时可能找不到Qt的Qt5Config.cmake，需要告诉CMake关于Qt5的安装位置，比如:
# set(CMAKE_PREFIX_PATH ${CMAKE_PREFIX_PATH} "D:\\applications\\Qt\\5.11.3\\mingw53_32\\lib\\cmake")
# 上述路径即为Qt的模块.cmake存放位置(或者也可以设置系统环境变量)
```

# 科学上网
```sh
# 购买vultr服务器
https://my.vultr.com

# ssh连接服务器，然后一键搭建v2ray
bash <(curl -s -L https://git.io/v2ray-setup.sh)
# 记录v2ray的vmess地址
v2ray url

# 安装客户端 https://github.com/2dust/v2rayN/releases
# 第一次安装需要安装v2rayN-Core.zip
```