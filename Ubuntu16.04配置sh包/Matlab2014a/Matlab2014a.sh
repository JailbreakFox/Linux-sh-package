#运行方式
#sh Matlab2014a.sh  挂载路径 安装路径

#===========Matlab2014a安装============
#挂载文件
mkdir $1
sudo mount -o loop MATHWORKS_R2014A.iso $1

#新建安装路径文件，并添加权限
sudo mkdir $2
sudo chmod a+w -R $2

#断开网络连接，并安装
cd $1
sudo ./install

#-----安装过程-----
#1、Use a File Installation Key
#2、yes
#3、I have the File Installation Key for my License:
#12313-94680-65562-90832

#4、安装路径选择 $2 

#5、生成link

#6、安装最后，会提示是否激活，去掉即可，再使用破解脚本
