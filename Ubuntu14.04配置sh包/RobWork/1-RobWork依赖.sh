#运行方式
#sh 1-RobWork依赖.sh

#===========RobWork依赖安装==========
#编译工具
#SVN和Mercurial客户端并不是必须的
sudo apt-get install subversion git mercurial
sudo apt-get install gcc g++ cmake

#RobWork需要的依赖
#安装Boost库
sudo apt-get install libboost-dev libboost-date-time-dev libboost-filesystem-dev libboost-program-options-dev libboost-regex-dev libboost-serialization-dev libboost-system-dev libboost-test-dev libboost-thread-dev

#---RobWork可选择的依赖---
#1.Xerces可以在RobWork中的某些位置用于打开XML文件，但这已经不再是必须安装的依赖，因为Robwork现在能够使用Boost解析器。
sudo apt-get install libxerces-c3.1 libxerces-c-dev
#2.Swig（可选）是一种工具，它可以为RobWork生成Lua脚本接口
sudo apt-get install swig liblua5.2-dev python-dev default-jdk
#3.google测试（可选）用于RobWork中的单元测试，如果您是开发人员，并且希望为RobWork开发代码，那么编写GTest将是必须的
sudo apt-get install libgtest-dev

#RobWorkStudio依赖
#RobWorkStudio需要安装Qt，Qt4与Qt5是支持的，但是新的Qt推荐安装Qt5版本
sudo apt-get install qtbase5-dev

#RobWorkSim依赖
#Open Dynamics Engine (ODE)可以通过功能包管理器安装
#Ubuntu14.04安装libode1，Ubuntu16.04安装libode4，Ubuntu版本高于16.10安装libode6。
#管理包安装方法ode版本可能低，如果需要安装最新版本请查阅安装教程http://www.robwork.dk/apidoc/nightly/rw/page_rw_installation_ubuntu.html
sudo apt-get install libode-dev libode4
#Bullet Physics也可以通过包管理器安装
#同理，需要下载特定版本查阅上述网址
sudo apt-get install libbullet-dev libbullet-extras-dev

#RobWorkHardware依赖
sudo apt-get install libdc1394-22-dev
