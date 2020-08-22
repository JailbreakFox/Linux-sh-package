#运行方式
#sh Hexo.sh

#===========Hexo安装============
# 先安装nodejs和npm
# 确保源内能找到以上两个包
sudo apt install nodejs npm

# 用npm安装hexo
sudo npm install hexo-cli -g
npm install hexo-deployer-git --save # 用于向git仓库提交代码
npm install https://github.com/7ym0n/hexo-asset-image --sa # 用于显示图片

# 初始化hexo框架
# hexo init
# 启动本地服务
# hexo s
#新建文章
# hexo new "postName" 

# 清除缓存
# hexo clean
# 编译生成静态页面
# hexo generate = hexo g
# 部署到GitHub
# hexo deploy = hexo d
