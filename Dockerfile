FROM alpine:latest

ARG NEZHA_VER=0.15.2

ENV domain=localhost port=5555 secret=password args=--disable-command-execute platform=Linux version=

WORKDIR /usr/local/bin

COPY ./entrypoint.sh /usr/local/bin/

RUN apk update --no-cache &&\
    apk add --no-cache supervisor &&\
    wget -O ./nezha-agent.zip "https://github.com/nezhahq/agent/releases/download/v${NEZHA_VER}/nezha-agent_linux_$(uname -m | sed "s#x86_64#amd64#; s#aarch64#arm64#").zip" &&\
    unzip ./nezha-agent.zip &&\
    rm -f ./nezha-agent.zip &&\
    rm -f /etc/alpine-release &&\
    chmod +x ./entrypoint.sh &&\
    chmod +x ./nezha-agent

ENTRYPOINT ["sh","./entrypoint.sh"]