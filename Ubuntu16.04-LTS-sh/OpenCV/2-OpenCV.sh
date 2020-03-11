#运行方式
#sh 2-OpenCV.sh

#===========OpenCV安装==========
#下载最新的Source源码 https://github.com/opencv/opencv/releases
tar -xvf opencv-3.4.3.tar.gz -C ~/opt/opencv-3.4.3

cd ~/opt/opencv-3.4.3  # 进入opencv文件夹
mkdir build # 创建build文件夹
cd build # 进入build文件夹

#cmake指令，如果没有特殊要求建议就选择默认的就可以
#注意，后面的两个点千万不能省，代表了上级目录
cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local ..  
make -j4 # 多线程执行make任务

# 最后一步，安装库文件
sudo make install

