# 简介
Cheetah Mini源码编译环境镜像搭建流程、源码编译流程介绍
https://zhuanlan.zhihu.com/p/654747553
https://blog.csdn.net/weixin_41106948/article/details/128779123

# 系统镜像下载
http://mirrors.ustc.edu.cn/ubuntu-releases/20.04/

# 搭建源码编译环境
```sh
# 安装依赖包
$ sudo apt install mesa-common-dev freeglut3-dev coinor-libipopt-dev libblas-dev liblapack-dev gfortran liblapack-dev coinor-libipopt-dev cmake gcc build-essential libglib2.0-dev

# 安装qt gamepad
$ sudo apt install libqt5gamepad5-dev

# 安装 eigen3
$ sudo apt-get install libeigen3-dev
$ mv /usr/include/eigen3 /usr/local/include

# 编译lcm
$ git clone https://github.com/lcm-proj/lcm.git
$ cd lcm
$ git checkout v1.5.0
$ mkdir build
$ cd build
$ cmake ..
$ make
$ sudo make install
$ sudo ldconfig
```

# 源码编译
```sh
$ git clone https://github.com/mit-biomimetics/Cheetah-Software.git

# 修改文件 common/CMakeLists.txt:30 master->main

# 修改文件 CMakeLists.txt:28 CMakeLists.txt:40 删除-Werror

# 新建文件 /usr/include/stropts.h
`
#if HAVE_STROPTS_H
#include <stropts.h>
#endif
`

# 修改文件robot/src/rt/rt_serial.cpp
`
#include <asm/termios.h>

#undef termios

#include <termios.h>
`
# 成为
`
#include <asm/ioctls.h>
#include <asm/termbits.h>

#undef termios

#include <sys/ioctl.h>
#include <termios.h>
`

$ cd Cheetah-Software
$ cd scripts
$ bash make_types.sh
$ cd ..
$ mkdir build
$ cd build
$ cmake ..
$ make -j2
```

# 测试运行
https://www.yii666.com/blog/416601.html
```sh
# 修改control_mode和cheater_mode为1，修改use_rc为0
$ vi ./config/mini-cheetah-defaults.yaml

# 打开机器人仿真控制界面
# 先点击Mini Cheetah和Simulator，然后点击Start
$ cd build
$ ./sim/sim

# mit_ctrl为编译得到的可执行文件，m的含义为mini cheetah模型，s的含义为simulate，即仿真
$ ./user/MIT_Controller/mit_ctrl m s

# 修改仿真控制界面的control_mode值为 1 -> 3 -> 9 ,完成后跳
# 机器狗运动通过手柄控制
```