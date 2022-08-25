# 纯净镜像下载
https://jingyan.baidu.com/article/37bce2bec1a11d5002f3a28b.html

# VSCode + MinGW / MSVC开发环境
```sh
# 官网安装 https://code.visualstudio.com/
# 如果安装速度较慢，将下载连接
# https://az764295.vo.msecnd.net/stable/... 部分改为
# https://vscode.cdn.azure.cn/stable/...

# 安装必要插件
# 1. chinese(simplified)
# 2. C++(插件名为 cpptools-win32.vsix 附带扩展插件)
# 3. CMake Tools
# 4. CMake
# 5. Remote Development
# 6. Git Graph
# 7. favorites(收藏功能)
# 8. Markdown All in One
# 9. Markdown Preview Enhanced
# 10. Gitbook kit
# 11. Python
# 12. Output Colorizer

# 安装编译器 + Qt + CMake
# 注意
	1. 如果已安装CMake且有环境变量，则CMake插件将加载该已安装CMake(未安装的情况下使用CMake插件自带CMake，版本不定)
# MinGW / MSVC版本配套:
	1. 如果使用VSCode + MinGW则无需安装VS(直接安装MinGW的编译器即可);如果使用MSVC则需先安装VS
	2. 推荐使用前者作为编译器，后者编译时文件编码格式必须为GBK，且有些C语言的头文件没有内置(比如unistd.h)
	3. CMake 3.14(3.13以上版本，且3.20不可用)

# 链接编译器
# 添加环境变量后，打开项目，并点击最下方一栏cmake里的编译工具选项，选择[SCan for kits]，就能加载新编译器(或者直接选择已被搜索到的编译工具)
# 修改Cmake:Build Directory路径，该路径是生成的中间文件目录，比较杂乱

# 修改编码格式(MinGW环境使用默认UTF-8编码文件，文件行尾推荐使用Linux的LF)
# MSVC环境需要修改编码格式:
# File(文件)->Preferences(首选项)->Usersettings(设置)，搜索encoding ，然后修改为GB2312
# 另外勾选Auto Guess Encoding

# ===== VSCode编译Qt程序 =====
# 开发Qt程序仍旧推荐使用QtCreator，但是如果只是要编译运行Qt，需要做如下操作
# ----- MSVC编译器 -----
# 注意，MSVC没有单独编译器下载，需要先安装VS
	1.安装具有MSVC开发工具(用于qmake链接编译器)的Qt版本，比如上面使用过的5.12.0
	2.添加环境变量，目的是让vscode找到Qt位置
		1) 可以添加全局环境变量 ...\Qt5.12.10\5.12.0\msvc2015_64\lib\cmake
		2) 或者可以使用CMakeLists.txt配置寻找Qt的路径
		
# ----- MinGW编译器 -----
# 注意，MinGW编译器一般Qt安装程序内置可以选择
	1.找到具有MinGW开发工具与编译器的Qt版本，比如上面使用过的5.12.0
	2.添加环境变量，目的是让vscode找到Qt位置
		1) 可以添加全局环境变量 ...\Qt5.12.10\5.12.0\msvc2015_64\lib\cmake
		2) 或者可以使用CMakeLists.txt配置寻找Qt的路径
		
# 在settings.json文件中添加默认配置
{
	// 设置build中间文件的路径
	"cmake.buildDirectory": "${workspaceFolder}/build_trash"
	
    // 设置Google的代码格式(快捷键 Shift + Alt + F)
    // 格式名可选：LLVM, Google, Chromium, Mozilla, WebKit
    "C_Cpp.clang_format_fallbackStyle": "{ BasedOnStyle: Google, UseTab: Never, IndentWidth: 4, TabWidth: 4}",
    "C_Cpp.clang_format_style": "{ BasedOnStyle: Google, UseTab: Never, IndentWidth: 4, TabWidth: 4}"
}
```
