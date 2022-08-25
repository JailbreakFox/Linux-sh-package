# 纯净镜像下载
https://jingyan.baidu.com/article/37bce2bec1a11d5002f3a28b.html

# CMake与MSVC命令行编译
```sh
# 添加CMake的bin目录环境变量

# 打开Visual Studio命令提示进程，执行以下命令
rd /s/q build # 删除build文件夹
mkdir build
cd build
cmake -G "NMake Makefiles" ..
nmake clean
nmake '指定模块名'
# 或者
nmake
```
