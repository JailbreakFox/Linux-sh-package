# 系统镜像Ubuntu20.04 LTS下载
https://releases.ubuntu.com/focal/

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
# 添加ROS1软件源
$ sudo apt update
$ sudo sh -c '. /etc/lsb-release && echo "deb http://mirrors.tuna.tsinghua.edu.cn/ros/ubuntu/ `lsb_release -cs` main" > /etc/apt/sources.list.d/ros-latest.list'

# 添加密钥
$ sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

# 安装ROS
$ sudo apt update
$ sudo apt-get install ros-noetic-desktop-full # Ubuntu20.04
# $ sudo apt-get install ros-melodic-desktop-full # Ubuntu18.04
# $ sudo apt-get install ros-kinetic-desktop-full # Ubuntu16.04

# 添加环境变量
$ vim ~/.bashrc
`
source /opt/ros/noetic/setup.bash
`
$ source ~/.bashrc

# 安装依赖包
$ sudo apt install python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential
$ sudo apt install python3-pip -y
$ sudo pip3 install -i https://pypi.tuna.tsinghua.edu.cn/simple rosdepc
$ sudo rosdepc init
$ rosdepc update
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