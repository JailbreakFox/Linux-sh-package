#运行方式
#sh 1-更新源.sh

#============UOS更新软件源=============
#新建deepin.list文件
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak

#往deepin.list添加华为源
sudo echo "" > /etc/apt/sources.list
sudo echo "deb [by-hash=force] http://pools.corp.deepin.com/ppa/dde-eagle eagle main contrib non-free

deb [by-hash=force] http://10.0.10.25/uos eagle main contrib non-free

deb-src [by-hash=force] http://10.0.10.25/uos eagle main contrib non-free

deb-src [by-hash=force] http://pools.corp.deepin.com/ppa/dde-eagle eagle main

deb http://pools.corp.deepin.com/ppa/dde-eagle experimental main

deb-src http://pools.corp.deepin.com/ppa/dde-eagle experimental main" > /etc/apt/sources.list

#更新源
sudo apt-get update

