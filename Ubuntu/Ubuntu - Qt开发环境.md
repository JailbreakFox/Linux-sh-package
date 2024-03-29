# 系统镜像下载
http://mirrors.ustc.edu.cn/ubuntu-releases/16.04/

# 配置源
直接往默认源文件中加入清华源
```sh
$ vi /etc/apt/source.list
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

# Qt开发环境搭建 - apt版本
```sh
# ===== 安装Qt =====
# 默认安装库里的Qt版本与依赖
sudo apt install qtcreator qt5-default

# ===== 安装必要软件 =====
$ sudo apt install g++ gdb openssh-server cmake
```

# Qt开发环境搭建 - 安装包版本
```sh
# 从官网(http://download.qt.io/)下载，但是速度很慢
# 建议从国内源下载
#     中国科学技术大学：http://mirrors.ustc.edu.cn/qtproject/
#     清华大学：https://mirrors.tuna.tsinghua.edu.cn/qt/
#     北京理工大学：http://mirror.bit.edu.cn/qtproject/
#     中国互联网络信息中心：https://mirrors.cnnic.cn/qt/
$ sudo chmod +x ./qt-opensource-linux-x64-5.5.1.run
$ ./qt-opensource-linux-x64-5.5.1.run
```

# Qt环境变量设置
```sh
# 添加环境变量 ~/.bashrc
export QT_SELECT=qt5.5.1
export QTDIR=/opt/Qt5.5.1/5.7/gcc_64
export PATH=$QTDIR/bin:$PATH
export MANPATH=$QTDIR/man:$MANPATH
```

# Qt版本选择工具使用
```sh
# 查看qt版本
& qmake -v

# qmake的本质是qtchooser
& ll /usr/bin/qmake
lrwxrwxrwx 1 root root 9 10月 18 2019 /usr/bin/qmake -> qtchooser*

# 查看qtchooser当前可选项
$ qtchooser -l
4
5
default
qt4-aarch64-linux-gnu
qt4
qt5-aarch64-linux-gnu
qt5

# 添加qtchooser版本配置
# 比如我们已经在/opt/Qt5.5.1目录下安装qt
# 则先/usr/share/qtchooser/目录下新建文件qt5.5.1.conf
/opt/Qt5.5.1/gcc_64/bin
/opt/Qt5.5.1

# 添加软链接
ln -s /usr/share/qtchooser/qt5.5.1.conf /usr/lib/x86_64-linux-gnu/qtchooser/qt5.5.1.conf
# 再次 'qtchooser -l' 即可看到已有qt5.5.1版本选择

# 版本选择
-------------------- QMake --------------------
$ export QT_SELECT=qt5.5.1
-------------------- CMake --------------------
# CMakeLists.txt内添加
$ export QTDIR='Qt安装根目录路径'
'
set(CMAKE_PREFIX_PATH "$ENV{QTDIR}")
或
find_package(Qt5 HINTS "$ENV{QTDIR}" COMPONENTS Core Quick REQUIRED)
'

# 再次 'qmake -v' 可查看已经选择的qt版本
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
```  
接下来分析下生成的文件结构:  
```sh
# 注意该工具会修改可执行程序的RPATH
# 我们只需要生成后的 ./lib 文件下的所有库文件即可

# 生成的文件结构
QtLibs
├── lib     # 存放所有运行时库
├── plugins # 存放所有需要的插件
└── qt.conf # *配置文件
```
qt.conf文件详解:

| 字段        | 默认值                              | 释义                                                         |
| ------------- | -------------------------------------- | -------------------------------------------------------------- |
| Prefix        | QCoreApplication::applicationDirPath() | 绝对路径，其他的设定都是相对于Prefix的相对路径，使用默认值即可 |
| Documentation | doc                                    | 文档                                                         |
| Headers       | include                                | 头文件                                                      |
| Libraries     | lib                                    | 库文件                                                      |
| Binaries      | bin                                    | 二进制文件                                                |
| Plugins       | plugins                                | 插件                                                         |
| Data          | .                                      |                                                                |
| Translations  | translations                           |                                                                |
| Settings      | .                                      |                                                                |
| Examples      | .                                      |                                                                |
| Demos         | .                                      |                                                                |

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