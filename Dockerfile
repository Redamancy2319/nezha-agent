FROM debian:11-slim

# 构建参数
ARG NEZHA_VER=0.15.10

# 环境变量
ENV domain="" port="5555" secret="" args="--disable-auto-update" platform="" version=""

# 设置工作目录
WORKDIR /usr/local/bin

# 安装必要的软件包，包括 tini、wget、unzip、ca-certificates 和 nginx
RUN apt-get update && \
    apt-get install -y --no-install-recommends tini wget unzip ca-certificates nginx && \
    rm -rf /var/lib/apt/lists/* && \
    arch=$(uname -m | sed "s#x86_64#amd64#; s#aarch64#arm64#; s#i386#386#") && \  
    wget -O ./nezha-agent.zip -t 4 -T 5 "https://github.com/nezhahq/agent/releases/download/v${NEZHA_VER}/nezha-agent_linux_${arch}.zip" && \
    unzip ./nezha-agent.zip && \
    rm -f ./nezha-agent.zip && \
    chmod +x ./nezha-agent

# 配置 Nginx 的默认服务器
RUN echo 'server { \
    listen 80; \
    server_name localhost; \
    location / { \
        root /usr/share/nginx/html; \
        index index.html; \
    } \
}' > /etc/nginx/conf.d/default.conf

# 暴露 HTTP 端口
EXPOSE 80

# 使用 tini 作为进程管理器，启动 Nginx 和 nezha-agent
CMD ["/usr/bin/tini", "-g", "--", "sh", "-c", "service nginx start && ./nezha-agent -s ${domain}:${port} -p ${secret} ${args}"]
