#运行方式
#sh Matlab2018a.sh 安装包路径 挂载路径 安装路径

#===========Matlab2018a安装============
#新建安装路径文件，并添加权限
#mkdir $3

#挂载文件
#mkdir $2
#sudo mount -t auto -o loop $1/R2018a_glnxa64_dvd1.iso $2
#sudo $2/install
#再打开另一个终端，挂载，点击继续安装
#sudo mount -t auto -o loop $1/R2018a_glnxa64_dvd2.iso $2

#断开网络连接，并安装
#cd $2
#sudo ./install

#安装完成后取消挂载
#sudo umount $2

#-----安装过程-----
#1、Use a File Installation Key
#2、yes
#3、I have the File Installation Key for my License:
#09806-07443-53955-64350-21751-41297

#4、安装路径选择 $2 
