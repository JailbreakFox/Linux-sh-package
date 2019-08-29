#MATLAB机器人工具包
#运行方式
#sh robotic-toolbox.sh 安装路径

#===========robotic-toolbox============
#先解压缩
sudo cp -r -i rvctools $1/toolbox/

#添加权限
sudo chmod -R 777 $1/toolbox/rvctools/

#matlab内打开rvctools/startup_rvc.m，并运行

#matlab终端内输入ver 查看是否加载成功

#以后每次打开，需要在matlab终端执行上述过程
