# 配置国内源
```sh
sudo  pacman-mirrors -i -c China -m rank  # 勾选科大源(USTC那个)
```

# 升级系统
```sh
sudo pacman -Syy && sudo pacman -Syu
```

# 安装必要库
```sh
# 编辑器
sudo pacman -S vim gedit

# 开发环境
sudo pacman -S gdb git gcc cmake qtcreator
```

# 添加Arch Linux cn源
```sh
sudo vim /etc/pacman.conf # 打开文件
# 在文件末尾添加以下两行
[archlinuxcn]
Server = https://mirrors.ustc.edu.cn/archlinuxcn/$arch
```

# 安装archlinuxcn签名钥匙(导入 GPG key，否则的话key验证失败会导致无法安装软件)
```sh
sudo pacman -Syy && sudo pacman -S archlinuxcn-keyring
```

# 安装sogou拼音输入法
```sh
# 安装fcitx 选择全部安装
sudo pacman -S fcitx-im

# fcitx 配置界面
sudo pacman -S fcitx-configtool

# 安装sogoupinyin
sudo pacman -S fcitx-sogoupinyin
```

# 配置环境，中文输入(重启后生效)
```sh
# 打开编辑.xprofile文件
vim ~/.xprofile


# 在文件中加入以下两行代码
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
```

# 安装Google-Chrome浏览器
```sh
sudo pacman -S google-chrome
```

# 安装网易云音乐
```sh
sudo pacman -S netease-cloud-music
```

# 安装配置oh my zsh(注销后生效)
```sh
# 安装zsh
sudo pacman -S zsh

# 安装oh my zsh
# https://github.com/ohmyzsh/ohmyzsh/
git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
# 拷贝配置文件，提示覆盖写入yes
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
chsh -s $(which zsh)
# 修改主题.改为自己喜欢的主题，比如mortalscumbag、ys
# vim ~/.zshrc
# ZSH_THEME="mortalscumbag"
```

# 安装VSCode
```sh
sudo pacman -S visual-studio-code-bin
```
