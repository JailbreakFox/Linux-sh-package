# FTP协议
FTP（File Transfer Protocol: 文件传输协议）是用来在Internet 上**传送文件的协议**。FTP服务器（File Transfer Protocol Server）是文件传输协议服务器，是在互联网上提供文件存储和访问服务的计算机，它们依照FTP协议提供服务。

# VSFTP服务器
VSFTP是一个基于GPL发布的类Unix系统上使用的**FTP服务器软件**，它的全称是Very Secure FTP 从此名称可以看出来，编制者的初衷是代码的安全。VSFTP具有安全、高速、稳定的特点。VSFTP的软件架构为C/S 模式（即一个客户端一个服务器端）。

```sh
# 安装启动
$ sudo apt-get install vsftpd
$ sudo service vsftpd start

# 修改配置文件
$ vi /etc/vsftpd.conf
`
write_enable=YES # 配置后可用FTP传输文件到服务器
local_umask=022 # 普通用户目录权限755 文件权限644
allow_writeable_chroot=YES # 
`
```