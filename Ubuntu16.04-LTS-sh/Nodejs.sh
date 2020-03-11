#运行方式
#sh Nodejs.sh

#===========Nodejs安装============
#-------方法一：------
#去官网下载最新的安装包
#http://nodejs.cn/download/

#解压并进入安装包，依次执行
#./configure
#make
#make install

#-------方法二：------
#安装旧版Noejs
sudo apt-get install nodejs
sudo apt install nodejs-legacy
sudo apt install npm

#更换淘宝的镜像，可以通过 sudo npm config list 查看是否生效
sudo npm config set registry https://registry.npm.taobao.org


#安装更新版本的工具N
sudo npm install n -g

#更新版本，可以看到有 installed：版号，说明更新成功
sudo n stable
