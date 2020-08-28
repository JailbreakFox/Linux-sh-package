#运行方式
#sh GitBook.sh

#===========Hexo安装============
# https://www.jianshu.com/p/421cc442f06c
# 先安装nodejs和npm
# 确保源内能找到以上两个包
sudo apt install nodejs npm

# 用npm安装gitbook
sudo npm install gitbook-cli -g

# 初始化gitbook框架
# gitbook init
# 将 book.json 配置文件拷贝到根目录下，并执行
# gitbook install ./
# 生成本地服务器，访问locallhost:4000
# gitbook serve
# 生成静态网页，不需要服务器
# gitbook build

# 目录结构
#├── _book/            不用管，init后自动生成
#├── book.json         配置文件，拷贝进去
#├── README.md         
#├── SUMMARY.md        目录组织文件，可利用json中的summary插件自动生成
#├── chapter-1/        *文章目录1
#|   ├── README.md
#|   └── something.md
#└── chapter-2/        *文章目录2
#    ├── README.md
#    └── something.md
