# 系统镜像下载
http://mirrors.aliyun.com/centos/7/isos/x86_64/
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

# 安装必要软件
```sh
# 安装wget
yum -y install wget gcc gcc-c++ cmake
```

# rpm打包环境搭建
```sh
# 打包工具安装
yum install rpm-build
# 也可以直接安装rpmdevtools，其中包含了rpm-build与一些必要打包工具
yum install rpmdevtools
```