# 纯净镜像下载
https://jingyan.baidu.com/article/37bce2bec1a11d5002f3a28b.html

# 安装应用
```sh
# 微信、钉钉、Git、Vscode、WPS

# chrome
https://www.google.cn/intl/zh-CN/chrome/

# VMware
https://www.vmware.com/cn/products/workstation-pro/workstation-pro-evaluation.html
# 激活码
ZF3R0-FHED2-M80TY-8QYGC-NPKYF

# Qt
# 可以从官网(http://download.qt.io/)下载，但是速度很慢
# 建议从国内源下载
#     中国科学技术大学：http://mirrors.ustc.edu.cn/qtproject/
#     清华大学：https://mirrors.tuna.tsinghua.edu.cn/qt/
#     北京理工大学：http://mirror.bit.edu.cn/qtproject/
#     中国互联网络信息中心：https://mirrors.cnnic.cn/qt/
#         安装组件: sources - 源码
#                        Qt所有插件
#                        MingGW - 编译器
# CMake
# 编译器使用MingGW，还需要CMake来构建
# 官网 https://cmake.org/download/
# CMakeList.txt
# 程序编译时可能找不到Qt的Qt5Config.cmake，需要告诉CMake关于Qt5的安装位置，比如:
# set(CMAKE_PREFIX_PATH ${CMAKE_PREFIX_PATH} "D:\\applications\\Qt\\5.11.3\\Src")
# 上述路径即为Qt的sources安装位置(或者也可以设置系统环境变量)
```

# 科学上网
```sh
# 购买vultr服务器
https://my.vultr.com

# ssh连接服务器，然后一键搭建v2ray
bash <(curl -s -L https://git.io/v2ray-setup.sh)
# 记录v2ray的vmess地址
v2ray url

# 安装客户端 https://github.com/2dust/v2rayN/releases
# 第一次安装需要安装v2rayN-Core.zip
```