# 纯净镜像下载
https://jingyan.baidu.com/article/37bce2bec1a11d5002f3a28b.html

# Godot开发环境搭建
```sh
# 教程网址
# https://docs.godotengine.org/zh_CN/latest/development/compiling/compiling_for_windows.html

# windows应用商店安装python
# 直接在powershell中键入
python

# 安装Godot的编译工具scons
# 注意将scons的安装路径加入到环境变量
python -m pip install scons

# 安装visual studio 2017
# 安装时勾选'使用C++的游戏开发'与'使用C++的Linux开发'

# 下载源码，并切换到稳定版本，比如 3.4.2-stable
# https://gitee.com/mirrors/godot

# 编译Godot
# 将在bin目录下将生成godot可执行文件，在根目录下生成.sln工程
scons p=windows vsproj=yes
```
