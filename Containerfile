FROM ubuntu:noble

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y curl openjdk-21-jdk unzip zsh

RUN curl -sLO https://github.com/itzg/rcon-cli/releases/download/1.6.9/rcon-cli_1.6.9_linux_amd64.tar.gz && \
    tar xf rcon-cli_1.6.9_linux_amd64.tar.gz rcon-cli && \
    mv rcon-cli /bin/rcon-cli && \
    rm rcon-cli_1.6.9_linux_amd64.tar.gz

WORKDIR /opt

RUN curl -sLO https://maven.minecraftforge.net/net/minecraftforge/forge/1.20.1-47.4.0/forge-1.20.1-47.4.0-installer.jar

RUN java -jar /opt/forge-1.20.1-47.4.0-installer.jar --installServer server

RUN rm forge-1.20.1-47.4.0-installer.jar*

RUN curl -SLO https://github.com/ThePansmith/Monifactory/releases/download/0.12.4/Monifactory-Beta.0.12.4-server.zip

RUN unzip -d pack /opt/Monifactory-Beta.0.12.4-server.zip

RUN rm Monifactory-Beta.0.12.4-server.zip

RUN useradd -m minecraft

USER minecraft

WORKDIR /home/minecraft

COPY ./bin/ .local/bin/

ENV PATH="$PATH:/home/minecraft/.local/bin"

RUN cp -r /opt/server server

RUN cp -r /opt/pack/overrides/* server

COPY --chown=minecraft ./overrides/* server

WORKDIR server

CMD exec start ./run.sh
