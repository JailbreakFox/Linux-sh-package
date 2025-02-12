# 简介
ROS2源码编译环境镜像搭建流程、源码编译流程介绍
http://dev.ros2.fishros.com/doc/Installation/Ubuntu-Development-Setup.html

# 系统镜像下载
目前基于Debian的Humble目标平台是：Ubuntu Linux - jammy (22.04) 64位
https://releases.ubuntu.com/jammy/

# 配置源
```sh
$ vi /etc/apt/sources.list
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-updates main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-updates main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-backports main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-backports main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-security main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-security main restricted universe multiverse
```

添加ROS2下载源
```sh
#更新源
$ sudo apt update

# 启用universe仓库
$ sudo apt install software-properties-common
$ sudo add-apt-repository universe

# 添加ROS 2 GPG key(需要梯子)
$ sudo apt update && sudo apt install curl -y
$ sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

# 仓库添加到源
$ echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

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
$ sudo apt install ros-humble-desktop
# 安装ROS2(非图形化界面)
# sudo apt install ros-humble-ros-base

# 安装编译工具及其他基础工具
$ sudo apt install ros-dev-tools

# 设置环境变量
$ echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
$ source ~/.bashrc

# 测试例子
# 终端一:
$ ros2 run demo_nodes_cpp talker
# 终端二:
$ ros2 run demo_nodes_cpp listener
```

# 替换通信中间件
为了实现cyclonedds直接与ROS2通信，需要先将ROS2依赖的通信中间件替换成自己的，此处以cyclonedds 0.10.4为例
```sh
# 安装依赖
$ sudo apt install ros-humble-rmw-cyclonedds-cpp
$ sudo apt install ros-humble-rosidl-generator-dds-idl

# 注释掉source
$ sudo vi ~/.bashrc
'
# source /opt/ros/humble/setup.bash 
'

# 开始编译cyclonedds
$ mkdir -p ~/ros2_workspace/cyclonedds_ws/src
$ cd ~/ros2_workspace/cyclonedds_ws/src
#克隆cyclonedds仓库
$ git clone https://github.com/ros2/rmw_cyclonedds -b humble
$ git clone https://github.com/eclipse-cyclonedds/cyclonedds -b releases/0.10.x
$ cd ..
$ colcon build --packages-select cyclonedds

# 打开~/.bashrc编辑
# CYCLONEDDS_URI NetworkInterface name修改成自己需要cyclonedds通信的网卡，该配置用于使用cyclonedds开发
'
#!/bin/bash
echo "setup ros2 environment"
source /opt/ros/humble/setup.bash
source $HOME/ros2_workspace/cyclonedds_ws/install/setup.bash
export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
export CYCLONEDDS_URI='<CycloneDDS><Domain><General><Interfaces>
                            <NetworkInterface name="ens33" priority="default" multicast="default" />
                        </Interfaces></General></Domain></CycloneDDS>'
'

# 更新当前终端配置
$ source ~/.bashrc
```

# 安装Moveit2
moveit2用于机械臂移动操作的库
```sh
# 安装rosdep
$ sudo rosdep init
$ rosdep update

# 安装依赖
$ sudo apt install python3-vcstool

# 安装moveit2
$ mkdir -p moveit2_ws/src && cd moveit2_ws/src
$ git clone https://github.com/ros-planning/moveit2_tutorials -b humble --depth 1 moveit2_tutorials
$ vcs import < moveit2_tutorials/moveit2_tutorials.repos

# 工作区软件包依赖项安装
$ sudo apt update && rosdep install -r --from-paths . --ignore-src --rosdistro $ROS_DISTRO -y

# 编译
$ colcon build --cmake-args -DCMAKE_BUILD_TYPE=Release

# 测试方式
$ source moveit2_ws/install/setup.bash
$ ros2 launch moveit2_tutorials demo.launch.py
$ ros2 launch moveit_task_constructor_demo demo.launch.py
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
$ systemctl restart sshd.services
```