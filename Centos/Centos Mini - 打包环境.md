# 系统镜像下载
http://mirrors.aliyun.com/centos/7/isos/x86_64/

# 安装桌面环境
由于该版本是最小系统，因此只有终端。需要先安装桌面环境
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
BOOTPROTO=static  #改为静态IP
ONBOOT=yes #开机自启
IPADDR=192.168.68.130  #ip不能超出起止IP，查看起止IP请看下文
NETMASK=255.255.255.0  # 子网掩码
GATEWAY=192.168.68.1  # 网关
DNS1=8.8.8.8
DNS2=?.?.?.?  # 可能需要配置
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

# rpm打包环境搭建
```sh
# 打包工具安装
yum install rpm-build
# 也可以直接安装rpmdevtools，其中包含了rpm-build与一些必要打包工具
yum install rpmdevtools
```