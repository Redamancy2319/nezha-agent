FROM alpine:latest

ENV panel_domain=localhost port=5555 secret=password args=--disable-command-execute

WORKDIR /usr/local/bin

COPY ./entrypoint.sh /usr/local/bin/

RUN apk update &&\
    apk add supervisor &&\
    wget -O ./nezha-agent.zip "https://github.com/nezhahq/agent/releases/download/v${NEZHA_VER}/nezha-agent_${SYS}}_$(uname -m | sed "s#x86_64#amd64#; s#aarch64#arm64#").zip" &&\
    unzip ./nezha-agent.zip &&\
    rm -f ./nezha-agent.zip &&\
    chmod +x ./entrypoint.sh &&\
    chmod +x ./nezha-agent

ENTRYPOINT ["sh","./entrypoint.sh"]