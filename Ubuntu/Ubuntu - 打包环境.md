# 系统镜像下载
http://mirrors.ustc.edu.cn/ubuntu-releases/16.04/

# 配置源
直接往默认源文件中加入清华源
```sh
$ vi /etc/apt/source.list
# deb cdrom:[Ubuntu 16.04 LTS _Xenial Xerus_ - Release amd64 (20160420.1)]/ xenial main restricted
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