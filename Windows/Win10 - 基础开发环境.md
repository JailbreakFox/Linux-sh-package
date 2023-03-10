# 纯净镜像下载
https://jingyan.baidu.com/article/37bce2bec1a11d5002f3a28b.html

# 安装应用
```sh
# 微信、钉钉、Git、Vscode、WPS

# chrome
https://www.google.cn/intl/zh-CN/chrome/

# VMware
https://www.vmware.com/cn/products/workstation-pro/workstation-pro-evaluation.html
# 激活码
ZF3R0-FHED2-M80TY-8QYGC-NPKYF

# Dependencies
https://github.com/lucasg/Dependencies
查看可执行文件的依赖库  

# sqlite 查看器
http://www.sqlitebrowser.org/dl/

# ScreenToGif 录屏软件
https://github.com/NickeManarin/ScreenToGif

# 7z 压缩软件
https://www.7-zip.org/

# SpaceSniffer 磁盘清理软件
http://www.uderzo.it/main_products/space_sniffer/download_alt.html

# WinSCP 文件传输
https://winscp.net/eng/index.php

# BoostNote 开源云笔记
https://github.com/BoostIO/boost-releases/releases/

# shotcut 视频剪辑软件
https://github.com/mltframework/shotcut

# OBS 录屏软件
https://obsproject.com/
```

# Hexo博客环境搭建
```sh
# 下载 node.js(注意要安装稳定版本 建议安装12.16.3)
# 官网 https://nodejs.org/en/
# https://nodejs.org/download/release/v12.16.3/node-v12.16.3-x64.msi

# 使用npm安装Hexo
npm install -g hexo-cli
# 卸载命令
npm uninstall -g hexo-cli

# 初始化hexo框架
hexo init
# 启动本地服务
hexo s
# 新建文章
hexo new "postName" 

# 清除缓存
hexo clean
# 编译生成静态页面
hexo generate = hexo g
# 部署到GitHub
hexo deploy = hexo d
```

# GitBook环境搭建
```sh
# 下载 node.js(注意要安装稳定版本 建议安装12.16.3)
# 官网 https://nodejs.org/en/
# https://nodejs.org/download/release/v12.16.3/node-v12.16.3-x64.msi

# 使用npm安装GitBook
npm install -g gitbook-cli
gitbook -V
# 卸载命令
npm uninstall -g gitbook-cli

# 初始化GitBook框架
# 生成README.md和SUMMARY.md两个必须文件，README.md是对书籍的简单介绍，SUMMARY.md 是书籍的目录结构
gitbook init
# 启动本地服务
# 生成_book文件夹，里面包含关于页面的配置以及静态页面
gitbook serve
# 生成静态html(生成位置在_book/index.html)
gitbook build

# 根据SUMMARY.md的目录生成md文档
gitbook init
```

# VSCode + GitBook环境搭建
```sh
# 如果不需要生成静态网页，则可不必安装上述GitBook框架。更简单，推荐

# 安装VSCode(方法在上面)
# 安装以下插件
#	Markdown All in One
#	Gitbook kit
	
# 新建最简单的笔记本结构
|-- SUMMARY.md     # 目录
|-- README.md      # 引言
|-- CHAPTER_1      # 第一章文件夹
| |-- CHAPTER_1.md # 第一章

# SUMMARY.md为目录，其大致内容如下
`
# 书名
* [引言](README.md)

## CHAPTER_1
* [第一章 XXX](CHAPTER_1/CHAPTER_1.md)
`
```

# 科学上网
```sh
# 购买vultr服务器
https://my.vultr.com

# ssh连接服务器，然后一键搭建v2ray
bash <(curl -s -L https://git.io/v2ray-setup.sh)
# 记录v2ray的vmess地址
v2ray url

# 安装客户端 https://github.com/2dust/v2rayN/releases
# 第一次安装需要安装v2rayN-Core.zip
```

# 远程桌面控制
```sh
# 安装MultiDesk

# 打开被控机器的远程桌面设置
# 右键我的电脑-属性-远程属性-远程-远程桌面

# 关闭防火墙

# 打开MultiDesk添加远程桌面IP并连接
```