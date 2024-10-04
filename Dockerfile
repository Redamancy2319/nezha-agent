FROM debian:11-slim

# 构建参数
ARG NEZHA_VER=0.19.8

# 环境变量
ENV domain="" port="5555" secret="" args="--disable-auto-update" platform="" version=""          

# 设置工作目录
WORKDIR /usr/local/bin

# 复制 entrypoint 脚本
COPY ./entrypoint.sh /usr/local/bin/  

# 安装必要的软件包，包括 tini、wget、unzip、ca-certificates 和 Python3
RUN apt-get update && \
    apt-get install -y --no-install-recommends tini wget unzip ca-certificates python3 && \
    rm -rf /var/lib/apt/lists/* && \
    arch=$(uname -m | sed "s#x86_64#amd64#; s#aarch64#arm64#; s#i386#386#") && \
    wget -O ./nezha-agent.zip -t 4 -T 5 "https://github.com/nezhahq/agent/releases/download/v${NEZHA_VER}/nezha-agent_linux_${arch}.zip" && \
    unzip ./nezha-agent.zip && \
    rm -f ./nezha-agent.zip && \
    chmod +x ./nezha-agent && \
    chmod +x ./entrypoint.sh

# 暴露 HTTP 端口 8080
EXPOSE 8080

# 使用 tini 作为进程管理器，启动 Python HTTP 服务器 和 nezha-agent
ENTRYPOINT ["/usr/bin/tini", "-g", "--", "sh", "-c", "python3 -m http.server 8080 --bind 0.0.0.0 & ./nezha-agent -s ${domain}:${port} -p ${secret} ${args}"]        
