# 容器化的 nezha-agent
[Github主页](https://github.com/Redamancy2319/dockerized-nezha-agent)  
[Dockerhub主页](https://hub.docker.com/r/redamancy2319/nezha-agent)  
由于Docker的特性，***宿主机的系统版本(可以自定义)不能被正确读取，网页终端和定时任务功能对宿主机无效***  

***
## 使用教程
#### 在容器云上安装  
##### 必须添加的环境变量  
| 变量名 | 值       |
| ------ | -------- |
| domain | 面板域名 |
| secret | 节点密钥 |
##### 可选添加的环境变量(不添加则使用默认值)  

| 变量名   | 值                         | 默认值                |
| -------- | -------------------------- | --------------------- |
| port     | 面板端口                   | 5555                  |
| args     | nezha-agent 支持的额外参数 | --disable-auto-update |
| platform | 系统名                     | 空                    |
| version  | 系统版本                   | 空                    |
#### 在命令行下安装(需要预装Docker环境)
```shell
docker run -d -e domain='<面板域名>' -e port='<面板端口>' -e secret='<节点密钥>' -e args='<nezha-agent运行额外参数>' -e platform='<自定义系统名>:' -e version='<自定义系统版本>' --net='host' --name='<容器名>' redamancy2319/nezha-agent:latest
```
多开可重复执行上方命令，替换为不同面板的参数，容器名不可重复
#### 关于自定义系统名称和系统版本功能的问题
如果这两个变量任何一个被启用，容器内部系统的版本信息就会被修改  
这会导致一些软件无法获取正确的版本信息  
***如果需要使用Web Terminal功能，请勿添加platform和version环境变量***

#### 关于Web Terminal功能的使用
Docker的基础镜像为Debian11，为精简系统占用，一些常用命令可能没有安装，在初次进入终端后需要执行  
```shell
apt-get update
```
就可以解决 `Unable to locate package` 的问题

***
## nezha-agent 支持的额外参数    
| 参数                      | 说明                     |
| ------------------------- | ------------------------ |
| -d, --debug               | 开启调试信息             |
| --disable-auto-update     | 禁用自动升级             |
| --disable-command-execute | 禁止在此机器上执行命令   |
| --disable-force-update    | 禁用强制升级             |
| --report-delay int        | 系统状态上报间隔 (默认1) |
| --skip-conn               | 不监控连接数             |
| --skip-procs              | 不监控进程数             |
| --tls                     | 启用SSL/TLS加密          |
***
## nezha-agent 支持的系统名  
只有特定的系统名会在面板前端(部分主题)显示图标  

| almalinux |   alpine    |    aosc    |    apple     |
| :-------: | :---------: | :--------: | :----------: |
| archlinux |  archlabs   |   artix    |    budgie    |
|  centos   |   coreos    |   debian   |    deepin    |
|  devuan   |   docker    | elementary |    fedora    |
|  ferris   |   flathub   |  freebsd   |    gentoo    |
| gnu-guix  |   illumos   | kali-linux |  kali-linux  |
|  mageia   |  mandriva   |  manjaro   |    nixos     |
|  openbsd  |  opensuse   |   pop-os   | raspberry-pi |
|  redhat   | rocky-linux |  sabayon   |  slackware   |
|  snappy   |    solus    |    tux     |    ubuntu    |
|   void    |    zorin    |            |              |
***
## 哪吒监控源项目

[官方使用指南](https://nezha.wiki/)  
[哪吒监控Github主页](https://github.com/naiba/nezha)