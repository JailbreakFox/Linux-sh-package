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

# Dependencies
https://github.com/lucasg/Dependencies
查看可执行文件的依赖库  

# sqlite 查看器
http://www.sqlitebrowser.org/dl/

# ScreenToGif 录屏软件
https://www.screentogif.com/

# 7z 压缩软件
https://www.7-zip.org/
```

# 开发环境搭建
====== Win10 + Qt + MinGW开发环境 =====
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
====== Win10 + Qt + MSVC开发环境 =====
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

# VSCode + MinGW / MSVC开发环境
```sh
# 官网安装 https://code.visualstudio.com/
# 如果安装速度较慢，将下载连接
# https://az764295.vo.msecnd.net/stable/... 部分改为
# https://vscode.cdn.azure.cn/stable/...

# 安装必要插件
# 1. chinese(simplified)
# 2. C++(插件名为 cpptools-win32.vsix 附带扩展插件)
# 3. CMake Tools
# 4. CMake
# 5. Remote Development
# 6. Git Graph
# 7. favorites(收藏功能)
# 8. Markdown All in One
# 9. Markdown Preview Enhanced
# 10. Gitbook kit
# 11. Python
# 12. Output Colorizer

# 安装编译器 + Qt + CMake
# 注意
	1. 如果已安装CMake且有环境变量，则CMake插件将加载该已安装CMake(未安装的情况下使用CMake插件自带CMake，版本不定)
# MinGW / MSVC版本配套:
	1. 如果使用VSCode + MinGW则无需安装VS(直接安装MinGW的编译器即可);如果使用MSVC则需先安装VS
	2. CMake 3.14(3.13以上版本，且3.20不可用)

# 链接编译器
# 添加环境变量后，打开项目，并点击最下方一栏cmake里的编译工具选项，选择[SCan for kits]，就能加载新编译器(或者直接选择已被搜索到的编译工具)
# 修改Cmake:Build Directory路径，该路径是生成的中间文件目录，比较杂乱

# 修改编码格式(MinGW环境使用默认UTF-8编码文件，文件行尾推荐使用Linux的LF)
# MSVC环境需要修改编码格式:
# File(文件)->Preferences(首选项)->Usersettings(设置)，搜索encoding ，然后修改为GB2312
# 另外勾选Auto Guess Encoding

# ===== VSCode编译Qt程序 =====
# 开发Qt程序仍旧推荐使用QtCreator，但是如果只是要编译运行Qt，需要做如下操作
# ----- MSVC编译器 -----
# 注意，MSVC没有单独编译器下载，需要先安装VS
	1.安装具有MSVC开发工具(用于qmake链接编译器)的Qt版本，比如上面使用过的5.12.0
	2.添加环境变量，目的是让vscode找到Qt位置
		1) 可以添加全局环境变量 ...\Qt5.12.10\5.12.0\msvc2015_64\lib\cmake
		2) 或者可以使用CMakeLists.txt配置寻找Qt的路径
		
# ----- MinGW编译器 -----
# 注意，MinGW编译器一般Qt安装程序内置可以选择
	1.找到具有MinGW开发工具与编译器的Qt版本，比如上面使用过的5.12.0
	2.添加环境变量，目的是让vscode找到Qt位置
		1) 可以添加全局环境变量 ...\Qt5.12.10\5.12.0\msvc2015_64\lib\cmake
		2) 或者可以使用CMakeLists.txt配置寻找Qt的路径
		
# 在settings.json文件中添加默认配置
{
	// 设置build中间文件的路径
	"cmake.buildDirectory": "${workspaceFolder}/build_trash"
	
    // 设置Google的代码格式(快捷键 Shift + Alt + F)
    // 格式名可选：LLVM, Google, Chromium, Mozilla, WebKit
    "C_Cpp.clang_format_fallbackStyle": "{ BasedOnStyle: Google, UseTab: Never, IndentWidth: 4, TabWidth: 4}",
    "C_Cpp.clang_format_style": "{ BasedOnStyle: Google, UseTab: Never, IndentWidth: 4, TabWidth: 4}"
}
```

# CMake与MSVC命令行编译
```sh
# 添加CMake的bin目录环境变量

# 打开Visual Studio命令提示进程，执行以下命令
rd /s/q build # 删除build文件夹
mkdir build
cd build
cmake -G "NMake Makefiles" ..
nmake clean
nmake '指定模块名'
# 或者
nmake
```

# Qt打包工具的使用
```sh
# 将已经编译好的exe文件单独放到某目录下
windeployqt 'XXX.exe'
```

# Hexo博客环境搭建
```sh
# 下载 node.js(注意要安装稳定版本 建议安装12.16.3)
# 官网 https://nodejs.org/en/
# https://nodejs.org/download/release/v12.16.3/node-v12.16.3-x64.msi

# 使用npm安装Hexo
npm install -g hexo-cli
# 卸载命令
npm uninstall -g hexo-cli

# 初始化hexo框架
hexo init
# 启动本地服务
hexo s
# 新建文章
hexo new "postName" 

# 清除缓存
hexo clean
# 编译生成静态页面
hexo generate = hexo g
# 部署到GitHub
hexo deploy = hexo d
```

# GitBook环境搭建
```sh
# 下载 node.js(注意要安装稳定版本 建议安装12.16.3)
# 官网 https://nodejs.org/en/
# https://nodejs.org/download/release/v12.16.3/node-v12.16.3-x64.msi

# 使用npm安装GitBook
npm install -g gitbook-cli
gitbook -V
# 卸载命令
npm uninstall -g gitbook-cli

# 初始化GitBook框架
# 生成README.md和SUMMARY.md两个必须文件，README.md是对书籍的简单介绍，SUMMARY.md 是书籍的目录结构
gitbook init
# 启动本地服务
# 生成_book文件夹，里面包含关于页面的配置以及静态页面
gitbook serve
# 生成静态html(生成位置在_book/index.html)
gitbook build

# 根据SUMMARY.md的目录生成md文档
gitbook init
```

# VSCode + GitBook环境搭建
```sh
# 如果不需要生成静态网页，则可不必安装上述GitBook框架。更简单，推荐

# 安装VSCode(方法在上面)
# 安装以下插件
#	Markdown All in One
#	Gitbook kit
	
# 新建最简单的笔记本结构
|-- SUMMARY.md     # 目录
|-- README.md      # 引言
|-- CHAPTER_1      # 第一章文件夹
| |-- CHAPTER_1.md # 第一章

# SUMMARY.md为目录，其大致内容如下
`
# 书名
* [引言](README.md)

## CHAPTER_1
* [第一章 XXX](CHAPTER_1/CHAPTER_1.md)
`
```

# VSCode + Anaconda + Pytorch环境搭建
```sh
# Anaconda指的是一个开源的Python发行版本，其包含了conda、Python等180多个科学包及其依赖项
# 官网下载比较慢 https://www.anaconda.com/distribution/
# 去镜像站下载 https://mirrors.tuna.tsinghua.edu.cn/anaconda/archive/
# 安装时不要勾选添加环境变量，勾选使VSCode能够获取到conda的选项
# 手动添加环境变量
	?\anaconda\anaconda\Scripts - conda.exe路径

# Anaconda基本使用方法
# 使用conda务必在Anaconda Prompt(conda的终端)执行
# 最好先将conda源换为清华的，https://mirrors.tuna.tsinghua.edu.cn/help/anaconda/ 具体方法如下:
	1.创建 C:\Users\用户名\.condarc 文件
		conda config --set show_channel_urls yes
	2.将网址内的源覆盖到.condarc文件
	3.清除索引缓存，保证用的是镜像站提供的索引
		conda clean -i
# Anaconda基础命令
	1.查看Anaconda版本
		conda --version
	2.查看Anaconda所有环境
		conda info --env
	3.新建环境名
		# conda create --name '环境名' 'python安装包名'
		conda create --name python2 python=2.7
	4.激活/退出环境
		conda activate '环境名'
		conda deactivate '环境名'
	5.复制环境
		conda create --name '新环境名' --clone '被复制环境名'
	6.删除环境
		conda remove --name '环境名' --all
	7.查看当前环境安装包
		conda list
	8.在当前环境安装/卸载指定包
		conda install <package_name>
		conda remove <package_name>
		
# 在Anaconda中搭建Pytorch环境
# 去Pytorch网站查找安装pytorch的具体命令 https://pytorch.org/
# 注意CUDA版本，如果查版本嫌麻烦直接使用CPU版本(速度慢)
	1.更换源
	2.新建环境名
		conda create --name pytorch python=3.6
	3.激活环境
		conda activate pytorch
	4.执行从pytorch官网获得的安装pytorch命令
	5.安装ipykernel(用于分块运行python代码)
		conda install ipykernel
	
# 安装VSCode(方法在上面)
	1.安装Python插件
	2.打开Anaconda Prompt，激活上面新建的环境
		conda activate pytorch
	3.打开VSCode
		code
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

# Godot开发环境搭建
```sh
# 教程网址
# https://docs.godotengine.org/zh_CN/latest/development/compiling/compiling_for_windows.html

# windows应用商店安装python
# 直接在powershell中键入
python

# 安装Godot的编译工具scons
# 注意将scons的安装路径加入到环境变量
python -m pip install scons

# 安装visual studio 2017
# 安装时勾选'使用C++的游戏开发'与'使用C++的Linux开发'

# 下载源码，并切换到稳定版本，比如 3.4.2-stable
# https://gitee.com/mirrors/godot

# 编译Godot
scons p=windows vsproj=yes
```

# 远程桌面控制
```sh
# 安装MultiDesk

# 打开被控机器的远程桌面设置
# 右键我的电脑-属性-远程属性-远程-远程桌面

# 关闭防火墙

# 打开MultiDesk添加远程桌面IP并连接
```