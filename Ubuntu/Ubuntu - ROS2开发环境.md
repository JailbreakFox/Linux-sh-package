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

添加ROS2下载源
```sh
#更新源
$ sudo apt update

# 安装基础软件
$ sudo apt install curl gnupg2 lsb-release

# 下面这条语句，我的输出错误： gpg: no valid OpenPGP data found
# curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
# 解决上面的问题，可以换成下面这条语句：
$ curl http://repo.ros2.org/repos.key | sudo apt-key add - 

# 之后再添加源:
sudo sh -c 'echo "deb http://packages.ros.org/ros2/ubuntu `lsb_release -cs` main" > /etc/apt/sources.list.d/ros2-latest.list'

#更新源
$ sudo apt update
```

# 设置语言环境
```sh
$ sudo locale-gen en_US en_US.UTF-8
$ sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
$ export LANG=en_US.UTF-8
```

# ROS2环境搭建
```sh
# 安装ROS2(图形化界面)
$ sudo apt install ros-foxy-desktop
# 安装ROS2(非图形化界面)
# sudo apt install ros-foxy-ros-base

# 设置环境变量
$ echo "source /opt/ros/foxy/setup.bash" >> ~/.bashrc
$ source ~/.bashrc

# 安装自动补全工具
$ sudo apt install python3-argcomplete

# 测试例子
# 终端一:
$ ros2 run demo_nodes_cpp talker
# 终端二:
$ ros2 run demo_nodes_cpp listener
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