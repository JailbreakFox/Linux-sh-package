# 开发工具下载
- 镜像 http://mirrors.ustc.edu.cn/ubuntu-releases/16.04/
- GCC http://mirrors.concertpass.com/gcc/releases/gcc-5.4.0/
- Qt源码 https://download.qt.io/new_archive/qt/5.5/5.5.1/single/
- 已编译交叉编译环境 https://zhuanlan.zhihu.com/p/79043170

# 配置源
直接往默认源文件中加入清华源
```sh
$ vi /etc/apt/source.list
# 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-updates main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-updates main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-backports main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-backports main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-security main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-security main restricted universe multiverse
```
更新源
```sh
$ sudo apt update
```

# GCC交叉编译环境搭建 - x86
```
1. 源码编译
2. apt下载
```
***1、源码编译***  
GCC源码编译对环境要求很高，比如ubuntu16.04几乎编不了4.8.5版本的GCC，所以如果能找到已编译版本或者能使用apt下载，则优先考虑，源码编译方法如下:
```sh
# 官网 https://gcc.gnu.org/releases.html ，下载一个GCC
# 以GCC-5.4.0为例 http://mirrors.concertpass.com/gcc/releases/gcc-5.4.0/

# 搭建GCC源码文件目录如下
$ tree tempDir
tempDir
├── gcc-build # 将GCC源码包解压至此
└── gcc-5.4.0 # 在运行configure时，设置GCC prefix，最终输出编译结果至此

# 安装GCC编译依赖
# 方案一: GCC源码自带安装依赖的文件
$ cd tempDir/gcc-build/contrib
$ ./download_prerequisites
# 方案二: 直接下载(推荐，速度更快)
& sudo apt-get install build-essential libgmp-dev libmpfr-dev libmpc-dev

# 在源码目录下新建build目录并开始编译
$ cd tempDir/gcc-build
$ ../configure --prefix='安装路径' --enable-threads=posix --disable-checking --disable-multilib

# 编译
$ make -j $(grep -c ^processor /proc/cpuinfo) # 后面这句可查看当前系统最高可运行编译的核数

# 安装
$ make install -j $(grep -c ^processor /proc/cpuinfo)

# .bashrc末尾添加添加环境变量
& vi /root/.bashrc
export PATH='build目录下的bin文件夹路径':$PATH

# 实例检验
# 修改CTest项目CMakeLists.txt文件下的gcc与g++路径
# 编译运行
```
***2、apt下载***  
```sh
# 降级安装gcc-4.8
sudo apt install gcc-4.8
sudo apt install g++-4.8
cd /usr/bin
sudo ln -s gcc-4.8 gcc
sudo ln -s g++-4.8 g++

# 实例检验
# 修改CTest项目CMakeLists.txt文件下的gcc与g++路径
# 编译运行
```

# GCC交叉编译环境搭建 - arm
由于arm版GCC源码编译困难，直接网上找已编译版本
```sh
# ARM已编译版本GCC下载网址 (arm 针对是是 32 位的， aarch64 针对 Arm64.)
# https://mirrors.tuna.tsinghua.edu.cn/armbian-releases/_toolchain/

# .bashrc末尾添加添加环境变量
& vim /root/.bashrc
'
export PATH='build目录下的bin文件夹路径':$PATH
'

# 实例检验
# CTest项目编译运行
$ cmake -DCROSS_COMPILE_FRAMEWORK=aarch64 ..
$ make
```

# GCC交叉编译环境搭建 - mips
网上已编译版本很难找，只有最新和最旧的版本
```sh
# 旧版下载地址 http://mirrors.aliyun.com/loongson/mirrors.html
# 新版下载地址 http://www.loongnix.cn/index.php/Cross-compile

# 这边用已经下载好的预编译版本
# 直接解压 cross-gcc-4.9.3-n64-loongson-rc6.1

# 添加环境变量
$ vim /root/.bashrc
'
export LD_LIBRARY_PATH=?/cross-gcc-4.9.3-n64-loongson-rc6.1/usr/x86_64-unknown-linux-gnu/mips64el-loongson-linux/lib:$LD_LIBRARY_PATH
export PATH=?/cross-gcc-4.9.3-n64-loongson-rc6.1/usr/bin:$PATH
'

# 实例检验
# CTest项目编译运行
$ cmake -DCROSS_COMPILE_FRAMEWORK=mips64 ..
$ make
```

# QT编译选项汇总
```sh
# 1、安装选项
-prefix： 指定部署目录，默认路径为 /usr/local/Qt-$QT_VERSION 
-extprefix： 指定安装目录，如主机上所示，[SYSROOT/PREFIX]
-hostprefix： 指定运行在本主机上的构建工具的安装目录，如果不指定则使用当前目录
-external-hostbindir： 指定为这台机器构建的Qt工具路径，当-platform和当前系统不匹配时使用，例如：创建交叉编译
# 可以使用下面选项来对安装目录进行微调，请注意，所有目录除-sysconfdir外，其他的应位于-prefix和-hostprefix下
-bindir： 可执行文件安装目录，[PREFIX/bin]
-headerdir： 头文件安装目录，[PREFIX/include]
-libdir： 库文件安装目录，[PREFIX/lib]
-archdatadir： Arch-dependent 数据安装目录，[PREFIX]
-plugindir： 插件安装目录，[ARCHDATADIR/plugins]
-libexecdir： 辅助程序安装目录，[ARCHDATADIR/bin on Windows, ARCHDATADIR/libexec otherwise]
-importdir： QML1 导入安装目录，[ARCHDATADIR/imports]
-qmldir： QML2 导入安装目录，[ARCHDATADIR/qml]
-datadir： Arch-independent 数据安装目录，[PREFIX]
-docdir： 文档安装目录，[DATADIR/doc]
-translationdir： 翻译数据安装目录，DATADIR/translations]
-sysconfdir： QT 程序使用的设置目录，[PREFIX/etc/xdg]
-examplesdir： 示例安装目录，[PREFIX/examples]
-testsdir： 测试安装目录，[PREFIX/tests]
-hostbindir： 主机可执行文件安装目录，[HOSTPREFIX/bin]
-hostlibdir： 主机库文件安装目录，[HOSTPREFIX/lib]
-hostdatadir： qmake 所使用的数据目录，[HOSTPREFIX]

# 2、配置选项
-help： -h 显示帮助信息
-verbose： -v 配置过程中打印每个步骤的的详细信息
-continue： 如果发生错误，尽管继续
-redo： 重新配置以前使用的选项，可能会传递其他额外的选项，但不会保存供稍后的-redo选项使用
-recheck [test,…]： 丢弃缓存的无用的配置测试结果，在安装完丢失的依赖项后使用该选项，或者，如果指定了 tests，只有它们的结果会被丢弃
-recheck-all： 丢弃所有缓存的配置测试结果
-feature-<feature>： 启用<feature>
-no-feature-<feature>： 禁止<feature>，[none]
-list-features： 列出可用的特性，请注意，一些特性还有专用的命令行选项
-list-libraries： 列出可能的外部依赖项

# 3、编译选项
-opensource： 编译Qt的开源版本
-commercial： 编译Qt的商业版
-confirm-license： 自动确认许可
-release： 编译Qt的release版本，关闭调试，[yes]
-debug： 编译Qt的debug版本，开启调试，[no]
-debug-and-release： 编译Qt的release和debug两个版本，[yes] (Apple and Windows only)
-optimize-debug： 在调试构建中启用调试友好的优化，[auto] (Not supported with MSVC or Clang toolchains)
-optimize-size： 优化发布版本的大小而不是速度，[no]
-optimized-tools： 构建优化的主机工具，即使在调试构建，[no]
-force-debug-info： 强制为release构建输出调试信息，[no]
-separate-debug-info： 将调试信息到一个单独的文件，[no]
-gdb-index： 将调试信息索引到加速 GDB， [no; auto if -developer-build with debug info]。
-strip： 使用 strip 去除不需要符号的二进制文件，[yes]
-gc-binaries： 将每个函数或数据项放入各自的分区中，启用未使用分区的链接器垃圾回收，[auto for static builds, otherwise no]
-force-asserts： 启用 Q_ASSERT 即使在 release 版本中，[no]
-developer-build： 编译和链接 Qt 用以开发 Qt 本身，(exports for auto-tests, extra checks, etc.) [no]
*-shared： 构建 Qt 共享库，[yes] (no for UIKit)
-static： 构建 QT 静态库，[no] (yes for UIKit)
-framework： 构建 Qt 框架包，[yes] (Apple only)
-platform <target>： 选择要构建的主机 mkspec，[detected]
-xplatform <target>： 选择交叉编译时的目标 mkspec，[PLATFORM]
-device <name>： 交叉编译<name>设备
-device-option <key=value>： 添加选项到设备的 mkspec
-appstore-compliant： 禁用平台应用程序商店中不允许的代码，对于需要通过 app store 进行分发的平台，这是默认打开的，特别是： Android, iOS, tvOS, watchOS, and Universal Windows Platform，[auto]。
-qtnamespace <name>： 把所有的 Qt 库代码放入namespace{…}中
-qtlibinfix <infix>： 重命名所有libQt*.so为libQt*<infix>.so
-qtlibinfix-plugins： 通过-qtlibinfix重命名 Qt 插件，[no]
-testcocoon： Instrument with the TestCocoon code coverage tool，[no]
-gcov： Instrument with the GCov code coverage tool，[no]
-trace [backend]： Enable instrumentation with tracepoints，目前支持的后端有： ‘etw’ (Windows) and ‘lttng’ (Linux), or ‘yes’ for auto-detection，[no]
-sanitize [address/thread/memory/undefined]： Instrument with the specified compiler sanitizer，请注意，一些 sanitizers 是不能混合使用，例如： -sanitize address不能和-sanitize thread一起使用
-coverage {trace-pc-guard}： 添加代码覆盖工具， (Clang only)
-c++std <edition>： 选择 C++ 标准<edition>，[c++2a/c++17/c++14/c++11] (Not supported with MSVC 2015)
-sse2： 使用 SSE2 指令，[auto]
-sse3/-ssse3/-sse4.1/-sse4.2/-avx/-avx2/-avx512： 启用对特定 x86 指令的使用，启用的仍然会受到运行时检测的影响，[auto]
-mips_dsp/-mips_dspr2： 使用 MIPS DSP/rev2 指令，[auto]
-qreal <type>： 将 qreal 类型定义为指定的类型，请注意，这会影响二进制兼容性，[double]
-R <string>： 向 Qt 库添加显式运行时库路径，支持相对于 LIBDIR 的路径
-rpath： 链接 Qt 库和可执行文件使用库安装路径作为运行时库路径，相当于-R LIBDIR。在Apple平台上，禁用它意味着对动态库和框架使用绝对安装名称(基于LIBDIR)，[auto]
-reduce-exports： 减少输出符号的数量，[auto]
-reduce-relocations： Reduce amount of relocations，[auto] (Unix only)
-relocatable： 允许重新安装Qt，[auto]
-plugin-manifests： Embed manifests into plugins，[no] (Windows only)
-static-runtime： With -static, use static runtime，[no] (Windows only)
-pch： 使用预编译头文件，[auto]
-ltcg： 使用链接时代码生成，[no]
-linker [bfd,gold,lld]： 强制使用 GNU ld，GNU gold or LLVM/LLD 链接器而不是默认值，(GCC only)。
-incredibuild-xge： 使用 IncrediBuild XGE，[no] (Windows only)
-ccache： 使用 ccache 编译器缓存，[no] (Unix only)
-make-tool <tool>： 使用<tool>来构建 qmake，[nmake] (Windows only)
-mp： 使用多个处理器进行编译，(MSVC only)
-warnings-are-errors： 将警告视为错误，[no; yes if -developer-build]
-silent： 减少编译输出，以便更容易地看到警告和错误

# 4、编译环境
-sysroot <dir>： 将 <dir> 设置为目标 sysroot
-gcc-sysroot： 使用 -sysroot，将 --sysroot 传给编译器，[yes]
-pkg-config： 使用 pkg-config，[auto] (Unix only)
-D <string>： 传递额外的预处理定义
-I <string>： 传递额外的包含路径
-L <string>： 传递额外的库路径
-F <string>： 传递额外的框架路径， (Apple only)
-sdk <sdk>： 使用 Apple 提供的 SDK 构建 Qt，参数应该是由xcodebuild -showsdks所列出的有效的 SDK 列表中的一个
请注意，这个参数只适用于使用目标 mkspec 构建的 Qt 库和应用程序，而不是像 qmake，moc，rcc 等主机工具
-android-sdk path： 设置 Android SDK 根目录，[$ANDROID_SDK_ROOT]
-android-ndk path： 设置 Android NDK 根目录，[$ANDROID_NDK_ROOT]
-android-ndk-platform： 设置 android 平台
-android-ndk-host： 设置 Android NDK 主机，(linux-x86, linux-x86_64, etc.) [$ANDROID_NDK_HOST]
-android-abis： 逗号分隔 Android abis，默认有： armeabi-v7a,arm64-v8a,x86,x86_64
-android-style-assets： 运行时自动从设备提取 style assets，这个选项可以确保正确的 Android style，但也会使得 Android 平台插件与 LGPL2.1 不兼容，[yes]

# 5、组件选择
-skip <repo>： 从构建中排除整个存储库
-make <part>： 在 make 时添加要构建的<part>组件，[libs and examples, also tools if not cross-building, also tests if -developer-build]
-nomake <part>： 在 make 时排除不构建的<part>组件
-compile-examples： 构建和安装 examples 源码，[no on WebAssembly，otherwise yes]
-gui： 构建 Qt GUI 模块和依赖项，[yes]
-widgets： 构建 Qt Widgets 模块和依赖项，[yes]
-no-dbus： 不编译 Qt D-Bus 模块，[default on Android and Windows]
-dbus-linked： 构建 Qt D-Bus 模块并链接到 libdbus-1，[auto]
-dbus-runtime： 构建 Qt D-Bus 模块并动态加载 libdbus-1，[no]
-accessibility： 启用可访问性支持（注意： 不建议禁用可访问性），[yes]
Qt 附带了一些第三方库的捆绑拷贝，如果各自系统库的自动检测失败，下面这些会被默认使用

# 6、核心选项
-doubleconversion： 选择使用双转换库，no 意味着使用 sscanf_l 和 snprintf_l（不精确），[system/qt/no]
-glib： 启用对 Glib 支持，[no; auto on Unix]
-eventfd： 启用对 eventfd 的支持
-inotify： 启用对 inotify 的支持
-iconv： 启用对 iconv(3) 的支持，[posix/sun/gnu/no] (Unix only)
-icu： 启用对 ICU 库的支持，这是 IBM 发布的字符集编码转换库，[auto]
-pcre： 选择使用 libpcre2，[system/qt/no]
-pps： 启用对 PPS 的支持，[auto] (QNX only)
-zlib： 选择使用 zlib，[system/qt]
# 后端日志：
-journald： 启用对 journald 的支持，[no] (Unix only)
-syslog： 启用对 syslog 的支持，[no] (Unix only)
-slog2： 启用对 slog2 的支持，[auto] (QNX only)

# 7、网络选项
-ssl： 启用对任何一种SSL方法的支持，[auto]
-no-openssl： 不适用 OpenSSL，[default on Apple and WinRT]
-openssl-linked： 使用 OpenSSL 并链接到 libssl，[no]
-openssl-runtime： 使用 OpenSSL 并动态加载 libssl，[auto]
-schannel： 使用安全通道，[no] (Windows only)
-securetransport： 使用安全传输，[auto] (Apple only)
-sctp： 启用对 SCTP 的支持，[no]
-libproxy： 启用对 libproxy 的使用，[no]
-system-proxies： 默认使用系统网络代理，[yes]

# 8、Gui, printing, widget选项
-cups： 启用对 CUPS 的支持，[auto] (Unix only)
-fontconfig： 启用对 Fontconfig 的支持，[auto] (Unix only)
-freetype： 选择使用 FreeType，[system/qt/no]
-harfbuzz： 选择使用 HarfBuzz-NG，[system/qt/no] (Not auto-detected on Apple and Windows)。
-gtk： 启用对 GTK 平台主题的支持，[auto]
-lgmon： 启用对 lgmon 的支持，[auto] (QNX only)
-no-opengl： 禁止对 OpenGL 的支持
-opengl <api>： 启用对 OpenGL 的支持，支持的 APIs： es2 (default on Windows)，desktop (default on Unix)，dynamic (Windows only)
-opengles3： 启用对 OpenGL ES 3.x 替换 ES 2.x 的支持，[auto]
-egl： 启用对 EGL 的支持，[auto]
-angle： 使用绑定的 ANGLE 来支持 OpenGL ES 2.0，[auto] (Windows only)
-combined-angle-lib： 将 LibEGL 和 LibGLESv2 合并到 LibANGLE 中，(Windows only)
-qpa <name>： 选择默认的 QPA 后端，用分号分隔的优先级列表，(e.g., xcb, cocoa, windows)
-xcb-xlib： 启用对 Xcb-Xlib 的支持，[auto]
Platform backends：
-direct2d： 启用对 Direct2D 的支持，[auto] (Windows only)
-directfb： 启用对 DirectFB 的支持，[no] (Unix only)
-eglfs： 启用对 EGLFS 的支持，[auto; no on Android and Windows]
-gbm： 为 GBM 启用后端，[auto] (Linux only)
-kms： 为 KMS 启用后端，[auto] (Linux only)
-linuxfb： 启用 Linux Framebuffer 的支持，[auto] (Linux only)
-xcb： 启用 X11 的支持，选择使用 xcb-* 库，[system/qt/no] (-qt-xcb still uses system version of libxcb itself)
# 后端输入：
-libudev： 启用对 udev 的支持，[auto]
-evdev： 启用对 evdev 的持之，[auto]
-imf： 启用对 IMF 的支持，[auto] (QNX only)
-libinput： 启用对 libinput 的支持，[auto]
-mtdev： 启用对 mtdev 的支持，[auto]
-tslib： 启用对 tslib 的支持，[auto]
-xcb-xinput： 启用对 XInput2 的支持，[auto]
-xkbcommon： 启用对键映射的支持，[auto]
#图片格式：
-gif： 启用对 GIF 的读取支持，[auto]
-ico： 启用对 ICO 的支持，[yes]
-libpng： 选择使用 libpng，[system/qt/no]
-libjpeg： 选择使用 libjpeg，[system/qt/no]

# 9、数据库选项
-sql-<driver>： 启用 SQL <driver> 插件，支持的驱动程序有： db2、ibase、mysql、oci、odbc、 psql、sqlite2、sqlite、tds，[all auto]
-sqlite： 选择使用 sqlite3，[system/qt]

# 10、Qt 3D选项
-assimp： 选择使用 assimp 库，[system/qt/no]
-qt3d-profile-jobs： 启用工作分析，[no]
-qt3d-profile-gl： 启用 OpenGL 分析，[no]
-qt3d-simd： 选择 SIMD 的支持级别，[no/sse2/avx2]
-qt3d-render： 启用 Qt3D 的渲染功能，[yes]
-qt3d-input： 启用 Qt3D 的输入功能，[yes]
-qt3d-logic： 启用 Qt3D 的逻辑功能，[yes]
-qt3d-extras： 启用 Qt3D 的额外功能，[yes]
-qt3d-animation： 启用 Qt3D 的动画功能，[yes]

# 11、进一步图片格式选项
-jasper： 启用 JPEG-2000 中对 JasPer 库的支持，[no]
-mng： 启用对 MNG 的支持，[no]
-tiff： 启用对 TIFF 的支持，[system/qt/no]
-webp： 启用对 WEBP 的支持，[system/qt/no]

# 12、多媒体选项
-pulseaudio： 启用对 PulseAudio 的支持，[auto] (Unix only)
-alsa： 启用对 ALSA 的支持，[auto] (Unix only)
-no-gstreamer： 禁止对 GStreamer 的支持
-gstreamer <version>： 启用对 GStreamer 的支持，在没有版本参数的情况下先尝试1.0，然后尝试0.10，[auto]
-evr： 在 DirectShow 和 WMF 中启用对 EVR 的支持，[auto]

# 13、QtQuick 3D选项
-assimp： 选择使用assimp库，[system/qt/no]

# 14、文字转音频选项
-flite： 启用对 Flite 的持之，[auto] (Unix only)
-flite-alsa： 启用 Flite 与 ALSA 的支持，[auto] (Unix only)
-speechd： 启用语音分配器支持，[auto] (Unix only)

# 15、Web引擎选项
-webengine-alsa： 启用 对ALSA 的支持，[auto] (Linux only)
-webengine-pulseaudio： 启用对 PulseAudio 的支持，[auto] (Linux only)
-webengine-embedded-build： 启用 Linux 嵌入式构建，[auto] (Linux only)
-webengine-icu： 使用系统 ICU 库，[system/qt] (Linux only)
-webengine-ffmpeg： 使用系统 FFmpeg 库，[system/qt] (Linux only)
-webengine-opus： 使用系统 Opus 库，[system/qt] (Linux only)
-webengine-webp： 使用系统 WebP 库，[system/qt] (Linux only)
-webengine-pepper-plugins： 使用 Pepper Flash 和Widevine 插件，[auto]
-webengine-printing-and-pdf： 允许打印和输出到 PDF，[auto]
-webengine-proprietary-codecs： 启用对专有编解码器的支持，[no]
-webengine-spellchecker： 启用对拼写检查程序的支持，[yes]
-webengine-native-spellchecker： 启用对本机拼写检查程序的支持，[no] (macOS only)
-webengine-webrtc： 启用对 WebRTC 的支持，[auto]
```

# QT交叉编译环境搭建 - x86
```sh
# 安装cmake
# 更换源后默认安装的cmake版本为3.5，如果觉得低，可以手动安装
# 官网 https://cmake.org/download/ ，下载一个sh包
$ sudo chmod 777 cmake-3.13.2-Linux-x86_64.sh
$ ./cmake-3.13.2-Linux-x86_64.sh
$ cd /usr/bin
$ sudo ln -s cmake 'cmake可执行程序路径'

# 安装Qt5默认依赖环境
# !!注意只有编译最快版本的时候需要安装该环境，如果安装最全版本则不需要该依赖(估计是会使用自己打出来的依赖)
$ sudo apt-get build-dep qt5-default

# 搭建Qt源码文件目录如下
$ tree tempDir
tempDir
├── Qt-build       # 将Qt源码包解压至此
└── Qt5.5.1        # 在运行configure时，设置Qt prefix，最终输出编译结果至此

# 新建如下脚本 autoConfigure.sh ，用于构建Qt源码的makefile
-------------------- 编译最快版本 --------------------
#! /bin/bash
QT_INSTALL_PATH="-prefix /home/xyh/Qt5.5.1" # Qt安装路径(自己对应修改)
QT_COMPLIER+="-platform linux-g++-64"       # 编译器(x64架构必须写成platform.aarch64/mips架构必须写成xplatform)

CONFIG_PARAM+="-shared "                    # 编译动态库(动态库为'-static')
CONFIG_PARAM+="-release "                   # 编译release
CONFIG_PARAM+="-make libs "
CONFIG_PARAM+="-nomake tools "              # 不编译tools
CONFIG_PARAM+="-nomake examples "           # 不编译examples
CONFIG_PARAM+="-nomake tests "              # 不编译tests

CONFIG_PARAM+="-skip qtwebengine -no-qml-debug "
CONFIG_PARAM+="-qt-zlib -qt-pcre -qt-libpng -qt-libjpeg -qt-freetype -qt-xcb -qt-harfbuzz -opengl desktop "
CONFIG_PARAM+="-dbus-linked -openssl-linked -feature-freetype -fontconfig "
CONFIG_PARAM+="-sysconfdir /etc/xdg -no-rpath -strip "
# 选择Qt版本(开源, 商业), 并自动确认许可认证
CONFIG_PARAM+="-opensource "                # 编译开源版本, -commercial商业版本
CONFIG_PARAM+="-confirm-license "           # 自动确认许可认证

echo "../configure $CONFIG_PARAM $QT_COMPLIER $QT_INSTALL_PATH"
../configure $CONFIG_PARAM $QT_COMPLIER $QT_INSTALL_PATH
-------------------- 编译最全版本 --------------------
#! /bin/bash
QT_INSTALL_PATH="-prefix /home/xyh/Qt5.5.1" # Qt安装路径(自己对应修改)
QT_COMPLIER+="-platform linux-g++-64"       # 编译器(x64架构必须写成platform.aarch64/mips架构必须写成xplatform)

CONFIG_PARAM+="-shared "                    # 编译动态库(动态库为'-static')
CONFIG_PARAM+="-release "                   # 编译release
# 选择Qt版本(开源, 商业), 并自动确认许可认证
CONFIG_PARAM+="-opensource "                # 编译开源版本, -commercial商业版本
CONFIG_PARAM+="-confirm-license "           # 自动确认许可认证

echo "../configure $CONFIG_PARAM $QT_COMPLIER $QT_INSTALL_PATH"
../configure $CONFIG_PARAM $QT_COMPLIER $QT_INSTALL_PATH
----------------------------------------------------

# 将脚本放到源码解压目录Qt-build/build并执行
# 这步实际就是在../configure
$ chmod +x autoConfigure.sh
$ ./autoConfigure.sh

# 编译
$ make -j $(grep -c ^processor /proc/cpuinfo) # 后面这句可查看当前系统最高可运行编译的核数

# 安装
$ make install -j $(grep -c ^processor /proc/cpuinfo)

# 添加该Qt版本的环境变量(默认用root用户搭建的交叉环境)，修改/root/.bashrc，添加如下行
----------------------------------------------------
export QTDIR=tempDir/Qt5.5.1
export PATH=$QTDIR/bin:$PATH
export MANPATH=$QTDIR/doc/man:$MANPATH
export LD_LIBRARY_PATH=$QTDIR/lib:$LD_LIBRARY_PATH
----------------------------------------------------

# 更新bashrc后查看是否已链接上Qt
$ source /root/.bashrc
$ qmake -v

# 在安装完成后可运行实例检查安装情况
# 如果有编译examples模块，可直接到tempDir/Qt5.5.1/examples下运行
# 如果没有编译该模块，则运行QTest
# 另外，静态编译只在bin目录下生成qmake，而没有make，因此实例文件只能用.pro来编译makefile
$ make -DCROSS_COMPILE_FRAMEWORK=x64 ..
```

# QT交叉编译环境搭建 - arm/mips
```sh
# 不需要安装依赖
# 因为build-dep qt5-default只会安装x64版本的依赖工具，这就导致aarch64在编译最快版本的时候找不到某些依赖，目前交叉编译只能编最全版本
# !!注意mips必须配置好LD_LIBRARY_PATH与PATH两个环境变量，不然会找不到一些库

# 搭建Qt源码文件目录如下
$ tree tempDir
tempDir
├── Qt-build       # 将Qt源码包解压至此
└── Qt5.5.1        # 在运行configure时，设置Qt prefix，最终输出编译结果至此

# 新增qmake.conf文件
-------------------- arm --------------------
$ cp -r qtbase/mkspecs/linux-arm-gnueabi-g++ qtbase/mkspecs/linux-aarch64-gnu-g++
$ vim qtbase/mkspecs/linux-aarch64-gnu-g++/qmake.conf
'
#
# qmake configuration for building with linux-aarch64-gnu-g++
#

MAKEFILE_GENERATOR      = UNIX
CONFIG                 += incremental
QMAKE_INCREMENTAL_STYLE = sublib

include(../common/linux.conf)
include(../common/gcc-base-unix.conf)
include(../common/g++-unix.conf)

# modifications to g++.conf
QMAKE_CC                = aarch64-linux-gnu-gcc
QMAKE_CXX               = aarch64-linux-gnu-g++
QMAKE_LINK              = aarch64-linux-gnu-g++
QMAKE_LINK_SHLIB        = aarch64-linux-gnu-g++

# modifications to linux.conf
QMAKE_AR                = aarch64-linux-gnu-ar cqs
QMAKE_OBJCOPY           = aarch64-linux-gnu-objcopy
QMAKE_NM                = aarch64-linux-gnu-nm -P
QMAKE_STRIP             = aarch64-linux-gnu-strip
load(qt_config)
'
-------------------- mips --------------------
$ cp -r qtbase/mkspecs/linux-arm-gnueabi-g++ qtbase/mkspecs/linux-mips-g++
$ vim qtbase/mkspecs/linux-mips-g++/qmake.conf
'
#
# qmake configuration for building with linux-mips-g++
#

MAKEFILE_GENERATOR      = UNIX
CONFIG                 += incremental
QMAKE_INCREMENTAL_STYLE = sublib

include(../common/linux.conf)
include(../common/gcc-base-unix.conf)
include(../common/g++-unix.conf)

# modifications to g++.conf
QMAKE_CC                = mips64el-loongson-linux-gcc
QMAKE_CXX               = mips64el-loongson-linux-g++
QMAKE_LINK              = mips64el-loongson-linux-g++
QMAKE_LINK_SHLIB        = mips64el-loongson-linux-g++

# modifications to linux.conf
QMAKE_AR                = mips64el-loongson-linux-ar cqs
QMAKE_OBJCOPY           = mips64el-loongson-linux-objcopy
QMAKE_NM                = mips64el-loongson-linux-nm -P
QMAKE_STRIP             = mips64el-loongson-linux-strip
load(qt_config)
'
----------------------------------------------------

# 新建如下脚本 autoConfigure.sh ，用于构建Qt源码的makefile
-------------------- arm --------------------
#! /bin/bash
QT_INSTALL_PATH="-prefix /home/xyh/Qt5.5.1"     # Qt安装路径(自己对应修改)
QT_COMPLIER+="-xplatform linux-aarch64-gnu-g++" # 编译器(x64架构必须写成platform.aarch64/mips架构必须写成xplatform)

CONFIG_PARAM+="-shared "                        # 编译动态库(动态库为'-static')
CONFIG_PARAM+="-release "                       # 编译release
# 选择Qt版本(开源, 商业), 并自动确认许可认证
CONFIG_PARAM+="-opensource "                    # 编译开源版本, -commercial商业版本
CONFIG_PARAM+="-confirm-license "               # 自动确认许可认证

echo "../configure $CONFIG_PARAM $QT_COMPLIER $QT_INSTALL_PATH"
../configure $CONFIG_PARAM $QT_COMPLIER $QT_INSTALL_PATH
-------------------- mips --------------------
#! /bin/bash
QT_INSTALL_PATH="-prefix /home/xyh/Qt5.5.1"     # Qt安装路径(自己对应修改)
QT_COMPLIER+="-xplatform linux-mips-g++"        # 编译器(x64架构必须写成platform.aarch64/mips架构必须写成xplatform)

CONFIG_PARAM+="-shared "                        # 编译动态库(动态库为'-static')
CONFIG_PARAM+="-release "                       # 编译release
# 选择Qt版本(开源, 商业), 并自动确认许可认证
CONFIG_PARAM+="-opensource "                    # 编译开源版本, -commercial商业版本
CONFIG_PARAM+="-confirm-license "               # 自动确认许可认证
CONFIG_PARAM+="-optimized-qmake -pch "
CONFIG_PARAM+="-qt-libjpeg -qt-libpng -qt-zlib -qpa linuxfb "
CONFIG_PARAM+="-skip qt3d -skip qtcanvas3d "
CONFIG_PARAM+="-no-opengl -no-sse2 -no-openssl -no-cups -no-glib -no-iconv -no-pch"

echo "../configure $CONFIG_PARAM $QT_COMPLIER $QT_INSTALL_PATH"
../configure $CONFIG_PARAM $QT_COMPLIER $QT_INSTALL_PATH
----------------------------------------------------

# 将脚本放到源码解压目录Qt-build/build并执行
# 这步实际就是在../configure
$ chmod +x autoConfigure.sh
$ ./autoConfigure.sh

# 编译
# 注意，arm架构必须多核编译，不然会报错
$ make -j $(grep -c ^processor /proc/cpuinfo) # 后面这句可查看当前系统最高可运行编译的核数

# 安装
$ make install -j $(grep -c ^processor /proc/cpuinfo)

# 添加该Qt版本的环境变量(默认用root用户搭建的交叉环境)，修改/root/.bashrc，添加如下行
----------------------------------------------------
export QTDIR=tempDir/Qt5.5.1
export PATH=$QTDIR/bin:$PATH
export MANPATH=$QTDIR/doc/man:$MANPATH
export LD_LIBRARY_PATH=$QTDIR/lib:$LD_LIBRARY_PATH
----------------------------------------------------

# 更新bashrc后查看是否已链接上Qt
$ source /root/.bashrc
$ qmake -v

# 在安装完成后可运行实例检查安装情况
# 如果有编译examples模块，可直接到tempDir/Qt5.5.1/examples下运行
# 如果没有编译该模块，则运行QTest
# 另外，静态编译只在bin目录下生成qmake，而没有make，因此实例文件只能用.pro来编译makefile
$ make -DCROSS_COMPILE_FRAMEWORK=aarch64 ..
# $ make -DCROSS_COMPILE_FRAMEWORK=mips64 ..
```

# Android交叉编译环境搭建
```sh
# 下载最新Linux 64位版本Android NDK.此处以r26d版本为例
# https://developer.android.com/ndk/downloads?hl=zh-cn

# 将包解压到/opt/android-ndk-r26d
# 添加环境变量 vi ~/.bashrc 加入PATH=$PATH:/opt/Qt-5.5.1-aarch64/bin:/opt/android-ndk-r26d/toolchains/llvm/prebuilt/linux-x86_64/bin

# x86_64版本cmake编译时添加如下内容
'
set(CMAKE_C_COMPILER x86_64-linux-android21-clang)
set(CMAKE_CXX_COMPILER x86_64-linux-android21-clang++)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -static-libstdc++") # 静态依赖c++库
'
# arm64版本cmake编译时添加如下内容
'
set(CMAKE_C_COMPILER aarch64-linux-android21-clang)
set(CMAKE_CXX_COMPILER aarch64-linux-android21-clang++)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -static-libstdc++") # 静态依赖c++库
'
```

# Android仿真环境搭建
```sh
# 下载并安装Genymotion，任意搭建一款安卓收集系统环境(仿真环境均为x86环境，实际手机大多为arm，需要注意)
# https://www.genymotion.com/product-desktop/download/

# cmd到xxx\Genymotion\tools\目录
# 拷贝二进制到手机文件夹
$ adb push '本地二进制路径' /data/local/tmp/

# shell进入到手机内部运行进程
$ adb shell
$ cd /data/local/tmp/
$ chmod +x '二进制名'
$ ./'二进制名'
```

# Qt版本选择工具使用
```sh
-------------------- QMake --------------------
# 查看qt版本
& qmake -v

# qmake的本质是qtchooser
& ll /usr/bin/qmake
lrwxrwxrwx 1 root root 9 10月 18 2019 /usr/bin/qmake -> qtchooser*

# 查看qtchooser当前可选项
$ qtchooser -l
4
5
default
qt4-aarch64-linux-gnu
qt4
qt5-aarch64-linux-gnu
qt5

# 添加qtchooser版本配置
# 比如我们已经在/opt/Qt5.5.1目录下安装qt
# 则先/usr/share/qtchooser/目录下新建文件qt5.5.1.conf
/opt/Qt5.5.1/gcc_64/bin
/opt/Qt5.5.1

# 添加软链接
ln -s /usr/share/qtchooser/qt5.5.1.conf /usr/lib/x86_64-linux-gnu/qtchooser/qt5.5.1.conf
# 再次 'qtchooser -l' 即可看到已有qt5.5.1版本选择

# 版本选择
$ export QT_SELECT=qt5.5.1

# 再次 'qmake -v' 可查看已经选择的qt版本

-------------------- CMake --------------------
# CMakeLists.txt内添加
$ export QTDIR='Qt安装根目录路径'
'
set(CMAKE_PREFIX_PATH "$ENV{QTDIR}")
或
find_package(Qt5 HINTS "$ENV{QTDIR}" COMPONENTS Core Quick REQUIRED)
'

# 再次 'qmake -v' 可查看已经选择的qt版本
```

# 运行时库制作
手动生成后需要手动去剔除一些不必要的文件，较为麻烦。可以尝试使用linuxdeployqt自动生成。
```
1 手动生成
2 自动生成
```

***1、手动生成***  
将源码编译出来的lib与plugin文件夹单独提取出来
并新建一个qt.conf文件
```
[Paths]
prefix = .
Plugins = ./plugins
```
最终目录如下:  
$ tree tempDir
tempDir
├── qt.conf       # qt配置文件
├── plugins      # qt插件
└── lib               # qt依赖库
```sh
# 还有一点需要注意的是，Qt二进制必须添加rpath到lib目录下
$ chrpath -r 'rpath路径' '二进制路径'
```

***2、自动生成***  
https://github.com/probonopd/linuxdeployqt
```sh
# 将Qt二进制文件放入一个单独文件夹，然后使用自己编译的linuxdeployqt执行
$ linuxdeployqt '二进制路径' -appimage
```

# CMake-Qt技巧
```sh
# 一些特殊的关于Qt变量可以从xxx/lib/cmake/Qt5/Qt5Config.cmake查看
# _qt5_install_prefix Qt 安装位置
# Qt5Core_VERSION_STRING Qt版本号

# HINTS代表优先从QTDIR变量路径寻找QT
find_package(Qt5 HINTS "${QTDIR}" COMPONENTS Core Gui Widgets Sql REQUIRED)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTORCC ON)

target_link_libraries(${PROJECT_NAME} Qt5::Core Qt5::Gui Qt5::Widgets)
```

# 生成root登陆用户
```sh
# ===== 登陆界面添加root =====
# 修改root密码
$ sudo passwd root
# 修改配置文件
$ vim /usr/share/lightdm/lightdm.conf.d/50-unity-greeter.conf
# 末尾添加
greeter-show-manual-login=true #手工输入登陆系统的用户名和密码
all-guest=false              #不允许guest登录（可选）
# 重启后登陆出现报错修改
# 修改/root/.profile最后一行为
tty -s && mesg n || true

# ===== ssh添加root用户 =====
# 设置ssh可登陆
$ vim /etc/ssh/sshd_config
# 修改PermitRootLogin
PermitRootLogin yes
# 重启服务
& systemctl restart sshd.services
```