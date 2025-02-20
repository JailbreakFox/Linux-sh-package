# 安装ROS2(Humble)
```sh
# 鱼香ROS按提示安装即可
$ wget http://fishros.com/install -O fishros && . fishros
```

# 安装Docker
```sh
# 鱼香ROS按提示安装即可
$ wget http://fishros.com/install -O fishros && . fishros
```

# 安装Anaconda
```sh
# 下载aarch64版本Anaconda
# https://mirrors.tuna.tsinghua.edu.cn/anaconda/archive/Anaconda3-2024.06-1-Linux-aarch64.sh

# 安装过程中所有提示都选yes
# 安装过程中会提醒安装路径 填写想安装到的位置即可
# Anaconda3 will now be installed into this location:
# /home/xxx/anaconda3

# 在Anaconda中搭建Pytorch环境
# 去Pytorch网站查找安装pytorch的具体命令 https://pytorch.org/
# 必须使用CUDA版本
conda create -n pytorch-gpu python=3.8
conda activate pytorch-gpu
```