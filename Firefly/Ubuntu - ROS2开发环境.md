# 配置源
添加ROS2下载源
```sh
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
# 安装ROS2(非图形化界面)
$ sudo apt install ros-foxy-ros-base

# 设置环境变量
$ echo "source /opt/ros/foxy/setup.bash" >> ~/.bashrc
$ source ~/.bashrc

# 安装自动补全工具
$ sudo apt install python3-argcomplete
# 安装colcon编译工具
$ sudo apt install python3-colcon-common-extensions
```
