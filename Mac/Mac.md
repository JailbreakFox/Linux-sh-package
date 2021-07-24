# 安装brew
```sh
# 从gitee安装，中途会提醒先安装git
/bin/zsh -c "$(curl -fsSL https://gitee.com/cunkai/HomebrewCN/raw/master/Homebrew.sh)"

# 安装完成后需要更新
source /Users/'账户名'/.zprofile
```

# 安装配置oh my zsh(注销后生效)
```sh
# Mac自带zsh

# 安装oh my zsh
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
# 拷贝配置文件，提示覆盖写入yes
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
chsh -s $(which zsh)
# 修改主题.改为自己喜欢的主题，比如mortalscumbag、ys
# vim ~/.zshrc
# ZSH_THEME="mortalscumbag"
```

# 搭建C++与Qt开发环境
Qt只有旧版本有Mac安装包(比如5.12.0)，新版本几乎都是需要源码安装，这边只描述怎么源码安装。另外有一点需要注意，Mac目前出了新款的M1型号(架构为ARM64)，但是亲测即无法用安装包也无法源码编译，据Qt官方发布Qt6.2以后将原生支持Mac M1。
```sh
# 安装编译器与cmake
brew install gcc cmake

# 下载Qt源码(http://mirrors.ustc.edu.cn/qtproject/official_releases/qt/5.15/5.15.0/single/)
# 建议从国内源下载
#     中国科学技术大学：http://mirrors.ustc.edu.cn/qtproject/
#     清华大学：https://mirrors.tuna.tsinghua.edu.cn/qt/
#     北京理工大学：http://mirror.bit.edu.cn/qtproject/
#     中国互联网络信息中心：https://mirrors.cnnic.cn/qt/
tar -xvf qt-everywhere-src-5.15.0.tar
cd qt5.15.0
sudo ./configure -prefix /usr/local/qt5.15.0/ -debug-and-release -opensource
# 输入o选择开源版本，选择Y接受协议
sudo make #不要多核编译，会出问题，这边大概要花10~20小时，所以建议直接用旧版dmg包安装
sudo make install

# 设置环境变量
vim ~/.zshrc # 前提是使用zsh
export PATH=$PATH:/usr/local/qt5.15.0/bin
```

# 搭建godot环境
```sh
# 安装编译器
brew install scrons yasm

# 下载源码(为了速度，使用国内的gitee)
https://gitee.com/mirrors/godot?_from=gitee_search
# 为X86_64平台编译
scons platform=osx arch=x86_64 --jobs=$(sysctl -n hw.logicalcpu)
# 为ARM架构编译
scons platform=osx arch=arm64 --jobs=$(sysctl -n hw.logicalcpu)
```

# Boost库静态依赖
```sh
# 下载开发包
https://mirrors.ustc.edu.cn/homebrew-bottles/bottles

# 在CMakeLists.txt中加入以下语句
# 注意，必须写在find_package之前
set(CMAKE_INCLUDE_PATH ${CMAKE_INCLUDE_PATH} "?/boost/1.76.0/include")
set(CMAKE_LIBRARY_PATH ${CMAKE_LIBRARY_PATH} "?/boost/1.76.0/lib")
```

# 翻墙
```sh
# ===== 方案一 =====
# 购买cloudss，获取链接地址

# 下载clashx
# https://github.com/yichengchen/clashX/releases

# 在~/.config/clashx/目录先添加.yaml配置文件
# 添加获得的链接地址

# ===== 方案二 =====
# 购买vultr服务器
https://my.vultr.com

# ssh连接服务器，然后一键搭建v2ray
bash <(curl -s -L https://git.io/v2ray-setup.sh)
# 记录v2ray的vmess地址
v2ray url

# 安装客户端 https://github.com/Cenmrev/V2RayX/releases
# 客户端搭建方法 https://www.imtrq.com/archives/1600
```

# 内置应用
```sh
# 从商店中可直接下载
WPS Office
OneNote
QQ
微信
网易云音乐
```