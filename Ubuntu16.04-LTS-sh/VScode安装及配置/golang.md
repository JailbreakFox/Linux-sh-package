# VSCode配置Golang开发环境

## 说明
&emsp;&emsp;因 VSCode 使用的调试工具 [https://github.com/go-delve/delve delve] 不支持系统源里的 Go 1.11 安装，所以需要升级下 Go 的版本，可以按照下面使用 Debian sid 的源来升级。不过你也可以试试从别人那复制过来一个 delve 的二进制文件  
&emsp;&emsp;因为 [https://github.com/golang/tools/tree/master/gopls gopls] 在 GOPATH 外使用时必须使用 go mod，所以需要将项目放进 GOPATH 中  
&emsp;&emsp;本文使用 <code>go env -w</code> 命令来配置环境变量，你也可以使用 <code>.profile</code>、<code>.bashrc</code> 等文件来配置，记住不要重复配置即可，秘诀就是："永远只使用同一方式配置"  
&emsp;&emsp;若是升级了 Go 版本，需注意不要使用系统源中的版本不支持的特性，不然会导致 crp 打包失败

## 升级 Go 版本

&emsp;&emsp;1.创建文件 /etc/apt/sources.list.d/sid.list
```sh
deb https://mirrors.tuna.tsinghua.edu.cn/debian sid main
```

&emsp;&emsp;2.创建文件 /etc/apt/preferences.d/99sid
```sh
# sid 源的所有的包优先级设置为 1，防止从 sid 源里安装其它包
Package: *
Pin: release o=Debian,n=sid
Pin-Priority: 1

# sid 源 golang 包的优先级设置为 500
Package: golang
Pin: release o=Debian,n=sid
Pin-Priority: 500

Package: golang-go
Pin: release o=Debian,n=sid
Pin-Priority: 500

Package: golang-src
Pin: release o=Debian,n=sid
Pin-Priority: 500

Package: golang-doc
Pin: release o=Debian,n=sid
Pin-Priority: 500

Package: dh-golang
Pin: release o=Debian,n=sid
Pin-Priority: 500
```
&emsp;&emsp;3.安装
```sh
sudo apt update
sudo apt install golang
```

## 配置环境变量
1.GOPATH  
&emsp;&emsp;我设置了三个 GOPATH，你可以根据需要自行删减合并
- ~/go：用来安装第三方包，以及后续 VSCode 会使用到的工具
- ~/dde-go：用来放项目，比如 dde-daemon 放在 ~/dde-go/src/pkg.deepin.io/dde/daemon
- /usr/share/gocode：开发依赖的包的存放路径

&emsp;&emsp;运行
```sh
go env -w GOPATH="$HOME/go:$HOME/dde-go:/usr/share/gocode"
```

2.GOPROXY，用来加速 go get，这里使用[Goproxy 中国](https://goproxy.cn)  
&emsp;&emsp;运行
```sh
go env -w GOPROXY=https://goproxy.cn,direct
```

## 配置 VSCode
1.在配置文件（~/.config/Code/User/settings.json）中添加 <code>"go.useLanguageServer": true </code>以使用 gopls  
2.安装 Go 扩展 <code>ms-vscode.go</code>
3.随便打开一个 Go 项目，按照提示进行，会自动安装 delve、gopls 等工具

## 为项目配置调试方式
&emsp;&emsp;这里以 dde-daemon 为例  
&emsp;&emsp;在项目根目录添加 <code>.vscode/launch.json</code>
```sh
{
    // 使用 IntelliSense 了解相关属性。 
    // 悬停以查看现有属性的描述。
    // 欲了解更多信息，请访问: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Launch dde-session-daemon",
            "type": "go",
            "request": "launch",
            "mode": "auto",
            "program": "${workspaceFolder}/bin/dde-session-daemon",
            "env": {
                "DDE_DEBUG_LEVEL": "debug"
            },
            "args": [],
            "host": "0.0.0.0"   // 黑魔法，UOS 上只有用 0.0.0.0 才能正常调试，127.0.0.1 经常报监听失败
        },
        {
            "name": "Launch soundeffect",
            "type": "go",
            "request": "launch",
            "mode": "auto",
            "program": "${workspaceFolder}/bin/soundeffect",
            "env": {
                "DDE_DEBUG_LEVEL": "debug"
            },
            "args": [],
            "host": "0.0.0.0"   // 黑魔法，UOS 上只有用 0.0.0.0 才能正常调试，127.0.0.1 经常报监听失败
        },
    ]
}
```
&emsp;&emsp;说明：program 填程序入口所在的文件夹或文件

## 远程调试
&emsp;&emsp;盘古等设备是 arm 架构，没有官方 VSCode，这时候远程调试就极为方便

1.安装扩展 <code>ms-vscode-remote.remote-ssh</code>  
2.从侧边栏打开「远程资源管理器」  
3.点击「+」，然后填入远程机器的 IP 和用户名，并按 Enter 确认  
4.在 target 上右键，选择「Connect to Host in New Window」，VSCode 会自动在远程机器上安装好需要的一切  
5.将远程机器按照上面的方式配置好环境  
6.将项目文件传送到远程机器上  
7.在资源管理器中选择「打开文件夹」，来打开项目  
8.开始调试  

