# 服务搭建
```sh
# 安装依赖
$ sudo apt-get install curl openssh-server ca-certificates postfix

# 下载安装包
$ curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh |sudo bash
$ sudo apt-get install gitlab-ce

# 修改对外域名
$ vi /etc/gitlab/gitlab.rb
`
external_url "http://192.168.1.1:8081"
`

# 保存并更新配置
$ sudo gitlab-ctl reconfigure

# 登录到上述保存的网址
```

# 常用命令
```sh
# 停止/重启/启动服务
$ sudo gitlab-ctl stop
$ sudo gitlab-ctl restart
$ sudo gitlab-ctl start

# 更新配置
$ sudo gitlab-ctl reconfigure
```