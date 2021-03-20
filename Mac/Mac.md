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