FROM debian:stable

ARG NEZHA_VER=0.14.12
ARG SYS=linux

ENV panel_domain=example.com port=5555 secret=hash

WORKDIR /usr/local/bin

COPY ./entrypoint.sh /usr/local/bin/

RUN apt-get update -y &&\
    apt-get install wget unzip -y
RUN wget -O ./nezha-agent.zip "https://github.com/naiba/nezha/releases/download/v${NEZHA_VER}/nezha-agent_${SYS}_$(uname -m | sed "s#x86_64#amd64#; s#aarch64#arm64#").zip" &&\
    unzip ./nezha-agent.zip &&\
    chmod +x ./nezha-agent &&\
    rm -f ./nezha-agent.zip &&\
    chmod +x ./entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]