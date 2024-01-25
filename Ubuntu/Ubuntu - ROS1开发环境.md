# 系统镜像下载
http://mirrors.ustc.edu.cn/ubuntu-releases/20.04.4/

# 配置源
直接往默认源文件中加入清华源
```sh
$ vi /etc/apt/sources.list
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-updates main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-updates main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-backports main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-backports main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-security main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-security main restricted universe multiverse multiverse
```

添加ROS1下载源
```sh
#更新源
$ sudo apt update

# 添加ROS1软件源
$ sudo sh -c '. /etc/lsb-release && echo "deb http://mirrors.ustc.edu.cn/ros/ubuntu/ $DISTRIB_CODENAME main" > /etc/apt/sources.list.d/ros-latest.list'

# 添加密钥
$ sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F42ED6FBAB17C654

#更新源
$ sudo apt update

# 安装ROS
$ sudo apt update
$ sudo apt-get install ros-noetic-desktop-full # Ubuntu20.04
$ sudo apt-get install ros-melodic-desktop-full # Ubuntu18.04
$ sudo apt-get install ros-kinetic-desktop-full # Ubuntu16.04

# 添加环境变量
$ vim ~/.bashrc
`
source /opt/ros/kinetic/setup.bash
`
```

# 配置C/C++开发环境
```sh
$ sudo apt install openssh-server git cmake vim

# 降级安装gcc-4.8
# 替换源
$ cp /etc/apt/sources.list /etc/apt/sources.list_bak
$ vi /etc/apt/sources.list
deb http://dk.archive.ubuntu.com/ubuntu/ xenial main
deb http://dk.archive.ubuntu.com/ubuntu/ xenial universe

# 更新源
$ sudo apt update

# 安装低版本gcc/g++
$ sudo apt install gcc-4.8
$ sudo apt install g++-4.8

# 添加软链接
$ cd /usr/bin
$ mv gcc gcc-9.4
$ mv g++ g++-9.4
$ sudo ln -s gcc-4.8 gcc
$ sudo ln -s g++-4.8 g++

# 替换回源
$ mv /etc/apt/sources.list_bak /etc/apt/sources.list
$ sudo apt update
```

# 生成root登陆用户
```sh
# ===== 登陆界面添加root =====
# 修改root密码
$ sudo passwd root
# 修改配置文件
$ sudo vim /usr/share/lightdm/lightdm.conf.d/50-ubuntu.conf
# 末尾添加
greeter-show-manual-login=true #手工输入登陆系统的用户名和密码
all-guest=false              #不允许guest登录（可选）

# ===== ssh添加root用户 =====
# 设置ssh可登陆
$ sudo vim /etc/ssh/sshd_config
# 修改PermitRootLogin
PermitRootLogin yes
# 重启服务
& systemctl restart sshd.services
```