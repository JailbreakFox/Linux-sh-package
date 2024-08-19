# 基础环境
该镜像未搭建，由于需要使用GPU(虚拟机使用GPU较为难配置)，建议直接安装Ubuntu系统

# Pytorch环境搭建
```sh
# 安装Anaconda(用于控制python、pytorch及其他依赖库的版本)
# https://www.anaconda.com/download/#linux
$ chmod +x Anaconda3-5.1.0-Linux-x86_64.sh
$ bash Anaconda3-5.1.0-Linux-x86_64.sh

# 安装完成后会提醒是否初始化，选择否
# Do you wish the installer to initialize Anaconda3 [no]

# 添加环境变量
$ vi ~/.bashrc
'
	export PATH="/root/anaconda3/bin:$PATH"
'
$ source ~/.bashrc

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

# 在Anaconda中搭建Pytorch环境
# 去Pytorch网站查找安装pytorch的具体命令 https://pytorch.org/
# 必须使用CUDA版本
conda create -n pytorch-gpu python=3.8
conda activate pytorch-gpu
# 从pytoch官网找对应pytoch gpu版本下载指令
pip3 install torch==1.10.0+cu113 torchvision==0.11.1+cu113 torchaudio==0.10.0+cu113 -f https://download.pytorch.org/whl/cu113/torch_stable.html
```

# Isaac Gym安装
Isaac Gym由NVIDIA开发，用于强化学习，且必须GPU支持
```sh
# 安装isaac-gym
# https://developer.nvidia.com/isaac-gym/download
cd /opt/isaacgym/python
pip install -e .

# 测试
cd /opt/isaacgym/python/examples
python 1080_balls_of_solitude.py
python joint_monkey.py
```

# (进阶)extreme-parkour
此处以extreme-parkour包(PPO算法四足机器人)为训练目标，需要依赖于legged_gym与rsl_rl
```sh
# extreme-parkour源码 https://github.com/chengxuxin/extreme-parkour/tree/main
# 论文地址 https://extreme-parkour.github.io/
# legged_gym源码 https://github.com/leggedrobotics/legged_gym
# rsl_rl源码 https://github.com/leggedrobotics/rsl_rl

# 安装extreme-parkour
git clone git@github.com:chengxuxin/extreme-parkour.git
cd ~/extreme-parkour/rsl_rl && pip install -e .
cd ~/extreme-parkour/legged_gym && pip install -e .

# 安装必要依赖
pip install "numpy<1.24" pydelatin wandb tqdm opencv-python ipdb pyfqmr flask
```