# 容器化的 nezha-agent
[Github主页](https://github.com/Redamancy2319/dockerized-nezha-agent)
[Dockerhub主页](https://hub.docker.com/r/redamancy2319/nezha-agent)
## 一个非官方的哪吒监控 Agent 端
因为官方并不提供docker版本的Agent，现学了一点docker和shell写出的小玩具
由于Docker的特性，***系统版本和磁盘大小不能被正确读取，网页终端和定时任务功能无效*** 
***
## 使用教程

#### 一键命令(需要预装Docker环境)
```
docker run -d -e panel_domain='<面板域名(未接入CDN)>' -e port='<面板端口(不填写默认5555)>' -e secret='<节点密钥>' redamancy2319/nezha-agent:latest
```
***
## 哪吒监控源项目
[官方使用指南](https://nezha.wiki/)
[哪吒监控Github主页](https://github.com/naiba/nezha)
