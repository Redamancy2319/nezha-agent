# 容器化的 nezha-agent
[Github主页](https://github.com/Redamancy2319/dockerized-nezha-agent)  
[Dockerhub主页](https://hub.docker.com/r/redamancy2319/nezha-agent)  
因为官方并不提供docker版本的Agent，现学了一点docker和shell写出的小玩具  
由于Docker的特性，***系统版本(可以自定义)不能被正确读取，网页终端和定时任务功能无效***  
已在主流Linux系统(Debian11，CentOS7)经过测试，仍有问题可以提出Issue  

***
## 使用教程
#### 一键命令(需要预装Docker环境)
```shell
docker run -d -e domain='<面板域名>' -e port='<面板端口>' -e secret='<节点密钥>' -e platform='<自定义系统发行版名>:' -e version='<自定义系统版本>' --net='host' --name='<容器名>' redamancy2319/nezha-agent:latest
```
多开可重复执行上方命令，替换为不同面板的参数，容器名不可重复
#### 在容器云上手动安装  
##### 必须添加的环境变量  
| 变量名 | 值       |
| ------ | -------- |
| domain | 面板域名 |
| secret | 节点密钥 |
##### 可选添加的环境变量(不添加则使用默认值)  

| 变量名   | 值                         | 默认值                                          |
| -------- | -------------------------- | ----------------------------------------------- |
| port     | 面板端口                   | 5555                                            |
| args     | nezha-agent 支持的额外参数 | --disable-command-execute --disable-auto-update |
| platform | 系统发行版名(任意字符串)   | Linux，只有debian和ubuntu会自动识别             |
| version  | 系统版本(任意字符串)       | 从内核读取Linux内核版本                         |
#### 修改nezha-agent设置  
如果读取网速或硬盘大小出错，可以执行下面命令修改设置  
方向键上下移动光标，方向键左全不选，方向键右全选，空格键单选，回车键确认  
```shell
docker exec -it <容器名> nezha-agent --edit-agent-config
```
网络接口通常只需要选择eth或enp开头的网络接口，硬盘分区应选择所有分区
每次修改后都需要重启nezha-agent  
```shell
docker exec -it <容器名> pkill nezha-agent
```
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
## nezha-agent 支持的系统发行版名  
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

Docker 运行时修改系统名
```shell
docker exec -it <容器名> sed -i "s/^ID=.*/ID=<新的系统名>/" /etc/os-release
```
Docker 运行时修改系统版本
```shell
docker exec -it <容器名> sed -i "s/^VERSION=.*/VERSION=<新的系统版本>/" /etc/os-release
```
每次修改后都需要重启nezha-agent
```shell
docker exec -it <容器名> pkill nezha-agent
``` 
***
## 哪吒监控源项目

[官方使用指南](https://nezha.wiki/)  
[哪吒监控Github主页](https://github.com/naiba/nezha)