# 纯净镜像下载
https://jingyan.baidu.com/article/37bce2bec1a11d5002f3a28b.html

# CMake与MSVC命令行编译
```sh
# 添加CMake的bin目录环境变量

# 打开Visual Studio命令提示进程(x86 Native Tools Command Prompt for VS 2017)
# 或者执行vs目录的XXX\VC\Auxiliary\Build\vcvarsall.bat x86进入命令模式
# 执行以下命令
rd /s/q build # 删除build文件夹
mkdir build
cd build
cmake -G "NMake Makefiles" ..
nmake clean
nmake '指定模块名'
# 或者
nmake
```

# MSVC界面调试  
cmake的编写注意事项:  
```
# 设置附带调试信息的release版本(可使用vs2017直接调试)
set(CMAKE_BUILD_TYPE "RelWithDebInfo")

# 设置运行库属性
# 多线程调试Dll (/MDd) 对应的是MDd_DynamicDebug
# 多线程Dll (/MD) 对应的是MD_DynamicRelease
# 多线程(/MT) 对应的是MT_StaticRelease
# 多线程(/MTd)对应的是MTD_StaticDebug
set(CMAKE_CXX_FLAGS_RELEASE "/MDd")

# boost使用 '-vc141-mt-x32-1_70.lib' 的库
```

vs界面调试流程:  
```sh
# 直接打开vs，文件->打开->CMake..

# 设置配置 x86-Release

# 加断点，直接运行进程
```

# MSVC .dump文件调试
```
# 需要查看详细符号的dll模块在编译时需要设置
# 属性-配置属性-链接器-调试 “是(/DEBUG)”
# 属性-配置属性-C/C++/优化 “已禁用(/Od)” // 能够更详细看到符号

# 将模块替换之后，复现崩溃并生成.dump文件

# 使用VS打开.dump文件(崩溃文件可放置在任意位置，并且VS所在机器必须包含源代码、dll库、PDB文件)
# 点击操作-设置符号路径-符号文件(.pdb)的位置-(+)，写入PDB所在路径
# 点击"使用 仅限本机 进行调试"
```