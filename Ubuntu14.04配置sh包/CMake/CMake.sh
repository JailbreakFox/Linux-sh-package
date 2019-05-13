#运行方式
#sh CMake.sh

#===========CMake安装==========
#下载CLion包https://cmake.org/download/
#解压tar.gz包，解压位置推荐设置为用户目录下的opt文件~/opt
tar -zxvf cmake-3.14.3.tar.gz -C ~/opt
#安装gcc和g++，可以选择分别安装sudo apt-get install gcc g++，或者直接
sudo apt-get install build-essential
#运行clion.sh脚本
cd ~/opt/cmake-3.14.3
sudo ./bootstrap
sudo make
sudo make install
cmake -version

