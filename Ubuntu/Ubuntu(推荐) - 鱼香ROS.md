# 简介
快速搭建ROS、配置源环境的脚本。自动适配Ubuntu版本
源码地址：https://github.com/fishros/install
教程地址：https://fishros.org.cn/forum/topic/20/小鱼的一键安装系列
官方主页：https://fishros.com/

# 使用方法
```sh
$ wget http://fishros.com/install -O fishros && . fishros
```

# 目前支持工具
一键安装:ROS(支持ROS和ROS2,树莓派Jetson) 贡献@小鱼
一键安装:VsCode(支持amd64和arm64) 贡献@小鱼
一键安装:github桌面版(小鱼常用的github客户端) 贡献@小鱼
一键安装:nodejs开发环境(通过nodejs可以预览小鱼官网噢 贡献@小鱼
一键配置:rosdep(小鱼的rosdepc,又快又好用) 贡献@小鱼
一键配置:ROS环境(快速更新ROS环境设置,自动生成环境选择) 贡献@小鱼
一键配置:系统源(更换系统源,支持全版本Ubuntu系统) 贡献@小鱼
一键安装:Docker(支持amd64和arm64) 贡献@alyssa
一键安装:cartographer 贡献@小鱼&Catalpa
一键安装:微信客户端 贡献@小鱼

# (进阶)宇树go2仿真环境搭建
```sh
# 安装依赖
$ sudo apt install liblcm-dev ros-noetic-controller-interface  ros-noetic-gazebo-ros-control ros-noetic-joint-state-controller ros-noetic-effort-controllers ros-noetic-joint-trajectory-controller

$ mkdir -p test_ws/src && cd test_ws/src
$ git clone https://github.com/unitreerobotics/unitree_legged_sdk.git
$ git clone https://github.com/unitreerobotics/unitree_ros_to_real.git
$ git clone https://github.com/unitreerobotics/unitree_ros.git
$ git clone https://github.com/unitreerobotics/unitree_guide.git

# 运行测试
$ roslaunch unitree_guide gazeboSim.launch rname:=go2
```