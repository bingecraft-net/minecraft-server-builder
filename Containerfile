FROM ubuntu:noble

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y curl openjdk-21-jdk zsh

RUN curl -sLO https://github.com/itzg/rcon-cli/releases/download/1.6.9/rcon-cli_1.6.9_linux_amd64.tar.gz && \
    tar xf rcon-cli_1.6.9_linux_amd64.tar.gz rcon-cli && \
    mv rcon-cli /bin/rcon-cli && \
    rm rcon-cli_1.6.9_linux_amd64.tar.gz

WORKDIR /opt

RUN curl -sLO https://api.papermc.io/v2/projects/paper/versions/1.21.5/builds/5/downloads/paper-1.21.5-5.jar

RUN curl -SLO https://github.com/BlueMap-Minecraft/BlueMap/releases/download/v5.7/bluemap-5.7-paper.jar

RUN useradd -m minecraft

USER minecraft

WORKDIR /home/minecraft

COPY ./bin/ .local/bin/

ENV PATH="$PATH:/home/minecraft/.local/bin"

COPY --chown=minecraft ./overrides server

WORKDIR server

RUN ln -s /opt/bluemap-5.7-paper.jar plugins/

CMD exec start java -jar /opt/paper-1.21.5-5.jar
