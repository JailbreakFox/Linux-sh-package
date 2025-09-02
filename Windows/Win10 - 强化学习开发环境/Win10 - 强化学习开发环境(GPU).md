# 纯净镜像下载
https://jingyan.baidu.com/article/37bce2bec1a11d5002f3a28b.html

# Anaconda + Pytorch环境搭建
```sh
# Anaconda指的是一个开源的Python发行版本，其包含了conda、Python等180多个科学包及其依赖项
# 官网下载比较慢 https://www.anaconda.com/distribution/
# 去镜像站下载 https://mirrors.tuna.tsinghua.edu.cn/anaconda/archive/
# 安装时不要勾选添加环境变量，勾选使VSCode能够获取到conda的选项
# 手动添加环境变量
	?\anaconda\anaconda\Scripts - conda.exe路径

# Anaconda基本使用方法
# 使用conda务必在Anaconda Prompt(conda的终端)执行
# 最好先将conda源换为清华的，https://mirrors.tuna.tsinghua.edu.cn/help/anaconda/ 具体方法如下:
	1.创建 C:\Users\用户名\.condarc 文件
		conda config --set show_channel_urls yes
	2.将网址内的源覆盖到.condarc文件
	3.清除索引缓存，保证用的是镜像站提供的索引
		conda clean -i
# Anaconda基础命令
	1.查看Anaconda版本
		conda --version
	2.查看Anaconda所有环境
		conda info --env
	3.新建环境名
		# conda create --name '环境名' 'python安装包名'
		conda create --name python3.8 python=3.8.8
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
		
# 在Anaconda中搭建Pytorch环境
# 去Pytorch网站查找安装pytorch的具体命令 https://pytorch.org/
# 注意CUDA版本，如果查版本嫌麻烦直接使用CPU版本(速度慢)
	1.更换源
	2.新建环境名(关闭科学上网)
		conda create --name python3.8 python=3.8.8
	3.激活环境
		conda activate python3.8
	4.执行从pytorch官网获得的安装pytorch命令(CUDA版本官方推荐11.8)
		pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118
	5.安装ipykernel(用于分块运行python代码)
		conda install ipykernel
```

# 超级马里奥训练测试
[测试视频](https://www.bilibili.com/video/BV1CERYY3EjA/?spm_id_from=333.788.player.switch&vd_source=8ea8730dc46c789bd14a5c8141ea1f20&p=5)
```sh
# 安装依赖
conda install setuptools=65.5.0
conda install wheel=0.38.4
conda install pip=20.2.4
# gym-super-mario-bros 将马里奥游戏的接口封装成了gym的接口，该包后续供RL_SuperMario仓库训练使用
pip install -r requirements.txt

# 测试安装结果
python test_mario.py

# 训练
git clone git@github.com:jusway/RL_SuperMario.git
python test_model.py
```

# Pycharm安装
```sh
# 从安装包安装Pycharm

# 添加本地解释器->选择现有->类型“conda”->"Anaconda3\envs\python3.8\python.exe"

# 打开RL_SuperMario项目
```
