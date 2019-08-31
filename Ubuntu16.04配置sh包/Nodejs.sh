#运行方式
#sh Nodejs.sh

#===========Nodejs安装============
#执行检查可更新的软件
sudo apt-get update

#安装低版本的Nodejs
sudo apt-get install nodejs
sudo apt install nodejs-legacy
sudo apt install npm

#更换淘宝的镜像(必须)
sudo npm config set registry https://registry.npm.taobao.org

#查看配置是否生效
sudo npm config list

#安装更新版本的工具N
sudo npm install n -g

#更新Nodejs版本
sudo n stable
