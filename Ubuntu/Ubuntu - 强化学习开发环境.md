# 基础镜像
Ubuntu ROS1研发环境

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
# 注意CUDA版本，如果查版本嫌麻烦直接使用CPU版本(速度慢)
	1.更换源
	2.新建环境名
		conda create --name pytorch python=3.8.5
	3.启动Anaconda
		conda init bash
		source activate # 切换到base环境
	4.激活环境
		conda activate pytorch
	5.1*执行从pytorch官网获得的安装pytorch命令(安装在当前anaconda环境 为了保持环境纯净还是使用此方式)
	5.2或者直接运行以下命令安装(安装在anaconda3/pkgs目录下 可被其他anaconda环境使用)
		conda install pytorch
```

# Gym环境搭建
```sh
# 安装依赖
conda install swig

# 安装完整版gym
pip install gym[all]

# 附上测试代码
'
import gym
env = gym.make('MountainCar-v0', render_mode = 'human')
for i_episode in range(10):
    observation = env.reset()
    for t in range(100):
        env.render()
        print(observation)
        action = env.action_space.sample()
        observation, reward, done, info, _ = env.step(action)
    if done:
        print("Episode finished after {} timesteps".format(t+1))
        break
env.close()
'
```
# Gymnasium环境搭建(需要先安装Gym环境)
```sh
# 安装完整版Gymnasium(gym2021年已不再维护)
pip install gymnasium[all]

# 安装插件
pip install free-mujoco-py
sudo apt-get install libosmesa6-dev
sudo apt-get install patchelf

# 修复mujoco bug
vi /opt/anaconda3/envs/pytorch/lib/python3.8/site-packages/gymnasium/envs/mujoco/mujoco_rendering.py
'
# 593行
bottomleft, "Solver iterations", str(self.data.solver_niter + 1)
'

# 附上测试代码
'
import mujoco_py
import os

mj_path = mujoco_py.utils.discover_mujoco()
xml_path = os.path.join(mj_path, 'model', 'arm26.xml')

model = mujoco_py.load_model_from_path(xml_path)

sim = mujoco_py.MjSim(model)
viewer = mujoco_py.MjViewer(sim)
sim_state = sim.get_state()

while True:
    sim.set_state(sim_state)

    for i in range(1000):
        if i < 2:
            sim.data.ctrl[:] = 0.0
        else:
            sim.data.ctrl[:] = -1.0
        sim.step()
        viewer.render()

    if os.getenv('TESTING') is not None:
        break
'
```

# (进阶)stable-baselines3安装
stable-baselines3包含了常见的强化学习算法
```sh
# 安装
pip install stable-baselines3[extra]

# 训练gym(mujoco)自带的游戏
git clone https://github.com/Jitu0110/RLMujoco.git
cd /root/RLMujoco/Code
python main.py Humanoid-v4 SAC -t # Ant-v4 HalfCheetah-v4
```

# Anaconda基础命令
```sh
1.查看Anaconda版本
	conda --version
2.查看Anaconda所有环境
	conda info --env
3.新建环境名
	# conda create --name '环境名' 'python安装包名'
	conda create --name python2 python=2.7
4.激活/退出环境
	conda activate '环境名'
	conda deactivate '环境名'
5.复制环境
	conda create --name '新环境名' --clone '被复制环境名'
6.删除环境
	conda remove --name '环境名' --all
7.查看当前环境安装包
	conda list
8.在当前环境安装/卸载指定包
	conda install <package_name>
	conda remove <package_name>
9.升级Anaconda
	conda update --all
```

# 学习网站
```sh
# gym游戏
# https://pypi.org/
# 例如马里奥 https://pypi.org/project/gym-super-mario-bros/

# gymnasium官方教程
# https://gymnasium.farama.org/
```