#运行方式
#sh MySQL.sh

#===========MySQL安装============
# 去源中寻找相关库
apt-cache search mysql-server

# 安装 default-mysql-server - MySQL database server binaries and system database setup (metapackage)
# 这个包是MariaDB,MySQL被微软收购,但是为了被闭源而克隆出来的开源库
sudo apt install default-mysql-server
