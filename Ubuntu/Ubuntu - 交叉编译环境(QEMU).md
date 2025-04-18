# 安装docker

```sh
# 鱼香ROS按提示安装即可
$ wget http://fishros.com/install -O fishros && . fishros
```

# 下载qemu-user-static

```sh
$ sudo apt install qemu-user-static
```

# 初始化并重置binfmt
这一步是必须的，qemu-user-static结合binfmt_misc来实现arm架构的指令模拟

```sh
# 需要先翻墙
$ docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
```

# 拉取或加载镜像

```sh
# 拉取纯净镜像
$ docker pull arm64v8/ubuntu:20.04

# or

# 加载镜像
$ docker load -i "镜像名"
```

# 运行容器

```sh
# 按照架构运行指定容器(输出aarch64则说明正常)
$ docker run -it --rm --platform linux/arm64 -v /usr/bin/qemu-aarch64-static:/usr/bin/qemu-aarch64-static "镜像名:版本" uname -m

# 进入容器
$ docker exec -it "容器ID" /bin/bash
```