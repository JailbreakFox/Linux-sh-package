#===========PlantUML安装============
# ----- 先安装Java -----
# 寻找库中的jdk文件
apt-cache search jdk
# 直接安装找到的包
sudo apt install openjdk-11-jdk

# ----- 再安装graphviz -----
sudo apt install graphviz

# 直接在VSCode扩展库中找到PlantUML,安装
# 写好*.wsd, *.pu, *.puml, *.plantuml, *.iuml 文件以后,按 ALT+D 显示
