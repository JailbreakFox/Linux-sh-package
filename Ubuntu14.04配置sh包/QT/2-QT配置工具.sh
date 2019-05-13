#运行方式
#sudo sh 2-QT配置工具.sh

#配置QT环境，先安装Linux下的编译器
sudo apt-get install gcc g++
#再安装QT的OpenGL库，不然会报错“cannot find -lgl”
sudo apt-get install libqt4-dev
