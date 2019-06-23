#运行方式
#该操作需要手动进行

#===========RobWork安装==========
#新建RobWork文件夹
#mkdir RobWork
#cd RobWork

#从Git仓库中下载最新版本的RobWork：https://gitlab.com/sdurobotics/RobWork
#如果是在终端中操作，输入如下命令行（确保您位于要安装robwork的目录中）。由于网络原因，不能下载，这个包在公司找
#git clone https://gitlab.com/sdurobotics/RobWork.git

#编译RobWork
#mkdir Build
#mkdir Build/RW
#mkdir Build/RWStudio
#mkdir Build/RWSim
#mkdir Build/RWHardware

#编译RW模块
#在运行make命令之前仔细查看CMake的输出，检查是否有错误以及是否正确找到了所需的依赖项。要生成的-j4参数将在4个CPU核心上构建RobWork。注意在编译时，每个线程至少需要1 GB的内存，例如用4个内核编译需要大约4GB的RAM。
#cd ~/RobWork/Build/RW
#cmake -DCMAKE_BUILD_TYPE=Release ../../RobWork
#make -j4

#编译RWS模块
#cd ~/RobWork/Build/RWStudio
#cmake -DCMAKE_BUILD_TYPE=Release ../../RobWorkStudio
#make -j4

#编译RWSim模块
#cd ~/RobWork/Build/RWSim
#cmake -DCMAKE_BUILD_TYPE=Release ../../RobWorkSim
#make -j4

#编译RobWH模块
#cd ~/RobWork/Build/RWHardware
#cmake -DCMAKE_BUILD_TYPE=Release ../../RobWorkHardware
#make -j4

#添加如下路径至~/.bashrc:
#export RW_ROOT=~/RobWork/RobWork/
#export RWS_ROOT=~/RobWork/RobWorkStudio/
#export RWHW_ROOT=~/RobWork/RobWorkHardware/
#export RWSIM_ROOT=~/RobWork/RobWorkSim/
