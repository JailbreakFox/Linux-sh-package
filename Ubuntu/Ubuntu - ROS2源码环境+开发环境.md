# 搭建源码编译环境
优先搭建ROS2源码环境
```sh
# 源码目录在~/ros2_foxy
# 使用前需要先执行
source ~/ros2_foxy/install/setup.bash
```

# 搭建开发环境
```sh
# 直接安装ros2 foxy，安装后目录在/opt/ros/foxy
sudo apt install ros-foxy-desktop

# 使用前需要先执行
source /opt/ros/foxy/setup.bash
```

# 替换通信中间件
为了实现cyclonedds直接与ROS2通信，需要先将ROS2依赖的通信中间件替换成自己的，此处以cyclonedds 0.10.4为例
```sh
# 安装依赖
sudo apt install ros-foxy-rmw-cyclonedds-cpp
sudo apt install ros-foxy-rosidl-generator-dds-idl

# 注释掉source
sudo vi ~/.bashrc
'
# source /opt/ros/foxy/setup.bash 
'

# 开始编译cyclonedds
mkdir -p ~/ros2_workspace/cyclonedds_ws/src
cd ~/ros2_workspace/cyclonedds_ws/src
#克隆cyclonedds仓库
git clone https://github.com/ros2/rmw_cyclonedds -b foxy
git clone https://github.com/eclipse-cyclonedds/cyclonedds -b releases/0.10.x 
cd ..
colcon build --packages-select cyclonedds

# 配置终端环境
# CYCLONEDDS_URI NetworkInterface name修改成自己需要cyclonedds通信的网卡，该配置用于使用cyclonedds开发
'
#!/bin/bash
echo "setup ros2 environment"
source /opt/ros/foxy/setup.bash
source $HOME/ros2_workspace/cyclonedds_ws/install/setup.bash
export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
export CYCLONEDDS_URI='<CycloneDDS><Domain><General><Interfaces>
                            <NetworkInterface name="ens33" priority="default" multicast="default" />
                        </Interfaces></General></Domain></CycloneDDS>'
'

# 更新当前终端配置
source ~/.bashrc
```