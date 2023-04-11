# 系统镜像下载
http://mirrors.aliyun.com/centos/7.9.2009/isos/x86_64/
https://mirrors.bfsu.edu.cn/centos-altarch/7.9.2009/isos/i386/

# 安装桌面环境
由于该版本是最小系统，因此只有终端。如果要安装界面安装桌面环境，则执行以下
```sh
# 安装X windows - 桌面控制功能
yum upgrade
yum -y groupinstall "X Window System"

# 安装KDE桌面
yum -y groups install "KDE Plasma Workspaces"
echo "exec startkde" >> ~/.xinitrc
startx
```

# 配置网络
```sh
# 查看网络硬件，一般为eth0、ens0...
ip addr

# 修改网络的配置文件
vi /etc/sysconfig/network-scripts/'ifcfg- 加上硬件'

# 修改配置，一般主要修改以下几个配置
# BOOTPROTO=static  #改为静态IP
ONBOOT=yes #开机自启
# IPADDR=192.168.68.130 #ip不能超出起止IP，查看起止IP请看下文
# NETMASK=255.255.255.0 # 子网掩码
# GATEWAY=192.168.68.1 # 网关
DNS1=8.8.8.8 # 如果没有DNS2，将DNS1改为DNS
DNS2=?.?.?.? # 如果物理机上有，则最好需要配置

# 重启network服务
$ systemctl restart network.service
```

# 配置源 - centos6
```sh
# 关闭fastestmirror, 修改参数
vi /etc/yum/pluginconf.d/fastestmirror.conf
enable=0

# 将原来的源备份
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.bak

# 替换为阿里云Vault镜像
wget -O /etc/yum.repos.d/CentOS-Base.repo https://static.lty.fun/%E5%85%B6%E4%BB%96%E8%B5%84%E6%BA%90/SourcesList/Centos-6-Vault-Aliyun.repo
```

# 配置源 - centos7
```sh
# 直接往默认源文件中加入阿里云的源
curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
```

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
```
