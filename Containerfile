FROM ubuntu:noble

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y curl openjdk-21-jdk zsh

RUN curl -sLO https://github.com/itzg/rcon-cli/releases/download/1.6.9/rcon-cli_1.6.9_linux_amd64.tar.gz && \
    tar xf rcon-cli_1.6.9_linux_amd64.tar.gz rcon-cli && \
    mv rcon-cli /bin/rcon-cli && \
    rm rcon-cli_1.6.9_linux_amd64.tar.gz

WORKDIR /opt

ARG MINECRAFT_VERSION

ARG PAPER_VERSION

RUN curl -sLo paper.jar https://api.papermc.io/v2/projects/paper/versions/$MINECRAFT_VERSION/builds/$PAPER_VERSION/downloads/paper-$MINECRAFT_VERSION-$PAPER_VERSION.jar

RUN useradd -m minecraft

USER minecraft

WORKDIR /home/minecraft

COPY ./bin/ .local/bin/

ENV PATH="$PATH:/home/minecraft/.local/bin"

COPY --chown=minecraft ./overrides server

WORKDIR server

CMD exec start java -jar /opt/paper.jar
