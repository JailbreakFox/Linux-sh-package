# 搭建Apache网站服务

```sh
# 官网下载Apache
# https://httpd.apache.org/

# 修改Apache24/conf/httpd.conf文件内容
'
# 修改为自己的安装路径
Define SRVROOT "D:/httpd-2.4.63-250207-win64-VS17/Apache24"

# 修改为自己的域名:端口
ServerName www.xxx.com:80
'

# cmd管理员方式进入Apache24/bin目录
# 安装Apache服务
$ httpd -k install apache
```

# 其他命令
```sh
# 停止服务
$ httpd -k stop

# 开始服务
$ httpd -k start

# 重启服务
$ httpd -k restart
```