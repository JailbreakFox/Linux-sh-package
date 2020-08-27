#===========v2ray客户端安装============
# https://github.com/dreamrover/v2ray-deb
# 下载deb包
wget https://github.com/dreamrover/v2ray-deb/releases/download/4.27.0/v2ray-4.27.0-amd64.deb

# 安装
sudo dpkg -i v2ray-4.27.0-amd64.deb

# 修改 /etc/v2ray/config.json 文件配置
# vim /etc/v2ray/config.json

# 重启v2ray服务
sudo systemctl restart v2ray.service
