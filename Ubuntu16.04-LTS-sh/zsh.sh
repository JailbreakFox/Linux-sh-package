#运行方式
#sh zsh.sh

#===========zsh安装============
# 安装zsh
sudo apt-get install zsh

# 安装oh my zsh
# https://github.com/ohmyzsh/ohmyzsh/
git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
chsh -s $(which zsh)
# 修改主题.改为自己喜欢的主题，比如mortalscumbag、ys
# vim ~/.zshrc
# ZSH_THEME="mortalscumbag"
