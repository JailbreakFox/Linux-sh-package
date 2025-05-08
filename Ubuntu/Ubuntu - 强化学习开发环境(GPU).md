# 基础环境
由于需要使用GPU(虚拟机使用GPU较为难配置)，所以该教程不生成虚拟机OVF，而是直接生成ISO镜像。

该教程使用镜像《ubuntu-20.04.4-desktop-amd64.iso》

另外Issac Gym目前只支持x86架构

**注意，下述所有需要pip安装的包都已经保存在《 Linux开发安装包 / AI》目录下，若有网络问题，可直接在对应anaconda环境下执行"conda install *.whl"来安装所有依赖包。**

# 强化学习三件套关系
- Isaac Gym: 提供高性能的物理仿真环境。
- Legged Gym: 基于 Isaac Gym，专注于四足机器人的强化学习任务。
- rsl_rl: 提供强化学习算法的实现，用于训练 Legged Gym 中的机器人控制策略。

# 更换源
```sh
# 使用鱼香ROS更换源
$ wget http://fishros.com/install -O fishros && . fishros
```

# 安装Nvidia驱动
Software & Updates => Additional Drivers => "Using NVIDIA driver metapackage from nvidia-driver-570(proprietary)"

# Pytorch环境搭建
```sh
# 安装Anaconda(用于控制python、pytorch及其他依赖库的版本)
# 官网 https://www.anaconda.com/download/#linux
# 清华源 https://mirrors.tuna.tsinghua.edu.cn/anaconda/archive/
$ chmod +x Anaconda3-5.1.0-Linux-x86_64.sh
$ bash Anaconda3-5.1.0-Linux-x86_64.sh

# 安装完成后会提醒是否初始化，选择否
# Do you wish the installer to initialize Anaconda3 [no]

# 切换Anaconda源(方便快速下载pytorch)
$ vi ~/.condarc
'
report_errors: false
channels:
  - http://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/pytorch/
  - http://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/
  - http://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
  - http://mirrors.ustc.edu.cn/anaconda/pkgs/free/
  - defaults
show_channel_urls: true
'

# 初始化anaconda
$ /root/anaconda3/bin/conda init bash

# 在Anaconda中搭建Pytorch环境
# 去Pytorch网站查找安装pytorch的具体命令 https://pytorch.org/
# 必须使用CUDA版本
$ conda create -n pytorch-gpu python=3.8
$ conda activate pytorch-gpu
# 从legged_gym官网找(正常情况下从pytoch官网找)对应pytoch gpu版本下载指令
# 官网地址 https://github.com/leggedrobotics/legged_gym
$ pip3 install torch==1.10.0+cu113 torchvision==0.11.1+cu113 torchaudio==0.10.0+cu113 -f https://download.pytorch.org/whl/cu113/torch_stable.html
```

# Isaac Gym安装
Isaac Gym由NVIDIA开发，用于强化学习，且必须GPU支持，且必须使用root权限，否则安装失败
```sh
# 安装isaac-gym
# https://developer.nvidia.com/isaac-gym/download
$ cd /opt/isaacgym/python
$ pip install -e .

# 测试
$ cd /opt/isaacgym/python/examples
$ python 1080_balls_of_solitude.py
$ python joint_monkey.py
```

# rsl_rl安装
```sh
$ cd /opt
$ git clone https://github.com/leggedrobotics/rsl_rl
$ cd rsl_rl && git checkout v1.0.2 && pip install -e .
```

# legged_gym安装
```sh
$ cd /opt
$ git clone https://github.com/leggedrobotics/legged_gym.git
$ cd legged_gym && pip install -e .
```

# (进阶)extreme-parkour
此处以extreme-parkour包(PPO算法四足机器人)为训练目标，需要依赖于legged_gym与rsl_rl
```sh
# extreme-parkour源码 https://github.com/chengxuxin/extreme-parkour/tree/main
# 论文地址 https://extreme-parkour.github.io/
# legged_gym源码 https://github.com/leggedrobotics/legged_gym
# rsl_rl源码 https://github.com/leggedrobotics/rsl_rl

# 安装extreme-parkour
$ git clone git@github.com:chengxuxin/extreme-parkour.git
$ cd ~/extreme-parkour/rsl_rl && pip install -e .
$ cd ~/extreme-parkour/legged_gym && pip install -e .

# 安装必要依赖
$ pip install "numpy<1.24" pydelatin wandb tqdm opencv-python ipdb pyfqmr flask
```


# ~~ISO镜像制作(安装后会导致黑屏)~~
```sh
# 安装systemback
$ sudo su
$ bash -c 'echo "deb [arch=amd64] https://mirrors.bwbot.org/ stable main" > /etc/apt/sources.list.d/systemback.list'
$ apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key 50B2C005A67B264F
$ apt update
$ apt install systemback

# 安装cdtools
$ wget https://sourceforge.net/projects/cdrtools/files/alpha/cdrtools-3.02a09.tar.gz
$ tar -zxvf cdrtools-3.02a09.tar.gz -C /opt
$ cd /opt/cdrtools-3.02
$ make && make install
# 创建测试数据
$ touch usb{1..10}

# 打开systemback
$ systemback-sustart
# 修改"Storage directory"到希望存放ISO的位置
# 点击"Live system create"
# 修改"Name of the Live system"到希望的镜像名
# 勾选"Include the user data files"包含用户的数据
# 点击"Create new"创建镜像
# 创建完成后，镜像.iso文件就在指定的目录下
```