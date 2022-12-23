# 纯净镜像下载
https://jingyan.baidu.com/article/37bce2bec1a11d5002f3a28b.html

# Godot开发环境搭建
```sh
# 教程网址
# https://docs.godotengine.org/zh_CN/latest/development/compiling/compiling_for_windows.html

# windows应用商店安装python
# 直接在powershell中键入
$ python

# 安装Godot的编译工具scons
# 注意将scons的安装路径加入到环境变量
$ python -m pip install scons

# 安装visual studio 2017
# 安装时勾选'使用C++的游戏开发'与'使用C++的Linux开发'

# 下载源码，并切换到稳定版本，比如 3.4.2-stable
# https://gitee.com/mirrors/godot

# 编译Godot(可以多核编译 -j4)
# 将在bin目录下将生成godot可执行文件，在根目录下生成.sln工程
$ scons p=windows vsproj=yes

# 生成桌面快捷方式
# XXX/bin/godot.windows.tools.64.exe
```



# Godot自定义C++模块
```sh
# 教程网址
# https://docs.godotengine.org/zh_CN/stable/development/cpp/custom_modules_in_cpp.html

# 模块的目录结构
modules                  # 模块放在 XXX/modules 下
└─test                   # 任意模块名(小写)
   │  config.py          # *模块配置文件
   │  register_types.cpp # *c++类的 注册/注销 函数入口
   │  register_types.h
   │  SCsub              # *scons的编译脚本
   └─ test.hpp           # 自定义c++类
   
# 编译Godot(可以多核编译 -j4)
# 自定义C++模块的使用需要源码编译Godot(由于scons是增量编译，每次修改模块后再执行以下命令即可)
$ scons p=windows vsproj=yes
```

```c++
# config.py
def can_build(env, platform):
    return True
        
def configure(env):
    pass
```

```c++
/* register_types.h */
void register_test_types();
void unregister_test_types();
/* test需要修改为文件名 */
```

```c++
/* register_types.cpp */
#include "register_types.h"
#include "core/class_db.h"
#include "test.hpp"

/* 注册 */
void register_test_types()
{
    ClassDB::register_class<Test>();
}

/* 注销 */
void unregister_summator_types()
{
}
```

```sh
# SCsub
Import('env')
module_env = env.Clone()
module_env.Append(CPPPATH=["./include"])
src_list = ["summator.cpp", "other.cpp", "etc.cpp"]
module_env.add_source_files(env.modules_sources, src_list)

module_env.Append(CCFLAGS=['-O2']) # Flags for C and C++ code
module_env.Append(CXXFLAGS=['-std=c++11']) # Flags for C++ code only
```

```c++
#ifndef TEST_HPP
#define TEST_HPP

#include "core/reference.h"

class Test :public Reference // 必须继承
{
    GDCLASS(Test, Reference); // 必加
protected:
     // 必加
    static void _bind_methods()
    {
        ClassDB::bind_method(D_METHOD("Init"), &Test::Init);
    }
public:
    int Init() { return 10; }
};

#endif //!TEST_HPP
```