# 简介
ROS2源码编译环境镜像搭建流程、源码编译流程介绍
http://dev.ros2.fishros.com/doc/Installation/Ubuntu-Development-Setup.html

# 系统镜像下载
目前基于Debian的Foxy Fitzroy目标平台是：Ubuntu Linux - Focal Fossa (20.04) 64位
https://renwole.com/archives/1598

# 搭建源码编译环境
添加ROS2 apt仓库
```sh
sudo apt update && sudo apt install curl gnupg2 lsb-release
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key  -o /usr/share/keyrings/ros-archive-keyring.gpg
```

然后将仓库添加到源文件列表中
```sh
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(source /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
```

安装开发工具和ROS工具
```sh
sudo apt update && sudo apt install -y \
  build-essential \
  cmake \
  git \
  libbullet-dev \
  python3-colcon-common-extensions \
  python3-flake8 \
  python3-pip \
  python3-pytest-cov \
  python3-rosdep \
  python3-setuptools \
  python3-vcstool \
  wget
# install some pip packages needed for testing
python3 -m pip install -U \
  argcomplete \
  flake8-blind-except \
  flake8-builtins \
  flake8-class-newline \
  flake8-comprehensions \
  flake8-deprecated \
  flake8-docstrings \
  flake8-import-order \
  flake8-quotes \
  pytest-repeat \
  pytest-rerunfailures \
  pytest
# install Fast-RTPS dependencies
sudo apt install --no-install-recommends -y \
  libasio-dev \
  libtinyxml2-dev
# install Cyclone DDS dependencies
sudo apt install --no-install-recommends -y \
  libcunit1-dev
```

# 源码编译
获取ROS2代码
```sh
mkdir -p ~/ros2_foxy/src
cd ~/ros2_foxy
wget https://raw.githubusercontent.com/ros2/ros2/foxy/ros2.repos
vcs import src < ros2.repos
```

使用rosdep安装依赖项
```sh
sudo rosdep init
rosdep update
rosdep install --from-paths src --ignore-src -y --skip-keys "fastcdr rti-connext-dds-5.3.1 urdfdom_headers"
```

在工作区中编译代码
```sh
cd ~/ros2_foxy/
colcon build --symlink-install
```

# 测试运行
设置环境
```sh
. ~/ros2_foxy/install/local_setup.bash
```

运行测试代码
```sh
ros2 run demo_nodes_cpp talker
ros2 run demo_nodes_py listener
```