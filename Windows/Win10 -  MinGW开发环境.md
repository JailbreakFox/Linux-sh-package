# 纯净镜像下载
https://jingyan.baidu.com/article/37bce2bec1a11d5002f3a28b.html

# MinGW命令行开发环境 - 无CMake
```sh
# 官网 https://sourceforge.net/projects/mingw-w64/files/mingw-w64/mingw-w64-release/
# 如果不需要在线下载，就下载离线包(已编译版本) x86_64-win32-seh
# 将解压出来的bin文件夹路径添加到path环境变量(搜索"编辑系统环境变量")

# 打开任意终端，执行
$ gcc -v

# 编译(或者使用Makefile)
$ gcc '源文件路径' -o '生成路径'
```
