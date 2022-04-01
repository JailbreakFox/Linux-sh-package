# 系统镜像下载
注意，低版本的centos7不支持docker的某些版本
http://mirrors.aliyun.com/centos/7.9.2009/isos/x86_64/

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
$ systemctl restart network
```

# 配置源
```sh
# 直接往默认源文件中加入阿里云的源
curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
```

# 安装必要软件
```sh
# 安装wget
yum -y install wget gcc gcc-c++ cmake
```

# docker环境搭建 - 离线安装
```sh
# 新建docker文件夹，在其中放入如下三个文件
mkdir docker
cd docker

# ======================== 三个文件 ========================
# 1.下载离线包 https://download.docker.com/linux/static/stable/x86_64/
# 此处以docker-18.09.9.tgz为例

# 2.新建一个服务文件
vim docker/docker.service
`
[Unit]
Description=Docker Application Container Engine
Documentation=https://docs.docker.com
After=network-online.target firewalld.service
Wants=network-online.target

[Service]
Type=notify
# the default is not to use systemd for cgroups because the delegate issues still
# exists and systemd currently does not support the cgroup feature set required
# for containers run by docker
ExecStart=/usr/bin/dockerd
ExecReload=/bin/kill -s HUP $MAINPID

# Having non-zero Limit*s causes performance problems due to accounting overhead
# in the kernel. We recommend using cgroups to do container-local accounting.
LimitNOFILE=infinity
LimitNPROC=infinity
LimitCORE=infinity

# Uncomment TasksMax if your systemd version supports it.
# Only systemd 226 and above support this version.
#TasksMax=infinity

TimeoutStartSec=0

# set delegate yes so that systemd does not reset the cgroups of docker containers
Delegate=yes

# kill only the docker process, not all processes in the cgroup
KillMode=process

# restart the docker process if it exits prematurely
Restart=on-failure
StartLimitBurst=3
StartLimitInterval=60s

[Install]
WantedBy=multi-user.target
`

# 3.新建一个安装脚本
`
#!/bin/sh
echo '解压tar包...'
tar -xvf $1 >/dev/null 2>&1

echo '将docker目录移到/usr/bin目录下...'
cp docker/* /usr/bin/

echo '将docker.service 移到/etc/systemd/system/ 目录...'
cp docker.service /etc/systemd/system/

echo '添加文件权限...'
chmod +x /etc/systemd/system/docker.service

echo '重新加载配置文件...'
systemctl daemon-reload

echo '启动docker...'
systemctl start docker

echo '设置开机自启...'
systemctl enable docker.service >/dev/null 2>&1

echo 'docker安装成功...'
docker -v >/dev/null 2>&1
`
# =================================================

# 执行install.sh进行安装
./install.sh docker-18.09.9.tgz

# 修改docker源
# 可以替换为
  科大镜像：https://docker.mirrors.ustc.edu.cn/
  网易：https://hub-mirror.c.163.com/
  阿里云：https://<你的ID>.mirror.aliyuncs.com
  七牛云加速器：https://reg-mirror.qiniu.com
$ vi /etc/docker/daemon.json
`
{"registry-mirrors":["https://reg-mirror.qiniu.com/"]}
# 替换成功后重启服务
$ systemctl daemon-reload
$ systemctl restart docker
`

# 关闭SELINUX部分功能，否则有可能无法运行容器
$ vi /etc/selinux/config
`
SELINUX=disabled
`
```

# docker基础用法
```sh
# 仓库、镜像与容器关系
# 仓库 - 一个仓库能存放大量镜像
# 镜像 - 相当于是一个root文件系统
# 容器 - 一个镜像运行时的实体，可以被创建、启动、停止、删除、暂停。镜像与容器的关系就像是类和实例

# ===== 镜像相关 =====
# 列出镜像列表
$ docker images

# 查找镜像
$ docker search ubuntu

# 获取镜像
$ docker pull ubuntu

# 删除镜像
$ docker rmi ubuntu

# 更新镜像
$ docker commit -m="XXX" -a="XXX" e218edb10161 runoob/ubuntu:v2
  -m: 提交的描述信息
  -a: 指定镜像作者
  e218edb10161: 容器ID
  runoob/ubuntu: 镜像所在仓库
  v2: 镜像tag号

# 创建镜像
# 使用 Dockerfile 指令来创建一个新的镜像(下面具体描述)

# ===== 容器相关 =====
# 新建容器
$ docker run -itd ubuntu /bin/bash
  -i: 交互式操作
  -t: 终端
  -d: 后台运行
  ubuntu: 仓库名
  /bin/bash: 交互式使用的终端
  
# 删除容器
$ docker rm -f '容器ID'

# 查看所有容器
$ docker ps -a

# 继续/停止/重新运行容器
$ docker start '容器ID'
$ docker stop '容器ID'
$ docker restart '容器ID'

# 进入容器 - attach(退出容器会导致其停止)
$ docker attach '容器ID'

# 进入容器 - exec(退出容器不会导致其停止)
$ docker exec -it '容器ID' /bin/bash
```