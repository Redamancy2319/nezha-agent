FROM debian:11-slim

ARG NEZHA_VER=0.15.8

ENV domain="" port="5555" secret="" args="--disable-auto-update" platform="" version=""

WORKDIR /usr/local/bin

COPY ./entrypoint.sh /usr/local/bin/

RUN apt-get update &&\
    apt-get install -y --no-install-recommends tini wget unzip ca-certificates &&\
    rm -rf /var/lib/apt/lists/* &&\
    arch=$(uname -m | sed "s#x86_64#amd64#; s#aarch64#arm64#; s#i386#386#") &&\
    wget -O ./nezha-agent.zip -t 4 -T 5 "https://github.com/nezhahq/agent/releases/download/v${NEZHA_VER}/nezha-agent_linux_${arch}.zip" &&\
    unzip ./nezha-agent.zip &&\
    rm -f ./nezha-agent.zip &&\
    chmod +x ./entrypoint.sh &&\
    chmod +x ./nezha-agent

ENTRYPOINT ["/usr/bin/tini","-g","--","/usr/local/bin/entrypoint.sh"]
