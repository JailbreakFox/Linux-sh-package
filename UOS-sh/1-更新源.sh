#运行方式
#sh 1-更新源.sh

#============UOS更新软件源=============
#新建deepin.list文件
sudo touch /etc/apt/sources.list.d/deepin.list 

#往deepin.list添加华为源
sudo echo "" > /etc/apt/sources.list.d/deepin.list 
sudo echo "### 华为源：

deb [trusted=yes] https://mirrors.huaweicloud.com/deepin stable main contrib non-free

#deb-src deb https://mirrors.huaweicloud.com/deepin stable main" > /etc/apt/sources.list.d/deepin.list 

#更新源
sudo apt-get update

