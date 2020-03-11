#Matlab2018a破解脚本

#===========Matlab2018a破解============
#先启动一次matlab
#sudo $3/bin/matlab
#出现激活框后,选择:Activate manually without the Internet 
#然后选择破解文件,在MATLAB R2018a Linux64 Crack/license_server.lic

#复制破解文件
#sudo cp -f $1/MATLAB R2018a Linux64 Crack/R2018a/bin/glnxa64/matlab_startup_plugins/lmgrimpl/libmwlmgrimpl.so $3/bin/glnxa64/matlab_startup_plugins/lmgrimpl
#sudo cp -i $1/license_server.lic $3/licenses
#sudo cp -i $1/license_standalone.lic $3/licenses

#修改.matlab权限
#sudo chmod -R a+w ~/.matlab/

#添加快捷方式
#cd ~/Desktop/
#mkdir matlab.desktop
#gedit matlab.desktop
#输入
#[Desktop Entry] 
#Encoding=UTF-8
#Name=Matlab 2018a
#Comment=MATLAB
#Exec=/home/cobot/opt/Matlab2018a/bin/matlab
#Icon=/home/cobot/opt/Matlab2018a/toolbox/shared/dastudio/resources/MatlabIcon.png
#Terminal=true
#ype=Application
#Categories=Application;
#添加快捷方式权限
#sudo chmod +x matlab.desktop

#双击运行
