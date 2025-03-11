# Apache服务搭建
```sh
# 安装Apache2
$ sudo apt-get install apache2

# 重启服务
# 配置文件路径 /etc/apache2/apache2.conf
# 网页路径 /var/www/html
$ sudo /etc/init.d/apache2 restart
```

# Apache网站文件服务
```sh
# 直接在 /var/www/html 放置文件夹(以 tmp 目录为例)
# 直接访问 http://XXX/tmp 即可
```

# Tomcat服务搭建
apache支持静态页，tomcat支持动态页
```sh
# 安装JDK
$ sudo apt install openjdk-8-jdk

# 下载tomcat源码
# https://dlcdn.apache.org/tomcat/tomcat-8/v8.5.84/bin/apache-tomcat-8.5.84.tar.gz

# 开启服务
$ tar -zxvf apache-tomcat-8.5.84.tar.gz
$ chmod 755 -R apache-tomcat-8.5.84
$ ./bin/startup.sh

# 浏览器访问
# http://localhost:8080
```