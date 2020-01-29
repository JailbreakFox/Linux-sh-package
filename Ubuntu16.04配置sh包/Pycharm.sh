#运行方式
#sh Pycharm.sh

#===========pycharm-community-2019.3.2安装==========
#安装必要开发环境
sudo apt-get install build-essential

#下载CLion包https://www.jetbrains.com/Pycharm/
#解压tar.gz包，解压位置推荐设置为用户目录下的opt文件~/opt
tar -zxvf pycharm-community-2019.3.2 -C ~/opt
#运行clion.sh脚本
cd ~/opt/pycharm-community-2019.3.2/bin/
./pycharm.sh

